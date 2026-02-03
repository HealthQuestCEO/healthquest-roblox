# LUMO'S FOOD LAB: CHEF'S KITCHEN

## Overview

A 3D cooking simulation game where players learn to build nutritionally balanced meals. Located as a special portal in the main meadow near the castle, it unlocks when the Kitchen room unlocks. Players progress through recipe levels, adding nutritious "boosters" to transform favorite foods into MyPlate-balanced meals.

---

## GAME CONCEPT

### Core Mechanic
- Enter Lumo's magical kitchen laboratory
- Select recipes from familiar "comfort foods" (mac & cheese, tacos, etc.)
- Progress through 5 levels per recipe, adding healthy ingredients
- Build toward "Rainbow Plates" with all 5 MyPlate food groups
- Complete IRL challenges for bonus XP

### Unlock Condition
- **Requirement:** Kitchen room must be unlocked in the Castle
- **Portal Location:** Special swirling pot portal near the castle in Main Meadow
- **When locked:** Portal shows "🔒 Unlock the Kitchen first!"

### Visual Style
- Colorful cartoon kitchen with floating ingredients
- Lumo appears as a chef with a tall white hat
- MyPlate zones visualized as glowing sections on a large plate
- Ingredients float and sparkle when selected

---

## PORTAL DESIGN

### Meadow Portal Appearance
```
        ╭─────────────────────╮
        │   🍳 FOOD LAB 🧪    │
        ╰─────────────────────╯

           ┌───────────┐
          /  ░░░░░░░░░  \
         │  ░🥦🧀🍗░░  │  ← Giant magical cooking pot
         │  ░░🍝░░🥕░  │    with floating ingredients
         │  ░░░░░░░░░  │
          ╲ ~~~~~~~~~~╱     ← Bubbling steam/sparkles
           ╲_________ /
            │███████│
            └───────┘
```

### Portal Interaction
```lua
-- When player approaches
local function showPortalPrompt(player, isUnlocked)
    if isUnlocked then
        showPrompt("Press E to enter Lumo's Food Lab!")
    else
        showPrompt("🔒 Unlock the Kitchen in your Castle first!")
        -- Show preview of what's inside
        showFloatingText("Learn to cook with Lumo!")
    end
end
```

---

## KITCHEN ENVIRONMENT

### 3D Layout
```
┌─────────────────────────────────────────────────────────────┐
│                      LUMO'S FOOD LAB                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────┐                        ┌─────────────┐     │
│  │ INGREDIENT  │                        │  COOKING    │     │
│  │   SHELF     │                        │  STATION    │     │
│  │ 🥦🧀🍗🌾🍎  │                        │    🍳       │     │
│  │ 🥕🥛🫘🍞🫐  │                        │             │     │
│  └─────────────┘                        └─────────────┘     │
│                                                             │
│                    ┌─────────────────┐                      │
│                    │   MYPLATE       │                      │
│                    │   DISPLAY       │                      │
│                    │  🌾 🍗          │                      │
│                    │  🥛 🥦 🍎       │                      │
│                    └─────────────────┘                      │
│                                                             │
│  ┌─────────────┐                        ┌─────────────┐     │
│  │  RECIPE     │                        │  SMOOTHIE   │     │
│  │  BOOK       │                        │  BLENDER    │     │
│  │   📖        │                        │    🥤       │     │
│  └─────────────┘                        └─────────────┘     │
│                                                             │
│             👨‍🍳 Lumo (Chef Mode)                           │
│                                                             │
│  [EXIT PORTAL]                            [IRL CHALLENGES]  │
└─────────────────────────────────────────────────────────────┘
```

---

## MYPLATE SYSTEM

### Food Groups (Color-Coded Zones)

