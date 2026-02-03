# BUBBLE BURST: NUTRIENT POP ARENA

## Overview

A 3D bubble-popping time attack game where players burst floating bubbles containing nutrient-dense foods while avoiding "fun foods" that steal time. Features 30 levels across 6 themed environments, special bubbles, power-ups, and environmental effects.

---

## GAME CONCEPT

### Core Mechanic
- Bubbles float up (or down in reverse mode) across the screen
- Tap/click bubbles containing healthy foods to collect them
- Avoid tapping "fun foods" (junk food) which deduct time
- Meet the target number before time runs out
- Earn 1-3 stars based on performance

### Visual Style
- Floating bubble arena in 3D space
- Themed environments (Ocean, Cherry Blossom, Night Sky, etc.)
- Translucent 3D sphere bubbles with food emojis inside
- Particle effects for bursting bubbles
- Environmental effects (wind, waves, fog)

---

## 3D ARENA DESIGN

### Bubble Arena Structure
```
┌─────────────────────────────────────────────────────────────┐
│                    BUBBLE BURST ARENA                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │              HUD (Timer, Score, Progress)           │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
│                         ○ 🍎                                │
│            ○ 🥦                      ○ 🍕                   │
│                    ○ 🌟                                     │
│       ○ 💧                 ○ 🥕          ○ 🍗               │
│                  ○ 🍬                                       │
│          ○ 🍌                    ○ 🐟                       │
│   ○ 🍊              ○ 🫐                     ○ 🥤           │
│              ○ 🥬           ○ 🧀                            │
│                                                             │
│  ═══════════════════════════════════════════════════════    │
│              [BUBBLE SPAWN ZONE - Bottom]                   │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Bubble 3D Design
```lua
-- Translucent sphere bubble with food inside
local function createBubble(food, size)
    local bubble = Instance.new("Part")
    bubble.Shape = Enum.PartType.Ball
    bubble.Size = Vector3.new(size, size, size)
    bubble.Material = Enum.Material.Glass
    bubble.Transparency = 0.4
    bubble.Color = Color3.fromRGB(200, 240, 255) -- Light blue tint

    -- Add shine/reflection
    local shine = Instance.new("SurfaceLight")
    shine.Brightness = 0.5
    shine.Color = Color3.new(1, 1, 1)
    shine.Parent = bubble

    -- Food emoji label (BillboardGui)
    local label = Instance.new("BillboardGui")
    label.Size = UDim2.new(0, 100, 0, 100)
    label.AlwaysOnTop = true

    local text = Instance.new("TextLabel")
    text.Text = food.emoji
    text.TextScaled = true
    text.BackgroundTransparency = 1
    text.Size = UDim2.new(1, 0, 1, 0)
    text.Parent = label

    label.Parent = bubble

    return bubble
