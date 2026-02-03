--[[
    QuestLoader.lua
    Loads quest lesson data from JSON and prepares it for gameplay
]]

local HttpService = game:GetService("HttpService")
local GameModes = require(script.Parent.GameModes)

local QuestLoader = {}

-- Load quest data from JSON string
function QuestLoader.loadFromJSON(jsonString)
    local success, data = pcall(function()
        return HttpService:JSONDecode(jsonString)
    end)

    if not success then
        warn("Failed to parse quest JSON: " .. tostring(data))
        return nil
    end

    return data
end

-- Get a specific lesson from quest data
function QuestLoader.getLesson(questData, lessonNumber)
    if not questData or not questData.lessons then
        return nil
    end

    for _, lesson in ipairs(questData.lessons) do
        if lesson.lesson == lessonNumber then
            return lesson
        end
    end

    return nil
end

-- Get lesson with assigned game mode
function QuestLoader.getLessonWithGameMode(questData, lessonNumber)
    local lesson = QuestLoader.getLesson(questData, lessonNumber)

    if not lesson then
        return nil
    end

    -- Assign game mode based on lesson number (rotating)
    lesson.gameMode = GameModes.getByRotation(lessonNumber)

    return lesson
end

-- Get all lessons for a specific unit
function QuestLoader.getLessonsByUnit(questData, unitNumber)
    if not questData or not questData.lessons then
        return {}
    end

    local unitLessons = {}

    for _, lesson in ipairs(questData.lessons) do
        if lesson.unit == unitNumber then
            table.insert(unitLessons, lesson)
        end
    end

    return unitLessons
end

-- Get quest progress info
function QuestLoader.getQuestInfo(questData)
    if not questData then
        return nil
    end

    return {
        questId = questData.quest,
        totalLessons = #questData.lessons,
        totalUnits = questData.units and #questData.units or 10
    }
end

-- Validate quest data structure
function QuestLoader.validate(questData)
    if not questData then
        return false, "No data provided"
    end

    if not questData.quest then
        return false, "Missing quest name"
    end

    if not questData.lessons or #questData.lessons == 0 then
        return false, "No lessons found"
    end

    for i, lesson in ipairs(questData.lessons) do
        if not lesson.title then
            return false, "Lesson " .. i .. " missing title"
        end

        if not lesson.intro then
            return false, "Lesson " .. i .. " missing intro"
        end

        if not lesson.questions or #lesson.questions < 5 then
            return false, "Lesson " .. i .. " needs 5 questions"
        end

        for j, question in ipairs(lesson.questions) do
            if not question.q or not question.a or not question.b or not question.c or not question.d or not question.answer then
                return false, "Lesson " .. i .. " question " .. j .. " incomplete"
            end
        end

        if not lesson.takeaways or #lesson.takeaways == 0 then
            return false, "Lesson " .. i .. " missing takeaways"
        end
    end

    return true, "Valid"
end

return QuestLoader
