--[[
    QuestProgress.lua
    Tracks player's quest progress and handles quest purchases

    RULES:
    - First Barrier Assessment = FREE (assigns first quest FREE)
    - Completing a quest = can retake it FREE
    - NEW Barrier Assessment after completion = 400 ROBUX
    - NEW quest from barrier results = 99 ROBUX
    - Retake SAME Barrier Assessment = FREE
    - Progress saves automatically
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

    -- Completed quests (can retake free)
    completedQuests = {},         -- {"NutriQuest", "MindQuest"}

    -- Purchased quests (unlocked with Robux)
    purchasedQuests = {},         -- {"ActiveAdventures"}

    -- Barrier Assessment tracking
    barrierAssessments = {},      -- {barrierId = {timestamp, answers, questScores, selectedQuest}}
    completedBarriers = {},       -- Barrier IDs that led to completed quests (can retake FREE)
    purchasedBarriers = {},       -- Barrier IDs purchased with Robux
    lastBarrierResults = nil,     -- Most recent barrier results (top 3 quests)

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
local NEW_QUEST_ROBUX_PRICE = 99      -- New quest from barrier results
local NEW_BARRIER_ROBUX_PRICE = 400   -- New barrier assessment after first

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

-- Complete a lesson
function QuestProgress.completeLesson(player, data)
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
        unit = data.currentUnit
    }
end

-- Complete entire quest
function QuestProgress.completeQuest(player, data)
    local questId = data.currentQuest

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
-- Marks which quests are completed (retake FREE) vs new (99 Robux)
function QuestProgress.getBarrierResultsForUI(data)
    if not data.lastBarrierResults then
        return nil, "No barrier results available"
    end

    local results = {
        barrierId = data.lastBarrierResults.barrierId,
        options = {}
    }

    -- Build options from top 3
    for i, questId in ipairs(data.lastBarrierResults.topThree) do
        local hasAccess, accessType = QuestProgress.canAccessQuest(data, questId)
        local option = {
            questId = questId,
            rank = i,
            score = data.lastBarrierResults.questScores[questId],
            status = "locked",
            cost = NEW_QUEST_ROBUX_PRICE,
            message = "Start for " .. NEW_QUEST_ROBUX_PRICE .. " Robux"
        }

        if hasAccess then
            if accessType == "completed" then
                option.status = "completed"
                option.cost = 0
                option.message = "✓ Completed - Retake FREE!"
            elseif accessType == "current" then
                option.status = "current"
                option.cost = 0
                option.message = "Currently in progress"
            elseif accessType == "purchased" then
                option.status = "purchased"
                option.cost = 0
                option.message = "Owned - Start FREE"
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
-- Handles both FREE selections and post-purchase selections
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

    -- Check if player can access this quest
    local hasAccess, accessType = QuestProgress.canAccessQuest(data, questId)

    if hasAccess then
        -- Free selection (completed, current, or purchased)
        data.currentQuest = questId
        data.currentLesson = 1
        data.currentUnit = 1
        data.questStartedTime = os.time()

        -- Record selection in barrier assessment
        if data.barrierAssessments[barrierId] then
            data.barrierAssessments[barrierId].selectedQuest = questId
        end

        QuestProgress.save(player, data)
        return true, "Quest started (FREE)"
    else
        -- Requires purchase - don't assign yet
        return false, "Quest requires purchase", {
            questId = questId,
            cost = NEW_QUEST_ROBUX_PRICE
        }
    end
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

-- Get Robux price for new quest
function QuestProgress.getNewQuestPrice()
    return NEW_QUEST_ROBUX_PRICE
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
