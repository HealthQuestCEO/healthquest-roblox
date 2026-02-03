--[[
    QuestProgress.lua
    Tracks player's quest progress and handles quest purchases

    RULES:
    - First Barrier Assessment = FREE (includes first quest selection)
    - Completing a quest = can retake it FREE
    - NEW Barrier Assessment = 400 ROBUX (includes quest selection from results)
    - Retake SAME Barrier Assessment = FREE
    - Retake SAME Quest = FREE
    - Progress saves automatically

    FLOW:
    1. Pay 400 Robux (or free if first/retake)
    2. Take 12-question Barrier Assessment
    3. See top 3 quest recommendations
    4. Pick one quest (included in the 400 Robux)
    5. Start quest

    QUEST STRUCTURE (102 lessons total per quest):
    1. Pre-Assessment (before starting) = 50 coins
    2. 100 Regular Lessons (10 units × 10 lessons)
    3. Post-Assessment (after Unit 10) = 50 coins
    4. Feedback = 50 coins

    COIN REWARDS (diminishing returns on retakes):
    - 1st time completing quest = 50 coins per lesson
    - 2nd time (1st retake) = 25 coins per lesson
    - 3rd time (2nd retake) = 15 coins per lesson
    - 4th+ time (3rd+ retake) = 10 coins per lesson

    BARRIER ASSESSMENT:
    - 12 questions = 100 coins reward
    - Use 100 coins to HATCH LUMO (first time only)

    Note: Emotion guess from Care Loop = 10 coins (up to 3/day, handled separately)

    This encourages buying new barriers to keep Lumo fed!
]]

local DataStoreService = game:GetService("DataStoreService")
local QuestDataStore = DataStoreService:GetDataStore("QuestProgress_v1")

local QuestProgress = {}