```lua
local MYPLATE_ZONES = {
    grains = {
        id = "grains",
        name = "Grains",
        emoji = "🌾",
        color = Color3.fromRGB(205, 133, 63), -- Brown/tan
        examples = {"Pasta", "Bread", "Rice", "Oatmeal", "Tortilla"},
        benefit = "Energy to run, play, and think!"
    },
    protein = {
        id = "protein",
        name = "Protein",
        emoji = "🍗",
        color = Color3.fromRGB(139, 69, 19), -- Brown/red
        examples = {"Chicken", "Beans", "Eggs", "Fish", "Nuts"},
        benefit = "Strong muscles and repairs your body!"
    },
    dairy = {
        id = "dairy",
        name = "Dairy",
        emoji = "🥛",
        color = Color3.fromRGB(135, 206, 250), -- Light blue
        examples = {"Milk", "Cheese", "Yogurt"},
        benefit = "Strong bones and teeth!"
    },
    vegetables = {
        id = "vegetables",
        name = "Vegetables",
        emoji = "🥦",
        color = Color3.fromRGB(34, 139, 34), -- Green
        examples = {"Broccoli", "Carrots", "Spinach", "Peppers"},
        benefit = "Vitamins to stay healthy and fight germs!"
    },
    fruits = {
        id = "fruits",
        name = "Fruits",
        emoji = "🍎",
        color = Color3.fromRGB(220, 20, 60), -- Red
        examples = {"Apples", "Bananas", "Berries", "Oranges"},
        benefit = "Natural sweetness and more vitamins!"
    }
}
```

### MyPlate 3D Display
```
           ┌───────────────────────┐
          /                         \
         /   🌾 Grains  │  🍗 Protein \
        │              │              │
        │──────────────┼──────────────│
        │   🥦 Veggies │  🍎 Fruits   │
         \             │             /
          \───────────────────────/
               │  🥛 Dairy  │
               └────────────┘
```

---

## RECIPE CATEGORIES

### 11 Food Categories

| Category | Icon | Examples |
|----------|------|----------|
| Pasta | 🍝 | Mac & Cheese, Spaghetti, Ramen |
| Tortillas | 🌯 | Tacos, Quesadillas, Burritos |
| Poultry | 🍗 | Chicken Nuggets, Tenders |
| Rice | 🍚 | White Rice, Fried Rice, Rice Bowls |
| Bread | 🍞 | Grilled Cheese, PB&J, Toast |
| Potatoes | 🥔 | French Fries, Mashed Potatoes |
| Cereal | 🥣 | Cold Cereal, Oatmeal |
| Crackers | 🧂 | Crackers & Cheese, Chips |
| Fruit | 🍎 | Fresh Fruit, Fruit Snacks |
| Sweets | 🍪 | Cookies, Treats (moderation focus) |
| Smoothies | 🥤 | Build-Your-Own Smoothies |

---

## LEVEL PROGRESSION SYSTEM

### 5 Levels Per Recipe

#### Example: Mac & Cheese Journey

**Level 1: Classic Comfort**
```
┌─────────────────────────────────────────────────┐
│  🧀 Classic Mac & Cheese                        │
│  "Your Favorite!"                               │
├─────────────────────────────────────────────────┤
│  Ingredients:                                   │
│  • 🍝 Box mac & cheese (Grains)                │
│  • 🧈 Butter                                    │
│  • 🥛 Milk (Dairy)                              │
├─────────────────────────────────────────────────┤
│  MyPlate Score: ⭐⭐ (2/5 groups)               │
│                                                 │
│  💡 Body Benefit:                               │
│  "Pasta gives your body energy to run, play,   │
│   and think! Cheese has calcium for strong     │
│   bones and teeth!"                            │
├─────────────────────────────────────────────────┤
│  NEXT LEVEL PREVIEW:                            │
│  "We'll sneak in extra protein - but it        │
│   tastes EXACTLY the same!"                    │
└─────────────────────────────────────────────────┘
```

**Level 2: Sneaky Protein**
```
┌─────────────────────────────────────────────────┐
│  💪 Sneaky Protein Mac                          │
│  "Same Taste - Secret Ingredient!"              │
├─────────────────────────────────────────────────┤
│  NEW Ingredient:                                │
│  • 🫘 White bean puree (Protein) ← HIDDEN!      │
├─────────────────────────────────────────────────┤
│  MyPlate Score: ⭐⭐⭐ (3/5 groups)             │
│                                                 │
│  💡 Booster Tip:                                │
│  "Blend 1/4 cup white beans until smooth.      │
│   Stir into cheese - you can't taste them!"    │
└─────────────────────────────────────────────────┘
```

