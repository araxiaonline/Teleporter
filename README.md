# 🌀 Araxia Teleport Selector (AzerothCore)

![Teleport Selector Preview](./Teleporter.gif)

[![Watch Demo Video](https://img.youtube.com/vi/OORbuCK2LDU/hqdefault.jpg)](https://youtu.be/OORbuCK2LDU)

## Overview

The **Araxia Teleport Selector** is an intuitive in-game interface for players to teleport to a wide range of world locations, dungeons, and raids across all major expansions. Built on **AzerothCore**, this Lua-based interface streamlines navigation across Azeroth, Outland, and Northrend with a user-friendly category and pagination system.

---

## 🛠️ Key Features

- ✅ **Categorized Destinations**  
  Teleports are grouped into logical categories like:
  - Capital Cities
  - Kalimdor / Eastern Kingdoms / Outland / Northrend
  - Dungeons (Vanilla, TBC, WOTLK)
  - Raids (Vanilla, TBC, WOTLK)
  - Custom Locations

- 🖱️ **Clickable UI with Pagination**  
  Users can scroll through teleport options with `Next` / `Previous` buttons. Each page shows a fixed number of teleport destinations for easier browsing.

- 🌍 **Precise World Coordinates**  
  Server-side coordinates match each location's real in-game position. IDs and image paths are strictly maintained for client/server sync.

- 📷 **Custom Button Icons**  
  Every teleport destination uses a themed icon (e.g., `Interface\\Buttons\\Teleport\\StormwindCity`) to provide a polished, immersive experience.

- ⚙️ **Developer-Friendly Structure**  
  - Clean separation of client (`TeleportSelectorClient.lua`) and server (`TeleportSelectorServer.lua`)
  - Easily extensible: just add a new category entry and coordinates
  - Image paths, IDs, and layout positioning strictly preserved for consistency

---

## 📦 File Structure

```
TeleportSelectorClient.lua   -- Client UI: buttons, layout, event handling
TeleportSelectorServer.lua   -- Server coords: teleport destination data
Interface/Buttons/Teleport   -- Go inside you custom MPQ
```

---

## 📌 How It Works

1. Players open the **Teleport Selector Frame** (via NPC, macro, or command).
2. They choose a category (e.g., Raids, Northrend, Capital Cities).
3. The UI shows buttons with icons and labels for each destination.
4. Clicking a button sends a teleport request to the server.
5. The server looks up the correct `map`, `x`, `y`, `z`, and `orientation`, then teleports the player.

---

## 💡 Custom Additions (Araxia Specific)

- **Guild Hall**, **Morza Island**, **Silithus Camp**, **Isle of Giants**, and other Araxia-exclusive zones are supported.
- Custom images like `Interface\\Buttons\\GuildHall` help distinguish them.
- Category `"Custom"` is alphabetized, but Guild Hall always appears first.

---

## 🔧 Developer Notes

- Image paths and names **must not be changed**; they directly map to client button graphics.
- IDs are **strictly ordered** and consistent between client/server to ensure teleport mapping.
- Pagination layout is centered using `SetPoint("BOTTOM", ..., ±X)` for symmetry across different screen sizes.

---

## 🧪 Compatibility

- ✔️ Designed for **AzerothCore**
- ❌ Not tested on TrinityCore or other forks
- 🧩 No external modules or frameworks required (pure Lua + native AC hook support)
