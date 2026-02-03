--[[
    LumoCare.lua
    Manages Lumo (pet) care loop and health mechanics

    RULES:
    - 3 Physical needs: Hunger, Thirst, Hygiene
    - Physical needs decay over 72 hours (100% → 0%)
    - Emotions are DERIVED from physical need percentages (see CARE_LOOP.md)
    - Care actions cost coins (15 each)
    - If NO CARE for 72 hours → Lumo flies away (solo quest, gets lost)
    - Use MAP (150 Robux) to bring Lumo back at 50% health
    - Emotion guess: 3 attempts per day, correct = 10 coins earned

    EMOTION PRIORITY (based on physical needs):
    1. THIRSTY - thirst ≤ 10%
    2. HUNGRY - hunger ≤ 10%
    3. MESSY - hygiene ≤ 15%
    4. ANGRY - hunger < 25% AND thirst < 25%
    5. SAD - 25-50% hunger AND thirst > 50% AND hygiene < 40%
    6. ANXIOUS - 25-50% hunger AND 25-50% thirst AND hygiene > 50%
    7. SCARED - hunger > 30% AND thirst > 30% AND 25-50% hygiene
    8. TIRED - Any need 25-35%
    9. PLAYFUL - All needs 50-75%
    10. HAPPY - All needs > 75%

    RESTRICTION WHEN LUMO IS GONE:
    - Player CANNOT leave the castle
    - Can only do quest lessons (to earn coins)
    - Must buy MAP (150 Robux) to bring Lumo back
    - This creates pressure to purchase or grind lessons

    CARE COSTS:
    - Feed: 15 coins
    - Water: 15 coins
    - Clean: 15 coins
    - Total daily care: 45 coins (minus emotion guess rewards)

    TIMERS:
    - Need decay: 72 hours (100% → 0%)
    - Fly away threshold: 72 hours of no care
    - Emotion guess cooldown: resets daily
]]

local DataStoreService = game:GetService("DataStoreService")
local LumoDataStore = DataStoreService:GetDataStore("LumoCare_v1")

local LumoCare = {}

-- Constants
local NEED_DECAY_HOURS = 72           -- Hours for need to go from 100% to 0% (matches fly away time)
local FLY_AWAY_HOURS = 72             -- Hours of no care before Lumo leaves
local MAP_ROBUX_PRICE = 150           -- Robux to bring Lumo back (3 days neglect = higher price)
local RETURN_HEALTH_PERCENT = 50      -- Health when Lumo returns

local CARE_COST_FEED = 15
local CARE_COST_WATER = 15
local CARE_COST_CLEAN = 15
local CARE_COST_EMOTIONAL = 15

local EMOTION_GUESS_REWARD = 10       -- Coins for correct guess
local MAX_EMOTION_GUESSES_PER_DAY = 3

-- Emotions Lumo can feel (determined by physical needs, checked in priority order)
-- From CARE_LOOP.md - emotions are based on hunger, thirst, hygiene percentages
local EMOTIONS = {
    "thirsty", "hungry", "messy", "angry", "sad",
    "anxious", "scared", "tired", "playful", "happy"
}

-- Determine Lumo's emotion based on physical needs (priority order)
local function determineEmotion(hunger, thirst, hygiene)
    -- Priority 1: THIRSTY - thirst ≤ 10%
    if thirst <= 10 then
        return "thirsty"
    end

    -- Priority 2: HUNGRY - thirst > 10% AND hunger ≤ 10%
    if thirst > 10 and hunger <= 10 then
        return "hungry"
    end

    -- Priority 3: MESSY - thirst > 10% AND hunger > 10% AND hygiene ≤ 15%
    if thirst > 10 and hunger > 10 and hygiene <= 15 then
        return "messy"
    end

    -- Priority 4: ANGRY - hunger < 25% AND thirst < 25%
    if hunger < 25 and thirst < 25 then
        return "angry"
    end

    -- Priority 5: SAD - 25% ≤ hunger ≤ 50% AND thirst > 50% AND hygiene < 40%
    if hunger >= 25 and hunger <= 50 and thirst > 50 and hygiene < 40 then
        return "sad"
    end

    -- Priority 6: ANXIOUS - 25-50% hunger AND 25-50% thirst AND hygiene > 50%
    if hunger >= 25 and hunger <= 50 and thirst >= 25 and thirst <= 50 and hygiene > 50 then
        return "anxious"
    end

    -- Priority 7: SCARED - hunger > 30% AND thirst > 30% AND 25-50% hygiene
    if hunger > 30 and thirst > 30 and hygiene >= 25 and hygiene <= 50 then
        return "scared"
    end

    -- Priority 8: TIRED - Any need between 25-35% AND no tough emotions apply
    if (hunger >= 25 and hunger <= 35) or (thirst >= 25 and thirst <= 35) or (hygiene >= 25 and hygiene <= 35) then
        return "tired"
    end

    -- Priority 9: PLAYFUL - 50-75% hunger AND 50-75% thirst AND 50-75% hygiene
    if hunger >= 50 and hunger <= 75 and thirst >= 50 and thirst <= 75 and hygiene >= 50 and hygiene <= 75 then
        return "playful"
    end

    -- Priority 10: HAPPY - hunger > 75% AND thirst > 75% AND hygiene > 75%
    if hunger > 75 and thirst > 75 and hygiene > 75 then
        return "happy"
    end

    -- Default fallback
    return "tired"
