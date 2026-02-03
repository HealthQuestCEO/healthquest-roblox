# LUMO'S MOVE & GROOVE: FITNESS ARENA

## Overview

A 3D HIIT (High-Intensity Interval Training) workout game with both Solo and Group modes. Located as a special portal near the Gym in the Castle. Features energy-level selection, 24 exercises across 4 color-coded categories, and a Simon-says style Group Mode for multiplayer fun.

---

## GAME CONCEPT

### Core Mechanic
- Choose energy level (Chill, Good Energy, or Let's GO!)
- Select exercises from color-coded categories
- Follow along with timed workout intervals
- Group Mode: Memory game with exercise patterns
- Track streaks, earn badges, log workouts

### Unlock Condition
- **Requirement:** Gym room must be unlocked in the Castle
- **Portal Location:** Special gym equipment portal near the castle
- **When locked:** Portal shows "🔒 Unlock the Gym first!"

### Visual Style
- Colorful fitness arena with neon accents
- Large exercise demonstration area
- Circular timer display
- Simon-says colored platforms for Group Mode

---

## PORTAL DESIGN

### Meadow Portal Appearance
```
        ╭─────────────────────────╮
        │  🏃 MOVE & GROOVE 💃    │
        ╰─────────────────────────╯

           ┌───────────────┐
          /   🔴  ●  🟡    \
         │    ●  💪  ●     │   ← Spinning fitness ring
         │   🔵  ●  🟢     │     with color buttons
          \               /
           └─────┬─────┬─┘
                 │     │
              ───┴─────┴───     ← Platform
```

---

## FITNESS ARENA ENVIRONMENT

### 3D Layout
```
┌─────────────────────────────────────────────────────────────┐
│                   MOVE & GROOVE ARENA                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │                                                     │    │
│  │            MAIN EXERCISE STAGE                      │    │
│  │                                                     │    │
│  │    ┌─────────────────────────────────────┐         │    │
│  │    │                                     │         │    │
│  │    │      LUMO TRAINER (3D Model)        │         │    │
│  │    │         Demonstrates moves          │         │    │
│  │    │                                     │         │    │
│  │    └─────────────────────────────────────┘         │    │
│  │                                                     │    │
│  │    ┌───────────────────────────────────┐           │    │
│  │    │         GIANT TIMER               │           │    │
│  │    │          [00:30]                  │           │    │
│  │    │       ████████████░░░             │           │    │
│  │    │        "SQUATS!"                  │           │    │
│  │    └───────────────────────────────────┘           │    │
│  │                                                     │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
│  ┌───────────────────────────────────────────────────────┐  │
│  │                 GROUP MODE PADS                        │  │
│  │      🔴          🟡          🔵          🟢            │  │
│  │   [Upper]     [Lower]      [Core]    [Total Body]     │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                             │
│  [EXIT]   [SOLO MODE]   [GROUP MODE]   [CALENDAR]   [BADGES]│
└─────────────────────────────────────────────────────────────┘
```

---

## ENERGY LEVELS

### Three Workout Intensities

```lua
local ENERGY_LEVELS = {
    [1] = {
        id = 1,
        name = "Chill Mode",
        emoji = "😌",
        description = "Taking it easy today",
        color = Color3.fromRGB(107, 171, 144), -- Teal
        exerciseCount = 5,
        rounds = 1,
        workSeconds = 30,
        restSeconds = 45,
        estimatedTime = "8-10 minutes",
        xpMultiplier = 1.0
    },
    [2] = {
        id = 2,
        name = "Good Energy",
        emoji = "😊",
        description = "Feeling solid, let's go!",
        color = Color3.fromRGB(249, 168, 38), -- Orange
        exerciseCount = 6,
        rounds = 2,
        workSeconds = 30,
        restSeconds = 30,
        estimatedTime = "15-20 minutes",
        xpMultiplier = 1.5
    },
    [3] = {
        id = 3,
        name = "Let's GO!",
        emoji = "🔥",
        description = "Pumped and ready to crush it!",
        color = Color3.fromRGB(255, 107, 107), -- Red
        exerciseCount = 8,
        rounds = 2,
        workSeconds = 40,
        restSeconds = 20,
        estimatedTime = "25-35 minutes",
        xpMultiplier = 2.0
    }
}
```

### Energy Selection UI
```
┌─────────────────────────────────────────────────────────────┐
│              HOW'S YOUR ENERGY TODAY?                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────┐                                        │
│  │      😌         │                                        │
│  │   Chill Mode    │   "Taking it easy today"               │
│  │   5 exercises   │   ~10 mins, 1 round                    │
│  │   ⭐ x1.0 XP    │                                        │
│  └─────────────────┘                                        │
│                                                             │
│  ┌─────────────────┐                                        │
│  │      😊         │                                        │
│  │  Good Energy    │   "Feeling solid!"                     │
│  │   6 exercises   │   ~20 mins, 2 rounds                   │
│  │   ⭐ x1.5 XP    │                                        │
│  └─────────────────┘                                        │
│                                                             │
│  ┌─────────────────┐                                        │
│  │      🔥         │                                        │
│  │   Let's GO!     │   "Ready to crush it!"                 │
│  │   8 exercises   │   ~30 mins, 2 rounds                   │
│  │   ⭐ x2.0 XP    │                                        │
│  └─────────────────┘                                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## EXERCISE CATEGORIES

### 4 Color-Coded Groups (24 Total Exercises)

#### 🔴 RED - Upper Body (6 exercises)

| Exercise | Emoji | Difficulty | Description |
|----------|-------|------------|-------------|
| Arm Circles | 💫 | Easy | Big circles forward and back |
| Push-Ups | 💪 | Medium | Floor, knee, or wall variations |
| Triceps Dips | 🪑 | Medium | Chair-assisted arm dips |
| Shoulder Taps | 🙋 | Easy | Plank position, tap shoulders |
| Wall Push-Ups | 🧱 | Easy | Standing wall push-ups |
| Arm Pulses | 🦅 | Easy | Arms out, small pulses |

#### 🟡 YELLOW - Lower Body (6 exercises)

| Exercise | Emoji | Difficulty | Description |
|----------|-------|------------|-------------|
| Squats | 🦵 | Easy | Sit back, stand up strong |
| Lunges | 🦿 | Medium | Step forward, dip down |
| Jump Squats | 🚀 | Hard | Squat then explode up |
| Calf Raises | 🩰 | Easy | Rise up on tippy toes |
| Side Lunges | ↔️ | Medium | Step to the side |
| Glute Bridges | 🌉 | Easy | Lift hips to the sky |

#### 🔵 BLUE - Core (6 exercises)

| Exercise | Emoji | Difficulty | Description |
|----------|-------|------------|-------------|
| Plank | 🧘 | Medium | Hold straight like a board |
| Mountain Climbers | ⛰️ | Hard | Fast alternating knee drives |
| High-Five Sit-ups | 🙌 | Medium | Sit up, reach hands high |
| Dead Bug | 🐛 | Easy | Opposite arm and leg extends |
| Bird Dog | 🐕 | Easy | All fours balance reach |
| Bicycle Crunches | 🚴 | Medium | Elbow to opposite knee |

#### 🟢 GREEN - Total Body (6 exercises)

| Exercise | Emoji | Difficulty | Description |
|----------|-------|------------|-------------|
| Jumping Jacks | 🤸 | Easy | Jump feet apart, arms up |
| High Knees | 🏃 | Medium | Run in place, knees high |
| Star Jumps | ⭐ | Medium | Jump up like a star |
| Burpees | 🔥 | Hard | Down, back, up, jump! |
| Speed Skaters | ⛸️ | Medium | Leap side to side |
| Dance Break | 💃 | Easy | Free dance - just move! |

---

## SOLO MODE WORKFLOW

### Exercise Selection
```
┌─────────────────────────────────────────────────────────────┐
│           PICK YOUR EXERCISES (6 needed)                    │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🔴 UPPER BODY          │   🟡 LOWER BODY                   │
│  ─────────────          │   ─────────────                   │
│  [💫] Arm Circles ✓     │   [🦵] Squats ✓                   │
│  [💪] Push-Ups          │   [🦿] Lunges                      │
│  [🪑] Triceps Dips      │   [🚀] Jump Squats                │
│  [🙋] Shoulder Taps ✓   │   [🩰] Calf Raises                 │
│  [🧱] Wall Push-Ups     │   [↔️] Side Lunges                 │
│  [🦅] Arm Pulses        │   [🌉] Glute Bridges               │
│                         │                                   │
│  🔵 CORE                │   🟢 TOTAL BODY                   │
│  ─────────────          │   ─────────────                   │
│  [🧘] Plank ✓           │   [🤸] Jumping Jacks ✓            │
│  [⛰️] Mountain Climbers  │   [🏃] High Knees ✓                │
│  [🙌] High-Five Sit-ups │   [⭐] Star Jumps                  │
│  [🐛] Dead Bug          │   [🔥] Burpees                     │
│  [🐕] Bird Dog          │   [⛸️] Speed Skaters               │
│  [🚴] Bicycle Crunches  │   [💃] Dance Break                 │
│                         │                                   │
│         Selected: 6/6   [START WORKOUT]                     │
└─────────────────────────────────────────────────────────────┘
```

### Workout Timer Screen
```
┌─────────────────────────────────────────────────────────────┐
│                        WORK TIME!                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│              ┌─────────────────────────┐                    │
│              │                         │                    │
│              │      🦵 SQUATS          │                    │
│              │                         │                    │
│              │   "Invisible Chair!"    │                    │
│              │                         │                    │
│              │     [LUMO DEMO]         │                    │
│              │                         │                    │
│              └─────────────────────────┘                    │
│                                                             │
│                      ┌──────────┐                           │
│                      │          │                           │
│                      │   :23    │   ← Big timer             │
│                      │          │                           │
│                      └──────────┘                           │
│                                                             │
│              ████████████████░░░░░░░                        │
│                                                             │
│              Round 1/2    Exercise 3/6                      │
│                                                             │
│  💡 "Sit back, knees over toes, stand up strong!"          │
│                                                             │
│                     [PAUSE]  [SKIP]                         │
└─────────────────────────────────────────────────────────────┘
```

### Rest Timer
```
┌─────────────────────────────────────────────────────────────┐
│                        REST TIME                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                   😌 Catch your breath!                     │
│                                                             │
│                      ┌──────────┐                           │
│                      │   :15    │                           │
│                      └──────────┘                           │
│                                                             │
│              ████████░░░░░░░░░░░░░░░                        │
│                                                             │
│                   NEXT UP:                                  │
│                                                             │
│              ┌─────────────────────────┐                    │
│              │      🏃 HIGH KNEES      │                    │
│              │   "Knees up high!"      │                    │
│              └─────────────────────────┘                    │
│                                                             │
│  💡 "Shake it out, get ready!"                             │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## GROUP MODE (Simon Says)

### Concept
- 1-8 players stand on colored platforms
- Watch Lumo's pattern of colors
- Repeat the pattern with exercises
- Pattern grows each round
- How far can you go?

### Simon Platforms Layout
```
              Player View (looking at stage)

                    ┌─────────┐
                    │  LUMO   │
                    │  STAGE  │
                    └─────────┘

         🔴              🟡              🔵              🟢
    ┌─────────┐    ┌─────────┐    ┌─────────┐    ┌─────────┐
    │ UPPER   │    │ LOWER   │    │  CORE   │    │  TOTAL  │
    │  BODY   │    │  BODY   │    │         │    │  BODY   │
    │         │    │         │    │         │    │         │
    │ Player  │    │ Player  │    │ Player  │    │ Player  │
    │ Stands  │    │ Stands  │    │ Stands  │    │ Stands  │
    │  Here   │    │  Here   │    │  Here   │    │  Here   │
    └─────────┘    └─────────┘    └─────────┘    └─────────┘
```

### Group Mode Flow

#### 1. Exercise Preview
```
┌─────────────────────────────────────────────────────────────┐
│              TODAY'S EXERCISES                              │
│         Remember these for the pattern!                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   🔴 ARM CIRCLES    🟡 SQUATS    🔵 PLANK    🟢 JUMPING JACKS│
│       💫               🦵          🧘           🤸           │
│                                                             │
│   "Watch the colors light up, then do the exercises!"       │
│                                                             │
│                    [READY!]                                 │
└─────────────────────────────────────────────────────────────┘
```

#### 2. Pattern Display
```
┌─────────────────────────────────────────────────────────────┐
│                    WATCH THE PATTERN!                       │
│                      Round 3                                │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│              🔴 → 🟢 → 🔴                                   │
│                                                             │
│   ┌─────┐    ┌─────┐    ┌─────┐    ┌─────┐                 │
│   │ ███ │    │     │    │     │    │     │   ← Red lights  │
│   │ ███ │    │     │    │     │    │     │     up first    │
│   └─────┘    └─────┘    └─────┘    └─────┘                 │
│     🔴         🟡         🔵         🟢                      │
│                                                             │
│   🎵 *Tone plays for each color*                           │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

#### 3. Player Turn
```
┌─────────────────────────────────────────────────────────────┐
│                    YOUR TURN!                               │
│              Do the exercises in order!                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   Pattern: 🔴 → 🟢 → 🔴                                     │
│   Current: 🔴 ✓ → 🟢 ✓ → 🔴 ⏳                              │
│                                                             │
│   ┌─────────────────────────────────────┐                   │
│   │                                     │                   │
│   │      💫 ARM CIRCLES                 │  ← Current        │
│   │         :15 remaining               │    exercise       │
│   │                                     │                   │
│   └─────────────────────────────────────┘                   │
│                                                             │
│   Step on the correct platform and exercise!                │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Pattern Generation
```lua
local function generatePattern(round)
    local pattern = {}
    local colors = {"red", "yellow", "blue", "green"}

    for i = 1, round do
        local randomColor = colors[math.random(1, 4)]
        table.insert(pattern, randomColor)
    end

    return pattern
end

local function getExerciseForColor(color, energyLevel)
    local category = GROUP_MODE_COLORS[color].category
    local exercises = getExercisesByCategory(category)

    -- Filter by difficulty based on energy level
    local filtered = {}
    for _, exercise in ipairs(exercises) do
        if energyLevel == 1 and exercise.difficulty == "easy" then
            table.insert(filtered, exercise)
        elseif energyLevel == 2 and exercise.difficulty ~= "hard" then
            table.insert(filtered, exercise)
        elseif energyLevel == 3 then
            table.insert(filtered, exercise)
        end
    end

    return filtered[math.random(1, #filtered)]
end
```

### Simon Tones
```lua
-- Each color has a unique musical tone
local SIMON_TONES = {
    red = 329.63,    -- E4 (Upper Body)
    yellow = 261.63, -- C4 (Lower Body)
    blue = 220.00,   -- A3 (Core)
    green = 164.81   -- E3 (Total Body)
}

function playColorTone(color, duration)
    local frequency = SIMON_TONES[color]
    -- Play sine wave tone
    playTone(frequency, duration or 0.5)
end
```

---

## LUMO TRAINER

### 3D Exercise Demonstrations
```lua
-- Lumo performs each exercise with the player
local LUMO_ANIMATIONS = {
    squats = "rbxassetid://SQUAT_ANIM",
    jumping_jacks = "rbxassetid://JUMPING_JACKS_ANIM",
    plank = "rbxassetid://PLANK_ANIM",
    -- ... all 24 exercises
}

function playLumoDemo(exerciseId)
    local animation = LUMO_ANIMATIONS[exerciseId]
    lumoAnimator:LoadAnimation(animation):Play()
end
```

### Trainer Phrases
```lua
local LUMO_PHRASES = {
    -- Energy selection
    level1 = "Taking it easy? That's totally cool!",
    level2 = "Good energy! Let's get a solid workout!",
    level3 = "You're PUMPED! Let's crush it!",

    -- During workout
    work = {
        "Push it!",
        "Keep going!",
        "You're doing great!",
        "Almost there!",
        "Strong work!",
        "Yes! Yes! Yes!"
    },
    rest = {
        "Catch your breath!",
        "Nice job!",
        "Get ready!",
        "You earned this!",
        "Shake it out!"
    },

    -- Group mode
    groupWatch = "Watch carefully! Remember the pattern!",
    groupGo = "Time to move! Follow the pattern!",
    groupSuccess = "Amazing teamwork!",
    groupMiss = "No worries! Let's try again!"
}
```

---

## BADGES & ACHIEVEMENTS

### Badge System
```lua
local BADGES = {
    {
        id = "first-workout",
        name = "First Steps",
        icon = "👟",
        requirement = "Complete your first workout",
        check = function(stats) return stats.totalWorkouts >= 1 end
    },
    {
        id = "chill-champion",
        name = "Chill Champion",
        icon = "😌",
        requirement = "Complete 10 Level 1 workouts",
        check = function(stats) return stats.level1Count >= 10 end
    },
    {
        id = "energy-master",
        name = "Energy Master",
        icon = "😊",
        requirement = "Complete 10 Level 2 workouts",
        check = function(stats) return stats.level2Count >= 10 end
    },
    {
        id = "fire-starter",
        name = "Fire Starter",
        icon = "🔥",
        requirement = "Complete 10 Level 3 workouts",
        check = function(stats) return stats.level3Count >= 10 end
    },
    {
        id = "variety-star",
        name = "Variety Star",
        icon = "⭐",
        requirement = "Use all 24 exercises",
        check = function(stats) return stats.uniqueExercises >= 24 end
    },
    {
        id = "streak-3",
        name = "On a Roll",
        icon = "🎯",
        requirement = "3-day streak",
        check = function(stats) return stats.currentStreak >= 3 end
    },
    {
        id = "streak-7",
        name = "Week Warrior",
        icon = "💪",
        requirement = "7-day streak",
        check = function(stats) return stats.currentStreak >= 7 end
    },
    {
        id = "streak-30",
        name = "Monthly Master",
        icon = "🏆",
        requirement = "30-day streak",
        check = function(stats) return stats.currentStreak >= 30 end
    },
    {
        id = "pattern-pro",
        name = "Pattern Pro",
        icon = "🎮",
        requirement = "Reach Round 5 in Group Mode",
        check = function(stats) return stats.groupModeBest >= 5 end
    },
    {
        id = "memory-master",
        name = "Memory Master",
        icon = "🧠",
        requirement = "Reach Round 10 in Group Mode",
        check = function(stats) return stats.groupModeBest >= 10 end
    }
}
```

### Badge Display
```
┌─────────────────────────────────────────────────────────────┐
│                    🏆 YOUR BADGES                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  EARNED (4/10):                                             │
│  ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐                           │
│  │ 👟  │ │ 😌  │ │ 🎯  │ │ 🎮  │                           │
│  │First│ │Chill│ │Roll │ │Pro  │                           │
│  │Steps│ │Champ│ │     │ │     │                           │
│  └─────┘ └─────┘ └─────┘ └─────┘                           │
│                                                             │
│  IN PROGRESS:                                               │
│  ┌─────┐                                                    │
│  │ 💪  │  Week Warrior                                      │
│  │     │  5/7 day streak                                    │
│  │ ░░░ │  ██████████░░░░                                    │
│  └─────┘                                                    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## WORKOUT CALENDAR

### Streak Tracking
```
┌─────────────────────────────────────────────────────────────┐
│                   📅 WORKOUT CALENDAR                       │
│                    February 2026                            │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   Sun   Mon   Tue   Wed   Thu   Fri   Sat                  │
│  ┌─────┬─────┬─────┬─────┬─────┬─────┬─────┐               │
│  │     │     │     │     │     │     │  1  │               │
│  │     │     │     │     │     │     │ 😌  │               │
│  ├─────┼─────┼─────┼─────┼─────┼─────┼─────┤               │
│  │  2  │  3  │  4  │  5  │  6  │  7  │  8  │               │
│  │ 😊  │ 🔥  │     │ 😌  │ 😊  │ 🔥  │ 😊  │               │
│  ├─────┼─────┼─────┼─────┼─────┼─────┼─────┤               │
│  │  9  │ 10  │ 11  │ ...                                   │
│  │ 😌  │ ⭕  │     │                                       │
│  └─────┴─────┴─────┴─────                                  │
│                                                             │
│   Current Streak: 🔥 8 days!                                │
│   This Week: 5/7 workouts                                   │
│   Total Workouts: 24                                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘

Legend: 😌 = Level 1 | 😊 = Level 2 | 🔥 = Level 3 | ⭕ = Today
```

---

## XP & REWARDS

### XP Calculation
```lua
function calculateWorkoutXP(workout)
    local baseXP = 50
    local energyMultiplier = ENERGY_LEVELS[workout.energyLevel].xpMultiplier
    local exerciseBonus = #workout.exercises * 5
    local roundBonus = workout.rounds * 10

    local totalXP = math.floor((baseXP + exerciseBonus + roundBonus) * energyMultiplier)

    -- Streak bonus
    if workout.currentStreak >= 7 then
        totalXP = totalXP + 25
    elseif workout.currentStreak >= 3 then
        totalXP = totalXP + 10
    end

    return totalXP
end
```

### Reward Table

| Action | Base XP |
|--------|---------|
| Complete workout | 50 |
| Per exercise | +5 |
| Per round | +10 |
| Energy Level 2 | ×1.5 |
| Energy Level 3 | ×2.0 |
| 3-day streak bonus | +10 |
| 7-day streak bonus | +25 |
| Group Mode round | 15 per round |

---

## WORKOUT COMPLETE SCREEN

```
┌─────────────────────────────────────────────────────────────┐
│              🎉 WORKOUT COMPLETE! 🎉                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│                    YOU DID IT!                              │
│                                                             │
│              ┌────────────────────────┐                     │
│              │   🔥 Let's GO! Mode    │                     │
│              │                        │                     │
│              │   8 exercises          │                     │
│              │   2 rounds             │                     │
│              │   28:32 total time     │                     │
│              │                        │                     │
│              │   + 150 XP earned!     │                     │
│              └────────────────────────┘                     │
│                                                             │
│   🔥 Streak: 8 days in a row!                               │
│                                                             │
│   NEW BADGE UNLOCKED!                                       │
│   ┌─────────────────────────┐                               │
│   │  💪 WEEK WARRIOR        │                               │
│   │  7-day workout streak!  │                               │
│   └─────────────────────────┘                               │
│                                                             │
│        [SHARE]      [CALENDAR]      [EXIT]                  │
└─────────────────────────────────────────────────────────────┘
```

---

## FILE STRUCTURE

```
ServerScriptService/
├── MoveGrooveServer.lua
│   ├── WorkoutManager
│   ├── StreakCalculator
│   ├── BadgeHandler
│   ├── GroupModeController
│   └── XPRewardHandler

ReplicatedStorage/
├── MoveGrooveData/
│   ├── Exercises.lua
│   ├── EnergyLevels.lua
│   ├── Badges.lua
│   ├── GroupModeConfig.lua
│   └── LumoDialogue.lua
├── MoveGrooveRemotes/
│   ├── StartWorkout
│   ├── CompleteExercise
│   ├── EndWorkout
│   ├── JoinGroupMode
│   ├── SubmitPattern
│   └── FetchCalendar

Workspace/
├── MoveGrooveArena/
│   ├── MainStage
│   ├── LumoTrainer (NPC)
│   ├── TimerDisplay
│   ├── GroupModePlatforms/
│   │   ├── RedPlatform
│   │   ├── YellowPlatform
│   │   ├── BluePlatform
│   │   └── GreenPlatform
│   └── ExerciseSelectPods

StarterGui/
├── MoveGrooveUI/
│   ├── EnergySelectScreen
│   ├── ExerciseSelectScreen
│   ├── WorkoutTimerHUD
│   ├── RestScreen
│   ├── GroupModeUI
│   ├── WorkoutCompleteScreen
│   ├── CalendarScreen
│   └── BadgesScreen
```

---

## DATA PERSISTENCE

```lua
local PlayerMoveGrooveData = {
    workouts = {
        {
            date = "2026-02-03",
            energyLevel = 3,
            exercises = {"squats", "push-ups", "plank", "jumping_jacks", ...},
            rounds = 2,
            duration = 1712, -- seconds
            xpEarned = 150
        }
    },
    earnedBadges = {"first-workout", "chill-champion", "streak-3"},
    weeklyGoal = 5,
    groupModeBest = 7,
    stats = {
        totalWorkouts = 24,
        level1Count = 8,
        level2Count = 10,
        level3Count = 6,
        uniqueExercises = 18,
        currentStreak = 8,
        longestStreak = 12
    }
}
```

---

## IMPLEMENTATION PRIORITY

### Phase 1: Core Workout
- Arena environment and portal
- Unlock gate tied to Castle Gym
- Energy level selection
- Exercise selection UI
- Basic timer system

### Phase 2: Full Solo Mode
- All 24 exercises with data
- Work/rest interval system
- Round progression
- Lumo demonstration animations
- Workout complete flow

### Phase 3: Group Mode
- Simon-says platforms
- Pattern generation
- Multi-player sync
- Score tracking
- Round progression

### Phase 4: Tracking & Polish
- Calendar system
- Streak calculation
- Badge system
- XP rewards
- Sound design
- Visual effects
