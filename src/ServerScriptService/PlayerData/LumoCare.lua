--[[
    LumoCare.lua
    Manages Lumo (pet) care loop and health mechanics

    RULES:
    - 3 Physical needs: Hunger, Thirst, Hygiene
    - Physical needs decay over 72 hours (100% → 0%)
    - Emotions are DERIVED from physical need percentages (see CARE_LOOP.md)
    - Care actions cost coins (15 each)
    - If NO CARE for 72 hours → Lumo flies away (solo quest, gets lost)
    - Use MAP (120 Robux) to bring Lumo back at 50% health
    - Emotion guess: 3 attempts per day, correct = 10 coins earned

    EVOLUTION STAGES (Lumo grows up with care!):
    Stage 1: EGG (0 care actions) - Just hatched from barrier assessment
    Stage 2: HATCHLING (10+ care actions) - Baby dragon, eyes open
    Stage 3: FLEDGLING (50+ care actions) - Learning to walk, small wings
    Stage 4: JUVENILE (150+ care actions) - Can fly short distances
    Stage 5: ADOLESCENT (400+ care actions) - Full wings, playful
    Stage 6: ADULT (1000+ care actions) - Mature, wise-looking
    Stage 7: ELDER (2500+ care actions) - Glowing, legendary appearance

    EVOLUTION BONUSES:
    - Each stage unlocks new animations/appearances
    - Higher stages = slightly reduced care costs (loyalty discount)
    - Elder Lumo: 20% care discount

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
    - Must buy MAP (120 Robux) to bring Lumo back
    - This creates pressure to purchase or grind lessons

    CARE COSTS:
    - Feed: 15 coins (physical)
    - Water: 15 coins (physical)
    - Clean: 15 coins (physical)
    - Emotional Care: 15 coins (after recognizing emotion)
    - Total daily care: 60 coins (minus emotion guess rewards)

    EMOTION CARE FLOW:
    1. RECOGNIZE: Guess Lumo's emotion (FREE, earn 10 coins if correct)
    2. ADDRESS: Provide emotional care (15 coins) - teaches coping strategies
    - Must guess correctly before emotional care is available
    - Emotional care shows age-appropriate coping technique for that emotion

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
local MAP_ROBUX_PRICE = 120           -- Robux to bring Lumo back (approx 3 days care cost: 45 x 3 = 135)
local RETURN_HEALTH_PERCENT = 50      -- Health when Lumo returns

local CARE_COST_FEED = 15
local CARE_COST_WATER = 15
local CARE_COST_CLEAN = 15
local CARE_COST_EMOTIONAL = 15

local EMOTION_GUESS_REWARD = 10       -- Coins for correct guess
local MAX_EMOTION_GUESSES_PER_DAY = 3

-- Evolution stages (Lumo grows up with care!)
local EVOLUTION_STAGES = {
    { name = "Egg", minCare = 0, discount = 0, description = "A glowing dragon egg" },
    { name = "Hatchling", minCare = 10, discount = 0, description = "Eyes just opened, curious about the world" },
    { name = "Fledgling", minCare = 50, discount = 5, description = "Learning to walk, tiny wings fluttering" },
    { name = "Juvenile", minCare = 150, discount = 10, description = "Can fly short distances, loves to play" },
    { name = "Adolescent", minCare = 400, discount = 12, description = "Full wings, energetic and adventurous" },
    { name = "Adult", minCare = 1000, discount = 15, description = "Mature and wise, a loyal companion" },
    { name = "Elder", minCare = 2500, discount = 20, description = "Glowing with ancient wisdom, legendary" }
}

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

    -- Emotional care (must recognize emotion first, then address it)
    emotionRecognizedToday = false,   -- Did they guess correctly today?
    recognizedEmotion = nil,          -- Which emotion they recognized
    emotionalCareGivenToday = false,  -- Did they provide emotional care today?
    lastEmotionalCareTime = 0,

    -- Stats
    totalCareActions = 0,
    totalCorrectGuesses = 0,
    timesFlewAway = 0,
    timesReturned = 0,

    -- Evolution tracking (Lumo grows up!)
    currentStage = 1,                 -- Current evolution stage (1-7)
    lastEvolutionTime = 0,            -- When last evolution happened
    totalDaysOfCare = 0,              -- Days with at least one care action
    lastCareDate = ""                 -- For tracking daily care streaks
}

-- Helper: Get current date string
local function getDateString()
    return os.date("%Y-%m-%d")
end

-- Helper: Update daily care tracking
local function updateDailyCare(data)
    local today = getDateString()
    if data.lastCareDate ~= today then
        data.lastCareDate = today
        data.totalDaysOfCare = (data.totalDaysOfCare or 0) + 1
    end
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
            message = "Lumo is lost! You're stuck in the castle. Do lessons to earn coins, then use a map (120 Robux) to bring Lumo back."
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
            clean = CARE_COST_CLEAN,
            emotional = CARE_COST_EMOTIONAL
        },

        -- Timers
        hoursUntilFlyAway = math.max(0, hoursUntilFlyAway),

        -- Emotion guessing (Step 1: Recognize)
        emotionGuessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - (data.emotionGuessesUsed or 0),
        emotionGuessReward = EMOTION_GUESS_REWARD,

        -- Emotional care (Step 2: Address)
        emotionRecognizedToday = data.emotionRecognizedToday or false,
        recognizedEmotion = data.recognizedEmotion,
        emotionalCareGivenToday = data.emotionalCareGivenToday or false,
        emotionalCareCost = CARE_COST_EMOTIONAL,

        -- Stats
        totalCareActions = data.totalCareActions,
        totalCorrectGuesses = data.totalCorrectGuesses,

        -- Evolution info
        evolution = LumoCare.getEvolutionInfo(data)
    }
