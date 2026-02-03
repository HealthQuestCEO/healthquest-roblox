--[[
    LumoCare.lua
    Manages Lumo (pet) care loop and health mechanics

    RULES:
    - Physical needs decay over 24 hours (100% → 0%)
    - 4 needs: Hunger, Thirst, Cleanliness, Emotional
    - Care actions cost coins (15 each for physical, emotional guess = free attempt)
    - If NO CARE for 72 hours → Lumo flies away (solo quest, gets lost)
    - Use MAP (100 Robux) to bring Lumo back at 50% health
    - Emotion guess: 3 attempts per day, correct = 10 coins earned

    CARE COSTS:
    - Feed: 15 coins
    - Water: 15 coins
    - Clean: 15 coins
    - Emotional care: 15 coins
    - Total daily care: 60 coins (minus 10 from emotion guess = 50 net)

    TIMERS:
    - Need decay: 24 hours (100% → 0%)
    - Fly away threshold: 72 hours of no care
    - Emotion guess cooldown: resets daily
]]

local DataStoreService = game:GetService("DataStoreService")
local LumoDataStore = DataStoreService:GetDataStore("LumoCare_v1")

local LumoCare = {}

-- Constants
local NEED_DECAY_HOURS = 24           -- Hours for need to go from 100% to 0%
local FLY_AWAY_HOURS = 72             -- Hours of no care before Lumo leaves
local MAP_ROBUX_PRICE = 100           -- Robux to bring Lumo back
local RETURN_HEALTH_PERCENT = 50      -- Health when Lumo returns

local CARE_COST_FEED = 15
local CARE_COST_WATER = 15
local CARE_COST_CLEAN = 15
local CARE_COST_EMOTIONAL = 15

local EMOTION_GUESS_REWARD = 10       -- Coins for correct guess
local MAX_EMOTION_GUESSES_PER_DAY = 3

-- Emotions Lumo can feel
local EMOTIONS = {
    "happy", "sad", "anxious", "excited", "tired",
    "frustrated", "calm", "lonely", "proud", "confused"
}