**Level 3: Side Veggie**
```
┌─────────────────────────────────────────────────┐
│  🥦 Mac & Broccoli Dippers                      │
│  "Dip Veggies in Cheese!"                       │
├─────────────────────────────────────────────────┤
│  NEW Addition:                                  │
│  • 🥦 Steamed broccoli ON THE SIDE              │
│  • Dip in cheesy sauce!                         │
├─────────────────────────────────────────────────┤
│  MyPlate Score: ⭐⭐⭐⭐ (4/5 groups)           │
│                                                 │
│  💡 Body Benefit:                               │
│  "Broccoli has Vitamin C to help you not       │
│   get sick! The cheese makes it yummy!"        │
└─────────────────────────────────────────────────┘
```

**Level 4: Almost Rainbow**
```
┌─────────────────────────────────────────────────┐
│  🎨 Orange Mac & Cheese                         │
│  "Hidden Squash in the Sauce!"                  │
├─────────────────────────────────────────────────┤
│  SNEAKY Addition:                               │
│  • 🎃 Butternut squash puree                    │
│  • Same orange color as cheese!                 │
├─────────────────────────────────────────────────┤
│  MyPlate Score: ⭐⭐⭐⭐ (4/5 groups)           │
│                                                 │
│  💡 Body Benefit:                               │
│  "Butternut squash has Vitamin A for           │
│   healthy eyes and skin!"                      │
└─────────────────────────────────────────────────┘
```

**Level 5: Rainbow Plate! (Complete)**
```
┌─────────────────────────────────────────────────┐
│  🌈 Rainbow Mac Plate                           │
│  "All 5 Food Groups - Champion Meal!"           │
├─────────────────────────────────────────────────┤
│  COMPLETE MEAL:                                 │
│  • 🌾 Mac & cheese (Grains)                     │
│  • 🫘 Hidden bean puree (Protein)               │
│  • 🧀 Cheese sauce (Dairy)                      │
│  • 🥦 Veggies on the side (Vegetables)          │
│  • 🍎 Apple slices (Fruits)                     │
├─────────────────────────────────────────────────┤
│  MyPlate Score: ⭐⭐⭐⭐⭐ (5/5 groups)         │
│  🎉 RAINBOW PLATE ACHIEVED!                     │
│                                                 │
│  💡 Body Benefit:                               │
│  "Rainbow eating means your body gets          │
│   EVERYTHING it needs to be strong!"           │
└─────────────────────────────────────────────────┘
```

---

## COOKING MINIGAME

### 3D Cooking Mechanics

#### Ingredient Gathering
```lua
-- Player walks to ingredient shelf
-- Ingredients float up when approached
-- Click/tap to grab ingredient
-- Carry to cooking station

function onIngredientTouch(ingredient, player)
    -- Ingredient floats to player
    ingredient:TweenPosition(player.Position + Vector3.new(0, 3, 0))

    -- Show prompt
    showPrompt("Press E to grab " .. ingredient.Name)
end
```

#### Cooking Station Actions
```
┌─────────────────────────────────────────────────┐
│            COOKING ACTIONS                       │
├─────────────────────────────────────────────────┤
│                                                 │
│   [CHOP]    [STIR]    [BLEND]    [HEAT]        │
│     🔪        🥄        🫙         🔥           │
│                                                 │
│   ┌─────────────────────────────────────┐       │
│   │                                     │       │
│   │     Current Ingredient: 🥦          │       │
│   │         "Broccoli"                  │       │
│   │                                     │       │
│   │     [████████░░] Chopping...        │       │
│   │                                     │       │
│   └─────────────────────────────────────┘       │
│                                                 │
└─────────────────────────────────────────────────┘
```

