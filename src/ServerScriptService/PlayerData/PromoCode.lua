--[[
    PromoCode.lua
    Cross-Platform Promo Code System

    PURPOSE:
    When players reach milestones in Lumo's Land, they receive a unique promo code
    that can be redeemed on the HealthQuest web app (DiscoverHealthQuest.com)

    MILESTONES THAT TRIGGER CODES:
    1. FIRST_QUEST_COMPLETE - Complete first quest (102 lessons)
    2. LUMO_ADULT - Lumo evolves to Adult stage (1000+ care actions)
    3. LEVEL_10 - Player reaches level 10
    4. PERFECT_WEEK - 7 consecutive days of caring for Lumo

    CODE GENERATION:
    - Option A: Pre-generated batch codes (current implementation)
    - Option B: Dynamic codes via API (future enhancement)

    DISPLAY:
    - Pop-up modal congratulating player
    - Code displayed as text (no external links - Roblox TOS compliant)
    - Code saved in player inventory/settings for later retrieval
    - Code only granted ONCE per account per milestone

    EXAMPLE MESSAGE:
    "Congratulations! Show this code to your parent!
     They can use it at DiscoverHealthQuest.com for a free bonus!
     Your code: LUMO-7X9K2M"
]]

local DataStoreService = game:GetService("DataStoreService")
local PromoDataStore = DataStoreService:GetDataStore("PromoCodes_v1")
local CodePoolStore = DataStoreService:GetDataStore("PromoCodePool_v1")

local PromoCode = {}

-- Milestone definitions
local MILESTONES = {
    FIRST_QUEST_COMPLETE = {
        id = "FIRST_QUEST_COMPLETE",
        name = "Quest Champion",
        description = "Complete your first quest",
        reward = "Special web bonus",
        codePrefix = "QUEST"
    },
    LUMO_ADULT = {
        id = "LUMO_ADULT",
        name = "Devoted Caretaker",
        description = "Evolve Lumo to Adult stage",
        reward = "Exclusive web content",
        codePrefix = "CARE"
    },
    LEVEL_10 = {
        id = "LEVEL_10",
        name = "Rising Star",
        description = "Reach Level 10",
        reward = "Web app upgrade",
        codePrefix = "STAR"
    },
    PERFECT_WEEK = {
        id = "PERFECT_WEEK",
        name = "Perfect Caretaker",
        description = "Care for Lumo 7 days in a row",
        reward = "Week streak bonus",
        codePrefix = "WEEK"
    }
}

-- Default player promo data
local DEFAULT_DATA = {
    -- Earned codes (milestone -> code)
    earnedCodes = {},          -- {FIRST_QUEST_COMPLETE = "QUEST-A1B2C3", ...}

    -- Milestone tracking
    milestonesCompleted = {},  -- {FIRST_QUEST_COMPLETE = timestamp, ...}

    -- Stats
    totalCodesEarned = 0,
    firstCodeEarnedTime = 0,

    -- For perfect week tracking
    consecutiveCareDays = 0,
    lastCareDate = ""
}

