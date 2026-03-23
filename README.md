# 🎣 as_fishing (Assured Studios Advanced Fishing)

**as_fishing** is an advanced fishing script for FiveM (ESX). It introduces a tiered progression system where the quality of your fishing rod directly impacts your catch rate and the rarity of the fish you pull from the depths.

---

## ✨ Features

- **Tiered Fishing Rods:**

  - _Starter Rod:_ Slow catch rate, low-quality loot.
  - _Intermediate Rod:_ Decent speed and improved loot tables.
  - _Pro Rod:_ Fast catch rate and high-tier rewards.

- **4 Unique Fishing Methods:**

  1. **Fishing Zones:** Guaranteed fast catches but lower-tier loot.
  2. **Shore Fishing:** Balanced speed and decent loot.
  3. **Boat Fishing:** Same as shore fishing, but allows access to deeper waters.
  4. **Deep Sea Fishing:** The ultimate challenge. Fast, high-tier loot, but dangerous! Watch out for sharks and the risk of being pulled overboard by massive fish.

- **Loot Categories:** Loot is divided into `Normal`, `Medium`, and `Rare` tiers based on item value.

- **Fully Configurable:** Everything from coordinates and items to rarity and language can be adjusted in the `config.lua`.

---

## ⚙️ Configuration

| Variable                 | Description                                                  |
| :----------------------- | :----------------------------------------------------------- |
| `Config.Debug`           | Set to `true` to enable console logs for troubleshooting.    |
| `Config.CatchWebhook`    | Discord webhook for logging catches (Anti-cheat/Monitoring). |
| `Config.BuySellWebhook`  | Discord webhook for logging shop transactions.               |
| `Config.FishingZoneTime` | Catch time (ms) when inside a designated Fishing Zone.       |
| `Config.NormalTime`      | Catch time (ms) for shore or standard boat fishing.          |
| `Config.DeepWaterTime`   | Catch time (ms) when fishing in deep sea areas.              |
| `Config.Depth`           | The required depth to trigger the "Deep Sea" mechanics.      |
| `Config.BigFish`         | Percentage chance of being pulled overboard by a large fish. |
| `Config.SkillCheck`      | Difficulty setting for the skill-check mini-game.            |

---

## 🛠 Customization Guide

### 📍 Adding a New Shop

Define where players can buy equipment.

```lua
['SHOP_PALETO'] = {
    PedModel = `s_m_m_linecook`,
    PedCoords = vector4(-1600.6, 5195.69, 4.37, 294.37),
    TargetLabel = 'Open Fish Shop',
    TargetIcon = 'fa-solid fa-fish',
    MenuLabel = 'Fishing Supplies',
    Blip = { ShowBlip = true, Sprite = 356, Color = 3, Scale = 0.8, ShortRange = true, Name = 'Fish Shop' },
}
```

# 💰 Adding a Sell Point

Define where players can sell their catch.

```
['SELL_PALETO'] = {
    PedModel = `s_m_m_linecook`,
    PedCoords = vector4(-1601.5081, 5197.6328, 4.3632, 304.9454),
    TargetLabel = 'Sell Fish',
    TargetIcon = 'fa-solid fa-dollar-sign',
    MenuLabel = 'Fish Market',
    Blip = { ShowBlip = true, Sprite = 356, Color = 2, Scale = 0.8, ShortRange = true, Name = 'Fish Market' },
}
```

# 🌊 Adding a Fishing Zone

Use ox_lib zones to define specific areas.

```
['FISHINGZONE_1_PALETOBAY'] = {
    coords = vec3(-1593.0, 5227.0, 4.0),
    size = vec3(10.0, 73.0, 10.0),
    rotation = 25.0,
    Blip = {
        Enabled = true,
        Sprite = 68,
        Color = 3,
        Scale = 0.8,
        Name = "Fishing Zone"
    },
}
```

# 📦 Dependencies

[ox_lib](https://github.com/overextended/ox_lib)

[ox_target](https://github.com/overextended/ox_target)

[ox_inventory](https://github.com/overextended/ox_inventory)

[es_extended](https://github.com/esx-framework/esx_core)

# ⚠️ Support & Credits

Support: This script is Open Source. No official support is provided.

Credits: Developed by Pelifix (Assured Studios) for SuperviserRP.

Usage: If you use or modify this script, please give proper credit.

# 🔗 Links

📺 [Video Preview](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3DDEuilMjDv48)

🛒 [Assured Studios Tebex](https://assured-studios.tebex.io/)

💬 [Discord Support](https://discord.gg/3QGwKDrtJA)

<img width="1356" height="718" alt="image" src="https://github.com/user-attachments/assets/33341f34-7925-4c28-a4eb-8a180deeec18" />
