# CloneWars HUD
![Version](https://img.shields.io/badge/Version-3.0.0-red.svg)
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

### Manual Installation

1. Download the latest version from the [Releases](https://github.com/Bragg-0/CloneWars-HUD/releases) page
2. Extract the contents to your Arma 3 folder
3. Enable the mod in your Arma 3 launcher
4. Make sure CBA_A3 is also enabled

## ⚙️ Configuration

The mod uses the CBA settings system. Access the options via:
**Options → Addons Options → CloneWars HUD**

### Available Settings

#### Global
- **Enable by Default**: Automatically activates the HUD on spawn
- **Enable Third Person**: Allows HUD display in third-person view
- **Break Chance**: Probability that the HUD will crack when taking damage (0% to 100%)

#### Colors
- **HUD Color**: Customize the interface color
- **RGB Mode**: Enables RGB color effects 🌈

#### Helmet Lists
Configuration of compatible helmets for each type:
- ARF helmets list
- BARC helmets list
- P1 helmets list
- P2 helmets list

> [!NOTE]
>  The default configuration includes a default list of compatible helmets.

> [!IMPORTANT]
> Modifying helmet lists requires a restart.

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