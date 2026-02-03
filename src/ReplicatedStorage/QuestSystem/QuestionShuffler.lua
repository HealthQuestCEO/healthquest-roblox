--[[
    QuestionShuffler.lua
    Shuffles answer positions so correct answer isn't always in same spot

    This happens in CODE, not JSON - so you always write correct answer as "a"
    and the system randomizes where it appears (a, b, c, or d)
]]

local QuestionShuffler = {}

-- Shuffle array in place (Fisher-Yates algorithm)
local function shuffleArray(array)
    local n = #array
    for i = n, 2, -1 do
        local j = math.random(1, i)
        array[i], array[j] = array[j], array[i]
    end
    return array
end

-- Shuffle a single question's answers
-- Returns shuffled question with new correct answer position
function QuestionShuffler.shuffleQuestion(question)
    -- Create answer objects with their original positions
    local answers = {
        { original = "a", text = question.a },
        { original = "b", text = question.b },
        { original = "c", text = question.c },
        { original = "d", text = question.d }
    }

    -- Shuffle the answers
    shuffleArray(answers)

    -- Build new question with shuffled answers
    local shuffled = {
        q = question.q,
        q_es = question.q_es, -- Keep Spanish if exists
        a = answers[1].text,
        b = answers[2].text,
        c = answers[3].text,
        d = answers[4].text,
        -- Find where the correct answer ended up
        answer = nil
    }

    -- Find new position of correct answer
    local originalCorrect = question.answer
    for i, answer in ipairs(answers) do
        if answer.original == originalCorrect then
            local positions = {"a", "b", "c", "d"}
            shuffled.answer = positions[i]
            break
        end
    end

    -- If Spanish versions exist, shuffle them the same way
    if question.a_es then
        local answers_es = {
            { original = "a", text = question.a_es },
            { original = "b", text = question.b_es },
            { original = "c", text = question.c_es },
            { original = "d", text = question.d_es }
        }

        -- Apply same shuffle order
        shuffled.a_es = answers_es[1].text
        shuffled.b_es = answers_es[2].text
        shuffled.c_es = answers_es[3].text
        shuffled.d_es = answers_es[4].text
    end

    return shuffled
end

-- Shuffle all questions in a lesson
function QuestionShuffler.shuffleLesson(lesson)
    if not lesson or not lesson.questions then
        return lesson
    end

    local shuffledLesson = {
        lesson = lesson.lesson,
        unit = lesson.unit,
        title = lesson.title,
        title_es = lesson.title_es,
        intro = lesson.intro,
        intro_es = lesson.intro_es,
        takeaways = lesson.takeaways,
        takeaways_es = lesson.takeaways_es,
        gameMode = lesson.gameMode,
        questions = {}
    }

    for _, question in ipairs(lesson.questions) do
        local shuffledQuestion = QuestionShuffler.shuffleQuestion(question)
        table.insert(shuffledLesson.questions, shuffledQuestion)
    end

    return shuffledLesson
end

-- Shuffle all lessons in a quest
function QuestionShuffler.shuffleQuest(questData)
    if not questData or not questData.lessons then
        return questData
    end

    local shuffledQuest = {
        quest = questData.quest,
        units = questData.units,
        lessons = {}
    }

    for _, lesson in ipairs(questData.lessons) do
        local shuffledLesson = QuestionShuffler.shuffleLesson(lesson)
        table.insert(shuffledQuest.lessons, shuffledLesson)
    end

    return shuffledQuest
end

return QuestionShuffler
