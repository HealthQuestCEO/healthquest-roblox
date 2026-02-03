# Promo Code Web Integration Spec

## Overview
When players earn promo codes in Lumo's Land, parents can redeem them on DiscoverHealthQuest.com for special rewards that appear back in the Roblox game.

---

## Flow

```
ROBLOX (Lumo's Land)                    WEB (DiscoverHealthQuest.com)
─────────────────────                    ────────────────────────────
Player reaches milestone
        ↓
Earns code: QUEST-A1B2C3
        ↓
Shows code to parent ──────────────────→ Parent enters code
                                                ↓
                                         Backend validates code
                                                ↓
                                         Marks code as REDEEMED
                                                ↓
                                         Links reward to player account
        ↓
Next time player logs into Roblox ←──── Roblox checks for pending rewards
        ↓
"You have a special gift!" 🎁
        ↓
Special sticker added to Nook inventory
```

---

## Web Backend Requirements

### 1. Database Tables

```sql
-- Promo codes earned in Roblox
CREATE TABLE promo_codes (
    id SERIAL PRIMARY KEY,
    code VARCHAR(20) UNIQUE NOT NULL,      -- "QUEST-A1B2C3"
    code_type VARCHAR(50) NOT NULL,        -- "QUEST", "CARE", "STAR", "WEEK"
    roblox_user_id BIGINT NOT NULL,        -- Roblox player who earned it
    milestone VARCHAR(50) NOT NULL,        -- "FIRST_QUEST_COMPLETE"
    created_at TIMESTAMP DEFAULT NOW(),
    redeemed_at TIMESTAMP NULL,
    redeemed_by VARCHAR(100) NULL,         -- Parent email/account
    reward_granted BOOLEAN DEFAULT FALSE,
    reward_type VARCHAR(50) NULL           -- "SPECIAL_STICKER"
);

-- Pending rewards to sync back to Roblox
CREATE TABLE pending_rewards (
    id SERIAL PRIMARY KEY,
    roblox_user_id BIGINT NOT NULL,
    reward_type VARCHAR(50) NOT NULL,
    reward_id VARCHAR(50) NOT NULL,        -- "STCK-PROMO-001"
    granted_at TIMESTAMP DEFAULT NOW(),
    synced_to_roblox BOOLEAN DEFAULT FALSE,
    synced_at TIMESTAMP NULL
);
```

### 2. API Endpoints

```
POST /api/promo/redeem
─────────────────────
Request:
{
    "code": "QUEST-A1B2C3",
    "parent_email": "parent@example.com"
}

Response (success):
{
    "success": true,
    "message": "Code redeemed! Your child will receive a special Gold Star Sticker next time they play!",
    "reward": {
        "type": "SPECIAL_STICKER",
        "name": "Gold Star Sticker",
        "description": "A special sticker for Quest Champions!"
    }
}

Response (already used):
{
    "success": false,
    "error": "This code has already been redeemed."
}

Response (invalid):
{
    "success": false,
    "error": "Invalid code. Please check and try again."
}
```

```
GET /api/promo/pending-rewards/{roblox_user_id}
───────────────────────────────────────────────
(Called by Roblox game server)

Response:
{
    "rewards": [
        {
            "id": 123,
            "reward_type": "SPECIAL_STICKER",
            "reward_id": "STCK-PROMO-001"
        }
    ]
}
```

```
POST /api/promo/confirm-reward
──────────────────────────────
(Called by Roblox after granting reward)

Request:
{
    "reward_id": 123,
    "roblox_user_id": 12345678
}
```

---

## Rewards (Special Stickers)

Add to Nook Shop under **"Special"** category - NOT purchasable, only from promo codes:

| Milestone | Sticker | ID | Description |
|-----------|---------|-----|-------------|
| Quest Champion | Gold Star | STCK-PROMO-001 | ⭐ "Quest Champion - Completed first quest!" |
| Devoted Caretaker | Heart Badge | STCK-PROMO-002 | 💖 "Devoted Caretaker - Lumo's best friend!" |
| Rising Star | Rocket | STCK-PROMO-003 | 🚀 "Rising Star - Reached Level 10!" |
| Perfect Caretaker | Rainbow | STCK-PROMO-004 | 🌈 "Perfect Week - 7 days of love!" |