end

-- Default Lumo data
local DEFAULT_DATA = {
    -- Physical needs (0-100) - decay over 72 hours
    -- Emotions are DERIVED from these values, not stored separately
    hunger = 100,
    thirst = 100,
    hygiene = 100,     -- cleanliness

    -- Timestamps for decay calculation
    lastFeedTime = 0,
    lastWaterTime = 0,
    lastCleanTime = 0,
    lastAnyCareTime = 0,              -- For 72-hour fly away check

    -- Lumo status
    isPresent = true,                 -- false = flew away
    flyAwayTime = 0,                  -- When Lumo left

    -- Emotion guessing (emotion is calculated from physical needs, not stored)
    emotionGuessesUsed = 0,           -- Today's guesses
    lastEmotionGuessDate = "",        -- "2026-02-03" for daily reset
    lastCorrectGuessTime = 0,

    -- Stats
    totalCareActions = 0,
    totalCorrectGuesses = 0,
    timesFlewAway = 0,
    timesReturned = 0
}

-- Helper: Get current date string
local function getDateString()
    return os.date("%Y-%m-%d")
end

-- Helper: Calculate decayed need value
local function calculateDecayedNeed(lastCareTime, baseValue)
    if lastCareTime == 0 then
        return baseValue
    end

    local now = os.time()
    local hoursSinceCare = (now - lastCareTime) / 3600
    local decayPerHour = 100 / NEED_DECAY_HOURS  -- ~4.17% per hour

    local decayedValue = baseValue - (hoursSinceCare * decayPerHour)
    return math.max(0, math.min(100, decayedValue))
end

