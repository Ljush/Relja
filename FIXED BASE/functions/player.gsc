PlayerDeath(type, player)
{
    if(isDefined(player.godmode))
        player Godmode(player);

    if(player HasMenu() || player isInMenu())
        player CloseMenu();
    player DisableInvulnerability(); 

    if(!Is_Alive(player))
        return self iPrintlnBold("^1ERROR: ^7Player Isn't Alive");
    
    wait 0.1;
    
    switch(type)
    {
        case "Down":
            if(player IsHost() && player != self)
                return self iPrintlnBold("^1Error: ^7You Can't Down The Host");
            
            if(player IsDown())
                return self iPrintlnBold("^1ERROR: ^7Player Is Already Down");

            if(player getVerification() >= self getVerification() && !self IsHost())
                return self iPrintlnBold("^1Error: ^7Can't Down Players with = or Greater Access Level Than Yours");
            
            player DoDamage(player.health + 999, (0, 0, 0));
            break;
        
        case "Kill":
            if(player IsHost() && player != self)
                return self iPrintlnBold("^1Error: ^7You Can't Kill The Host");

            if(player getVerification() >= self getVerification() && !self IsHost())
                return self iPrintlnBold("^1Error: ^7Can't Kill Players with = or Greater Access Level Than Yours");

            if(!player IsDown())
            {
                player DoDamage(player.health + 999, (0, 0, 0));
                wait 1.5;
            }
            
            if(player IsDown())
            {
                player.bleedout_time = 0.5;
                player notify("bled_out");
                player zm_laststand::bleed_out();
            }
            break;
        
        default:
            break;
    }
}

PlayerRevive(player)
{
    if(!player isDown())
        return;

    // remote_revive        VER

    player zm_laststand::auto_revive(player);
}

PlayerAutoRevive(player)
{ 
    player endon("disconnect");
    player endon("end_auto_revive");

    player.AutoRevive = isDefined(player.AutoRevive) ? undefined : true;
    
    if(isDefined(player.AutoRevive))
    {
        if(IsDefined(player.reviveTrigger))
            player zm_laststand::auto_revive(player);
        while(isDefined(player.AutoRevive))
        {
            player waittill("player_downed");
            player zm_laststand::auto_revive(player);
        }
    }
    else 
        player notify("end_auto_revive");
}

PlayerRespawn(player)
{
    if(IsDefined(player.reviveTrigger))
        return player zm_laststand::auto_revive(player);
    
    if(IsAlive(player))
        return;

    player [[level.spawnPlayer]]();
    player FreezeControls(false);
}

KickPlayer(player)
{
    if(player IsHost())
        return self iPrintlnBold("^1Error: ^7You Can't Kick The Host");
    
    if(player == self)
        return self iPrintlnBold("^1Error: ^7You Can't Kick Yourself");
    
    if(player getVerification() >= self getVerification())
        return self iPrintlnBold("^1Error: ^7Can't Kick Players with = or Greater Access Level Than Yours");
    
    Kick(player GetEntityNumber(), "EXE_PLAYERKICKED_NOTSPAWNED");
}

SuperSpeedLoop()
{
    self endon("disconnect");
    self endon("death");
    self endon("end_super_speed");

    while(isDefined(self.SuperSpeed))
    {
        // Get current velocity
        velocity = self GetVelocity();

        // Only work with horizontal (ground) movement
        vel_2d = (velocity[0], velocity[1], 0);
        speed_2d = length(vel_2d);

        // Only boost if player is actually moving
        if(speed_2d > 10)
        {
            // Set speed cap to prevent going too fast
            maxSpeed = 350;

            if(speed_2d < maxSpeed)
            {
                // Get normalized direction of movement
                direction = VectorNormalize(vel_2d);

                // Add constant boost in movement direction (not multiply)
                boost_amount = 12;
                boost_vector = (direction[0] * boost_amount, direction[1] * boost_amount, 0);

                // Apply boosted velocity (keep vertical velocity unchanged)
                self SetVelocity((velocity[0] + boost_vector[0], velocity[1] + boost_vector[1], velocity[2]));
            }
        }

        wait 0.05;
    }
}

SuperSpeed(player)
{
    player endon("disconnect");

    player.SuperSpeed = isDefined(player.SuperSpeed) ? undefined : true;

    if(isDefined(player.SuperSpeed))
    {
        player thread SuperSpeedLoop();
        player iPrintLnBold("Super Speed ^2ON");
    }
    else
    {
        player notify("end_super_speed");
        player iPrintLnBold("Super Speed ^1OFF");
    }
}

SuperJump(player)
{
    player endon("disconnect");

    player.SuperJump = isDefined(player.SuperJump) ? undefined : true;

    if(isDefined(player.SuperJump))
    {
        player SetPlayerCollisionHeight(200);
        player iPrintLnBold("Super Jump ^2ON");
    }
    else
    {
        player SetPlayerCollisionHeight(39);
        player iPrintLnBold("Super Jump ^1OFF");
    }
}

SetJumpHeight(height)
{
    if(!isDefined(height))
        height = 39;

    self SetPlayerCollisionHeight(height);
    self iPrintLnBold("Jump Height: ^3" + height);
}
