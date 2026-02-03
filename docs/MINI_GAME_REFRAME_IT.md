# Reframe It: Sunshine Mind - Mini-Game Spec

## Overview

| Property | Value |
|----------|-------|
| Game Name | Reframe It: Sunshine Mind |
| Platform | Roblox |
| Genre | Cognitive Reframing / Mindfulness |
| Target Age | 6-12 years |
| Educational Focus | Positive Self-Talk, Growth Mindset, Emotional Regulation |
| Images Required | **NONE** - Uses 3D clouds, particles, and text |

A mindfulness game where players transform negative thought clouds into positive sunshine thoughts.

---

## Core Concept

Dark "worry clouds" float toward the player containing negative self-talk. The player taps/clicks the cloud to "reframe" it - the cloud bursts open with rays of sunshine and reveals a positive reframed thought.

### The Transformation

```
  ☁️ "I can't do this"          →    ☀️ "I can try my best!"
  ☁️ "Nobody likes me"          →    ☀️ "I am worthy of friendship!"
  ☁️ "I always mess up"         →    ☀️ "Mistakes help me learn!"
```

---

## Game Flow

```
┌─────────────────────────────────────────────────────────────┐
│  START SCREEN                                                │
│  • "Your thoughts have power!"                               │
│  • "Let's turn worry clouds into sunshine!"                 │
│  • [ Start ] button                                          │
│  • Difficulty: Easy (5 clouds) / Medium (8) / Challenge (12)│
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  GAMEPLAY                                                    │
│  • Dark clouds float from edges toward center               │
│  • Each cloud has negative thought text                     │
│  • Player taps cloud before it reaches "worry zone"         │
│  • Cloud BURSTS → Sunshine rays → Positive thought appears │
│  • If cloud reaches worry zone = "thought stuck" (no XP)   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  REFRAME MOMENT (When Cloud is Tapped)                       │
│  1. Cloud stops moving                                       │
│  2. Cloud shakes/wobbles                                     │
│  3. BURST! Golden rays shoot outward                        │
│  4. Cloud transforms to bright yellow/white                 │
│  5. Positive thought text fades in                          │
│  6. Lumo says encouraging message                           │
│  7. +XP awarded                                              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│  END SCREEN                                                  │
│  • "You reframed X thoughts!"                               │
│  • Shows all positive thoughts collected                    │
│  • "Remember: You can change how you think!"               │
│  • XP + Coins earned                                        │
│  • [ Play Again ] [ Save Favorites ] [ Exit ]              │
└─────────────────────────────────────────────────────────────┘
```

---

## Visual Design (No Images Needed!)

### Scene Layout

```
TOP VIEW:

         [Worry Clouds spawn from edges]
                    ☁️
                     ↓
        ☁️ →                    ← ☁️

              ┌───────────┐
              │  PLAYER   │
              │   ZONE    │
              │    😊     │
              └───────────┘

        ☁️ →                    ← ☁️
                     ↑
                    ☁️
         [Clouds drift toward center]
```

### 3D Elements (Built in Roblox Studio)

| Element | Roblox Part Type | Visual |
|---------|------------------|--------|
| Worry Cloud | MeshPart (cloud mesh) | Dark gray, swirling particles |
| Sunshine Cloud | Same mesh | Bright yellow/white, ray particles |
| Sunshine Rays | Beam or Particle Emitter | Golden streaks outward |
| Text | BillboardGui + TextLabel | Floats above cloud |
| Background | Sky gradient | Starts cloudy, clears with progress |
| Player Zone | Transparent cylinder | Safe area indicator |

### Cloud States

```lua
CloudStates = {
    WORRY = {
        color = Color3.fromRGB(80, 80, 100),      -- Dark gray-blue
        particleColor = Color3.fromRGB(50, 50, 70),
        transparency = 0.3,
        textColor = Color3.fromRGB(40, 40, 60),
        size = Vector3.new(8, 5, 8)
    },

    TRANSFORMING = {
        shakeIntensity = 0.5,
        shakeDuration = 0.5,
        glowColor = Color3.fromRGB(255, 220, 100),
        glowIntensity = {0, 1}
    },

    SUNSHINE = {
        color = Color3.fromRGB(255, 245, 200),    -- Warm white-yellow
        particleColor = Color3.fromRGB(255, 200, 50),
        transparency = 0.5,
        textColor = Color3.fromRGB(255, 150, 0),
        size = Vector3.new(10, 6, 10),
        rays = true
    }
}
```

---

## Thought Database

### Negative → Positive Thought Pairs

#### Self-Doubt

| Negative | Positive | Tip |
|----------|----------|-----|
| "I can't do this." | "I can try my best!" | Trying is the first step to success. |
| "I'm not smart enough." | "My brain grows when I learn new things!" | Every expert was once a beginner. |
| "I'll never get it right." | "Practice makes progress!" | Each try teaches you something new. |
| "I'm bad at everything." | "I have my own special strengths!" | Everyone is good at different things. |

