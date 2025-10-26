//Functions
Godmode(player)
{
    if(isDefined(player.DemiGod))
        player DemiGod(player);

    player.godmode = isDefined(player.godmode) ? undefined : true;

    if(isDefined(player.godmode))
    {
        player endon("disconnect");
        player EnableInvulnerability();
        
        if(player IsHost())
            player.godModeCalled = true;
    }
    else
    {
        player DisableInvulnerability();
        if(player IsHost())
        {
            player.godModeCalled = false;
        }
    }
}

DemiGod(player)
{
    if(isDefined(player.godmode))
        player Godmode(player);

    player.DemiGod = isDefined(player.DemiGod) ? undefined : true;
}

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
