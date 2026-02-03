# Lumo Care Loop - Full Emotion System

## Overview

The Care Loop is a virtual pet mechanic where players care for Lumo by:
1. Recognizing Lumo's emotions (guessing game)
2. Meeting physical needs (hunger, thirst, hygiene)
3. Providing emotional support (Helper Zone)

**Key Mechanic:** 72-hour countdown - Lumo disappears if not cared for!

---

## Physical Needs (3 Stats)

| Need | Range | Decay |
|------|-------|-------|
| Hunger | 0-100% | Decreases over 72 hours |
| Thirst | 0-100% | Decreases over 72 hours |
| Hygiene | 0-100% | Decreases over 72 hours |

- Stats decrease continuously over 72 hours
- If ALL needs hit 0% and stay neglected → Lumo disappears
- No numbers shown to player (visual indicators only)

---

## 10 Emotions (Priority Order)

Emotions are checked **top to bottom** - first match wins.

| Priority | Emotion | Trigger Condition |
|----------|---------|-------------------|
| 1 | THIRSTY | thirst ≤ 10% |
| 2 | HUNGRY | thirst > 10% AND hunger ≤ 10% |
| 3 | MESSY | thirst > 10% AND hunger > 10% AND hygiene ≤ 15% |
| 4 | ANGRY | hunger < 25% AND thirst < 25% |
| 5 | SAD | 25% ≤ hunger ≤ 50% AND thirst > 50% AND hygiene < 40% |
| 6 | ANXIOUS | 25-50% hunger AND 25-50% thirst AND hygiene > 50% |
| 7 | SCARED | hunger > 30% AND thirst > 30% AND 25-50% hygiene |
| 8 | TIRED | Any need between 25-35% AND no tough emotions apply |
| 9 | PLAYFUL | 50-75% hunger AND 50-75% thirst AND 50-75% hygiene |
| 10 | HAPPY | hunger > 75% AND thirst > 75% AND hygiene > 75% |

### Emotion Categories

```
CORE NEEDS (Physical)     TOUGH EMOTIONS          POSITIVE EMOTIONS
├── THIRSTY               ├── ANGRY               ├── PLAYFUL
├── HUNGRY                ├── SAD                 └── HAPPY
└── MESSY                 ├── ANXIOUS
                          ├── SCARED
                          └── TIRED
```

---

## Care Loop Flow

```
┌─────────────────────────────────────────────────────────────┐
│                    STEP 1: READ NEEDS                       │
│         Retrieve hunger, thirst, hygiene (0-100%)           │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                  STEP 2: DETERMINE EMOTION                  │
│         Run through priority list → Return ONE emotion      │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│              STEP 3: EMOTION GUESSING GAME                  │
│                                                             │
│  • Show STATIC emotion image (not GIF)                      │
│  • Emotion name is HIDDEN                                   │
│  • Player guesses the emotion                               │
│                                                             │
│  FIRST GUESS:                                               │
│  ✓ Correct → Success effect → Recovery Den                  │
│  ✗ Wrong → Show hint → Allow 2nd guess                      │
│                                                             │
│  SECOND GUESS:                                              │
│  ✓ Correct → Success effect → Recovery Den                  │
│  ✗ Wrong → Reveal answer → Recovery Den                     │
│                                                             │
│  REWARDS: 5 coins + 10 XP per correct guess                 │
│  LIMIT: Max 4 correct guesses per day                       │
│  NOTE: Can't keep guessing "happy" if all needs met         │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                   STEP 4: RECOVERY DEN                      │
│                                                             │
│  "Lumo needs a little support right now.                    │
│   Let's help his body or emotions feel steadier."           │
│                                                             │
│  Two options:                                               │
│  ┌─────────────────┐  ┌─────────────────┐                   │
│  │ Help Lumo's     │  │ Choose a        │                   │
│  │ Body            │  │ Helper          │                   │
│  │ (physical)      │  │ (emotional)     │                   │
│  └─────────────────┘  └─────────────────┘                   │
│                                                             │
│  Show 2-3 care items related to the emotion                 │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                  STEP 5: ITEM INTERACTION                   │
│                                                             │
│  1. Player selects item                                     │
│  2. Show child-friendly explanation                         │
│  3. Player dismisses explanation                            │
│  4. Play Lumo GIF using the item                            │
│  5. Show feedback: "Nice choice. That helped Lumo           │
│     feel more balanced and ready."                          │
│                                                             │
│  RESULT:                                                    │
│  • Emotional need = met                                     │
│  • Physical needs reset to 50% baseline                     │
└─────────────────────────────────────────────────────────────┘
                            │
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                 STEP 6: RETURN TO GAME                      │
│                                                             │
│  CTA: "Back to HealthQuest"                                 │
│  New emotion calculates next time loop runs                 │
└─────────────────────────────────────────────────────────────┘
```

