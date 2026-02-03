--[[
    QuestProgress.lua
    Tracks player's quest progress and handles quest purchases

    RULES:
    - First quest is FREE (assigned from Barrier Assessment)
    - Completing a quest = can retake it FREE
    - NEW quest after completion = costs ROBUX
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

    -- Stats
    totalLessonsCompleted = 0,
    totalQuestsCompleted = 0,

    -- Timestamps
    lastLoginTime = 0,
    questStartedTime = 0
}

-- ROBUX PRICE FOR NEW QUEST
local NEW_QUEST_ROBUX_PRICE = 99 -- Adjust as needed

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
function QuestProgress.assignFirstQuest(player, data, questId)
    if data.currentQuest ~= nil then
        return false, "Player already has a quest"
    end

    data.currentQuest = questId
    data.currentLesson = 1
    data.currentUnit = 1
    data.questStartedTime = os.time()

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

    QuestProgress.save(player, data)

    return true, "Quest completed!", {
        questId = questId,
        totalCompleted = data.totalQuestsCompleted
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

-- Get quest status for UI
function QuestProgress.getStatus(data)
    return {
        currentQuest = data.currentQuest,
        currentLesson = data.currentLesson,
        currentUnit = data.currentUnit,
        progress = math.floor((data.currentLesson - 1) / 100 * 100), -- Percentage
        completedQuests = data.completedQuests,
        purchasedQuests = data.purchasedQuests,
        totalLessonsCompleted = data.totalLessonsCompleted,
        totalQuestsCompleted = data.totalQuestsCompleted
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