#### Mistakes & Failure

| Negative | Positive | Tip |
|----------|----------|-----|
| "I always mess up." | "Mistakes help me learn!" | Mistakes are proof you're trying. |
| "I failed. I'm a failure." | "Failing means I tried something hard!" | Failure is just a step toward success. |
| "I made a mistake. Everyone will laugh." | "Everyone makes mistakes. It's okay!" | Laughing at mistakes can make them smaller. |
| "I ruined everything." | "I can fix this or try again!" | Most things can be made better. |

#### Social Worries

| Negative | Positive | Tip |
|----------|----------|-----|
| "Nobody likes me." | "I am worthy of friendship!" | Being yourself attracts true friends. |
| "They're all looking at me." | "People are usually thinking about themselves!" | Most people aren't judging you. |
| "I don't fit in." | "Being different makes me special!" | The best people are wonderfully unique. |
| "What if they don't want to play with me?" | "I can ask! The worst they can say is 'not now.'" | Asking takes courage, and that's brave! |

#### Anxiety & Worry

| Negative | Positive | Tip |
|----------|----------|-----|
| "Something bad is going to happen." | "I can handle whatever comes!" | You're stronger than you think. |
| "What if I get it wrong?" | "Getting it wrong helps me learn!" | Wrong answers guide you to right ones. |
| "I'm so worried about tomorrow." | "I'll take it one step at a time!" | Focus on right now, not far away. |
| "Everything feels too hard." | "I can do hard things!" | Break big things into tiny steps. |

#### Perfectionism

| Negative | Positive | Tip |
|----------|----------|-----|
| "It has to be perfect." | "Done is better than perfect!" | Progress matters more than perfection. |
| "I can't start until I know I'll do it right." | "Starting is the bravest part!" | You learn by doing, not waiting. |
| "It's not good enough." | "Good enough IS enough!" | Your best effort is always valuable. |

#### Giving Up

| Negative | Positive | Tip |
|----------|----------|-----|
| "I give up." | "I'll take a break and try again!" | Breaks help your brain reset. |
| "This is impossible." | "It's just hard right now. I can learn!" | Impossible just means 'not yet possible.' |
| "Why even try?" | "Trying is how amazing things happen!" | Every big success started with trying. |

#### Body & Appearance

| Negative | Positive | Tip |
|----------|----------|-----|
| "I don't like how I look." | "My body is amazing and does cool things!" | Your body lets you run, play, and hug. |
| "I wish I was different." | "I am exactly who I'm meant to be!" | There's only one you - that's your superpower. |

#### Comparison

| Negative | Positive | Tip |
|----------|----------|-----|
| "Everyone is better than me." | "I'm on my own journey!" | Comparing steals your joy. |
| "They make it look so easy." | "I don't see their practice and struggle!" | Everyone struggles - they just hide it. |

---

## Gameplay Mechanics

### Difficulty Settings

| Setting | Easy | Medium | Challenge |
|---------|------|--------|-----------|
| Total Clouds | 5 | 8 | 12 |
| Spawn Interval | 4 sec | 3 sec | 2.5 sec |
| Cloud Speed | 3 studs/sec | 4 studs/sec | 5 studs/sec |
| Time Limit | 45 sec | 60 sec | 75 sec |

### Scoring System

| Action | Points |
|--------|--------|
| Base reframe | 100 |
| Speed bonus (< 2 sec) | 1.5x multiplier |
| Speed bonus (< 4 sec) | 1.25x multiplier |
| 3 streak | +50 |
| 5 streak | +100 |
| 8 streak | +200 |
| 10 streak | +300 |
| All clouds reframed | +500 |
| No misses | +250 |
| Speed run (>30% time left) | +300 |

### XP Conversion

- 100 points = 10 XP
- 100 points = 5 coins

---

## Visual Effects

### Background Sky Transition

The sky changes as more clouds are reframed:

| Progress | Sky Color | Description |
|----------|-----------|-------------|
| 0% | Dark gray-blue | Cloudy, overcast |
| 25% | Light gray-blue | Breaking through |
| 50% | Pale blue | Partly sunny |
| 75% | Light blue | Mostly clear |
| 100% | Bright blue | Beautiful day! |

### Sunshine Burst Effect

```lua
SunshineRayEmitter = {
    Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 200)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 0))
    }),
    Lifetime = NumberRange.new(0.5, 1),
    Speed = NumberRange.new(20, 40),
    SpreadAngle = Vector2.new(360, 360),
    burstCount = 30
}
```

---

## UI Design

### HUD During Gameplay

