SelectPlayer()
{
    foreach(player in level.players)
        if(isDefined(self.selected_player) && player == self.selected_player)
            return player;
    return self;
}

RunMenu()
{
    self endon("disconnect");

    player = self SelectPlayer();
    menu = CleanMenuName(self getCurrentMenu());
    
    switch(menu)
    {
        case "Main":
            self addMenu("Main", "Main Menu");
                if(self getVerification() > 0)  //  Verified
                {
                    self addOpt("Personal Options", ::newMenu, "Personal Options" + player GetEntityNumber());
                   self addOpt("Fun Menu", ::newMenu, "Fun Menu" + player GetEntityNumber());
                    self addOpt("Weapons Menu", ::newMenu, "Weapons Menu" + player GetEntityNumber());
                    self addOpt("Message Menu", ::newMenu, "Message Menu" + player GetEntityNumber());
                    self addOpt("Zombie Options", ::newMenu, "Zombie Options" + player GetEntityNumber());
                    self addOpt("PowerUp Options", ::newMenu, "PowerUp Options" + player GetEntityNumber());
                    self addOpt("Misc Options", ::newMenu, "Misc Options" + player GetEntityNumber());
                    self addOpt("Map Options", ::newMenu, "Map Options" + player GetEntityNumber());
                    self addOpt("Movement Menu", ::newMenu, "Movement Menu" + player GetEntityNumber());
                    self addOpt("Menu Customization", ::newMenu, "Menu Customization");
                }
                if(self getVerification() > 1)  //  VIP
                {
          
                }
                if(self getVerification() > 2)  //  Admin
                {
                   
                    
                }
                if(self getVerification() > 3)  //  Co-Host
                {
                    
                }
                if(self IsHost())               //  Host
                {
                    self addOpt("Host Menu", ::newMenu, "Host Menu");
                    self addOpt("Players Menu", ::newMenu, "Players Menu");
                }
            break;
        
        case "Personal Options":
        self addMenu("Personal Options" + player GetEntityNumber(), "Personal Options");
                self addOptBool(player.godmode, "God Mode", ::Godmode, player);
                self addOptBool(player.DemiGod, "Demi God", ::DemiGod, player);
                self addOptBool(player.NoTarget, "No Target", ::NoTarget, player);
                self addOptBool(player.SuperSpeed, "Super Speed", ::SuperSpeed, player);
            break;
            
            case "Fun Menu":
            self addMenu("Fun Menu" + player GetEntityNumber(), "Fun Menu");
            self addOptBool(player.godmode, "balllllllll", ::Godmode, player);
                self addOptBool(player.DemiGod, "Demi God", ::DemiGod, player);
                self addOptBool(player.NoTarget, "No Target", ::NoTarget, player);               
            break;
            
             case "Weapons Menu":
            self addMenu("Weapons Menu" + player GetEntityNumber(), "Weapons Menu");
            self addOptBool(player.godmode, "fack dick", ::Godmode, player);
                self addOptBool(player.DemiGod, "Demi God", ::DemiGod, player);
                self addOptBool(player.NoTarget, "No Target", ::NoTarget, player);               
            break;


        case "Custom Perks":
            self addMenu("Custom Perks", "Custom Perks");
                self addOptBool(isDefined(player.PhdFlopper) && player.PhdFlopper == "Flopper", "PhD Flopper", ::PhdFlopper, player, "Flopper");
                self addOptBool(isDefined(player.PhdFlopper) && player.PhdFlopper == "Slider", "PhD Slider", ::PhdFlopper, player, "Slider");
                self addOptBool(isDefined(player.ElectricCherry) && player.ElectricCherry == "v1", "Electric Cherry", ::ElectricCherry, player, "v1");
                // self addOptBool(isDefined(player.ElectricCherry) && player.ElectricCherry == "v2", "Electric Cherry v2", ::ElectricCherry, player, "v2");
            break;


        case "Message Menu":
            self addMenu("Message Menu" + player GetEntityNumber(), "Message Menu");
                // ... existing Message Menu Customizationions ...
                // Added option with submenu's own name
                self addOpt("Message Menu", ::newMenu, "Message Menu " + player GetEntityNumber());
            break;

        case "Zombie Options":
            self addMenu("Zombie Options" + player GetEntityNumber(), "Zombie Options");
                // ... existing Zombie Options ...
                // Added option with submenu's own name
                self addOpt("Zombie Options", ::newMenu, "Zombie Options " + player GetEntityNumber());
            break;

        case "PowerUp Options":
            self addMenu("PowerUp Options" + player GetEntityNumber(), "PowerUp Options");
                // ... existing PowerUp Options ...
                // Added option with submenu's own name
                self addOpt("PowerUp Options", ::newMenu, "PowerUp Options " + player GetEntityNumber());
            break;

        case "Misc Options":
            self addMenu("Misc Options" + player GetEntityNumber(), "Misc Options");
                // ... existing Misc Options ...
                // Added option with submenu's own name
                self addOpt("Misc Options", ::newMenu, "Misc Options " + player GetEntityNumber());
            break;

        case "Map Options":
            self addMenu("Map Options" + player GetEntityNumber(), "Map Options");
                // ... existing Map Options ...
                // Added option with submenu's own name
                self addOpt("Map Options", ::newMenu, "Map Options " + player GetEntityNumber());
            break;

        case "Movement Menu":
            self addMenu("Movement Menu" + player GetEntityNumber(), "Movement Menu");
                self addOptBool(player.SuperSpeed, "Super Speed", ::SuperSpeed, player);
                self addOptBool(player.SuperJump, "Super Jump", ::SuperJump, player);
                self addOptIntSlider("Jump Height", ::SetJumpHeight, 39, 100, 500, 10);
            break;

        case "Menu Customization":
            self addMenu("Menu Customization", "Menu Customization");
                self addOpt("Set Default Preset", ::SetDefaultPreset);
                self addOptIntSlider("Max Opts", ::SetMenuMaxOpts, 3, self.menu["MaxOpts"], 9, 2);
                self addOptBool(self.menu["Instructions"], "Menu Instructions", ::SetMenuInstructions);
                self addOpt("Menu Colors", ::newMenu, "Menu Colors");
                self addOpt("Header", ::newMenu, "Header");
                self addOpt("Opacity", ::newMenu, "Opacity");
                self addOpt("Shaders", ::newMenu, "Shaders");
                self addOpt("Toggle Styles", ::newMenu, "Toggle Styles");
            break;

        case "Menu Colors":
            self addMenu("Menu Colors", "Menu Colors");
                for(i = 0; i <= level.huds.size; i++)
                {
                    self addOpt(level.hud_names[i], ::newMenu, level.hud_names[i]);
                }
            break;

        case "Opacity":
            self addMenu("Opacity", "Opacity");
                self addOptIntSlider("Title Opacity", ::SetTitleOpacity, 0, self.hudalpha["MenuTitle"], 1, 0.1);
                self addOptIntSlider("Header Opacity", ::SetHeaderOpacity, 0, self.hudalpha["LUI_Head"], 1, 0.1);
                self addOptIntSlider("Background Opacity", ::SetBackgroundOpacity, 0, self.hudalpha["Background"], 1, 0.1);
            break;

        case "Header":
            self addMenu("Header", "Header");
                self addOptBool(self.header_vision, "Header Vision", ::SetHeaderVision);
            break;

        case "Shaders":
            self addMenu("Shaders", "Shaders");
                self addOptBool(self.menu["ShaderRotation"], "Shader Spinning", ::DoShaderRotation);
                for(i = 0; i < level.shaderLists.size; i++)
                {
                    self addOpt(level.shaderLists[i], ::newMenu, "Shader List " + level.shaderLists[i]);
                }
            break;

        case "Toggle Styles":
            self addMenu("Toggle Styles", "Toggle Styles");
                self addOptSlider("Toggle Style", ::SetBoolStyle, "Checks;Text", self.menu["BoolStyle"]);
                self addOptSlider("Icon Style", ::SetBoolIconStyle, "Box;Arrow;Inst Kill;Dob Points;Fire Sale;Mask;Scavenger;Armor;Other", self.menu["BoolIconName"]);
                self addOptSlider("Inside Color", ::SetBoolColors, "Magenta;Teal;Laurel;Sky Blue;Aquamarine;Lime;Gold;Indigo;Maroon;Turquoise;Coral;Olive;Sapphire;Orchid;Amber;Gray;White Smoke;Black;Random Color", undefined, "Inside");
                self addOptSlider("Outline Color", ::SetBoolColors, "Magenta;Teal;Laurel;Sky Blue;Aquamarine;Lime;Gold;Indigo;Maroon;Turquoise;Coral;Olive;Sapphire;Orchid;Amber;Gray;White Smoke;Black;Random Color", undefined, "Outline");
                self addOptBool(self.testbool, "Bool Test", ::testbool, self);
                for(i = 0; i < (self.menu_Strings[self getCurrentMenu()].size - 1); i++)
                {
                    self iPrintLnBold(self.menu_Strings[self getCurrentMenu()][i]);
                }
            break;

       

        case "Host Menu":
            self addMenu("Host Menu", "Host Menu");
                self addOpt("Debug Exit", ::debugexit);
                self addOpt("Restart Game", ::RestartGame);
                self addOptBool((GetDvarString("ui_lobbyDebugVis") == "1"), "DevGui Info", ::DevGUIInfo);
                self addOpt("Revive", ::PlayerRevive, self);
                self addOpt("Down", ::PlayerDeath, "Down", self);
                self addOpt("Suicide", ::PlayerDeath, "Kill", self);
                self addOpt("Test Stuff", ::newMenu, "Test");
            break;
            
            
            
          

        case "Players Menu":
            self addMenu("Players Menu", "Players Menu");
                foreach(player in level.players)
                {
                    self.selected_player = undefined;
                    status = level.menuStatus[player getVerification()];
                    self addOpt("[" + verificationToColor(status) + "^7]" + CleanName(player getName()), ::newMenu, "Player Menu: " + player GetEntityNumber());
                    // self addOpt(level.players[i] + ((IsTestClient(level.players[i])) ? " (Bot)" : ""));
                }
            break;

        case "Verification":
            self addMenu("Verification " + player GetEntityNumber(), "Verification");
                for(a = 0; a < (level.menuStatus.size - 1); a++)
                    self addOptBool((player getVerification() == a), level.menuStatus[a], ::setVerification, a, player, true);
                if(player IsHost() && self IsHost())
                    self addOptBool((player getVerification() == a), level.menuStatus[level.menuStatus.size - 1], ::setVerification, 5, player, true);
            break;
            
                                default:
            nothingToShow = true;
            newmenu = self getCurrentMenu();
            // self iPrintLnBold(newmenu);
            for(i = 0; i <= level.hud_names.size; i++)
            {
                if(level.hud_names[i] == newmenu)
                {
                    nothingToShow = false;
                    HUD = "hud";
                    self addMenu(level.hud_names[i], level.hud_names[i]);
                    self addOptIntSlider("Fade Delay (Secs)", ::SetFadeDelay, 1, self.fadeDelay[level.huds[i]], 10, 1, level.huds[i]);
                    self addOptBool(self.RainbowActive[level.huds[i]], "Rainbow Fade", ::RainbowEffect, self.menu[HUD][level.huds[i]], self.fadeDelay[level.huds[i]], level.huds[i]);
                    self addOptBool(self.DarkRainbowActive[level.huds[i]], "Dark Rainbow Fade", ::DarkRainbowEffect, self.menu[HUD][level.huds[i]], self.fadeDelay[level.huds[i]], level.huds[i]);
                    self addOptBool(self.LightRainbowActive[level.huds[i]], "Light Rainbow Fade", ::LightRainbowEffect, self.menu[HUD][level.huds[i]], self.fadeDelay[level.huds[i]], level.huds[i]);
                    self addOptSlider("Random Rainbow", ::DoRandomRainbow, "Normal;Light;Dark", undefined, self.menu[HUD][level.huds[i]], self.fadeDelay[level.huds[i]], level.huds[i]);
                    for(a = 0; a <= level.colorNames.size; a++)
                    {
                        self addOpt(level.colorNames[a], ::ChangeHUDColor, self.menu[HUD][level.huds[i]], level.colors[a], level.huds[i]);
                    }
                    if(self IsHost())
                        self addOpt("Print HUD Color", ::printHudColor, level.huds[i]);
                }
            }

            if(isSubStr(newmenu, "Shader List "))
            {
                // self iPrintLnBold("Substring found for: ^5" + newmenu);
                nothingToShow = false;
                for(i = 0; i < level.shaderLists.size; i++)
                {
                    if("Shader List " + level.shaderLists[i] == newmenu)
                    {
                        self addMenu(newmenu, level.shaderLists[i]);
                        self addOpt("No Shader", ::SetCustomShader, undefined, true);
                        currArray = level.cShadersBiArray[i];
                        for(a = 0; a < currArray.size; a++)
                        {
                            self addOpt(CleanString(currArray[a]), ::SetCustomShader, currArray[a]);
                            // self addOpt(currArray[a], ::SetCustomShader, currArray[a]);
                        }
                    }
                }
            }

            if(isSubStr(newmenu, "Player Menu: "))
            {
                nothingToShow = false;
                foreach(selPlayer in level.players)
                {
                    if(newmenu == "Player Menu: " + selPlayer GetEntityNumber())
                        RunPlayerMenu(selPlayer, newmenu);
                }
            }

            if(nothingToShow)
            {
                self addMenu(newmenu, "No Options Found");
                    self addOpt("Nothing Here..");
            }
            break;

       
    }
}

RunPlayerMenu(player, menu)
{
    self.selected_player = player;  //  To be used in RunMenu
    playerMenus = ["Personal Options", "Gameplay", "Fun Scripts"];

    self addMenu(menu, CleanName(player getName()));
        if(self getVerification() >= 3)
            self addOpt("Verification", ::newMenu, "Verification" + " " + player GetEntityNumber());

        foreach(submenu in playerMenus)
            self addOpt(submenu, ::newMenu, submenu + " " + player GetEntityNumber());
        if(self IsHost() || self getVerification() >= 3)
        {
            self addOpt("Check Player Access", ::CheckPlayerAccess, player);
            self addOpt("Kick", ::KickPlayer, player);
            self addOpt("Revive", ::PlayerRevive, player);
            self addOpt("Down", ::PlayerDeath, "Down", player);
            self addOpt("Kill", ::PlayerDeath, "Kill", player);
        }
}