--[[
    PromoCode.lua
    Promo Code Redemption System for Lumo's Land

    PURPOSE:
    Players enter promo codes IN THE GAME to receive special items.
    Codes come from HealthQuest marketing (website, social media, email).

    FLOW:
    1. HealthQuest creates codes (via admin/database)
    2. Player sees code on website/social/email
    3. Player enters code in Lumo's Land (Settings → Enter Code)
    4. Player receives special sticker reward

    CODE TYPES:
    - Global: Anyone can use, limited total uses (e.g., WELLNESS2026)
    - Single-Use: One player only (e.g., WINNER-A1B2C3)

    REWARDS:
    - Special stickers (legendary, not purchasable)
    - Display in Sticker Journal & Castle walls
]]

local DataStoreService = game:GetService("DataStoreService")
local PromoDataStore = DataStoreService:GetDataStore("PromoCodes_v1")
local GlobalCodeStore = DataStoreService:GetDataStore("GlobalPromoCodes_v1")

local PromoCode = {}

-- ==========================================
-- PROMO CODE DATABASE (HealthQuest manages these)
-- In production, this would come from an external API/database
-- For now, hardcoded for testing
-- ==========================================

local PROMO_CODES = {
    -- Global codes (anyone can use, limited total)
    ["WELLNESS2026"] = {
        rewardId = "STCK-PROMO-005",
        rewardName = "Wellness Star Sticker",
        rewardEmoji = "⭐",
        codeType = "global",
        maxUses = 10000,
        expiresAt = nil, -- Unix timestamp or nil for never
        active = true
    },
    ["LUMOLOVE"] = {
        rewardId = "STCK-PROMO-002",
        rewardName = "Devoted Caretaker Heart",
        rewardEmoji = "💖",
        codeType = "global",
        maxUses = 5000,
        expiresAt = nil,
        active = true
    },
    ["HEALTHY"] = {
        rewardId = "STCK-PROMO-006",
        rewardName = "Apple of Health",
        rewardEmoji = "🍎",
        codeType = "global",
        maxUses = nil, -- Unlimited
        expiresAt = nil,
        active = true
    },
    ["QUESTCHAMP"] = {
        rewardId = "STCK-PROMO-001",
        rewardName = "Quest Champion Star",
        rewardEmoji = "⭐",
        codeType = "global",
        maxUses = nil,
        expiresAt = nil,
        active = true
    },
    ["ROCKET"] = {
        rewardId = "STCK-PROMO-003",
        rewardName = "Rising Star Rocket",
        rewardEmoji = "🚀",
        codeType = "global",
        maxUses = nil,
        expiresAt = nil,
        active = true
    },
    ["RAINBOW"] = {
        rewardId = "STCK-PROMO-004",
        rewardName = "Perfect Week Rainbow",
        rewardEmoji = "🌈",
        codeType = "global",
        maxUses = nil,
        expiresAt = nil,
        active = true
    }
}

-- Default player promo data
local DEFAULT_DATA = {
    -- Codes this player has redeemed
    redeemedCodes = {},  -- { "WELLNESS2026" = { timestamp, rewardId }, ... }

    -- Stats
    totalCodesRedeemed = 0,
    firstRedemptionTime = 0
}

-- ==========================================
-- DATA PERSISTENCE
-- ==========================================

-- Load player promo data
function PromoCode.load(player)
    local userId = player.UserId
    local key = "Promo_" .. userId

    local success, data = pcall(function()
        return PromoDataStore:GetAsync(key)
    end)

    if success and data then
        for k, v in pairs(DEFAULT_DATA) do
            if data[k] == nil then
                data[k] = v
            end
        end
        return data
    else
        return table.clone(DEFAULT_DATA)
    end
end

-- Save player promo data
function PromoCode.save(player, data)
    local userId = player.UserId
    local key = "Promo_" .. userId

    local success, err = pcall(function()
        PromoDataStore:SetAsync(key, data)
    end)

    if not success then
        warn("Failed to save promo data for " .. player.Name .. ": " .. tostring(err))
    end

    return success
end

-- ==========================================
-- GLOBAL CODE USAGE TRACKING
-- ==========================================

-- Get current usage count for a global code
local function getGlobalCodeUsage(code)
    local success, count = pcall(function()
        return GlobalCodeStore:GetAsync("usage_" .. code) or 0
    end)
    return success and count or 0
end

-- Increment usage count for a global code
local function incrementGlobalCodeUsage(code)
    local success, newCount = pcall(function()
        return GlobalCodeStore:IncrementAsync("usage_" .. code, 1)
    end)
    return success and newCount or 0
end

-- ==========================================
-- CODE REDEMPTION
-- ==========================================

