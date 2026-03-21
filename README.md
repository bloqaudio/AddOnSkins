# AddOnSkins

A World of Warcraft addon skinning framework that provides unified visual styling for Blizzard UI elements and 130+ third-party addons. Works standalone or integrates with [ElvUI](http://www.tukui.org) and [Tukui](http://www.tukui.org) for seamless theme consistency.

Originally by Azilroka and Nihilistzsche. This is a maintained fork by quinnoshea.

**Current Version:** 5.00
**Supported WoW Versions:** Retail (Midnight 12.0.1), Vanilla Classic, Mists of Pandaria Classic

## Installation

Install via [CurseForge](https://www.curseforge.com/wow/addons/addonskins) or [Wago](https://addons.wago.io/addons/addonskins), or clone this repository into your `Interface/AddOns` directory.

If cloning, initialize the Ace3 submodule:
```
git submodule update --init
```

## Features

### Blizzard UI Skins (103 Mainline)
Reskins Blizzard's default UI frames to match your ElvUI/Tukui theme, including:
- **Core:** Character, SpellBook, Friends, Mail, Merchant, Trade, Loot, Bags, Tooltip
- **Group Content:** LFG, Raid, PVP, Communities, Guild
- **Collections:** Mounts, Pets, Toys, Heirlooms, Wardrobe
- **Progression:** Achievements, Professions, Encounter Journal, Weekly Rewards
- **World:** World Map, Quest Log, Flight Map, Calendar
- **Legacy Expansion:** Garrison, Order Hall, Covenants, Torghast, Islands, Artifacts (all still functional when visiting old content)

### Third-Party Addon Skins (~130)
Unified styling for popular addons including:
- **Boss Mods:** DBM, BigWigs
- **Action Bars:** Bartender4, Dominos
- **Damage Meters:** Recount, Skada, TinyDPS
- **Threat:** Omen
- **Utilities:** Postal, TomTom, Pawn, Hekili, RaiderIO, Simulationcraft, Clique, Quartz
- **Collections:** AtlasLoot, AllTheThings, MogIt, PetTracker
- **And many more** — see `Skins/AddOns/` for the full list

### Embed System
Embeds damage meters (Details, Skada, Recount, Omen, TinyDPS) directly into ElvUI chat frames for a clean, integrated layout.

### Theme System
Three border themes to match your preference:
- **PixelPerfect** (1px)
- **TwoPixel** (2px)
- **ThickBorder** (3px)

## Configuration

Access settings via `/addonskins` or `/as`. The options panel provides:
- Per-skin enable/disable toggles for all Blizzard and addon skins
- Theme, font, and color customization
- Embed system configuration
- ElvUI conflict prevention (avoids double-skinning when ElvUI already handles a frame)

## Contributing

- Report bugs or request features: [GitHub Issues](https://github.com/quinnoshea/AddOnSkins/issues)
- Source code: [GitHub Repository](https://github.com/quinnoshea/AddOnSkins)

## License

See the repository for license information.