-- Generate a random code (Option A: simple generation)
-- Format: PREFIX-XXXXXX (6 alphanumeric characters)
local function generateCode(prefix)
    local chars = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789" -- Removed confusing chars (0,O,1,I,L)
    local code = prefix .. "-"

    for i = 1, 6 do
        local idx = math.random(1, #chars)
        code = code .. chars:sub(idx, idx)
    end

    return code
end

-- Load player promo data
function PromoCode.load(player)
    local userId = player.UserId
    local key = "Promo_" .. userId

    local success, data = pcall(function()
        return PromoDataStore:GetAsync(key)
    end)

    if success and data then
        -- Merge with defaults
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

-- Check if player has already earned a milestone code
function PromoCode.hasEarnedCode(data, milestoneId)
    return data.earnedCodes[milestoneId] ~= nil
end

-- Get a player's code for a milestone (if earned)
function PromoCode.getCode(data, milestoneId)
    return data.earnedCodes[milestoneId]
end

-- Award a promo code for a milestone
-- Returns: success, message, codeInfo
function PromoCode.awardCode(player, data, milestoneId)
    -- Validate milestone
    local milestone = MILESTONES[milestoneId]
    if not milestone then
        return false, "Invalid milestone", nil
    end

    -- Check if already earned
    if data.earnedCodes[milestoneId] then
        return false, "Code already earned for this milestone", {
            alreadyEarned = true,
            code = data.earnedCodes[milestoneId]
        }
    end

    -- Generate unique code
    local code = generateCode(milestone.codePrefix)

    -- Store the code
    data.earnedCodes[milestoneId] = code
    data.milestonesCompleted[milestoneId] = os.time()
    data.totalCodesEarned = data.totalCodesEarned + 1

    if data.firstCodeEarnedTime == 0 then
        data.firstCodeEarnedTime = os.time()
    end

    PromoCode.save(player, data)

    return true, "Code earned!", {
        code = code,
        milestone = milestone,
        message = buildRewardMessage(milestone, code)
    }
end

-- Build the reward message for display
function buildRewardMessage(milestone, code)
    return {
        title = "Congratulations!",
        subtitle = milestone.name,
        description = milestone.description,
        instruction = "Show this code to your parent! They can use it at DiscoverHealthQuest.com for a free bonus!",
        code = code,
        reward = milestone.reward
    }
end

-- Get all earned codes for display in inventory/settings
function PromoCode.getAllEarnedCodes(data)
    local codes = {}

    for milestoneId, code in pairs(data.earnedCodes) do
        local milestone = MILESTONES[milestoneId]
        if milestone then
            table.insert(codes, {
                milestoneId = milestoneId,
                milestoneName = milestone.name,
                description = milestone.description,
                code = code,
                earnedTime = data.milestonesCompleted[milestoneId],
                reward = milestone.reward
            })
        end
    end

    -- Sort by earned time (oldest first)
    table.sort(codes, function(a, b)
        return (a.earnedTime or 0) < (b.earnedTime or 0)
    end)

    return codes
end

-- ==========================================
-- MILESTONE CHECKING FUNCTIONS
-- (Call these from other systems when events happen)
-- ==========================================

-- Check: First Quest Complete
function PromoCode.checkFirstQuestComplete(player, data, questData)
    if questData.totalQuestsCompleted >= 1 then
        if not PromoCode.hasEarnedCode(data, "FIRST_QUEST_COMPLETE") then
            return PromoCode.awardCode(player, data, "FIRST_QUEST_COMPLETE")
        end
    end
    return false, "Milestone not reached", nil
end

-- Check: Lumo Adult Stage
function PromoCode.checkLumoAdult(player, data, lumoData)
    local stage = lumoData.currentStage or 1
    if stage >= 6 then -- Adult is stage 6
        if not PromoCode.hasEarnedCode(data, "LUMO_ADULT") then
            return PromoCode.awardCode(player, data, "LUMO_ADULT")
        end
    end
    return false, "Milestone not reached", nil
end

-- Check: Level 10
function PromoCode.checkLevel10(player, data, playerLevel)
    if playerLevel >= 10 then
        if not PromoCode.hasEarnedCode(data, "LEVEL_10") then
            return PromoCode.awardCode(player, data, "LEVEL_10")
        end
    end
    return false, "Milestone not reached", nil
end

-- Check: Perfect Week (7 consecutive care days)
function PromoCode.checkPerfectWeek(player, data, careDate)
    local today = careDate or os.date("%Y-%m-%d")

    -- Check if this is a new day
    if data.lastCareDate ~= today then
        -- Check if consecutive (yesterday)
        local yesterday = os.date("%Y-%m-%d", os.time() - 86400)

        if data.lastCareDate == yesterday then
            data.consecutiveCareDays = data.consecutiveCareDays + 1
        else
            data.consecutiveCareDays = 1 -- Reset streak
        end

        data.lastCareDate = today
    end

    -- Check for 7-day streak
    if data.consecutiveCareDays >= 7 then
        if not PromoCode.hasEarnedCode(data, "PERFECT_WEEK") then
            local success, msg, info = PromoCode.awardCode(player, data, "PERFECT_WEEK")
            data.consecutiveCareDays = 0 -- Reset after earning
            return success, msg, info
        end
    end

    return false, "Milestone not reached", {
        currentStreak = data.consecutiveCareDays,
        daysNeeded = 7 - data.consecutiveCareDays
    }
end

-- ==========================================
-- UI HELPER FUNCTIONS
-- ==========================================

-- Get promo code display data for UI modal
function PromoCode.getCodeDisplayData(milestone, code)
    return {
        -- Modal content
        title = "Amazing Achievement!",
        subtitle = milestone.name,

        -- Code display (large, prominent)
        code = code,
        codeLabel = "Your Special Code:",

        -- Instructions (no links, Roblox TOS compliant)
        instructions = {
            "Show this code to your parent!",
            "They can use it at:",
            "DiscoverHealthQuest.com",
            "for a FREE bonus reward!"
        },

        -- Additional info
        reward = milestone.reward,
        tip = "This code is saved in your Settings menu",

        -- Button
        buttonText = "Got it!"
    }
end

-- Get summary for settings/inventory display
function PromoCode.getSettingsDisplay(data)
    local earnedCodes = PromoCode.getAllEarnedCodes(data)

    return {
        title = "My Promo Codes",
        subtitle = "Show these to your parent for web bonuses!",
        website = "DiscoverHealthQuest.com",
        codes = earnedCodes,
        totalEarned = data.totalCodesEarned,

        -- Milestones progress
        availableMilestones = {
            {
                id = "FIRST_QUEST_COMPLETE",
                name = "Quest Champion",
                description = "Complete your first quest",
                earned = data.earnedCodes["FIRST_QUEST_COMPLETE"] ~= nil
            },
            {
                id = "LUMO_ADULT",
                name = "Devoted Caretaker",
                description = "Evolve Lumo to Adult stage",
                earned = data.earnedCodes["LUMO_ADULT"] ~= nil
            },
            {
                id = "LEVEL_10",
                name = "Rising Star",
                description = "Reach Level 10",
                earned = data.earnedCodes["LEVEL_10"] ~= nil
            },
            {
                id = "PERFECT_WEEK",
                name = "Perfect Caretaker",
                description = "Care for Lumo 7 days in a row",
                earned = data.earnedCodes["PERFECT_WEEK"] ~= nil
            }
        }
    }
end

-- Export milestones for reference
PromoCode.MILESTONES = MILESTONES

return PromoCode
