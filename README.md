# CloneWars HUD
![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)
![Languages](https://img.shields.io/badge/Languages-English%20/%20French-blue.svg)

CloneWars HUD is a mod for Arma 3 that adds an immersive HUD inspired by the Clone Wars series.

## 📋 Description

CloneWars HUD enhances the gaming experience by adding authentic HUD interfaces inspired by the Star Wars Clone Wars universe. The mod features different types of helmets, each with its own specific HUD, providing total immersion in the world of Clone Troopers.

## ✨ Features

- **Multiple HUDs**: Support for different helmet types (P1, P2, ARF, BARC)
- **Customization**: Customizable colors and RGB mode
- **Damage System**: The HUD can crack when the player takes damage
- **Repair**: Ability to repair damaged HUD
- **ACE3 Compatibility**: ACE3 compatibility module included
- **CBA Configuration**: Fully configurable settings via CBA Settings
- **First and Third Person View**: Option to enable/disable in external view

## 📦 Dependencies

### Required
- [CBA_A3](https://github.com/CBATeam/CBA_A3) - Community Base Addons

### Optional
- [ACE3](https://github.com/acemod/ACE3) - For advanced compatibility features

## 🔧 Installation

### Steam Workshop (Recommended)

1. Subscribe to the mod on [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2421703737)
2. The mod will download automatically
3. Enable the mod in your Arma 3 launcher
4. Make sure CBA_A3 is also enabled

## ⚙️ Configuration

The mod uses the CBA settings system. Access the options via:
**Options → Addons Options → CloneWars HUD**

### Available Settings

#### Global
- **Enable by Default**: Automatically activates the HUD on mission start (your choice is then kept across respawns)
- **Enable Sun Filter by Default**: Darker visor on mission start
- **Enable Third Person**: Allows HUD display in third-person view
- **Hide in Night/Thermal Vision**: Hides the HUD while night or thermal vision is active

#### Colors
- **HUD Color**: Customize the interface color
- **RGB Mode**: Enables RGB color effects 🌈

#### Damage
- **Break Chance**: Probability that the HUD will crack on each head hit (0% to 100%)
- **Repair Time**: Time in seconds needed to repair a cracked HUD

#### Helmet Lists
Configuration of compatible helmets for each type:
- ARF helmets list
- BARC helmets list
- P1 helmets list
- P2 helmets list

Format: `["class1", "class2"]` or `class1, class2`. Helmets inheriting from a listed class are included.

> [!NOTE]
>  The default configuration includes a default list of compatible helmets. Changes apply immediately, no restart needed.

## 🎮 Usage

1. Equip a compatible helmet
2. The HUD activates automatically (if configured)
3. Use configurable keybinds to:
   - Activate/Deactivate the HUD
   - Repair damaged HUD

## 🔨 HUD Types

- P1 (Phase I)
- P2 (Phase II)
- ARF (Advanced Recon Force)
- BARC

## 🧩 For Mod Makers

### Declare a helmet as compatible

Add the `cwh_hudType` attribute to your helmet class (it is inherited by child classes):

```cpp
class CfgWeapons {
    class H_HelmetB;
    class My_Clone_Helmet: H_HelmetB {
        cwh_hudType = "P2"; // P1, P2, ARF, BARC or a custom type
    };
};
```

### Add a custom HUD type

```cpp
class cwh_hud_types {
    class MyType {
        displayName = "My HUD";
        frame = "\my\addon\frame_ca.paa"; // Static part of the visor
        color = "\my\addon\color_ca.paa"; // Part tinted with the HUD color (white texture)
    };
};
```

### Functions

| Function | Arguments | Description |
|---|---|---|
| `cwh_hud_fnc_setEnabled` | `[enabled]` (toggle if omitted) | Enables or disables the HUD |
| `cwh_hud_fnc_setSunFilter` | `[enabled]` (toggle if omitted) | Enables or disables the sun filter |
| `cwh_hud_fnc_setBroken` | `[unit, broken]` | Cracks or repairs the HUD |
| `cwh_hud_fnc_repair` | `[unit]` | Starts the repair (progress bar) |
| `cwh_hud_fnc_getHelmetType` | `[classname]` | HUD type of a helmet, `""` if none |

### Events (CBA, local)

| Event | Arguments |
|---|---|
| `cwh_hud_visibilityChanged` | `[visible]` |
| `cwh_hud_enabledChanged` | `[enabled]` |
| `cwh_hud_brokenChanged` | `[unit, broken]` |

```sqf
["cwh_hud_visibilityChanged", {
    params ["_visible"];
    systemChat format ["HUD visible: %1", _visible];
}] call CBA_fnc_addEventHandler;
```

## 🛠️ Development

This project uses [HEMTT](https://github.com/BrettMayson/HEMTT) for packaging and development.

### Project Structure

```
CloneWars-HUD/
├── addons/
│   ├── main/           # Main component
│   ├── hud/            # HUD logic
│   ├── ui/             # Graphic resources
│   └── compat_ace/     # ACE3 compatibility module
└── include/            # Include files
```

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs via [Issues](https://github.com/Bragg-0/CloneWars-HUD/issues)
- Suggest improvements
- Submit Pull Requests

Thank you to all contributors and supporters of the CloneWars HUD project!
<div align="center">
  <a href="https://github.com/Bragg-0/CloneWars-HUD/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=Bragg-0/CloneWars-HUD"/>
  </a>
</div>

## 🔗 Links

- [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2421703737)
- [GitHub Repository](https://github.com/Bragg-0/CloneWars-HUD)
- [Report a Bug](https://github.com/Bragg-0/CloneWars-HUD/issues)

## 📝 Arma Public License Share Alike (APL-SA)

See the [LICENSE](LICENSE.md) file for more details.

---

> [!CAUTION]
> This mod is a fan-made project and is not officially affiliated with Star Wars or Lucasfilm.