end
```

---

## THEMED ENVIRONMENTS

### 6 Theme Zones (5 Levels Each)

| Zone | Levels | Theme | Colors | Backdrop |
|------|--------|-------|--------|----------|
| 1 | 1-5 | Ocean | Teal/Cyan | Underwater scene, fish, coral |
| 2 | 6-10 | Cherry Blossom | Pink/Rose | Floating petals, Japanese garden |
| 3 | 11-15 | Night Sky | Indigo/Purple | Stars, moon, constellations |
| 4 | 16-20 | Autumn Forest | Orange/Amber | Falling leaves, trees |
| 5 | 21-25 | Winter Wonderland | Sky Blue/White | Snowflakes, ice crystals |
| 6 | 26-30 | Galaxy | Violet/Fuchsia | Nebulas, planets, asteroids |

### Environment Visual Implementation
```lua
local THEMES = {
    ocean = {
        name = "Ocean",
        skyColor = Color3.fromRGB(100, 200, 220),
        bubbleGlow = Color3.fromRGB(0, 150, 180),
        particles = "Bubbles", -- Water bubbles rising
        ambient = "UnderwaterAmbience"
    },
    cherry = {
        name = "Cherry Blossom",
        skyColor = Color3.fromRGB(255, 200, 220),
        bubbleGlow = Color3.fromRGB(236, 72, 153),
        particles = "Petals", -- Cherry blossom petals
        ambient = "SpringBreeze"
    },
    night = {
        name = "Night Sky",
        skyColor = Color3.fromRGB(20, 20, 60),
        bubbleGlow = Color3.fromRGB(99, 102, 241),
        particles = "Stars", -- Twinkling stars
        ambient = "NightCrickets"
    },
    autumn = {
        name = "Autumn Forest",
        skyColor = Color3.fromRGB(255, 180, 100),
        bubbleGlow = Color3.fromRGB(251, 146, 60),
        particles = "Leaves", -- Falling autumn leaves
        ambient = "ForestWind"
    },
    winter = {
        name = "Winter Wonderland",
        skyColor = Color3.fromRGB(200, 230, 255),
        bubbleGlow = Color3.fromRGB(56, 189, 248),
        particles = "Snowflakes", -- Falling snow
        ambient = "WinterWind"
    },
    galaxy = {
        name = "Galaxy",
        skyColor = Color3.fromRGB(40, 20, 80),
        bubbleGlow = Color3.fromRGB(147, 51, 234),
        particles = "Stardust", -- Cosmic particles
        ambient = "SpaceAmbience"
    }
}
```

---

## LEVEL PROGRESSION

### 30 Levels Configuration

| Level | Theme | Time | Target | Max Bubbles | Environment | Special % |
|-------|-------|------|--------|-------------|-------------|-----------|
| 1 | Ocean | 60s | 8 | 10 | None | 0% |
| 2 | Ocean | 60s | 10 | 10 | None | 2% |
| 3 | Ocean | 55s | 12 | 11 | None | 3% |
| 4 | Ocean | 55s | 14 | 11 | Wind | 3% |
| 5 | Ocean | 50s | 16 | 12 | Wind | 4% |
| 6 | Cherry | 55s | 18 | 12 | None | 4% |
| 7 | Cherry | 55s | 20 | 13 | Wind | 5% |
| 8 | Cherry | 50s | 22 | 13 | Wind | 5% |
| 9 | Cherry | 50s | 24 | 14 | Waves | 6% |
| 10 | Cherry | 45s | 25 | 14 | Waves | 6% |
| 11 | Night | 50s | 26 | 14 | None | 6% |
| 12 | Night | 50s | 28 | 15 | Wind | 7% |
| 13 | Night | 45s | 28 | 15 | Waves | 7% |
| 14 | Night | 45s | 30 | 15 | Shrinking | 8% |
| 15 | Night | 40s | 30 | 16 | Fog | 8% |
| 16 | Autumn | 45s | 30 | 16 | Wind | 8% |
| 17 | Autumn | 45s | 32 | 16 | Waves | 9% |
| 18 | Autumn | 40s | 32 | 17 | Shrinking | 9% |
| 19 | Autumn | 40s | 34 | 17 | Fog | 10% |
| 20 | Autumn | 35s | 34 | 17 | Shrinking | 10% |
| 21 | Winter | 40s | 34 | 17 | Wind | 10% |
| 22 | Winter | 40s | 36 | 18 | Waves | 10% |
| 23 | Winter | 35s | 36 | 18 | Fog | 11% |
| 24 | Winter | 35s | 38 | 18 | Shrinking | 11% |
| 25 | Winter | 30s | 38 | 19 | Reverse | 12% |
| 26 | Galaxy | 35s | 38 | 19 | Waves | 12% |
| 27 | Galaxy | 35s | 40 | 19 | Shrinking | 12% |
| 28 | Galaxy | 30s | 40 | 20 | Fog | 13% |
| 29 | Galaxy | 30s | 42 | 20 | Reverse | 13% |
| 30 | Galaxy | 25s | 45 | 20 | Reverse | 15% |

---

## ENVIRONMENTAL EFFECTS

### Effect Types
```lua
local ENVIRONMENTS = {
    none = {
        name = "Calm",
        description = "No special effects",
        applyEffect = function(bubble, progress)
            return bubble.position
        end
    },
    wind = {
        name = "Wind",
        description = "Bubbles drift sideways",
        applyEffect = function(bubble, progress)
            local x = bubble.baseX + math.sin(progress * math.pi * 4) * 8
            return Vector3.new(x, bubble.y, bubble.z)
        end
    },
    waves = {
        name = "Waves",
        description = "Bubbles move in wave patterns",
        applyEffect = function(bubble, progress)
            local x = bubble.baseX + math.sin(progress * math.pi * 6) * 12
            local y = bubble.y + math.cos(progress * math.pi * 4) * 5
            return Vector3.new(x, y, bubble.z)
        end
    },
    shrinking = {
        name = "Shrinking",
        description = "Bubbles shrink as they rise",
        applyEffect = function(bubble, progress)
            local scale = 1 - (progress * 0.4)
            scale = math.max(scale, 0.5)
            bubble:SetSize(bubble.originalSize * scale)
            return bubble.position
        end
    },
    reverse = {
        name = "Reverse",
        description = "Bubbles fall down!",
        applyEffect = function(bubble, progress)
            -- Y goes down instead of up
            local y = bubble.startY + (progress * bubble.travelDistance)
            return Vector3.new(bubble.x, y, bubble.z)
        end
    },
    fog = {
        name = "Fog",
        description = "Some bubbles are partially hidden",
        applyEffect = function(bubble, progress)
            if bubble.isFoggy then
                bubble.Transparency = 0.7
            end
            return bubble.position
        end
    }
}
```

### Visual Effect Implementation
```lua
-- Wind effect - adds particle streamers
function applyWindEffect()
    local wind = Instance.new("ParticleEmitter")
    wind.Texture = "rbxasset://textures/particles/wind_streak"
    wind.Speed = NumberRange.new(20, 30)
    wind.Lifetime = NumberRange.new(1, 2)
    wind.Rate = 50
    wind.SpreadAngle = Vector2.new(10, 10)
    wind.Parent = workspace.BubbleArena
