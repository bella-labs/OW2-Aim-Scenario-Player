rule "Load Import Bot":
    @Event global

    createDummy(Hero.ECHO, Team.1, 11, vect(0,9999,0), vect(0,1,0))
    

rule "Load Scenario Data":
    @Event eachPlayer
    @Team 1
    @Slot 11
    @Condition eventPlayer.isDummy() 
    @Condition eventPlayer.hasSpawned()

    eventPlayer.export_data = null
    import_settings()
    if eventPlayer.scenario_names != null:
        scenario_names = eventPlayer.scenario_names
    if eventPlayer.scenario_authors != null:
        scenario_authors = eventPlayer.scenario_authors
    if eventPlayer.export_data != null:
        scenarios = eventPlayer.export_data
        scenario = scenarios[scenario_index]
    else:
        bad_data = true

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())


rule "Display Error for BAD DATA":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition bad_data == true

    waitUntil(hostPlayer.isAlive(), 9999)
    hudHeader(hostPlayer, "NO SCENARIO DATA LOADED", HudPosition.TOP, -9999, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