#### Action Minigames
```lua
local COOKING_ACTIONS = {
    chop = {
        name = "Chop",
        emoji = "🔪",
        mechanic = "tap", -- Tap repeatedly to chop
        targetTaps = 5,
        animation = "ChopAnimation"
    },
    stir = {
        name = "Stir",
        emoji = "🥄",
        mechanic = "circle", -- Drag in circles
        targetCircles = 3,
        animation = "StirAnimation"
    },
    blend = {
        name = "Blend",
        emoji = "🫙",
        mechanic = "hold", -- Hold button for duration
        holdTime = 3,
        animation = "BlendAnimation"
    },
    heat = {
        name = "Heat",
        emoji = "🔥",
        mechanic = "wait", -- Watch temperature gauge
        targetTemp = 100,
        animation = "HeatAnimation"
    }
}
```

---

## SMOOTHIE BUILDER

### Interactive Blender Station
```
┌─────────────────────────────────────────────────┐
│           🥤 SMOOTHIE BUILDER                   │
├─────────────────────────────────────────────────┤
│                                                 │
│   INGREDIENTS         │        BLENDER          │
│   ─────────────       │       ┌───────┐         │
│   🍌 Banana           │      /         \        │
│   🫐 Blueberries      │     │ 🍌 🫐 🥛 │        │
│   🥛 Milk             │     │  💜💜💜  │        │
│   🍓 Strawberries     │     │  💜💜💜  │        │
│   🥬 Spinach          │      \_________/        │
│   🥜 Peanut Butter    │         │   │           │
│   🍫 Cocoa Powder     │      [BLEND!]           │
│                       │                         │
│   MyPlate Zones:      │                         │
│   🍎 Fruits ✓         │                         │
│   🥛 Dairy ✓          │                         │
│   🥦 Veggies ✓        │                         │
│   🍗 Protein ✓        │                         │
│                       │                         │
│   Score: ⭐⭐⭐⭐      │                         │
└─────────────────────────────────────────────────┘
```

### Smoothie Recipes
```lua
local SMOOTHIE_COMBOS = {
    {
        name = "Berry Blast",
        ingredients = {"blueberries", "strawberries", "banana", "milk"},
        myPlateScore = 2, -- Fruits + Dairy
        color = Color3.fromRGB(148, 0, 211) -- Purple
    },
    {
        name = "Green Machine",
        ingredients = {"spinach", "banana", "milk", "peanut_butter"},
        myPlateScore = 4, -- Veggies + Fruits + Dairy + Protein
        color = Color3.fromRGB(50, 205, 50) -- Green
    },
    {
        name = "Chocolate Power",
        ingredients = {"banana", "cocoa", "milk", "peanut_butter"},
        myPlateScore = 3, -- Fruits + Dairy + Protein
        color = Color3.fromRGB(139, 69, 19) -- Brown
    }
}
```

---

## BOOSTERS SYSTEM

### Hidden Ingredient Boosters
```lua
local BOOSTERS = {
    -- High Stealth (Can't taste them!)
    {
        id = "white_beans",
        name = "White Bean Puree",
        emoji = "🫘",
        myPlateZone = "protein",
        stealthRating = 5,
        description = "Blend until smooth - disappears into sauces!",
        bestWith = {"mac_cheese", "quesadilla", "pasta"}
    },
    {
        id = "butternut_squash",
        name = "Butternut Squash",
        emoji = "🎃",
        myPlateZone = "vegetables",
        stealthRating = 5,
        description = "Orange like cheese - perfect disguise!",
        bestWith = {"mac_cheese", "pasta"}
    },
    {
        id = "cauliflower",
        name = "Cauliflower Puree",
        emoji = "🥬",
        myPlateZone = "vegetables",
        stealthRating = 4,
        description = "Neutral flavor, adds creaminess!",
        bestWith = {"mashed_potatoes", "pasta", "rice"}
    },

    -- Medium Stealth
    {
        id = "spinach",
        name = "Baby Spinach",
        emoji = "🥬",
        myPlateZone = "vegetables",
        stealthRating = 3,
        description = "Mild taste, wilts small in smoothies!",
        bestWith = {"smoothie", "pasta"}
    },

    -- Visible but Tasty
    {
        id = "broccoli",
        name = "Steamed Broccoli",
        emoji = "🥦",
        myPlateZone = "vegetables",
        stealthRating = 2,
        description = "Great for dipping in cheese!",
        bestWith = {"mac_cheese", "chicken_nuggets"}
    }
}
```