end

-- Fog effect - adds atmospheric haze
function applyFogEffect()
    local fog = Instance.new("Atmosphere")
    fog.Density = 0.4
    fog.Color = Color3.fromRGB(200, 200, 220)
    fog.Decay = Color3.fromRGB(150, 150, 180)
    fog.Parent = game.Lighting
end
```

---

## FOOD ITEMS

### Nutrient-Dense Foods (27 items)

| ID | Name | Emoji | Category | Health Takeaway |
|----|------|-------|----------|-----------------|
| water | Water | 💧 | Hydration | "Water keeps you hydrated!" |
| apple | Apple | 🍎 | Fruit | "Apples are packed with fiber!" |
| banana | Banana | 🍌 | Fruit | "Bananas give quick energy!" |
| strawberries | Strawberries | 🍓 | Fruit | "Full of vitamin C!" |
| orange | Orange | 🍊 | Fruit | "Boosts your immune system!" |
| grapes | Grapes | 🍇 | Fruit | "Nature's candy for your heart!" |
| watermelon | Watermelon | 🍉 | Fruit | "Keeps you hydrated!" |
| blueberries | Blueberries | 🫐 | Fruit | "Brain food for thinking!" |
| carrot | Carrot | 🥕 | Vegetable | "Healthy eyes and energy!" |
| broccoli | Broccoli | 🥦 | Vegetable | "Super veggie for strength!" |
| leafy_greens | Leafy Greens | 🥬 | Vegetable | "Iron for energy!" |
| bell_pepper | Bell Pepper | 🫑 | Vegetable | "Crunchy and full of vitamins!" |
| tomato | Tomato | 🍅 | Vegetable | "Keeps your body strong!" |
| sweet_potato | Sweet Potato | 🍠 | Vegetable | "Long-lasting energy!" |
| cucumber | Cucumber | 🥒 | Vegetable | "Refreshing and hydrating!" |
| beans | Beans | 🫘 | Protein | "Builds strong muscles!" |
| egg | Egg | 🥚 | Protein | "Muscles and focus!" |
| nuts | Nuts | 🥜 | Protein | "Brain power and energy!" |
| salmon | Salmon | 🐟 | Protein | "Healthy fats for brain!" |
| chicken | Chicken | 🍗 | Protein | "Lean protein for muscles!" |
| shrimp | Shrimp | 🍤 | Protein | "Tasty protein power!" |
| brown_rice | Brown Rice | 🍚 | Grain | "Steady lasting energy!" |
| oatmeal | Oatmeal | 🥣 | Grain | "Warm energy breakfast!" |
| whole_grain_bread | Bread | 🍞 | Grain | "Fiber and energy!" |
| yogurt | Yogurt | 🥛 | Dairy | "Protein for your tummy!" |
| cheese | Cheese | 🧀 | Dairy | "Calcium for strong bones!" |
| avocado | Avocado | 🥑 | Healthy Fat | "Good fats for focus!" |

### Fun Foods to Avoid (12 items)

| ID | Name | Emoji | Penalty |
|----|------|-------|---------|
| soda | Soda | 🥤 | -2 seconds |
| chips | Chips | 🍟 | -2 seconds |
| cookies | Cookies | 🍪 | -2 seconds |
| candy | Candy | 🍬 | -2 seconds |
| juice | Juice Box | 🧃 | -2 seconds |
| pizza | Pizza | 🍕 | -2 seconds |
| ice_cream | Ice Cream | 🍦 | -2 seconds |
| donut | Donut | 🍩 | -2 seconds |
| popcorn | Popcorn | 🍿 | -2 seconds |
| cupcake | Cupcake | 🧁 | -2 seconds |
| lollipop | Lollipop | 🍭 | -2 seconds |
| chocolate | Chocolate | 🍫 | -2 seconds |

---

## SPECIAL BUBBLES

### 5 Special Types
```lua
local SPECIAL_BUBBLES = {
    golden = {
        emoji = "🌟",
        name = "Golden",
        effect = "Counts as 2 bursts!",
        color = Color3.fromRGB(255, 215, 0), -- Gold
        glowColor = Color3.fromRGB(255, 200, 50),
        reward = 2 -- multiplier
    },
    bomb = {
        emoji = "💣",
        name = "Bomb",
        effect = "-5 seconds!",
        color = Color3.fromRGB(50, 50, 50), -- Dark gray
        glowColor = Color3.fromRGB(255, 0, 0),
        penalty = 5 -- seconds
    },
    frozen = {
        emoji = "❄️",
        name = "Frozen",
        effect = "Tap twice to burst",
        color = Color3.fromRGB(180, 220, 255), -- Light blue
        glowColor = Color3.fromRGB(100, 200, 255),
        tapsRequired = 2
    },
    rainbow = {
        emoji = "🌈",
        name = "Rainbow",
        effect = "Bonus XP!",
        colors = {
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(255, 165, 0),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(128, 0, 128)
        },
        bonusXP = 3
    },
    mystery = {
        emoji = "❓",
        name = "Mystery",
        effect = "Random effect!",
        color = Color3.fromRGB(200, 100, 255), -- Purple
        glowColor = Color3.fromRGB(255, 150, 255),
        effects = {"time+3", "time+3", "double", "time-2"} -- Weighted toward positive
    }
}
```

### Special Bubble Visual Effects
```lua
function createGoldenBubble()
    local bubble = createBaseBubble()
    bubble.Color = SPECIAL_BUBBLES.golden.color

    -- Golden sparkle particles
    local sparkle = Instance.new("ParticleEmitter")
    sparkle.Texture = "rbxasset://textures/particles/sparkle"
    sparkle.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
    sparkle.Size = NumberSequence.new(0.3, 0)
    sparkle.Rate = 20
    sparkle.Parent = bubble

    return bubble
