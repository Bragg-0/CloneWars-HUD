# Changelog

## 4.1.0

Thanks to Berry [16th] for the detailed feedback.

### New

- **Compass size** setting, independent of the HUD scale (default bigger than in 4.0)
- **Radio block position** setting: left under the health block (default), top right or bottom right
- **HUD font** setting: every font known by the game is listed, including fonts added by other mods (e.g. Aurebesh)
- **Grenade short name** in the grenade block, to tell apart grenades sharing the same icon (e.g. thermal detonator classes)
- Compact weapon block, the ammo counter is no longer bold
- The grenade icon keeps its own colors, the smoke color is shown by the colored stripe under it

### Changed

- The compass graduations, labels and markers fade out near its edges instead of being cut
- Squad members on the compass are colored chevrons, following the team colors setting
- The waypoint stays at the edge of the compass, dimmed, when it is out of view
- Notifications fit their text and are centered
- The compass gets smaller when it would overlap the side blocks (narrow screens with a big HUD scale)

### Fixed

- The grenade count was one less than the actual number (the selected grenade was not counted)
- The green smoke grenade was shown cyan
- Markers flickered at the edges of the compass
- Notifications could overlap the weapon and grenade blocks

## 4.0.0

Complete rewrite of the mod.

> [!IMPORTANT]
> The CBA settings and keybinds of 3.x are kept. Mission scripts using the player variables `cwh_hud_active` or `cwh_hud_enableSunFilter` must now call `cwh_hud_fnc_setEnabled` and `cwh_hud_fnc_setSunFilter`.

### New

- **New look**: original weapon, grenade, compass, health and radio blocks, new logo and icons
- **Any screen**: the HUD adapts to every aspect ratio (4:3, 16:9, 21:9...) without stretching, with HUD scale and opacity settings
- **Compass strip** at the top of the screen, showing the squad members and your waypoint (custom waypoint, task destination or group waypoint)
- **Ammo counter** in big digits, with a low ammo warning
- **Health block**: health and stamina, or blood and pain with ACE medical
- **Squad markers**: small icon above the members of your group, blinking orange when they are unconscious
- **Notifications** under the compass, replacing the vanilla hints, with squad alerts (member down or killed)
- **Effects**: boot sequence when the HUD turns on, glitch when you are hit
- **Sounds**: power on / off, hit, low ammo, crack and repair
- **Smoke grenade colors**: the grenade icon is tinted with the smoke color
- **TFAR radio block**: short range radios and active long range radio, channel, frequency and additional channel, green while transmitting and amber while receiving. The TFAR hint is hidden while the HUD is shown
- **Zeus Enhanced modules**: crack, repair, turn on / off the HUD of a player, send a HUD notification to a player, a group, a side or everyone
- **Settings** to turn every block and effect on or off
- **Translations**: German and Spanish, in addition to English and French
- Passengers in FFV seats now have the HUD
- The HUD is hidden while unconscious, in spectator mode and in the ACE arsenal

### Fixed

- The ACE stamina bar overlapped the weapon block
- The fire mode of modded weapons (JLTS, Legion Studios) was not shown
- The HUD could be cracked by hits on your previous body after a respawn
- The HUD disappeared after loading a savegame
- The vanilla weapon info sometimes stayed visible when the mission started
- The repair could be started several times and was not cancelled when dying
- The heading followed the body instead of where you look

### For mod and mission makers

- Helmets can declare their HUD type in config (`cwh_hudType`) and new HUD types can be added (`cwh_hud_types`)
- Public functions and CBA events: see the README
- Helmet lists accept `class1, class2` and apply without restart