### Booster Discovery Animation
```lua
function showBoosterDiscovery(booster)
    -- Booster ingredient floats up with sparkles
    local particle = Instance.new("ParticleEmitter")
    particle.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0)) -- Gold
    particle.Size = NumberSequence.new(0.5, 0)
    particle.Lifetime = NumberRange.new(1, 2)
    particle:Emit(30)

    -- Show discovery card
    showFloatingCard({
        title = "🔬 BOOSTER DISCOVERED!",
        name = booster.name,
        emoji = booster.emoji,
        stealth = "🥷 Stealth: " .. string.rep("⭐", booster.stealthRating),
        tip = booster.description
    })
end
```

---

## IRL CHALLENGES

### Real-World Cooking Integration
```
┌─────────────────────────────────────────────────┐
│         📋 IRL CHALLENGE                        │
│     "Make it in Real Life!"                     │
├─────────────────────────────────────────────────┤
│                                                 │
│   Recipe: Rainbow Mac Plate                     │
│                                                 │
│   Instructions:                                 │
│   1. Make mac & cheese at home                  │
│   2. Try adding the boosters!                   │
│   3. Take a photo of your plate                 │
│   4. Rate your MyPlate zones below              │
│                                                 │
│   How many food groups did you include?         │
│                                                 │
│   [1⭐] [2⭐] [3⭐] [4⭐] [5⭐]                 │
│                                                 │
│   📝 Optional: Tell us how it went!             │
│   ┌─────────────────────────────────────┐       │
│   │ Type your cooking story here...     │       │
│   └─────────────────────────────────────┘       │
│                                                 │
│   [COMPLETE CHALLENGE +50 XP]                   │
│                                                 │
└─────────────────────────────────────────────────┘
```

### XP Rewards

| Action | XP |
|--------|-----|
| Complete recipe level | 10 XP |
| Reach Rainbow Plate (5/5) | 25 XP bonus |
| Complete IRL Challenge | 15 XP base |
| IRL + High MyPlate Score | +5 XP per zone |
| IRL + Journal Entry | +50 XP |
| Discover new booster | 10 XP |
| Build smoothie | 10-25 XP (based on zones) |

---

## LUMO CHEF DIALOGUE

### Context-Aware Chef Tips
```lua
local LUMO_CHEF_DIALOGUE = {
    welcome = {
        en = "Welcome to my Food Lab! Let's power up your favorite foods!",
        es = "¡Bienvenido a mi Laboratorio! ¡Vamos a potenciar tus comidas favoritas!"
    },

    levelUp = {
        en = "You leveled up! See how we added nutrition without changing the taste?",
        es = "¡Subiste de nivel! ¿Ves cómo agregamos nutrición sin cambiar el sabor?"
    },

    rainbowPlate = {
        en = "RAINBOW PLATE! Your body is doing a happy dance right now!",
        es = "¡PLATO ARCOÍRIS! ¡Tu cuerpo está bailando de felicidad!"
    },

    boosterTip = {
        en = "Pro tip: Blending veggies until smooth makes them invisible!",
        es = "Consejo: ¡Licuar las verduras las hace invisibles!"
    },

    encouragement = {
        en = "Every food group is a superpower for your body!",
        es = "¡Cada grupo de alimentos es un superpoder para tu cuerpo!"
    }
}
```

---

## UI SCREENS

### Recipe Selection
```
┌─────────────────────────────────────────────────┐
│              🍳 RECIPE LAB                      │
│         Pick a food to power up!                │
├─────────────────────────────────────────────────┤
│                                                 │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐           │
│  │   🍝    │ │   🌯    │ │   🍗    │           │
│  │  Pasta  │ │Tortillas│ │ Poultry │           │
│  │  Lv 3/5 │ │  Lv 1/5 │ │  Lv 2/5 │           │
│  └─────────┘ └─────────┘ └─────────┘           │
│                                                 │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐           │
│  │   🍚    │ │   🍞    │ │   🥔    │           │
│  │  Rice   │ │  Bread  │ │Potatoes │           │
│  │  🔒     │ │  🔒     │ │  🔒     │           │
│  └─────────┘ └─────────┘ └─────────┘           │
│                                                 │
│      ┌────────────────────────┐                 │
│      │  🥤 Smoothie Builder   │                 │
│      └────────────────────────┘                 │
│                                                 │
└─────────────────────────────────────────────────┘
```

