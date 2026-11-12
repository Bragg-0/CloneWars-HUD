# CloneWars HUD
![Status](https://img.shields.io/badge/Status-Active-brightgreen.svg)
![Languages](https://img.shields.io/badge/Languages-English%20/%20French%20/%20German%20/%20Spanish-blue.svg)

CloneWars HUD is a mod for Arma 3 that adds an immersive HUD inspired by the Clone Wars series.

## 📋 Description

CloneWars HUD enhances the gaming experience by adding authentic HUD interfaces inspired by the Star Wars Clone Wars universe. The mod features different types of helmets, each with its own specific HUD, providing total immersion in the world of Clone Troopers.

## ✨ Features

- **Multiple HUDs**: Support for different helmet types (P1, P2, ARF, BARC)
- **Customization**: Customizable colors and RGB mode
- **Damage System**: The HUD can crack when the player takes damage
- **Repair**: Ability to repair damaged HUD
- **ACE3 Compatibility**: ACE3 compatibility module included
- **Compass strip**: Graduated compass with squad members and waypoint
- **Notifications**: HUD messages replacing the vanilla hints, usable by mission makers
- **Radio**: Radios and channels with TFAR
- **Zeus Enhanced modules**: Crack, repair, turn on / off the HUD of a player, send HUD notifications
- **CBA Configuration**: Fully configurable settings via CBA Settings
- **First and Third Person View**: Option to enable/disable in external view

## 📦 Dependencies

### Required
- [CBA_A3](https://github.com/CBATeam/CBA_A3) - Community Base Addons

### Optional
- [ACE3](https://github.com/acemod/ACE3) - For advanced compatibility features
- [TFAR](https://github.com/michail-nikolaev/task-force-arma-3-radio) (1.0 beta) - Radio block
- [Zeus Enhanced](https://github.com/zen-mod/ZEN) - Zeus modules

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

#### Display
- **HUD Scale**: Size of the info elements (weapon, grenades, heading)
- **HUD Opacity**: Opacity of the info elements

The HUD adapts to any aspect ratio (4:3, 16:9, 21:9...): nothing is stretched.

#### Elements
- **Show weapon / grenade / heading / health block**: Turn each info block on or off
- **Low ammo warning**: Magazine level under which the ammo counter blinks orange (0% to disable)
- **Squad markers**: Marks the members of your group with a small icon in the HUD color (team colors optional, orange blink if unconscious), up to a configurable range
- **Squad / waypoint on the compass**: Direction of the group members and of your waypoint (custom waypoint, task destination or group waypoint) on the compass strip
- **Show radio block**: Short range radios (active first) and active long range radio, with channel, frequency and additional channel. Green while you transmit, amber while someone transmits on one of your frequencies (TFAR)
- **Hide the TFAR hint**: While the radio block is shown, hides the TFAR transmitting / channel hint

The health block shows health and stamina, or blood volume and pain when ACE medical is loaded.

#### Effects
- **Boot sequence**: The HUD elements light up one after the other when the HUD turns on
- **Glitch when hit**: The HUD shakes and flickers briefly when you take damage
- **HUD sounds** and volume: Power on / off, hit, low ammo, crack and repair sounds

#### Notifications
- **Show notifications**: HUD messages under the compass (CBA notifications are used when the HUD is not shown)
- **Notification duration**
- **Squad alerts**: Notification when a group member goes down or is killed

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
| `cwh_hud_fnc_glitch` | `[duration]` (0.35 s if omitted) | Makes the HUD glitch |
| `cwh_hud_fnc_playSound` | `[name]` | Plays a HUD sound: `boot`, `shutdown`, `glitch`, `warning`, `alert`, `confirm` |
| `cwh_hud_fnc_notify` | `[text, type, duration]` | Shows a HUD notification. Type: `info`, `warning`, `alert`, `success` |
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

### Remote events (CBA, sent to the machine of a player)

```sqf
["cwh_hud_notify", ["Extraction in 5 minutes", "warning"], _player] call CBA_fnc_targetEvent;
["cwh_hud_notify", ["Mission complete", "success"]] call CBA_fnc_globalEvent; // Every player
["cwh_hud_setEnabled", [false], _player] call CBA_fnc_targetEvent;
["cwh_hud_setBroken", [_player, true], _player] call CBA_fnc_targetEvent;
```

### Radio providers

Another radio mod can feed the radio block:

```sqf
cwh_hud_radioProviders pushBack {
    // List of radios (up to 3 shown), each [radio name, channel text, transmitting, additional channel text (optional), receiving (optional)]
    [["My radio", "CH 2", false, "+CH 5", false]]
};
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
│   ├── compat_ace/     # ACE3 compatibility
│   ├── compat_tfar/    # TFAR compatibility (radio block)
│   └── compat_zen/     # Zeus Enhanced modules
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
