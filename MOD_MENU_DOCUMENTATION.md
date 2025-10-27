# Black Ops 3 Mod Menu Development Guide

This guide covers how to add features to your BO3 Zombies mod menu using GSC scripting.

---

## Table of Contents
1. [Points/Score Management](#pointsscore-management)
2. [Weapon Management](#weapon-management)
3. [Powerups](#powerups)
4. [GobbleGums (BGBs)](#gobblegums-bgbs)
5. [Perks](#perks)
6. [Player Stats & Modifications](#player-stats--modifications)
7. [Already Implemented Features](#already-implemented-features)
8. [Resources](#resources)

---

## Points/Score Management

### Add Points
```gsc
// Add points to player
player zm_score::add_to_player_score(amount);

// Example: Give 1000 points
player zm_score::add_to_player_score(1000);
```

### Remove Points
```gsc
// Subtract points
player zm_score::minus_to_player_score(amount);

// Example: Remove 500 points
player zm_score::minus_to_player_score(500);
```

### Set Points
```gsc
// Set exact point value
player.score = amount;

// Example: Set to 50,000 points
player.score = 50000;
```

### Get Current Points
```gsc
// Get player's current score
currentScore = player.score;
```

### Example Menu Implementation
```gsc
// In Options.gsc
case "Points Menu":
    self addMenu("Points Menu", "Points Menu");
    self addOpt("Give 10000 Points", ::GivePoints, player, 10000);
    self addOpt("Give 50000 Points", ::GivePoints, player, 50000);
    self addOpt("Max Points", ::GivePoints, player, 999999);
    self addOpt("Remove All Points", ::RemoveAllPoints, player);
    break;

// In player.gsc or a new file
GivePoints(player, amount)
{
    player zm_score::add_to_player_score(amount);
    self iPrintLnBold("^2+" + amount + " Points");
}

RemoveAllPoints(player)
{
    player.score = 0;
    self iPrintLnBold("^1Points Reset");
}
```

---

## Weapon Management

### Give Weapon
```gsc
// Basic weapon give
weapon = GetWeapon("weapon_name");
player GiveWeapon(weapon);
player SwitchToWeapon(weapon);

// Example: Give Ray Gun
weapon = GetWeapon("ray_gun");
player GiveWeapon(weapon);
player SwitchToWeapon(weapon);
```

### Pack-a-Punched Weapons
```gsc
// Give upgraded weapon
weapon = GetWeapon("weapon_name_upgraded");
player GiveWeapon(weapon);
player SwitchToWeapon(weapon);

// Example: Give Pack-a-Punched KN-44
weapon = GetWeapon("ar_standard_upgraded");
player GiveWeapon(weapon);
player SwitchToWeapon(weapon);
```

### Common Weapon Names
```gsc
// Wonder Weapons
"ray_gun"              // Ray Gun
"ray_gun_upgraded"     // Porter's X2 Ray Gun
"thundergun"           // Thunder Gun
"thundergun_upgraded"  // Zeus Cannon

// Assault Rifles
"ar_standard"          // KN-44
"ar_standard_upgraded" // KN-44 Upgraded
"ar_longburst"         // M8A7
"ar_cqb"              // HVK-30

// Submachine Guns
"smg_standard"         // Kuda
"smg_burst"           // Pharo
"smg_versatile"       // Vesper

// Light Machine Guns
"lmg_heavy"           // Dingo
"lmg_cqb"             // 48 Dredge

// Sniper Rifles
"sniper_fastsemi"     // Drakon
"sniper_powerbolt"    // Locus

// Shotguns
"shotgun_pump"        // KRM-262
"shotgun_fullauto"    // Haymaker 12

// Pistols
"pistol_standard"     // MR6
"pistol_burst"        // RK5

// Special/Melee
"melee_knife"         // Knife
"hero_bow"           // Elemental Bows (Der Eisendrache)
```

### Take Weapons
```gsc
// Take current weapon
weapon = player GetCurrentWeapon();
player TakeWeapon(weapon);

// Take all weapons (already in your weaponry.gsc)
TakeAllWeapons(player);

// Take specific weapon
weapon = GetWeapon("ray_gun");
player TakeWeapon(weapon);
```

### Weapon Utilities
```gsc
// Get all weapons player has
weapons = player GetWeaponsList(true);

// Give max ammo for current weapon
weapon = player GetCurrentWeapon();
player GiveMaxAmmo(weapon);

// Set ammo for specific weapon
weapon = GetWeapon("ray_gun");
player SetWeaponAmmoClip(weapon, 20);    // Clip ammo
player SetWeaponAmmoStock(weapon, 160);  // Reserve ammo
```

### Example Menu Implementation
```gsc
// In Options.gsc
case "Weapons Menu":
    self addMenu("Weapons Menu", "Weapons Menu");
    self addOpt("Wonder Weapons", ::newMenu, "Wonder Weapons");
    self addOpt("Assault Rifles", ::newMenu, "Assault Rifles");
    self addOpt("Give Max Ammo", ::GiveMaxAmmo, player);
    self addOpt("Take All Weapons", ::TakeAllWeapons, player);
    break;

case "Wonder Weapons":
    self addMenu("Wonder Weapons", "Wonder Weapons");
    self addOpt("Ray Gun", ::GiveWeaponToPlayer, player, "ray_gun");
    self addOpt("Ray Gun (PaP)", ::GiveWeaponToPlayer, player, "ray_gun_upgraded");
    self addOpt("Thunder Gun", ::GiveWeaponToPlayer, player, "thundergun");
    break;

// In weaponry.gsc or player.gsc
GiveWeaponToPlayer(player, weaponName)
{
    weapon = GetWeapon(weaponName);
    player GiveWeapon(weapon);
    player SwitchToWeapon(weapon);
    player GiveMaxAmmo(weapon);
    self iPrintLnBold("^2Given: ^7" + weaponName);
}
```

---

## Powerups

### Spawn Powerup
```gsc
// Spawn powerup at location
zm_powerups::specific_powerup_drop(powerup_name, location);

// Example: Spawn Max Ammo at player's location
zm_powerups::specific_powerup_drop("full_ammo", player.origin);
```

### Powerup Names
```gsc
"nuke"              // Nuke
"insta_kill"        // Insta-Kill
"double_points"     // Double Points
"full_ammo"         // Max Ammo
"fire_sale"         // Fire Sale
"carpenter"         // Carpenter
"bonus_points_team" // Bonus Points
"free_perk"         // Free Perk
"lose_perk"         // Lose Perk (negative)
"death_machine"     // Death Machine
```

### Give Powerup Effect (No Pickup)
```gsc
// Activate powerup effect directly
level notify("powerup_dropped", powerup_name);

// Or use specific functions
zm_powerups::start_powerup("insta_kill", duration);

// Example: 30 second insta-kill
zm_powerups::start_powerup("insta_kill", 30);
```

### Example Menu Implementation
```gsc
// In Options.gsc
case "PowerUp Options":
    self addMenu("PowerUp Options", "PowerUp Options");
    self addOpt("Max Ammo", ::SpawnPowerup, player, "full_ammo");
    self addOpt("Nuke", ::SpawnPowerup, player, "nuke");
    self addOpt("Insta-Kill", ::SpawnPowerup, player, "insta_kill");
    self addOpt("Double Points", ::SpawnPowerup, player, "double_points");
    self addOpt("Fire Sale", ::SpawnPowerup, player, "fire_sale");
    self addOpt("Carpenter", ::SpawnPowerup, player, "carpenter");
    self addOpt("Death Machine", ::SpawnPowerup, player, "death_machine");
    break;

// In player.gsc or new file
SpawnPowerup(player, powerupName)
{
    // Spawn slightly above player so it drops
    spawnPos = player.origin + (0, 0, 40);
    zm_powerups::specific_powerup_drop(powerupName, spawnPos);
    self iPrintLnBold("^2Spawned: ^7" + powerupName);
}
```

---

## GobbleGums (BGBs)

### Already Available in Your Code
Your `main.gsc:300-305` already loads all available gobblegums:
```gsc
level.CustomBGB = [];
bgb = GetArrayKeys(level.bgb);
for(a = 0; a < bgb.size; a++)
    array::add(level.CustomBGB, bgb[a], 0);
```

### Activate GobbleGum
```gsc
// Give/activate a gobblegum
player zm_bgb::bgb_gumball_anim(bgb_name);

// Or use
player zm_bgb::activate(bgb_name);
```

### Common GobbleGum Names
```gsc
// Mega GobbleGums
"zm_bgb_perkaholic"          // Perkaholic
"zm_bgb_shopping_free"       // Shopping Free
"zm_bgb_phoenix_up"          // Phoenix Up
"zm_bgb_immolation_liquidation" // Immolation Liquidation
"zm_bgb_power_vacuum"        // Power Vacuum
"zm_bgb_near_death_experience" // Near Death Experience

// Classic GobbleGums
"zm_bgb_always_done_swiftly" // Always Done Swiftly
"zm_bgb_arsenal_accelerator" // Arsenal Accelerator
"zm_bgb_coagulant"          // Coagulant
"zm_bgb_in_plain_sight"     // In Plain Sight
"zm_bgb_stock_option"       // Stock Option
"zm_bgb_sword_flay"         // Sword Flay
"zm_bgb_lucky_crit"         // Lucky Crit
```

### Example Menu Implementation
```gsc
// In Options.gsc
case "GobbleGum Menu":
    self addMenu("GobbleGum Menu", "GobbleGum Menu");
    // Use your existing level.CustomBGB array
    for(i = 0; i < level.CustomBGB.size; i++)
    {
        bgbName = level.CustomBGB[i];
        displayName = BGBName(bgbName); // Function already in tables.gsc
        self addOpt(displayName, ::ActivateGobbleGum, player, bgbName);
    }
    break;

// In player.gsc
ActivateGobbleGum(player, bgbName)
{
    player zm_bgb::activate(bgbName);
    self iPrintLnBold("^2Activated: ^7" + bgbName);
}
```

---

## Perks

### Give Perk
```gsc
// Give specific perk
player zm_perks::give_perk(perk_name);

// Example: Give Juggernog
player zm_perks::give_perk("specialty_armorvest");
```

### Common Perk Names
```gsc
"specialty_armorvest"        // Juggernog
"specialty_quickrevive"      // Quick Revive
"specialty_fastreload"       // Speed Cola
"specialty_doubletap2"       // Double Tap II
"specialty_staminup"         // Stamin-Up
"specialty_deadshot"         // Deadshot Daiquiri
"specialty_widowswine"       // Widow's Wine
"specialty_electriccherry"   // Electric Cherry
"specialty_additionalprimaryweapon" // Mule Kick
```

### Give All Perks
```gsc
GiveAllPerks(player)
{
    perks = array("specialty_armorvest", "specialty_quickrevive",
                  "specialty_fastreload", "specialty_doubletap2",
                  "specialty_staminup", "specialty_deadshot",
                  "specialty_widowswine", "specialty_additionalprimaryweapon");

    foreach(perk in perks)
    {
        if(!player HasPerk(perk))
            player zm_perks::give_perk(perk);
    }

    self iPrintLnBold("^2All Perks Given!");
}
```

### Remove Perk
```gsc
// Take specific perk
player zm_perks::take_perk(perk_name);

// Remove all perks
player zm_perks::lose_all_perks();
```

---

## Player Stats & Modifications

### No Target (Already Implemented!)
Your `basic.gsc:35-46` already has this:
```gsc
NoTarget(player)
{
    player.NoTarget = isDefined(player.NoTarget) ? undefined : true;
    if(isDefined(player.NoTarget))
    {
        player endon("disconnect");
        player.ignoreme = true;
    }
    else
        player.ignoreme = false;
}
```

### Infinite Ammo
```gsc
InfiniteAmmo(player)
{
    player endon("disconnect");
    player.InfiniteAmmo = isDefined(player.InfiniteAmmo) ? undefined : true;

    if(isDefined(player.InfiniteAmmo))
    {
        player thread InfiniteAmmoLoop();
        player iPrintLnBold("Infinite Ammo ^2ON");
    }
    else
    {
        player notify("end_infinite_ammo");
        player iPrintLnBold("Infinite Ammo ^1OFF");
    }
}

InfiniteAmmoLoop()
{
    self endon("disconnect");
    self endon("end_infinite_ammo");

    while(isDefined(self.InfiniteAmmo))
    {
        weapon = self GetCurrentWeapon();
        if(weapon != level.weaponbasemelee)
        {
            self GiveMaxAmmo(weapon);
        }
        wait 0.1;
    }
}
```

### Teleport
```gsc
// Teleport to crosshair position
TeleportToCrosshair(player)
{
    // GetCursorPos() already exists in utilities.gsc:426
    position = player GetCursorPos();
    player SetOrigin(position);
    player iPrintLnBold("^2Teleported");
}

// Teleport to another player
TeleportToPlayer(player, targetPlayer)
{
    player SetOrigin(targetPlayer.origin);
    player iPrintLnBold("^2Teleported to " + targetPlayer.name);
}
```

### Modify Round
```gsc
// Set round number
SetRound(roundNum)
{
    level.zombie_vars["zombie_spawn_delay"] = [];
    level.zombie_vars["zombie_spawn_delay"][0] = 1;
    level.zombie_move_speed = roundNum * 10;

    level notify("end_of_round");
    level notify("restart_round");
    wait 0.1;

    level.round_number = roundNum - 1;
    level notify("end_of_round");

    self iPrintLnBold("^2Round Set to: ^7" + roundNum);
}
```

### Freeze/Unfreeze Zombies
```gsc
FreezeZombies()
{
    level.FrozenZombies = isDefined(level.FrozenZombies) ? undefined : true;

    zombies = GetAITeamArray(level.zombie_team);
    foreach(zombie in zombies)
    {
        if(isDefined(level.FrozenZombies))
            zombie.ignoreall = true;
        else
            zombie.ignoreall = false;
    }

    status = isDefined(level.FrozenZombies) ? "^2ON" : "^1OFF";
    self iPrintLnBold("Freeze Zombies " + status);
}
```

### Aimbot (Basic)
```gsc
Aimbot(player)
{
    player endon("disconnect");
    player.Aimbot = isDefined(player.Aimbot) ? undefined : true;

    if(isDefined(player.Aimbot))
    {
        player thread AimbotLoop();
        player iPrintLnBold("Aimbot ^2ON");
    }
    else
    {
        player notify("end_aimbot");
        player iPrintLnBold("Aimbot ^1OFF");
    }
}

AimbotLoop()
{
    self endon("disconnect");
    self endon("end_aimbot");

    while(isDefined(self.Aimbot))
    {
        if(self AttackButtonPressed())
        {
            zombies = GetAITeamArray(level.zombie_team);
            if(zombies.size > 0)
            {
                closest = GetClosest(self.origin, zombies);
                if(isDefined(closest))
                {
                    self SetPlayerAngles(VectorToAngles(closest GetTagOrigin("j_head") - self GetTagOrigin("j_head")));
                }
            }
        }
        wait 0.05;
    }
}
```

---

## Already Implemented Features

Based on your existing code, you already have:

### In `basic.gsc`:
- ✅ `Godmode()` - Invincibility
- ✅ `DemiGod()` - Partial damage reduction
- ✅ `NoTarget()` - Zombies ignore you

### In `player.gsc`:
- ✅ `PlayerDeath()` - Down/Kill player
- ✅ `PlayerRevive()` - Revive downed player
- ✅ `PlayerAutoRevive()` - Auto-revive on down
- ✅ `PlayerRespawn()` - Force respawn
- ✅ `KickPlayer()` - Kick from game
- ✅ `SuperSpeed()` - Movement speed boost
- ✅ `SuperJump()` - Jump height boost
- ✅ `SetJumpHeight()` - Custom jump height

### In `weaponry.gsc`:
- ✅ `TakeCurrentWeapon()` - Remove current weapon
- ✅ `TakeAllWeapons()` - Remove all weapons

### In Custom Perks:
- ✅ `PhdFlopper()` - PhD Flopper perk
- ✅ `ElectricCherry()` - Electric Cherry perk

---

## Resources

### Official Documentation
- **T7 Compiler**: https://github.com/shiversoftdev/t7-compiler
- **BO3 GSC Dump**: https://github.com/ate47/BO3-GSC-Dump (All function names and includes)
- **Serious GSC Documentation**: https://github.com/Scobalula/Serious-GSC-Documentation

### Your Menu Base
- Original: https://github.com/NicoLeo13/Silverlines-BO3-GSC-Mod-Menu

### Example Mods & Menus
- Search GitHub for: `"bo3 gsc menu"` or `"bo3 zombies menu"`
- Look at: https://github.com/topics/bo3-gsc
- ZombieModding.com forums

### Testing & Debugging
- Use `iPrintLnBold()` for debugging messages
- Check console for GSC errors when compiling
- Test in custom games first before public use

---

## Quick Start Template

Here's a template for adding a new feature to your menu:

```gsc
// 1. In Options.gsc - Add menu case
case "My New Menu":
    self addMenu("My New Menu", "My New Menu");
    self addOpt("Give Points", ::MyGivePoints, player, 10000);
    self addOptBool(player.MyFeature, "My Toggle", ::MyToggleFeature, player);
    break;

// 2. In player.gsc or new file - Add functions
MyGivePoints(player, amount)
{
    player zm_score::add_to_player_score(amount);
    self iPrintLnBold("^2Gave " + amount + " points!");
}

MyToggleFeature(player)
{
    player.MyFeature = isDefined(player.MyFeature) ? undefined : true;

    if(isDefined(player.MyFeature))
    {
        player thread MyFeatureLoop();
        player iPrintLnBold("My Feature ^2ON");
    }
    else
    {
        player notify("end_my_feature");
        player iPrintLnBold("My Feature ^1OFF");
    }
}

MyFeatureLoop()
{
    self endon("disconnect");
    self endon("end_my_feature");

    while(isDefined(self.MyFeature))
    {
        // Your feature logic here
        wait 0.05;
    }
}

// 3. In main.gsc - Add any required includes at top
#include scripts\zm\_zm_score;
#include scripts\zm\_zm_weapons;
#include scripts\zm\_zm_powerups;
```

---

## Notes

- Always use `player endon("disconnect")` in loops
- Use `wait 0.05` or higher in while loops to prevent game freezing
- Test all features in a private match first
- Use `level.` for global variables, `self.` or `player.` for player-specific
- Remember to compile with T7 Compiler before testing

Good luck building your mod menu!