### MyPlate Progress
```
┌─────────────────────────────────────────────────┐
│          YOUR MYPLATE PROGRESS                   │
├─────────────────────────────────────────────────┤
│                                                 │
│   Today's Plates Made: 3                        │
│   Rainbow Plates: 1 🌈                          │
│                                                 │
│   Food Group Mastery:                           │
│   🌾 Grains      ████████████████░░ 85%        │
│   🍗 Protein     ██████████████░░░░ 70%        │
│   🥛 Dairy       ████████████░░░░░░ 60%        │
│   🥦 Vegetables  ██████████░░░░░░░░ 50%        │
│   🍎 Fruits      ████████░░░░░░░░░░ 40%        │
│                                                 │
│   Boosters Discovered: 8/12 🔬                  │
│                                                 │
│   IRL Challenges Completed: 5 📋                │
│                                                 │
└─────────────────────────────────────────────────┘
```

---

## FILE STRUCTURE

```
ServerScriptService/
├── FoodLabServer.lua
│   ├── RecipeProgressManager
│   ├── MyPlateCalculator
│   ├── IRLChallengeHandler
│   └── XPRewardHandler

ReplicatedStorage/
├── FoodLabData/
│   ├── Recipes.lua
│   ├── MyPlateZones.lua
│   ├── Boosters.lua
│   ├── SmoothieCombos.lua
│   └── LumoDialogue.lua
├── FoodLabRemotes/
│   ├── StartRecipe
│   ├── CompleteStep
│   ├── DiscoverBooster
│   ├── BuildSmoothie
│   └── SubmitIRLChallenge

Workspace/
├── FoodLabKitchen/
│   ├── KitchenEnvironment
│   ├── IngredientShelf
│   ├── CookingStations
│   │   ├── ChopStation
│   │   ├── StirStation
│   │   ├── BlendStation
│   │   └── HeatStation
│   ├── MyPlateDisplay
│   ├── SmoothieBlender
│   ├── RecipeBook
│   └── LumoChef (NPC)

StarterGui/
├── FoodLabUI/
│   ├── RecipeSelectScreen
│   ├── CookingHUD
│   ├── MyPlateProgress
│   ├── BoosterDiscoveryPopup
│   ├── SmoothieBuilderUI
│   └── IRLChallengeScreen
```

---

## DATA PERSISTENCE

```lua
local PlayerFoodLabData = {
    recipes = {
        mac_cheese = { currentLevel = 3, completed = false },
        quesadilla = { currentLevel = 1, completed = false },
        -- ... other recipes
    },
    boostersDiscovered = {"white_beans", "spinach"},
    smoothiesMade = 5,
    rainbowPlatesEarned = 2,
    irlChallenges = {
        completed = {"mac_cheese_rainbow"},
        active = {"quesadilla_level2"}
    },
    myPlateStats = {
        grains = 45,
        protein = 38,
        dairy = 42,
        vegetables = 25,
        fruits = 30
    },
    totalXP = 350
}
```

---

## IMPLEMENTATION PRIORITY

### Phase 1: Core Kitchen
- Kitchen environment and portal
- Unlock gate tied to Castle Kitchen
- Recipe selection UI
- Basic 5-level progression for 3 recipes

### Phase 2: Cooking Mechanics
- Ingredient gathering
- Cooking station minigames
- MyPlate visualization
- Booster discovery system

### Phase 3: Extended Features
- Smoothie Builder station
- All 11 recipe categories
- IRL Challenge system
- Progress tracking

### Phase 4: Polish
- Lumo Chef NPC dialogue
- Visual effects and animations
- Sound design
- Bilingual support (EN/ES)