-- Default Lumo data
local DEFAULT_DATA = {
    -- Health needs (0-100)
    hunger = 100,
    thirst = 100,
    cleanliness = 100,
    emotional = 100,

    -- Timestamps for decay calculation
    lastFeedTime = 0,
    lastWaterTime = 0,
    lastCleanTime = 0,
    lastEmotionalCareTime = 0,
    lastAnyCareTime = 0,              -- For 72-hour fly away check

    -- Lumo status
    isPresent = true,                 -- false = flew away
    flyAwayTime = 0,                  -- When Lumo left

    -- Emotion guessing
    currentEmotion = "happy",         -- Lumo's current emotion
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
        newData.lastEmotionalCareTime = os.time()
        newData.lastEmotionGuessDate = getDateString()
        newData.currentEmotion = EMOTIONS[math.random(1, #EMOTIONS)]
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
            message = "Lumo is lost! Use a map (100 Robux) to bring them back."
        }
    end

    -- Calculate current needs with decay
    local hunger = calculateDecayedNeed(data.lastFeedTime, 100)
    local thirst = calculateDecayedNeed(data.lastWaterTime, 100)
    local cleanliness = calculateDecayedNeed(data.lastCleanTime, 100)
    local emotional = calculateDecayedNeed(data.lastEmotionalCareTime, 100)

    -- Overall health is average of all needs
    local overallHealth = (hunger + thirst + cleanliness + emotional) / 4

    -- Hours until fly away
    local hoursSinceCare = (os.time() - data.lastAnyCareTime) / 3600
    local hoursUntilFlyAway = FLY_AWAY_HOURS - hoursSinceCare

    return {
        isPresent = true,
        hunger = math.floor(hunger),
        thirst = math.floor(thirst),
        cleanliness = math.floor(cleanliness),
        emotional = math.floor(emotional),
        overallHealth = math.floor(overallHealth),

        -- Care costs
        careCosts = {
            feed = CARE_COST_FEED,
            water = CARE_COST_WATER,
            clean = CARE_COST_CLEAN,
            emotional = CARE_COST_EMOTIONAL
        },

        -- Timers
        hoursUntilFlyAway = math.max(0, hoursUntilFlyAway),

        -- Emotion guessing
        currentEmotion = nil,  -- Hidden until they guess
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

-- Clean Lumo
function LumoCare.clean(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0
    end

    if playerCoins < CARE_COST_CLEAN then
        return false, "Not enough coins", 0
    end

    data.cleanliness = 100
    data.lastCleanTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1

    LumoCare.save(player, data)
    return true, "Lumo is sparkling clean!", CARE_COST_CLEAN
end

-- Emotional care (costs coins)
function LumoCare.emotionalCare(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0
    end

    if playerCoins < CARE_COST_EMOTIONAL then
        return false, "Not enough coins", 0
    end

    data.emotional = 100
    data.lastEmotionalCareTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1

    LumoCare.save(player, data)
    return true, "Lumo feels loved!", CARE_COST_EMOTIONAL
end

-- Guess Lumo's emotion (FREE attempt, earn coins if correct)
function LumoCare.guessEmotion(player, data, guessedEmotion)
    if not data.isPresent then
        return false, "Lumo is lost!", 0, nil
    end

    -- Check daily reset
    if data.lastEmotionGuessDate ~= getDateString() then
        data.emotionGuessesUsed = 0
        data.lastEmotionGuessDate = getDateString()
        data.currentEmotion = EMOTIONS[math.random(1, #EMOTIONS)]
    end

    -- Check if guesses remaining
    if data.emotionGuessesUsed >= MAX_EMOTION_GUESSES_PER_DAY then
        return false, "No guesses left today! Come back tomorrow.", 0, nil
    end

    data.emotionGuessesUsed = data.emotionGuessesUsed + 1

    -- Check if correct
    local isCorrect = (guessedEmotion == data.currentEmotion)

    if isCorrect then
        data.totalCorrectGuesses = data.totalCorrectGuesses + 1
        data.lastCorrectGuessTime = os.time()
        data.lastAnyCareTime = os.time()  -- Correct guess counts as care!

        -- Randomize new emotion for next guess
        data.currentEmotion = EMOTIONS[math.random(1, #EMOTIONS)]

        LumoCare.save(player, data)
        return true, "Correct! Lumo feels understood!", EMOTION_GUESS_REWARD, {
            wasCorrect = true,
            guessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - data.emotionGuessesUsed,
            coinsEarned = EMOTION_GUESS_REWARD
        }
    else
        LumoCare.save(player, data)
        return false, "Not quite... Lumo is feeling " .. data.currentEmotion, 0, {
            wasCorrect = false,
            correctEmotion = data.currentEmotion,
            guessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - data.emotionGuessesUsed
        }
    end
end

-- Bring Lumo back with map (100 Robux)
-- Called AFTER successful Robux purchase
function LumoCare.bringBackWithMap(player, data)
    if data.isPresent then
        return false, "Lumo is already here!"
    end

    -- Bring back at 50% health
    data.isPresent = true
    data.hunger = RETURN_HEALTH_PERCENT
    data.thirst = RETURN_HEALTH_PERCENT
    data.cleanliness = RETURN_HEALTH_PERCENT
    data.emotional = RETURN_HEALTH_PERCENT

    -- Reset timers (start decay from now)
    local now = os.time()
    data.lastFeedTime = now
    data.lastWaterTime = now
    data.lastCleanTime = now
    data.lastEmotionalCareTime = now
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
        emotional = CARE_COST_EMOTIONAL,
        totalDaily = CARE_COST_FEED + CARE_COST_WATER + CARE_COST_CLEAN + CARE_COST_EMOTIONAL
    }
end

return LumoCare