-- Default player quest data
local DEFAULT_DATA = {
    -- Current quest info
    currentQuest = nil,           -- "NutriQuest", "MindQuest", etc.
    currentLesson = 1,            -- Lesson number (1-100)
    currentUnit = 1,              -- Unit number (1-10)

    -- Quest phase tracking (102 total: pre + 100 lessons + post + feedback)
    preAssessmentComplete = false,   -- Before starting lessons
    postAssessmentComplete = false,  -- After finishing lessons
    feedbackComplete = false,        -- Final feedback

    -- Completed quests (can retake free)
    completedQuests = {},         -- {"NutriQuest", "MindQuest"}

    -- Purchased quests (unlocked with Robux)
    purchasedQuests = {},         -- {"ActiveAdventures"}

    -- Barrier Assessment tracking
    barrierAssessments = {},      -- {barrierId = {timestamp, answers, questScores, selectedQuest}}
    completedBarriers = {},       -- Barrier IDs that led to completed quests (can retake FREE)
    purchasedBarriers = {},       -- Barrier IDs purchased with Robux
    lastBarrierResults = nil,     -- Most recent barrier results (top 3 quests)

    -- Quest completion counts (for diminishing coin rewards)
    questCompletionCount = {},    -- {NutriQuest = 2, MindQuest = 1} = times fully completed

    -- Lumo hatching (first barrier's 100 coins used to hatch!)
    lumoHatched = false,          -- Has Lumo been hatched?
    lumoHatchTime = 0,            -- When Lumo was hatched

    -- Stats
    totalLessonsCompleted = 0,
    totalQuestsCompleted = 0,
    totalBarriersTaken = 0,

    -- Timestamps
    lastLoginTime = 0,
    questStartedTime = 0,
    lastBarrierTime = 0
}

-- ROBUX PRICES
-- Only ONE price: barrier assessment includes quest selection
local NEW_BARRIER_ROBUX_PRICE = 400   -- New barrier assessment (includes quest selection)

-- COIN REWARDS PER LESSON (diminishing returns on retakes)
local COINS_FIRST_TIME = 50    -- First time doing quest
local COINS_SECOND_TIME = 25   -- 1st retake (2nd time)
local COINS_THIRD_TIME = 15    -- 2nd retake (3rd time)
local COINS_FOURTH_PLUS = 10   -- 3rd+ retake (4th+ time)

-- SPECIAL REWARDS
local BARRIER_ASSESSMENT_REWARD = 100  -- Coins for completing 12-question barrier (use to hatch Lumo!)
local PRE_ASSESSMENT_REWARD = 50       -- Coins for pre-assessment
local POST_ASSESSMENT_REWARD = 50      -- Coins for post-assessment
local FEEDBACK_REWARD = 50             -- Coins for feedback

-- QUEST STRUCTURE
local TOTAL_LESSONS = 100              -- Regular lessons per quest
local TOTAL_WITH_ASSESSMENTS = 102     -- Including pre/post assessment + feedback (100 + 1 + 1)

-- Load player data
function QuestProgress.load(player)
    local userId = player.UserId
    local key = "Player_" .. userId

    local success, data = pcall(function()
        return QuestDataStore:GetAsync(key)
    end)

    if success and data then
        -- Merge with defaults (in case new fields added)
        for k, v in pairs(DEFAULT_DATA) do
            if data[k] == nil then
                data[k] = v
            end
        end
        data.lastLoginTime = os.time()
        return data
    else
        -- New player
        local newData = table.clone(DEFAULT_DATA)
        newData.lastLoginTime = os.time()
        return newData
    end
end

-- Save player data
function QuestProgress.save(player, data)
    local userId = player.UserId
    local key = "Player_" .. userId

    local success, err = pcall(function()
        QuestDataStore:SetAsync(key, data)
    end)

    if not success then
        warn("Failed to save quest progress for " .. player.Name .. ": " .. tostring(err))
    end

    return success
end

-- Assign first quest (from Barrier Assessment) - FREE
-- barrierId is optional - links quest to the barrier that assigned it
function QuestProgress.assignFirstQuest(player, data, questId, barrierId)
    if data.currentQuest ~= nil then
        return false, "Player already has a quest"
    end

    data.currentQuest = questId
    data.currentLesson = 1
    data.currentUnit = 1
    data.questStartedTime = os.time()

    -- Link to barrier assessment if provided
    if barrierId and data.barrierAssessments[barrierId] then
        data.barrierAssessments[barrierId].selectedQuest = questId
    end

    QuestProgress.save(player, data)
    return true, "Quest assigned"
end

-- Get coin reward for current quest based on completion history
function QuestProgress.getLessonCoinReward(data)
    local questId = data.currentQuest
    if not questId then
        return COINS_FIRST_TIME
    end

    -- Initialize if not exists
    if not data.questCompletionCount then
        data.questCompletionCount = {}
    end

    local completionCount = data.questCompletionCount[questId] or 0

    if completionCount == 0 then
        return COINS_FIRST_TIME      -- 50 coins (first time)
    elseif completionCount == 1 then
        return COINS_SECOND_TIME     -- 25 coins (1st retake)
    elseif completionCount == 2 then
        return COINS_THIRD_TIME      -- 15 coins (2nd retake)
    else
        return COINS_FOURTH_PLUS     -- 10 coins (3rd+ retake)
    end
end

-- Get barrier assessment reward (100 coins - use to hatch Lumo!)
function QuestProgress.getBarrierAssessmentReward()
    return BARRIER_ASSESSMENT_REWARD
end

-- Get pre-assessment reward
function QuestProgress.getPreAssessmentReward()
    return PRE_ASSESSMENT_REWARD
end

-- Get post-assessment reward
function QuestProgress.getPostAssessmentReward()
    return POST_ASSESSMENT_REWARD
end

-- Get feedback reward
function QuestProgress.getFeedbackReward()
    return FEEDBACK_REWARD
end

-- Complete a lesson
function QuestProgress.completeLesson(player, data)
    -- Calculate coin reward BEFORE incrementing lesson
    local coinsEarned = QuestProgress.getLessonCoinReward(data)

    data.currentLesson = data.currentLesson + 1
    data.totalLessonsCompleted = data.totalLessonsCompleted + 1

    -- Check if moved to new unit (every 10 lessons)
    data.currentUnit = math.ceil(data.currentLesson / 10)

    -- Check if quest complete (100 lessons)
    if data.currentLesson > 100 then
        return QuestProgress.completeQuest(player, data)
    end

    QuestProgress.save(player, data)
    return true, "Lesson completed", {
        lesson = data.currentLesson,
        unit = data.currentUnit,
        coinsEarned = coinsEarned
    }
end

-- Complete entire quest
function QuestProgress.completeQuest(player, data)
    local questId = data.currentQuest

    -- Initialize completion count if needed
    if not data.questCompletionCount then
        data.questCompletionCount = {}
    end

    -- Increment completion count for this quest
    local previousCount = data.questCompletionCount[questId] or 0
    data.questCompletionCount[questId] = previousCount + 1

    -- Add to completed quests if not already there
    local alreadyCompleted = false
    for _, q in ipairs(data.completedQuests) do
        if q == questId then
            alreadyCompleted = true
            break
        end
    end

    if not alreadyCompleted then
        table.insert(data.completedQuests, questId)
        data.totalQuestsCompleted = data.totalQuestsCompleted + 1
    end

    -- Mark any barrier that assigned this quest as "completed"
    -- This allows FREE retake of that barrier assessment
    for barrierId, assessment in pairs(data.barrierAssessments) do
        if assessment.selectedQuest == questId then
            local alreadyMarked = false
            for _, id in ipairs(data.completedBarriers) do
                if id == barrierId then
                    alreadyMarked = true
                    break
                end
            end
            if not alreadyMarked then
                table.insert(data.completedBarriers, barrierId)
            end
        end
    end

    QuestProgress.save(player, data)

    return true, "Quest completed!", {
        questId = questId,
        totalCompleted = data.totalQuestsCompleted,
        canTakeNewBarrierFree = true, -- They can now retake barriers for free
        newBarrierPrice = NEW_BARRIER_ROBUX_PRICE
    }
end

-- Retake current/completed quest - FREE
function QuestProgress.retakeQuest(player, data, questId)
    -- Check if player has completed or owns this quest
    local canRetake = false

    if data.currentQuest == questId then
        canRetake = true
    end

    for _, q in ipairs(data.completedQuests) do
        if q == questId then
            canRetake = true
            break
        end
    end

    for _, q in ipairs(data.purchasedQuests) do
        if q == questId then
            canRetake = true
            break
        end
    end

    if not canRetake then
        return false, "You don't have access to this quest"
    end

    -- Reset to beginning of quest
    data.currentQuest = questId
    data.currentLesson = 1
    data.currentUnit = 1
    data.questStartedTime = os.time()

    QuestProgress.save(player, data)
    return true, "Quest restarted"
end

-- Check if player can access a quest
function QuestProgress.canAccessQuest(data, questId)
    -- Current quest
    if data.currentQuest == questId then
        return true, "current"
    end

    -- Completed quest (can retake)
    for _, q in ipairs(data.completedQuests) do
        if q == questId then
            return true, "completed"
        end
    end

    -- Purchased quest
    for _, q in ipairs(data.purchasedQuests) do
        if q == questId then
            return true, "purchased"
        end
    end

    return false, "locked"
end

-- Purchase new quest with Robux
function QuestProgress.purchaseNewQuest(player, data, questId)
    -- Check if already owns it
    local hasAccess, reason = QuestProgress.canAccessQuest(data, questId)
    if hasAccess then
        return false, "You already have this quest"
    end

    -- Process Robux purchase (handled by Roblox MarketplaceService)
    -- This function is called AFTER successful purchase

    table.insert(data.purchasedQuests, questId)

    -- Set as current quest
    data.currentQuest = questId
    data.currentLesson = 1
    data.currentUnit = 1
    data.questStartedTime = os.time()

    QuestProgress.save(player, data)
    return true, "Quest purchased and started"
end

-- ==========================================
-- BARRIER ASSESSMENT FUNCTIONS
-- ==========================================

-- Check if player can take barrier assessment for free
function QuestProgress.canTakeBarrierFree(data)
    -- First barrier is always free
    if data.totalBarriersTaken == 0 then
        return true, "first_barrier"
    end

    -- Can retake a completed barrier for free
    -- (A barrier is "completed" when its assigned quest is completed)
    if #data.completedBarriers > 0 then
        return true, "retake_completed"
    end

    return false, "requires_purchase"
end

-- Check if a specific barrier can be retaken free
function QuestProgress.canRetakeBarrierFree(data, barrierId)
    for _, id in ipairs(data.completedBarriers) do
        if id == barrierId then
            return true
        end
    end
    return false
end

-- Record barrier assessment results
-- Called after player completes the 12-question assessment
function QuestProgress.recordBarrierAssessment(player, data, assessmentData)
    --[[
        assessmentData = {
            barrierId = "barrier_001" (unique ID for this assessment instance),
            answers = {1, 2, 3, 3, 3, 2, 3, 3, 3, 2, 2, 2}, -- Q1-Q12 scores
            questScores = {MindQuest = 4.0, ...}, -- Weighted scores per quest
            topThree = {"MindQuest", "ResilienceAdventure", "ActiveAdventures"}
        }
    ]]

    local barrierId = assessmentData.barrierId or ("barrier_" .. os.time())

    -- Store assessment
    data.barrierAssessments[barrierId] = {
        timestamp = os.time(),
        answers = assessmentData.answers,
        questScores = assessmentData.questScores,
        topThree = assessmentData.topThree,
        selectedQuest = nil -- Set when player picks a quest
    }

    data.lastBarrierResults = {
        barrierId = barrierId,
        topThree = assessmentData.topThree,
        questScores = assessmentData.questScores
    }

    data.totalBarriersTaken = data.totalBarriersTaken + 1
    data.lastBarrierTime = os.time()

    QuestProgress.save(player, data)
    return true, barrierId
end

-- Get barrier results with quest availability info
-- All quests from barrier results are FREE to select (payment was for the barrier)
function QuestProgress.getBarrierResultsForUI(data)
    if not data.lastBarrierResults then
        return nil, "No barrier results available"
    end

    local results = {
        barrierId = data.lastBarrierResults.barrierId,
        options = {}
    }

    -- Build options from top 3 - all are FREE since barrier was paid for
    for i, questId in ipairs(data.lastBarrierResults.topThree) do
        local hasAccess, accessType = QuestProgress.canAccessQuest(data, questId)
        local option = {
            questId = questId,
            rank = i,
            score = data.lastBarrierResults.questScores[questId],
            status = "available",
            cost = 0,
            message = "Select this quest"
        }

        -- Add extra info if they've done this quest before
        if hasAccess then
            if accessType == "completed" then
                option.status = "completed"
                option.message = "✓ Previously completed - Start again?"
            elseif accessType == "current" then
                option.status = "current"
                option.message = "Currently in progress - Restart?"
            end
        end

        table.insert(results.options, option)
    end

    return results
end

-- Purchase new barrier assessment (400 Robux)
-- Called AFTER successful Robux purchase
function QuestProgress.purchaseNewBarrier(player, data)
    local barrierId = "barrier_" .. os.time()
    table.insert(data.purchasedBarriers, barrierId)

    QuestProgress.save(player, data)
    return true, barrierId, "Barrier assessment unlocked"
end

-- Select quest from barrier results
-- Quest selection is FREE - the barrier assessment payment covers it
function QuestProgress.selectQuestFromBarrier(player, data, questId, barrierId)
    -- Verify this quest was in the barrier results
    if not data.lastBarrierResults or data.lastBarrierResults.barrierId ~= barrierId then
        return false, "Invalid barrier ID"
    end

    local inTopThree = false
    for _, q in ipairs(data.lastBarrierResults.topThree) do
        if q == questId then
            inTopThree = true
            break
        end
    end

    if not inTopThree then
        return false, "Quest not in barrier results"
    end

    -- All selections from barrier results are FREE (barrier payment covers quest)
    data.currentQuest = questId
    data.currentLesson = 1
    data.currentUnit = 1
    data.questStartedTime = os.time()

    -- Record selection in barrier assessment
    if data.barrierAssessments[barrierId] then
        data.barrierAssessments[barrierId].selectedQuest = questId
    end

    -- Add to purchased quests so they can retake it later
    local alreadyOwned = false
    for _, q in ipairs(data.purchasedQuests) do
        if q == questId then
            alreadyOwned = true
            break
        end
    end
    for _, q in ipairs(data.completedQuests) do
        if q == questId then
            alreadyOwned = true
            break
        end
    end
    if not alreadyOwned then
        table.insert(data.purchasedQuests, questId)
    end

    QuestProgress.save(player, data)
    return true, "Quest started"
end

-- Mark barrier as completed (called when quest from that barrier is finished)
function QuestProgress.markBarrierCompleted(player, data, barrierId)
    -- Check if already marked
    for _, id in ipairs(data.completedBarriers) do
        if id == barrierId then
            return true, "Already completed"
        end
    end

    table.insert(data.completedBarriers, barrierId)
    QuestProgress.save(player, data)
    return true, "Barrier marked complete - can retake FREE"
end

-- Get Robux price for new barrier assessment
function QuestProgress.getNewBarrierPrice()
    return NEW_BARRIER_ROBUX_PRICE
end

-- ==========================================
-- STATUS AND UTILITY FUNCTIONS
-- ==========================================

-- Get quest status for UI
function QuestProgress.getStatus(data)
    local canTakeFree, freeReason = QuestProgress.canTakeBarrierFree(data)

    return {
        -- Quest progress
        currentQuest = data.currentQuest,
        currentLesson = data.currentLesson,
        currentUnit = data.currentUnit,
        progress = math.floor((data.currentLesson - 1) / 100 * 100), -- Percentage
        completedQuests = data.completedQuests,
        purchasedQuests = data.purchasedQuests,
        totalLessonsCompleted = data.totalLessonsCompleted,
        totalQuestsCompleted = data.totalQuestsCompleted,

        -- Barrier assessment status
        totalBarriersTaken = data.totalBarriersTaken,
        canTakeBarrierFree = canTakeFree,
        barrierFreeReason = freeReason,
        newBarrierPrice = NEW_BARRIER_ROBUX_PRICE,
        lastBarrierResults = data.lastBarrierResults
    }
end

-- Get Robux price (barrier assessment includes quest selection)
function QuestProgress.getPrice()
    return NEW_BARRIER_ROBUX_PRICE
end

-- ==========================================
-- LUMO HATCHING (uses barrier assessment coins)
-- ==========================================

-- Hatch Lumo with barrier assessment coins (100 coins)
-- Called after first barrier assessment
function QuestProgress.hatchLumo(player, data, playerCoins)
    if data.lumoHatched then
        return false, "Lumo is already hatched!", 0
    end

    if playerCoins < BARRIER_ASSESSMENT_REWARD then
        return false, "Not enough coins to hatch Lumo!", 0
    end

    data.lumoHatched = true
    data.lumoHatchTime = os.time()

    QuestProgress.save(player, data)
    return true, "Lumo has hatched! Welcome your new friend!", BARRIER_ASSESSMENT_REWARD
end

-- Check if Lumo is hatched
function QuestProgress.isLumoHatched(data)
    return data.lumoHatched == true
end

-- ==========================================
-- PRE/POST ASSESSMENT & FEEDBACK
-- ==========================================

-- Complete pre-assessment (before starting lessons)
function QuestProgress.completePreAssessment(player, data)
    if data.preAssessmentComplete then
        return false, "Pre-assessment already completed", 0
    end

    data.preAssessmentComplete = true

    QuestProgress.save(player, data)
    return true, "Pre-assessment complete!", PRE_ASSESSMENT_REWARD
end

-- Complete post-assessment (after lesson 100)
function QuestProgress.completePostAssessment(player, data)
    if data.postAssessmentComplete then
        return false, "Post-assessment already completed", 0
    end

    if data.currentLesson <= TOTAL_LESSONS then
        return false, "Complete all lessons first", 0
    end

    data.postAssessmentComplete = true

    QuestProgress.save(player, data)
    return true, "Post-assessment complete!", POST_ASSESSMENT_REWARD
end

-- Complete feedback (after post-assessment)
function QuestProgress.completeFeedback(player, data)
    if data.feedbackComplete then
        return false, "Feedback already completed", 0
    end

    if not data.postAssessmentComplete then
        return false, "Complete post-assessment first", 0
    end

    data.feedbackComplete = true

    QuestProgress.save(player, data)

    -- Now fully complete the quest
    return QuestProgress.completeQuest(player, data)
end

-- Reset quest phase tracking (when starting new quest)
function QuestProgress.resetQuestPhases(data)
    data.preAssessmentComplete = false
    data.postAssessmentComplete = false
    data.feedbackComplete = false
end

-- Get quest phase status
function QuestProgress.getQuestPhaseStatus(data)
    return {
        preAssessmentComplete = data.preAssessmentComplete,
        lessonsComplete = data.currentLesson > TOTAL_LESSONS,
        postAssessmentComplete = data.postAssessmentComplete,
        feedbackComplete = data.feedbackComplete,
        currentLesson = data.currentLesson,
        totalLessons = TOTAL_LESSONS,
        totalWithAssessments = TOTAL_WITH_ASSESSMENTS
    }
end

-- ==========================================
-- COIN SUMMARY
-- ==========================================

-- Get potential coins for first-time quest completion
function QuestProgress.getFirstQuestPotentialCoins()
    -- Barrier: 100 + Pre: 50 + 100 lessons × 50 + Post: 50 + Feedback: 50
    return {
        barrierAssessment = BARRIER_ASSESSMENT_REWARD,  -- 100
        preAssessment = PRE_ASSESSMENT_REWARD,          -- 50
        lessons = TOTAL_LESSONS * COINS_FIRST_TIME,     -- 100 × 50 = 5000
        postAssessment = POST_ASSESSMENT_REWARD,        -- 50
        feedback = FEEDBACK_REWARD,                     -- 50
        total = BARRIER_ASSESSMENT_REWARD + PRE_ASSESSMENT_REWARD + (TOTAL_LESSONS * COINS_FIRST_TIME) + POST_ASSESSMENT_REWARD + FEEDBACK_REWARD
        -- Total: 100 + 50 + 5000 + 50 + 50 = 5,250 coins
    }
end

-- List of all quests
QuestProgress.ALL_QUESTS = {
    "ActiveAdventures",
    "MissionPowerUp",
    "BodyImageOdyssey",
    "FocusandFeel",
    "KindnessCrusaders",
    "MindfulBites",
    "MindfulHeroAdventure",
    "MindQuest",
    "NutriQuest",
    "ResilienceAdventure"
}

return QuestProgress