---

## Emotion Details

### 🥤 1. THIRSTY (Highest Priority)
| Property | Value |
|----------|-------|
| Trigger | thirst ≤ 10% |
| Static Icon | Water cup |
| GIF Action | Drinking / gulping |
| Explanation | "A drink helps Lumo's body cool down and feel steady." |
| Hints | "Lumo keeps looking at cups and licking his lips." / "His mouth looks dry, and he wants a big sip." |

### 🍎 2. HUNGRY
| Property | Value |
|----------|-------|
| Trigger | thirst > 10% AND hunger ≤ 10% |
| Static Icon | Fruit / snack |
| GIF Action | Eating / nibbling |
| Explanation | "Lumo needs fuel so he can feel strong again." |
| Hints | "Lumo's tummy is rumbling and he keeps thinking about snacks." / "He looks low on energy and keeps pointing to food." |

### 🫧 3. MESSY
| Property | Value |
|----------|-------|
| Trigger | thirst > 10% AND hunger > 10% AND hygiene ≤ 15% |
| Static Icon | Bubbles / brush / toothbrush |
| GIF Action | Bubble bath / scrub |
| Explanation | "Cleaning up helps Lumo feel fresh and ready again." |
| Hints | "Lumo has stuff stuck on him and doesn't feel comfy." / "His scales look dirty, and he wants to clean up." |

### 🔥 4. ANGRY
| Property | Value |
|----------|-------|
| Trigger | hunger < 25% AND thirst < 25% |
| Static Icon | Flame |
| GIF Action | Fly + fire-breath |
| Explanation | "Lumo lets out big hot feelings safely." |
| Hints | "Lumo's face looks tight, and his body feels hot." / "He's stomping and blowing out big breaths." |

### 😢 5. SAD
| Property | Value |
|----------|-------|
| Trigger | 25% ≤ hunger ≤ 50% AND thirst > 50% AND hygiene < 40% |
| Static Icon | Teddy bear |
| GIF Action | Hugging a stuffy |
| Explanation | "It's okay to cry. Hugging a teddy helps Lumo feel comforted and let big feelings out." |
| Hints | "Lumo's eyes look watery, and his head is down." / "He's very quiet and doesn't feel like playing." |

### 😟 6. ANXIOUS
| Property | Value |
|----------|-------|
| Trigger | 25-50% hunger AND 25-50% thirst AND hygiene > 50% |
| Static Icon | Yoga mat |
| GIF Action | Yoga / calming pose |
| Explanation | "A calming stretch helps Lumo slow down inside." |
| Hints | "Lumo is wiggly and can't sit still." / "His heart feels fast, and he keeps looking around." |

### 😨 7. SCARED
| Property | Value |
|----------|-------|
| Trigger | hunger > 30% AND thirst > 30% AND 25-50% hygiene |
| Static Icon | Tablet (LumoLink) |
| GIF Action | Tapping tablet, connecting with dragon friend |
| Explanation | "Talking to a friend helps Lumo feel safe and remember he isn't alone." |
| Hints | "Lumo is frozen and looking for a safe spot." / "His eyes are wide, and his body wants to hide." |

### 😴 8. TIRED
| Property | Value |
|----------|-------|
| Trigger | Any need 25-35% AND no tough emotions apply |
| Static Icon | Pillow / blanket |
| GIF Action | Yawn + slow blink |
| Explanation | "Lumo needs rest so his body can recharge." |
| Hints | "Lumo's eyes are droopy, and he's moving slowly." / "He keeps yawning and wants to rest." |