-- Validate a promo code
function PromoCode.validateCode(code)
    -- Normalize code (uppercase, trim)
    code = string.upper(string.gsub(code, "%s+", ""))

    local codeData = PROMO_CODES[code]
    if not codeData then
        return nil, "INVALID"
    end

    if not codeData.active then
        return nil, "INACTIVE"
    end

    -- Check expiration
    if codeData.expiresAt and os.time() > codeData.expiresAt then
        return nil, "EXPIRED"
    end

    -- Check max uses (for global codes)
    if codeData.maxUses then
        local currentUses = getGlobalCodeUsage(code)
        if currentUses >= codeData.maxUses then
            return nil, "LIMIT_REACHED"
        end
    end

    return codeData, "VALID"
end

-- Check if player has already redeemed a code
function PromoCode.hasPlayerRedeemedCode(data, code)
    code = string.upper(string.gsub(code, "%s+", ""))
    return data.redeemedCodes[code] ~= nil
end

-- Redeem a promo code
-- Returns: success, message, rewardInfo
function PromoCode.redeemCode(player, data, code)
    -- Normalize code
    code = string.upper(string.gsub(code, "%s+", ""))

    -- 1. Validate code exists and is active
    local codeData, status = PromoCode.validateCode(code)

    if not codeData then
        local errorMessages = {
            INVALID = "Invalid code. Please check and try again.",
            INACTIVE = "This code is no longer active.",
            EXPIRED = "This code has expired.",
            LIMIT_REACHED = "This code has reached its redemption limit."
        }
        return false, errorMessages[status] or "Invalid code.", nil
    end

    -- 2. Check if player already used this code
    if PromoCode.hasPlayerRedeemedCode(data, code) then
        return false, "You've already redeemed this code!", nil
    end

    -- 3. Increment global usage (for global codes)
    if codeData.codeType == "global" and codeData.maxUses then
        incrementGlobalCodeUsage(code)
    end

    -- 4. Record redemption for player
    data.redeemedCodes[code] = {
        timestamp = os.time(),
        rewardId = codeData.rewardId,
        rewardName = codeData.rewardName
    }
    data.totalCodesRedeemed = data.totalCodesRedeemed + 1

    if data.firstRedemptionTime == 0 then
        data.firstRedemptionTime = os.time()
    end

    PromoCode.save(player, data)

    -- 5. Return success with reward info
    -- Note: Actual item granting handled by caller (InventoryService)
    return true, "Code redeemed!", {
        rewardId = codeData.rewardId,
        rewardName = codeData.rewardName,
        rewardEmoji = codeData.rewardEmoji,
        code = code
    }
end

-- ==========================================
-- UI HELPERS
-- ==========================================

-- Get all codes redeemed by player (for Settings display)
function PromoCode.getRedeemedCodes(data)
    local codes = {}

    for code, info in pairs(data.redeemedCodes) do
        table.insert(codes, {
            code = code,
            rewardId = info.rewardId,
            rewardName = info.rewardName,
            redeemedAt = info.timestamp
        })
    end

    -- Sort by redemption time (newest first)
    table.sort(codes, function(a, b)
        return (a.redeemedAt or 0) > (b.redeemedAt or 0)
    end)

    return codes
end

-- Get redemption count
function PromoCode.getRedemptionCount(data)
    return data.totalCodesRedeemed or 0
end

-- Get UI data for code entry screen
function PromoCode.getCodeEntryUIData()
    return {
        title = "Enter Promo Code",
        subtitle = "Have a special code? Enter it below!",
        placeholder = "Enter code here...",
        buttonText = "Redeem Code",
        helpText = "Find codes on DiscoverHealthQuest.com"
    }
end

-- Get UI data for success modal
function PromoCode.getSuccessUIData(rewardInfo)
    return {
        title = "🎉 Code Redeemed!",
        subtitle = "You received:",
        rewardName = rewardInfo.rewardName,
        rewardEmoji = rewardInfo.rewardEmoji,
        message = "Check your Sticker Book!",
        buttonText = "Awesome!"
    }
end

-- Get UI data for error modal
function PromoCode.getErrorUIData(errorMessage)
    return {
        title = "Oops!",
        message = errorMessage,
        buttonText = "Try Again"
    }
end

-- ==========================================
-- ADMIN FUNCTIONS (for future use)
-- ==========================================

-- Add a new promo code (would be called by admin system)
function PromoCode.addCode(code, rewardId, rewardName, rewardEmoji, codeType, maxUses, expiresAt)
    PROMO_CODES[string.upper(code)] = {
        rewardId = rewardId,
        rewardName = rewardName,
        rewardEmoji = rewardEmoji,
        codeType = codeType or "global",
        maxUses = maxUses,
        expiresAt = expiresAt,
        active = true
    }
end

-- Deactivate a code
function PromoCode.deactivateCode(code)
    code = string.upper(code)
    if PROMO_CODES[code] then
        PROMO_CODES[code].active = false
        return true
    end
    return false
end

-- Get all active codes (for admin)
function PromoCode.getAllCodes()
    return PROMO_CODES
end

return PromoCode