### Sticker Properties
- **Category:** "promo" (special, not purchasable)
- **Tradeable:** No
- **Display:** Sticker Journal + Castle walls
- **Rarity:** Legendary (gold border)

---

## Roblox Integration

### Check for pending rewards on player join:

```lua
-- In player join handler
local function checkPendingRewards(player)
    local userId = player.UserId

    -- Call web API (via proxy/MessagingService)
    local rewards = WebAPI.getPendingRewards(userId)

    if rewards and #rewards > 0 then
        for _, reward in ipairs(rewards) do
            -- Grant the special sticker
            InventoryService.addItem(player, reward.reward_id)

            -- Show celebration UI
            RewardUI.showSpecialReward(player, {
                title = "Special Gift from HealthQuest!",
                message = "Your parent redeemed your promo code!",
                item = reward
            })

            -- Confirm receipt to web
            WebAPI.confirmReward(reward.id, userId)
        end
    end
end
```

---

## Shop Data Addition

Add to `data/shop/shop-items.json`:

```json
{
    "id": "STCK-PROMO-001",
    "name": "Quest Champion Star",
    "emoji": "⭐",
    "description": "Awarded for completing your first quest! (Promo reward)",
    "category": "promo",
    "room": "BDRM",
    "coinPrice": 0,
    "purchasable": false,
    "promoOnly": true,
    "rarity": "legendary",
    "milestone": "FIRST_QUEST_COMPLETE"
},
{
    "id": "STCK-PROMO-002",
    "name": "Devoted Caretaker Heart",
    "emoji": "💖",
    "description": "Awarded for evolving Lumo to Adult! (Promo reward)",
    "category": "promo",
    "room": "BDRM",
    "coinPrice": 0,
    "purchasable": false,
    "promoOnly": true,
    "rarity": "legendary",
    "milestone": "LUMO_ADULT"
},
{
    "id": "STCK-PROMO-003",
    "name": "Rising Star Rocket",
    "emoji": "🚀",
    "description": "Awarded for reaching Level 10! (Promo reward)",
    "category": "promo",
    "room": "BDRM",
    "coinPrice": 0,
    "purchasable": false,
    "promoOnly": true,
    "rarity": "legendary",
    "milestone": "LEVEL_10"
},
{
    "id": "STCK-PROMO-004",
    "name": "Perfect Week Rainbow",
    "emoji": "🌈",
    "description": "Awarded for caring for Lumo 7 days straight! (Promo reward)",
    "category": "promo",
    "room": "BDRM",
    "coinPrice": 0,
    "purchasable": false,
    "promoOnly": true,
    "rarity": "legendary",
    "milestone": "PERFECT_WEEK"
}
```

---

## Parent Experience on Web

### Redemption Page UI

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│         🎁 Redeem Your Child's Code 🎁              │
│                                                     │
│  Your child earned a special achievement in        │
│  Lumo's Land! Enter their code below:              │
│                                                     │
│  ┌─────────────────────────────────────┐           │
│  │  QUEST-A1B2C3                       │           │
│  └─────────────────────────────────────┘           │
│                                                     │
│  Your email (optional):                            │
│  ┌─────────────────────────────────────┐           │
│  │  parent@example.com                 │           │
│  └─────────────────────────────────────┘           │
│                                                     │
│            [ Redeem Code ]                         │
│                                                     │
└─────────────────────────────────────────────────────┘
```

### Success Message

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│         🎉 Code Redeemed Successfully! 🎉           │
│                                                     │
│  Your child will receive:                          │
│                                                     │
│         ⭐ Quest Champion Star ⭐                   │
│         A legendary sticker for their              │
│         Sticker Journal!                           │
│                                                     │
│  The reward will appear next time they             │
│  log into Lumo's Land.                             │
│                                                     │
│  Want to learn more about your child's             │
│  wellness journey? [View Progress Report]          │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## Summary

| Component | What to Build |
|-----------|---------------|
| **Web Backend** | Promo code validation API, pending rewards table |
| **Web Frontend** | Redemption page at /redeem |
| **Roblox** | Check pending rewards on join, grant special stickers |
| **Shop Data** | 4 promo-only legendary stickers |
| **Nook Shop UI** | "Special" section showing promo items (locked until earned) |
