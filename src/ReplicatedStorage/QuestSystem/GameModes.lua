--[[
    GameModes.lua
    Handles the different interactive game modes for quest MCQ questions

    All modes deliver the same MCQ format (A, B, C, D answers)
    but with different fun gameplay mechanics
]]

local GameModes = {}

-- Available game modes for quest lessons
local GAME_MODES = {
    "glass_bridge",     -- Jump on answer panels, wrong = fall
    "door_dash",        -- Run through correct door, wrong = bonk
    "climb_mountain",   -- Climb to correct answer platform
    "target_practice",  -- Shoot/throw at correct target
    "race_lanes",       -- Run down correct lane, wrong has obstacles
    "balloon_pop",      -- Pop balloon with correct answer
    "lily_pad",         -- Jump to correct lily pad, wrong = splash
    "wall_break"        -- Run through correct wall, only right one breaks
}

-- Get game mode by rotating through all modes
-- Each lesson gets a different mode in sequence
function GameModes.getByRotation(lessonNumber)
    local index = ((lessonNumber - 1) % #GAME_MODES) + 1
    return GAME_MODES[index]
end

-- Get random game mode
function GameModes.getRandom()
    return GAME_MODES[math.random(1, #GAME_MODES)]
end

-- Get game mode by unit (same mode for entire unit)
function GameModes.getByUnit(unitNumber)
    local index = ((unitNumber - 1) % #GAME_MODES) + 1
    return GAME_MODES[index]
end

-- Get specific game mode by name
function GameModes.get(modeName)
    for _, mode in ipairs(GAME_MODES) do
        if mode == modeName then
            return mode
        end
    end
    return GAME_MODES[1] -- Default to glass_bridge
end

-- Get all available modes
function GameModes.getAll()
    return GAME_MODES
end

-- Get mode count
function GameModes.count()
    return #GAME_MODES
end

-- Mode display names (for UI)
GameModes.DisplayNames = {
    glass_bridge = "Glass Bridge",
    door_dash = "Door Dash",
    climb_mountain = "Climb Mountain",
    target_practice = "Target Practice",
    race_lanes = "Race Lanes",
    balloon_pop = "Balloon Pop",
    lily_pad = "Lily Pad Jump",
    wall_break = "Wall Break"
}

-- Mode display names in Spanish
GameModes.DisplayNames_es = {
    glass_bridge = "Puente de Cristal",
    door_dash = "Carrera de Puertas",
    climb_mountain = "Escalar Montaña",
    target_practice = "Tiro al Blanco",
    race_lanes = "Carriles de Carrera",
    balloon_pop = "Reventar Globos",
    lily_pad = "Salto de Nenúfar",
    wall_break = "Romper Pared"
}

-- Mode icons (emojis for UI)
GameModes.Icons = {
    glass_bridge = "🌉",
    door_dash = "🚪",
    climb_mountain = "⛰️",
    target_practice = "🎯",
    race_lanes = "🏃",
    balloon_pop = "🎈",
    lily_pad = "🐸",
    wall_break = "🧱"
}

return GameModes