end

function createRainbowBubble()
    local bubble = createBaseBubble()

    -- Cycling rainbow colors
    spawn(function()
        local colors = SPECIAL_BUBBLES.rainbow.colors
        local index = 1
        while bubble.Parent do
            bubble.Color = colors[index]
            index = (index % #colors) + 1
            wait(0.2)
        end
    end)

    return bubble
end
```

---

## POWER-UPS

### 4 Power-Up Types
```lua
local POWER_UPS = {
    timeBonus = {
        emoji = "⏱️",
        name = "Time Bonus",
        description = "+5 seconds!",
        duration = 0, -- Instant
        effect = function(gameState)
            gameState.timeRemaining = gameState.timeRemaining + 5
        end
    },
    shield = {
        emoji = "🛡️",
        name = "Shield",
        description = "Block next penalty",
        duration = 15, -- seconds
        effect = function(gameState)
            gameState.hasShield = true
        end
    },
    magnet = {
        emoji = "🧲",
        name = "Magnet",
        description = "Bubbles move slower",
        duration = 5, -- seconds
        effect = function(gameState)
            gameState.bubbleSpeedMultiplier = 0.5
        end
    },
    doublePop = {
        emoji = "2️⃣",
        name = "Double Pop",
        description = "Next burst counts as 2",
        duration = 10, -- seconds
        effect = function(gameState)
            gameState.nextPopDouble = true
        end
    }
}
```

### Power-Up Bubble Design
```lua
function createPowerUpBubble(powerUpType)
    local powerUp = POWER_UPS[powerUpType]
    local bubble = createBaseBubble()

    -- Purple/pink gradient for power-ups
    bubble.Color = Color3.fromRGB(200, 100, 255)

    -- Pulsing glow effect
    local light = Instance.new("PointLight")
    light.Color = Color3.fromRGB(255, 150, 255)
    light.Brightness = 2
    light.Range = 8
    light.Parent = bubble

    -- Pulse animation
    spawn(function()
        while bubble.Parent do
            TweenService:Create(light, TweenInfo.new(0.5), {
                Brightness = 4
            }):Play()
            wait(0.5)
            TweenService:Create(light, TweenInfo.new(0.5), {
                Brightness = 2
            }):Play()
            wait(0.5)
        end
    end)

    return bubble
end
```

---

## GAME FLOW

### Bubble Spawning System
```lua
local BubbleSpawner = {}

function BubbleSpawner:spawnBubble(levelConfig)
    local spawnX = math.random(10, 90) / 100 * ARENA_WIDTH
    local spawnY = levelConfig.environment == "reverse" and ARENA_TOP or ARENA_BOTTOM

    -- Check for special bubble spawn
    if math.random() < levelConfig.specialChance then
        return self:createSpecialBubble(spawnX, spawnY, levelConfig)
    end

    -- Check for power-up spawn
    if math.random() < levelConfig.powerUpChance then
        return self:createPowerUpBubble(spawnX, spawnY, levelConfig)
    end

    -- Regular bubble (nutrient vs fun food ratio)
    local isNutrient = math.random() < levelConfig.nutrientRatio

    if isNutrient then
        local food = self:getRandomNutrientFood()
        return self:createNutrientBubble(food, spawnX, spawnY, levelConfig)
    else
        local funFood = self:getRandomFunFood()
        return self:createFunFoodBubble(funFood, spawnX, spawnY, levelConfig)
    end
end

function BubbleSpawner:startSpawning(levelConfig)
    self.spawnLoop = task.spawn(function()
        while self.isActive do
            if self:countActiveBubbles() < levelConfig.maxBubbles then
                local bubble = self:spawnBubble(levelConfig)
                table.insert(self.activeBubbles, bubble)
            end
            task.wait(0.7) -- Spawn interval
        end
    end)
end
```

### Bubble Click Handler
```lua
function handleBubbleClick(bubble, player, gameState)
    if bubble.isPopped then return end

    -- Handle frozen bubble
    if bubble.specialType == "frozen" then
        bubble.tapsRemaining = bubble.tapsRemaining - 1
        if bubble.tapsRemaining > 0 then
            playSound("FrozenTap")
            showFloatingText(bubble, tostring(bubble.tapsRemaining))
            return
        end
    end

    -- Handle power-up bubble
    if bubble.isPowerUp then
        activatePowerUp(bubble.powerUpType, gameState)
        popBubble(bubble, "powerup")
        return
    end

    -- Handle special bubbles
    if bubble.isSpecial then
        handleSpecialBubble(bubble, gameState)
        return
    end

    -- Handle nutrient bubble
    if bubble.isNutrient then
        local count = gameState.doublePop and 2 or 1
        gameState.collected = gameState.collected + count
        gameState.doublePop = false -- Use up double pop

        -- Streak tracking
        if bubble.food.category == gameState.lastCategory then
            gameState.streak = gameState.streak + 1
            if gameState.streak >= 3 and gameState.streak % 3 == 0 then
                showStreakBonus(gameState.streak)
            end
        else
            gameState.streak = 1
            gameState.lastCategory = bubble.food.category
        end

        popBubble(bubble, "nutrient")
        showHealthTakeaway(bubble.food.takeaway)
        return
    end

    -- Handle fun food bubble (penalty!)
    if bubble.isFunFood then
        if gameState.hasShield then
            gameState.hasShield = false
            showFloatingText(bubble, "🛡️ Blocked!")
            playSound("ShieldBlock")
        else
            gameState.timeRemaining = gameState.timeRemaining - 2
            gameState.streak = 0
            showFloatingText(bubble, "-2s!")
            playSound("Penalty")
        end
        popBubble(bubble, "funfood")
    end
end
```

---

## POP EFFECTS

### Burst Animation
```lua
function popBubble(bubble, type)
    bubble.isPopped = true

    -- Scale up and fade
    local popTween = TweenService:Create(bubble, TweenInfo.new(0.15), {
        Size = bubble.Size * 1.5,
        Transparency = 1
    })
    popTween:Play()

    -- Particle burst
    local burstColor = type == "nutrient" and Color3.fromRGB(100, 255, 150)
                    or type == "funfood" and Color3.fromRGB(255, 100, 100)
                    or Color3.fromRGB(255, 255, 100)

    local particles = Instance.new("ParticleEmitter")
    particles.Color = ColorSequence.new(burstColor)
    particles.Size = NumberSequence.new(0.5, 0)
    particles.Speed = NumberRange.new(10, 20)
    particles.SpreadAngle = Vector2.new(360, 360)
    particles.Lifetime = NumberRange.new(0.3, 0.5)
    particles.Parent = bubble
    particles:Emit(20)

    -- Play sound
    if type == "nutrient" then
        playSound("Pop")
    elseif type == "funfood" then
        playSound("Penalty")
    elseif type == "powerup" then
        playSound("PowerUp")
    end

    -- Remove after animation
    Debris:AddItem(bubble, 0.5)
end
```

### Streak Effect
```lua
function showStreakBonus(streak)
    local streakText = Instance.new("BillboardGui")
    streakText.Size = UDim2.new(0, 200, 0, 50)
    streakText.StudsOffset = Vector3.new(0, 5, 0)

    local label = Instance.new("TextLabel")
    label.Text = "🔥 " .. streak .. " STREAK!"
    label.TextColor3 = Color3.fromRGB(255, 150, 50)
    label.TextSize = 24
    label.Font = Enum.Font.GothamBold
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Parent = streakText

    streakText.Parent = workspace.BubbleArena

    -- Animate and remove
    TweenService:Create(streakText, TweenInfo.new(1), {
        StudsOffset = Vector3.new(0, 10, 0)
    }):Play()

    Debris:AddItem(streakText, 1.5)
end
```

---

## UI LAYOUT

### HUD During Gameplay
```
┌─────────────────────────────────────────────────────────────┐
│  Level 15: Constellation          🌙 Night Sky              │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌──────────┐   ┌──────────┐   ┌──────────┐               │
│   │  ⏱️ 0:35  │   │  28/30   │   │  🔥 5    │               │
│   │  TIME    │   │ COLLECTED│   │  STREAK  │               │
│   └──────────┘   └──────────┘   └──────────┘               │
│                                                             │
│   Progress: ████████████████████████████░░░░░░ 93%          │
│                                                             │
│   Star Goals:  ⭐30   ⭐⭐35   ⭐⭐⭐39                      │
│                                                             │
│   Active Power-ups: [🛡️] [🧲]                               │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Level Complete Screen
```
┌─────────────────────────────────────────────────────────────┐
│                     ⭐⭐⭐                                  │
│              LEVEL 15 COMPLETE!                             │
│                 "Constellation"                             │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│            Collected: 42/30                                 │
│            Time Remaining: 0:08                             │
│            Max Streak: 7 🔥                                 │
│                                                             │
│   ┌───────────────────────────────────────────────────┐     │
│   │  Points: 4,200                                    │     │
│   │  ──────────────────────                           │     │
│   │  Base XP:           +12                           │     │
│   │  Star Bonus:        +5                            │     │
│   │  Streak Bonus:      +4                            │     │
│   │  Perfect Bonus:     +5                            │     │
│   │  ──────────────────────                           │     │
│   │  TOTAL XP:          +26                           │     │
│   └───────────────────────────────────────────────────┘     │
│                                                             │
│   💡 Health Takeaway:                                       │
│   "Blueberries are brain food that help you think!"         │
│                                                             │
│   [🚀 NEXT LEVEL]    [🔄 REPLAY]    [📋 LEVEL SELECT]      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Level Select Screen
```
┌─────────────────────────────────────────────────────────────┐
│                   BUBBLE BURST                              │
│                 Select Your Level                           │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  🌊 OCEAN (Levels 1-5)                                      │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐                             │
│  │ 1 │ │ 2 │ │ 3 │ │ 4 │ │ 5 │                             │
│  │⭐⭐⭐│ │⭐⭐⭐│ │⭐⭐░│ │⭐░░│ │░░░│                             │
│  └───┘ └───┘ └───┘ └───┘ └───┘                             │
│                                                             │
│  🌸 CHERRY BLOSSOM (Levels 6-10)                            │
│  ┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐                             │
│  │ 6 │ │ 7 │ │ 8 │ │ 9 │ │10 │                             │
│  │⭐░░│ │🔒 │ │🔒 │ │🔒 │ │🔒 │                             │
│  └───┘ └───┘ └───┘ └───┘ └───┘                             │
│                                                             │
│  🌙 NIGHT SKY (Levels 11-15)         [LOCKED]               │
│  🍂 AUTUMN FOREST (Levels 16-20)     [LOCKED]               │
│  ❄️ WINTER (Levels 21-25)            [LOCKED]               │
│  🌌 GALAXY (Levels 26-30)            [LOCKED]               │
│                                                             │
│  Total Stars: ⭐ 12/90                                      │
│  Daily XP: 45/100                                           │
│                                                             │
│                    [BACK TO MENU]                           │
└─────────────────────────────────────────────────────────────┘
```

---

## SCORING SYSTEM

### Star Thresholds
```lua
local STAR_THRESHOLDS = {
    oneStar = 1.00,   -- 100% of target
    twoStar = 1.15,   -- 115% of target
    threeStar = 1.30  -- 130% of target
}

function calculateStars(collected, target)
    local ratio = collected / target
    if ratio >= STAR_THRESHOLDS.threeStar then return 3 end
    if ratio >= STAR_THRESHOLDS.twoStar then return 2 end
    if ratio >= STAR_THRESHOLDS.oneStar then return 1 end
    return 0
end
```

### XP Calculation
```lua
local BASE_XP_BY_ZONE = {
    ocean = 5,
    cherry = 8,
    night = 12,
    autumn = 15,
    winter = 18,
    galaxy = 20
}

local BONUSES = {
    star = {0, 1, 3, 5}, -- 0, 1, 2, 3 stars
    streak = 2,          -- Per 3-streak
    perfect = 5          -- No penalties
}

function calculateXP(levelConfig, collected, target, streakBonus, isPerfect, stars, isFirstCompletion)
    if collected < target then return 0 end

    local baseXP = BASE_XP_BY_ZONE[levelConfig.theme]
    local starBonus = BONUSES.star[stars + 1] or 0
    local perfectBonus = isPerfect and BONUSES.perfect or 0

    local totalXP = baseXP + starBonus + streakBonus + perfectBonus

    -- 50% XP on replay
    if not isFirstCompletion then
        totalXP = math.floor(totalXP * 0.5)
    end

    return totalXP
end
```

---

## AUDIO DESIGN

### Sound Effects

| Event | Sound Description |
|-------|-------------------|
| Nutrient Pop | Satisfying bubble burst (high pitch) |
| Fun Food Pop | Buzzer/penalty sound |
| Special Pop | Magical chime |
| Power-up Collect | Ascending sparkle |
| Streak (3+) | Fire whoosh |
| Shield Block | Metallic clang |
| Time Warning | Ticking (last 10s) |
| Level Complete | Victory fanfare |
| Time's Up | Sad trombone |

### Ambient Music
- Each theme has unique background music
- Tempo increases in last 15 seconds
- Victory stinger on level complete

---

## FILE STRUCTURE

```
ServerScriptService/
├── BubbleBurstServer.lua
│   ├── LevelManager
│   ├── BubbleSpawner
│   ├── ScoreCalculator
│   └── XPRewardHandler

ReplicatedStorage/
├── BubbleBurstData/
│   ├── LevelConfigs.lua
│   ├── Foods.lua
│   ├── SpecialBubbles.lua
│   ├── PowerUps.lua
│   └── Themes.lua
├── BubbleBurstRemotes/
│   ├── StartLevel
│   ├── BubbleClicked
│   ├── LevelComplete
│   └── FetchProgress

Workspace/
├── BubbleBurstArena/
│   ├── ArenaFrame
│   ├── ThemeBackdrops/
│   │   ├── OceanBackdrop
│   │   ├── CherryBackdrop
│   │   ├── NightBackdrop
│   │   ├── AutumnBackdrop
│   │   ├── WinterBackdrop
│   │   └── GalaxyBackdrop
│   ├── BubbleContainer
│   └── EffectsContainer

StarterGui/
├── BubbleBurstUI/
│   ├── MainMenu
│   ├── LevelSelectScreen
│   ├── GameHUD
│   │   ├── TimerDisplay
│   │   ├── ScoreDisplay
│   │   ├── ProgressBar
│   │   ├── StreakIndicator
│   │   └── PowerUpSlots
│   ├── LevelCompleteScreen
│   ├── TimeUpScreen
│   └── HealthTakeawayPopup
```

---

## DATA PERSISTENCE

```lua
local PlayerBubbleBurstData = {
    levelStars = {
        [1] = 3, [2] = 3, [3] = 2, [4] = 1, [5] = 0,
        -- ... levels 6-30
    },
    dailyXP = {
        date = "2026-02-03",
        earned = 45
    },
    stats = {
        totalBubblesBurst = 1250,
        totalLevelsCompleted = 18,
        highestLevel = 15,
        longestStreak = 12,
        perfectLevels = 5
    },
    totalXP = 320
}
```

---

## IMPLEMENTATION PRIORITY

### Phase 1: Core Gameplay
- Bubble arena environment
- Bubble spawning and movement
- Click/tap detection
- Basic scoring (nutrient vs fun food)
- Timer system

### Phase 2: Level System
- 30 level configurations
- Star rating system
- Level select UI
- XP rewards
- Progress saving

### Phase 3: Special Features
- Special bubbles (golden, bomb, frozen, rainbow, mystery)
- Power-ups
- Environmental effects (wind, waves, shrinking, reverse, fog)
- Streak system

### Phase 4: Polish
- 6 themed environments with backdrops
- Visual effects (particles, animations)
- Sound design
- Health takeaway popups
- Daily XP cap