```
┌─────────────────────────────────────────────────────────────┐
│  ☁️ 3/8              🔥 x5 Streak!              ⏱️ 0:45     │
│  Clouds Left         Streak                     Time Left   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│                    [3D GAMEPLAY AREA]                        │
│                                                              │
├─────────────────────────────────────────────────────────────┤
│  ⭐ 450 points                        [ Pause ]             │
└─────────────────────────────────────────────────────────────┘
```

### End Screen

```
┌─────────────────────────────────────────────────────────────┐
│                    ☀️ GREAT JOB! ☀️                         │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│     You reframed 7 out of 8 thoughts!                       │
│                                                              │
│     ┌──────────────────────────────────────────────────┐    │
│     │  YOUR SUNSHINE THOUGHTS:                          │    │
│     │                                                    │    │
│     │  ☀️ "I can try my best!"                          │    │
│     │  ☀️ "Mistakes help me learn!"                     │    │
│     │  ☀️ "I am worthy of friendship!"                  │    │
│     │  ☀️ "My brain grows when I learn new things!"     │    │
│     │  ☀️ "I can handle whatever comes!"                │    │
│     │  ☀️ "Practice makes progress!"                    │    │
│     │  ☀️ "I can do hard things!"                       │    │
│     └──────────────────────────────────────────────────┘    │
│                                                              │
│     FINAL SCORE: 1,250 points                               │
│     XP EARNED: +125 XP                                       │
│     COINS EARNED: +62 coins                                  │
│                                                              │
│     💭 "Remember: You have the power to                    │
│         change your thoughts!"                              │
│                                                              │
│     [ ⭐ Save Favorites ]  [ 🔄 Play Again ]  [ 🚪 Exit ]  │
│                                                              │
└─────────────────────────────────────────────────────────────┘
```

---

## Special Features

### Save Favorite Thoughts

Players can save positive thoughts they like to a "Sunshine Journal" for later reference.

```lua
SunshineJournal = {
    savedThoughts = {
        "I can try my best!",
        "Mistakes help me learn!",
        "I can do hard things!"
    },

    accessibleFrom = {"MainMenu", "SettingsMenu", "GardenArea"},

    dailyReminder = {
        enabled = true,
        time = "morning",
        notification = "☀️ Your sunshine thought for today!"
    }
}
```

### Category Focus Mode

Players can choose to focus on specific worry types:

| Mode | Focus |
|------|-------|
| All Thoughts | Random Mix |
| Building Confidence | Self-Doubt |
| Learning from Mistakes | Mistakes |
| Friendship & Belonging | Social |
| Calming Worries | Anxiety |
| Good Enough is Great | Perfectionism |
| Keep Going! | Giving Up |

---

## Educational Research Basis

This game is based on **Cognitive Behavioral Therapy (CBT)** principles adapted for children:

1. **Cognitive Restructuring** - Identifying and challenging negative thoughts
2. **Positive Self-Talk** - Replacing negative with constructive thoughts
3. **Growth Mindset** - Believing abilities can develop through effort
4. **Externalization** - Visualizing thoughts as separate objects (clouds)
5. **Agency** - Player actively transforms thoughts (empowerment)

---

## Integration with HealthQuest

```lua
Integrations = {
    barrierAssessment = {
        enabled = true,
        triggerCategories = {"anxiety", "self_esteem", "social"},
        personalizeThoughts = true
    },

    questProgress = {
        questCategory = "emotional_wellness",
        activityType = "mindfulness"
    },

    journal = {
        logActivity = true,
        saveFavorites = true
    },

    meadowHub = {
        location = "MindGymPortal",
        npcIntro = "Lumo"
    }
}
```

---

## File Structure (Roblox)

```
ReframeIt_SunshineMind/
├── ServerScriptService/
│   ├── ReframeItServer.lua         # Server game logic
│   ├── ThoughtDatabase.lua         # All thought pairs
│   └── ProgressTracker.lua         # XP, achievements
│
├── ReplicatedStorage/
│   ├── ReframeItConfig.lua         # Shared settings
│   ├── CloudEffects.lua            # Visual effect functions
│   └── RemoteEvents/
│       ├── TapCloud
│       ├── GameStart
│       ├── GameEnd
│       └── SaveFavorite
│
├── StarterGui/
│   ├── ReframeItHUD/               # In-game HUD
│   ├── StartScreen/                # Difficulty selection
│   ├── ReframePopup/               # Thought reveal popup
│   └── EndScreen/                  # Results + favorites
│
├── StarterPlayerScripts/
│   └── ReframeItClient.lua         # Input handling
│
└── Workspace/
    └── ReframeItArena/
        ├── SkyBox/                 # Dynamic sky
        ├── PlayerZone/             # Center area
        ├── CloudSpawners/          # Edge spawn points
        └── Lighting/               # Dynamic lighting
```

---

## Technical Notes

**This game uses ZERO images** - just:
- Roblox parts (spheres for clouds)
- Particle emitters (for sunshine rays)
- Text labels (for thoughts)
- Dynamic lighting (sky changes)