end

-- Feed Lumo (costs coins, with evolution discount)
function LumoCare.feed(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0, nil
    end

    local cost = LumoCare.getDiscountedCareCost(data, CARE_COST_FEED)
    if playerCoins < cost then
        return false, "Not enough coins (need " .. cost .. ")", 0, nil
    end

    data.hunger = 100
    data.lastFeedTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1
    updateDailyCare(data)

    -- Check for evolution
    local evolved, evolutionInfo = LumoCare.checkEvolution(player, data)

    LumoCare.save(player, data)
    return true, "Lumo is full!", cost, evolutionInfo
end

-- Give water to Lumo (with evolution discount)
function LumoCare.water(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0, nil
    end

    local cost = LumoCare.getDiscountedCareCost(data, CARE_COST_WATER)
    if playerCoins < cost then
        return false, "Not enough coins (need " .. cost .. ")", 0, nil
    end

    data.thirst = 100
    data.lastWaterTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1
    updateDailyCare(data)

    -- Check for evolution
    local evolved, evolutionInfo = LumoCare.checkEvolution(player, data)

    LumoCare.save(player, data)
    return true, "Lumo is hydrated!", cost, evolutionInfo
end

-- Clean Lumo (hygiene, with evolution discount)
function LumoCare.clean(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0, nil
    end

    local cost = LumoCare.getDiscountedCareCost(data, CARE_COST_CLEAN)
    if playerCoins < cost then
        return false, "Not enough coins (need " .. cost .. ")", 0, nil
    end

    data.hygiene = 100
    data.lastCleanTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1
    updateDailyCare(data)

    -- Check for evolution
    local evolved, evolutionInfo = LumoCare.checkEvolution(player, data)

    LumoCare.save(player, data)
    return true, "Lumo is sparkling clean!", cost, evolutionInfo
end

-- ==========================================
-- EMOTIONAL CARE SYSTEM (Recognize → Address)
-- ==========================================

-- Emotional care items for each emotion (15 coins each)
-- Each emotion has a specific item that teaches a coping strategy
local EMOTION_CARE_ITEMS = {
    thirsty = {
        item = "Water Bottle",
        emoji = "🍶",
        action = "Give Lumo a refreshing drink",
        message = "Lumo drinks the water happily! Staying hydrated helps us feel better."
    },
    hungry = {
        item = "Healthy Snack",
        emoji = "🍎",
        action = "Give Lumo a healthy snack",
        message = "Lumo munches happily! Eating well gives us energy to handle big feelings."
    },
    messy = {
        item = "Bubble Bath",
        emoji = "🛁",
        action = "Give Lumo a bubble bath",
        message = "Lumo is sparkling clean! A tidy space helps our mind feel calm too."
    },
    angry = {
        item = "Calm Ball",
        emoji = "🔵",
        action = "Squeeze the calm ball together",
        message = "Squeeze and release... Lumo takes 5 deep breaths. The anger floats away."
    },
    sad = {
        item = "Teddy Bear",
        emoji = "🧸",
        action = "Give Lumo a teddy bear hug",
        message = "Lumo hugs the teddy bear tight. It's okay to feel sad. Hugs help!"
    },
    anxious = {
        item = "Grounding Stone",
        emoji = "🪨",
        action = "Hold the grounding stone together",
        message = "Feel the smooth stone... Name 5 things you can see. Lumo feels calmer."
    },
    scared = {
        item = "Brave Cape",
        emoji = "🦸",
        action = "Put on the brave cape",
        message = "Lumo puts on the cape and feels brave! Remember something brave you did."
    },
    tired = {
        item = "Cozy Blanket",
        emoji = "🛏️",
        action = "Wrap Lumo in a cozy blanket",
        message = "Lumo snuggles in the blanket. Rest is important! Take a quiet moment."
    },
    playful = {
        item = "Bouncy Ball",
        emoji = "⚽",
        action = "Play catch with Lumo",
        message = "Lumo bounces with joy! Playing together is so much fun!"
    },
    happy = {
        item = "Party Hat",
        emoji = "🎉",
        action = "Celebrate with Lumo",
        message = "Lumo puts on the party hat! Let's dance and celebrate together!"
    }
}

-- Step 1: Guess Lumo's emotion (FREE attempt, earn coins if correct)
-- Must guess correctly to unlock emotional care
function LumoCare.guessEmotion(player, data, guessedEmotion)
    if not data.isPresent then
        return false, "Lumo is lost!", 0, nil
    end

    -- Check daily reset for guesses AND emotional care
    if data.lastEmotionGuessDate ~= getDateString() then
        data.emotionGuessesUsed = 0
        data.lastEmotionGuessDate = getDateString()
        data.emotionRecognizedToday = false
        data.recognizedEmotion = nil
        data.emotionalCareGivenToday = false
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

        -- Unlock emotional care for today
        data.emotionRecognizedToday = true
        data.recognizedEmotion = currentEmotion

        LumoCare.save(player, data)
        return true, "Correct! Lumo feels understood! Now you can help with emotional care.", EMOTION_GUESS_REWARD, {
            wasCorrect = true,
            guessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - data.emotionGuessesUsed,
            coinsEarned = EMOTION_GUESS_REWARD,
            emotionalCareUnlocked = true,
            emotion = currentEmotion
        }
    else
        LumoCare.save(player, data)
        return false, "Not quite... Lumo is feeling " .. currentEmotion, 0, {
            wasCorrect = false,
            correctEmotion = currentEmotion,
            guessesRemaining = MAX_EMOTION_GUESSES_PER_DAY - data.emotionGuessesUsed,
            emotionalCareUnlocked = false
        }
    end
end

-- Step 2: Provide emotional care (15 coins, must recognize emotion first)
-- Uses specific items to teach children how to ADDRESS emotions
-- Example: Lumo is sad → Use Teddy Bear (15 coins) to help
function LumoCare.giveEmotionalCare(player, data, playerCoins)
    if not data.isPresent then
        return false, "Lumo is lost! Use a map to bring them back.", 0, nil
    end

    -- Check daily reset
    if data.lastEmotionGuessDate ~= getDateString() then
        data.emotionRecognizedToday = false
        data.recognizedEmotion = nil
        data.emotionalCareGivenToday = false
    end

    -- Must recognize emotion first
    if not data.emotionRecognizedToday then
        return false, "First, guess how Lumo is feeling! Then you can help.", 0, nil
    end

    -- Already gave emotional care today
    if data.emotionalCareGivenToday then
        return false, "You already helped Lumo with their feelings today! Come back tomorrow.", 0, nil
    end

    -- Check cost (with evolution discount)
    local cost = LumoCare.getDiscountedCareCost(data, CARE_COST_EMOTIONAL)
    if playerCoins < cost then
        return false, "Not enough coins (need " .. cost .. ")", 0, nil
    end

    -- Get the care item for the recognized emotion
    local emotion = data.recognizedEmotion
    local careItem = EMOTION_CARE_ITEMS[emotion] or {
        item = "Comfort Item",
        emoji = "💝",
        action = "Comfort Lumo",
        message = "Lumo feels better!"
    }

    -- Mark emotional care as given
    data.emotionalCareGivenToday = true
    data.lastEmotionalCareTime = os.time()
    data.lastAnyCareTime = os.time()
    data.totalCareActions = data.totalCareActions + 1
    updateDailyCare(data)

    -- Check for evolution
    local evolved, evolutionInfo = LumoCare.checkEvolution(player, data)

    LumoCare.save(player, data)
    return true, careItem.message, cost, {
        emotion = emotion,
        item = careItem.item,
        emoji = careItem.emoji,
        action = careItem.action,
        message = careItem.message,
        evolutionInfo = evolutionInfo
    }
end

-- Get the care item for an emotion (for UI preview)
function LumoCare.getEmotionCareItem(emotion)
    return EMOTION_CARE_ITEMS[emotion]
end

-- Get all emotion care items (for UI)
function LumoCare.getAllEmotionCareItems()
    return EMOTION_CARE_ITEMS
end

-- Check if emotional care is available
function LumoCare.canGiveEmotionalCare(data)
    -- Check daily reset
    if data.lastEmotionGuessDate ~= getDateString() then
        return false, "guess_first", "Guess Lumo's emotion first!"
    end

    if not data.emotionRecognizedToday then
        return false, "guess_first", "Guess Lumo's emotion first!"
    end

    if data.emotionalCareGivenToday then
        return false, "already_done", "Already helped today!"
    end

    return true, "available", "Help Lumo with their feelings!"
end

-- Bring Lumo back with map (120 Robux)
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
        return false, "You can't leave without Lumo! Use a map (120 Robux) to find them, or do lessons to earn coins."
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

-- Get care costs (for UI) - base costs without discount
function LumoCare.getCareCosts()
    return {
        feed = CARE_COST_FEED,
        water = CARE_COST_WATER,
        clean = CARE_COST_CLEAN,
        emotional = CARE_COST_EMOTIONAL,
        totalPhysical = CARE_COST_FEED + CARE_COST_WATER + CARE_COST_CLEAN,  -- 45 coins base
        totalDaily = CARE_COST_FEED + CARE_COST_WATER + CARE_COST_CLEAN + CARE_COST_EMOTIONAL  -- 60 coins base
    }
end

-- Get care costs with evolution discount (for UI)
function LumoCare.getCareCostsWithDiscount(data)
    local feedCost = LumoCare.getDiscountedCareCost(data, CARE_COST_FEED)
    local waterCost = LumoCare.getDiscountedCareCost(data, CARE_COST_WATER)
    local cleanCost = LumoCare.getDiscountedCareCost(data, CARE_COST_CLEAN)
    local emotionalCost = LumoCare.getDiscountedCareCost(data, CARE_COST_EMOTIONAL)
    local stageData = EVOLUTION_STAGES[LumoCare.getEvolutionStage(data)]

    return {
        feed = feedCost,
        water = waterCost,
        clean = cleanCost,
        emotional = emotionalCost,
        totalPhysical = feedCost + waterCost + cleanCost,
        totalDaily = feedCost + waterCost + cleanCost + emotionalCost,
        discountPercent = stageData.discount,
        baseFeed = CARE_COST_FEED,
        baseWater = CARE_COST_WATER,
        baseClean = CARE_COST_CLEAN,
        baseEmotional = CARE_COST_EMOTIONAL,
        basePhysical = CARE_COST_FEED + CARE_COST_WATER + CARE_COST_CLEAN,
        baseTotal = CARE_COST_FEED + CARE_COST_WATER + CARE_COST_CLEAN + CARE_COST_EMOTIONAL
    }
end

-- ==========================================
-- EVOLUTION SYSTEM (Lumo grows up!)
-- ==========================================

-- Get current evolution stage based on total care actions
function LumoCare.getEvolutionStage(data)
    local totalCare = data.totalCareActions or 0
    local stage = 1

    for i, stageData in ipairs(EVOLUTION_STAGES) do
        if totalCare >= stageData.minCare then
            stage = i
        else
            break
        end
    end

    return stage
end

-- Get evolution stage info
function LumoCare.getEvolutionInfo(data)
    local currentStage = LumoCare.getEvolutionStage(data)
    local stageData = EVOLUTION_STAGES[currentStage]
    local nextStageData = EVOLUTION_STAGES[currentStage + 1]

    local info = {
        stage = currentStage,
        stageName = stageData.name,
        description = stageData.description,
        discount = stageData.discount,
        totalCareActions = data.totalCareActions or 0,
        isMaxStage = (currentStage == #EVOLUTION_STAGES)
    }

    -- Add progress to next stage
    if nextStageData then
        local currentMin = stageData.minCare
        local nextMin = nextStageData.minCare
        local progress = data.totalCareActions - currentMin
        local needed = nextMin - currentMin

        info.nextStageName = nextStageData.name
        info.nextStageAt = nextMin
        info.careUntilNext = nextMin - data.totalCareActions
        info.progressPercent = math.floor((progress / needed) * 100)
    else
        info.nextStageName = nil
        info.careUntilNext = 0
        info.progressPercent = 100
    end

    return info
end

-- Check for evolution (called after care actions)
function LumoCare.checkEvolution(player, data)
    local newStage = LumoCare.getEvolutionStage(data)
    local oldStage = data.currentStage or 1

    if newStage > oldStage then
        -- Evolution happened!
        data.currentStage = newStage
        data.lastEvolutionTime = os.time()

        local stageData = EVOLUTION_STAGES[newStage]

        LumoCare.save(player, data)
        return true, {
            evolved = true,
            newStage = newStage,
            stageName = stageData.name,
            description = stageData.description,
            discount = stageData.discount,
            message = "Lumo evolved into a " .. stageData.name .. "!"
        }
    end

    return false, { evolved = false }
end

-- Get care cost with evolution discount
function LumoCare.getDiscountedCareCost(data, baseCost)
    local stageData = EVOLUTION_STAGES[LumoCare.getEvolutionStage(data)]
    local discount = stageData.discount or 0
    local discountedCost = math.floor(baseCost * (1 - discount / 100))
    return math.max(1, discountedCost)  -- Minimum 1 coin
end

-- Get all evolution stages (for UI)
function LumoCare.getEvolutionStages()
    return EVOLUTION_STAGES
end

return LumoCare
