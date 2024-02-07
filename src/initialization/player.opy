rule "Player Joined: Disable GameHUD":
    @Event playerJoined
    @Team 1

    eventPlayer.disableGamemodeHud()
    eventPlayer.lang_type = lang_type


rule "Player Spawned: Setup Host":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.hasSpawned() 

    # Allow player to use inputs
    enable_player_input()
    # Make player unkillable by default.
    eventPlayer.setStatusEffect(eventPlayer, Status.INVINCIBLE, 9999)
    

rule "Fast Restart Not Versus":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer == hostPlayer
    @Condition scenario_type != GAME_TYPES.VERSUS
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    restart_scenario()


rule "Fast Restart Versus":
    @Event eachPlayer
    @Team 1
    @Condition scenario_type == GAME_TYPES.VERSUS
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)
    @Condition eventPlayer.isHoldingButton(Button.MELEE)

    restart_versus_scenario()