### 🟡 9. PLAYFUL
| Property | Value |
|----------|-------|
| Trigger | 50-75% hunger AND 50-75% thirst AND 50-75% hygiene |
| Static Icon | Glowing ball / tennis ball |
| GIF Action | Play fetch |
| Explanation | "Lumo has extra wiggles and wants to play!" |
| Hints | "Lumo can't stop moving and wants to chase something." / "His body feels bouncy and full of fun." |

### 💙 10. HAPPY (Lowest Priority)
| Property | Value |
|----------|-------|
| Trigger | hunger > 75% AND thirst > 75% AND hygiene > 75% |
| Static Icon | Music notes |
| GIF Action | Dance Party |
| Explanation | "Lumo feels great and wants to celebrate with you!" |
| Hints | "Lumo is smiling and wants to give a high-five." / "His body feels light, calm, and just right." |

---

## Helper Zone (Emotional Support)

**Opening Copy:**
> "One helper is glowing. That one may support Lumo's emotions right now. You can choose it—or explore others."

- Recommended helper has soft glow (no checkmarks, no right/wrong)
- NO purchase/buy language
- CTA: "Use This Helper" / "Try This Helper"

### Helpers by Emotion

| Emotion | Helper Item | Action |
|---------|-------------|--------|
| ANGRY | Fire breath area | Let out feelings safely |
| SAD | Teddy bear / stuffy | Comfort hug |
| ANXIOUS | Yoga mat | Calming stretch |
| SCARED | LumoLink tablet | Call a friend (Luna) |
| TIRED | Blanket / pillow | Rest |

---

## Rewards Summary

| Action | Coins | XP | Limit |
|--------|-------|-----|-------|
| Correct emotion guess | 5 | 10 | 4 per day |
| Care item used | 0 | 0 | Unlimited |

---

## 72-Hour Countdown

```
FULL NEEDS (100%)
    │
    │  Time passes...
    ▼
DECLINING NEEDS
    │
    │  72 hours no care...
    ▼
LUMO DISAPPEARS 😢

Player must return and care for Lumo to prevent this!
```

---

## Data Structure (for implementation)

```lua
-- Lumo State
LumoState = {
    hunger = 100,      -- 0-100%
    thirst = 100,      -- 0-100%
    hygiene = 100,     -- 0-100%
    lastCareTime = os.time(),
    currentEmotion = "HAPPY",
    dailyCorrectGuesses = 0,
    lastGuessDate = "2025-01-01"
}

-- Emotion Definition
Emotion = {
    id = "THIRSTY",
    priority = 1,
    staticIcon = "rbxassetid://water_cup",
    gifAction = "rbxassetid://drinking_gif",
    explanation = "A drink helps Lumo's body cool down and feel steady.",
    hints = {
        "Lumo keeps looking at cups and licking his lips.",
        "His mouth looks dry, and he wants a big sip."
    },
    checkCondition = function(state)
        return state.thirst <= 10
    end
}

-- Care Item
CareItem = {
    id = "water_bottle",
    emotion = "THIRSTY",
    name = "Water Bottle",
    icon = "rbxassetid://water_bottle",
    gifAction = "rbxassetid://drinking",
    explanation = "A drink helps Lumo's body cool down and feel steady.",
    effect = {
        thirst = 50  -- Boost thirst by 50%
    }
}
```

---

## UI Copy Reference

| Screen | Copy |
|--------|------|
| Recovery Den Entry | "Lumo needs a little support right now. Let's help his body or emotions feel steadier." |
| Helper Zone Entry | "One helper is glowing. That one may support Lumo's emotions right now. You can choose it—or explore others." |
| After Care | "Nice choice. That helped Lumo feel more balanced and ready." |
| Wrong Guess (1st) | "Try looking at Lumo's face." / "Does Lumo look calm or wiggly?" / "Check his body—does he seem ready to move or rest?" |
| Wrong Guess (2nd) | "Lumo was feeling _____. Let's help him feel better." |
| Exit CTA | "Back to HealthQuest" |