-- Load Lumo data
function LumoCare.load(player)
    local userId = player.UserId
    local key = "Lumo_" .. userId

    local success, data = pcall(function()
        return LumoDataStore:GetAsync(key)
    end)

    if success and data then
        -- Merge with defaults
        for k, v in pairs(DEFAULT_DATA) do
            if data[k] == nil then
                data[k] = v
            end
        end

        -- Reset daily emotion guesses if new day
        if data.lastEmotionGuessDate ~= getDateString() then
            data.emotionGuessesUsed = 0
            data.lastEmotionGuessDate = getDateString()
            -- Randomize Lumo's emotion for new day
            data.currentEmotion = EMOTIONS[math.random(1, #EMOTIONS)]
        end

        return data
    else
        -- New player
        local newData = table.clone(DEFAULT_DATA)
        newData.lastAnyCareTime = os.time()
        newData.lastFeedTime = os.time()
        newData.lastWaterTime = os.time()
        newData.lastCleanTime = os.time()
        newData.lastEmotionGuessDate = getDateString()
        return newData
    end
end

-- Save Lumo data
function LumoCare.save(player, data)
    local userId = player.UserId
    local key = "Lumo_" .. userId

    local success, err = pcall(function()
        LumoDataStore:SetAsync(key, data)
    end)

    if not success then
        warn("Failed to save Lumo data for " .. player.Name .. ": " .. tostring(err))
    end

    return success
end

-- Check if Lumo should fly away (72 hours no care)
function LumoCare.checkFlyAway(player, data)
    if not data.isPresent then
        return false, "already_gone"
    end

    local now = os.time()
    local hoursSinceCare = (now - data.lastAnyCareTime) / 3600

    if hoursSinceCare >= FLY_AWAY_HOURS then
        data.isPresent = false
        data.flyAwayTime = now
        data.timesFlewAway = data.timesFlewAway + 1

        LumoCare.save(player, data)
        return true, "flew_away", {
            hoursSinceCare = hoursSinceCare,
            message = "Lumo went on a solo quest and got lost! Use a map to find them."
        }
    end

    return false, "still_here", {
        hoursUntilFlyAway = FLY_AWAY_HOURS - hoursSinceCare
    }
end

-- Get current health status (with decay calculated)
function LumoCare.getStatus(data)
    -- Check if Lumo is present first
    if not data.isPresent then
        return {
            isPresent = false,
            flyAwayTime = data.flyAwayTime,
            mapPrice = MAP_ROBUX_PRICE,
            canLeaveCastle = false,
            allowedActions = LumoCare.getAllowedActionsWithoutLumo(),
            message = "Lumo is lost! You're stuck in the castle. Do lessons to earn coins, then use a map (100 Robux) to bring Lumo back."
        }
    end

    -- Calculate current needs with decay (72-hour decay)
    local hunger = calculateDecayedNeed(data.lastFeedTime, 100)
    local thirst = calculateDecayedNeed(data.lastWaterTime, 100)
    local hygiene = calculateDecayedNeed(data.lastCleanTime, 100)

    -- Determine emotion based on physical needs (from CARE_LOOP.md percentages)
    local currentEmotion = determineEmotion(hunger, thirst, hygiene)

    -- Overall health is average of physical needs
    local overallHealth = (hunger + thirst + hygiene) / 3

    -- Hours until fly away
    local hoursSinceCare = (os.time() - data.lastAnyCareTime) / 3600
    local hoursUntilFlyAway = FLY_AWAY_HOURS - hoursSinceCare

    return {
        isPresent = true,
        canLeaveCastle = true,

        -- Physical needs (emotions derived from these)
        hunger = math.floor(hunger),
        thirst = math.floor(thirst),
        hygiene = math.floor(hygiene),
        overallHealth = math.floor(overallHealth),

        -- Current emotion (determined by physical need percentages)
        currentEmotion = currentEmotion,  -- For internal use
        emotionHidden = true,             -- Don't show to player until they guess

        -- Care costs
        careCosts = {
            feed = CARE_COST_FEED,
            water = CARE_COST_WATER,
            clean = CARE_COST_CLEAN
        },

        -- Timers
        hoursUntilFlyAway = math.max(0, hoursUntilFlyAway),

        -- Emotion guessing
        emotionGuessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - data.emotionGuessesUsed,
        emotionGuessReward = EMOTION_GUESS_REWARD,

        -- Stats
        totalCareActions = data.totalCareActions,
        totalCorrectGuesses = data.totalCorrectGuesses
    }
end

-- Feed Lumo (costs coins)
function LumoCare.feed(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0
    end

    if playerCoins < CARE_COST_FEED then
        return false, "Not enough coins", 0
    end

    data.hunger = 100
    data.lastFeedTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1

    LumoCare.save(player, data)
    return true, "Lumo is full!", CARE_COST_FEED
end

-- Give water to Lumo
function LumoCare.water(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0
    end

    if playerCoins < CARE_COST_WATER then
        return false, "Not enough coins", 0
    end

    data.thirst = 100
    data.lastWaterTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1

    LumoCare.save(player, data)
    return true, "Lumo is hydrated!", CARE_COST_WATER
end

-- Clean Lumo (hygiene)
function LumoCare.clean(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0
    end

    if playerCoins < CARE_COST_CLEAN then
        return false, "Not enough coins", 0
    end

    data.hygiene = 100
    data.lastCleanTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1

    LumoCare.save(player, data)
    return true, "Lumo is sparkling clean!", CARE_COST_CLEAN
end

-- Note: Emotional care is handled through the Helper Zone
-- Emotions are derived from physical needs, so caring for physical needs
-- automatically improves Lumo's emotional state

-- Guess Lumo's emotion (FREE attempt, earn coins if correct)
function LumoCare.guessEmotion(player, data, guessedEmotion)
    if not data.isPresent then
        return false, "Lumo is lost!", 0, nil
    end

    -- Check daily reset
    if data.lastEmotionGuessDate ~= getDateString() then
        data.emotionGuessesUsed = 0
        data.lastEmotionGuessDate = getDateString()
    end

    -- Check if guesses remaining
    if data.emotionGuessesUsed >= MAX_EMOTION_GUESSES_PER_DAY then
        return false, "No guesses left today! Come back tomorrow.", 0, nil
    end

    data.emotionGuessesUsed = data.emotionGuessesUsed + 1

    -- Calculate current emotion from physical needs
    local hunger = calculateDecayedNeed(data.lastFeedTime, 100)
    local thirst = calculateDecayedNeed(data.lastWaterTime, 100)
    local hygiene = calculateDecayedNeed(data.lastCleanTime, 100)
    local currentEmotion = determineEmotion(hunger, thirst, hygiene)

    -- Check if correct
    local isCorrect = (guessedEmotion == currentEmotion)

    if isCorrect then
        data.totalCorrectGuesses = data.totalCorrectGuesses + 1
        data.lastCorrectGuessTime = os.time()
        data.lastAnyCareTime = os.time()  -- Correct guess counts as care!

        LumoCare.save(player, data)
        return true, "Correct! Lumo feels understood!", EMOTION_GUESS_REWARD, {
            wasCorrect = true,
            guessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - data.emotionGuessesUsed,
            coinsEarned = EMOTION_GUESS_REWARD
        }
    else
        LumoCare.save(player, data)
        return false, "Not quite... Lumo is feeling " .. currentEmotion, 0, {
            wasCorrect = false,
            correctEmotion = currentEmotion,
            guessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - data.emotionGuessesUsed
        }
    end
end

-- Bring Lumo back with map (150 Robux)
-- Called AFTER successful Robux purchase
function LumoCare.bringBackWithMap(player, data)
    if data.isPresent then
        return false, "Lumo is already here!"
    end

    -- Bring back at 50% health (all physical needs at 50%)
    data.isPresent = true
    data.hunger = RETURN_HEALTH_PERCENT
    data.thirst = RETURN_HEALTH_PERCENT
    data.hygiene = RETURN_HEALTH_PERCENT

    -- Reset timers (start decay from 50%, so partial time until 0%)
    -- We set times as if care happened at 50% point
    local now = os.time()
    local halfDecaySeconds = (NEED_DECAY_HOURS / 2) * 3600  -- Half of 72 hours in seconds
    data.lastFeedTime = now - halfDecaySeconds   -- Will show 50%
    data.lastWaterTime = now - halfDecaySeconds
    data.lastCleanTime = now - halfDecaySeconds
    data.lastAnyCareTime = now
    data.flyAwayTime = 0

    data.timesReturned = data.timesReturned + 1

    LumoCare.save(player, data)
    return true, "Lumo found their way back! They're at 50% health - take care of them!", {
        health = RETURN_HEALTH_PERCENT
    }
end

-- Get map price
function LumoCare.getMapPrice()
    return MAP_ROBUX_PRICE
end

-- Check if player can leave castle (requires Lumo to be present)
function LumoCare.canLeaveCastle(data)
    if data.isPresent then
        return true, "Lumo is with you!"
    else
        return false, "You can't leave without Lumo! Use a map (100 Robux) to find them, or do lessons to earn coins."
    end
end

-- Get allowed actions when Lumo is gone
function LumoCare.getAllowedActionsWithoutLumo()
    return {
        canDoLessons = true,        -- Can earn coins
        canAccessShop = false,      -- No shopping
        canLeaveCastle = false,     -- Stuck inside
        canAccessMeadow = false,    -- No meadow
        canAccessPortals = false,   -- No world portals
        canPlayMiniGames = false,   -- No mini-games
        message = "Lumo is lost! You can only do lessons until you bring them back."
    }
end

-- Get all possible emotions (for UI)
function LumoCare.getEmotionsList()
    return EMOTIONS
end

-- Get care costs (for UI)
function LumoCare.getCareCosts()
    return {
        feed = CARE_COST_FEED,
        water = CARE_COST_WATER,
        clean = CARE_COST_CLEAN,
        totalDaily = CARE_COST_FEED + CARE_COST_WATER + CARE_COST_CLEAN  -- 45 coins
    }
end

return LumoCare
