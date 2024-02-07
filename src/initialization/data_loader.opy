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
        data_loaded[DATA_TYPE.SCENARIO] = 1
    else:
        data_loaded[DATA_TYPE.SCENARIO] = -1

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())


rule "Display Error for No Data Read":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition data_loaded[DATA_TYPE.SCENARIO] == -1

    hudHeader(hostPlayer, "NO SCENARIO DATA LOADED", HudPosition.TOP, -9999, Color.RED, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)




rule "Load Scenario Bots":
    @Event global
    @Condition data_loaded[DATA_TYPE.SCENARIO] == 1

    load_scenario_bots()


def load_scenario_bots():
    @Name "SUB: load_scenario_bots"

    scenario_bot = null
    scenario_bot_index = 0
    for bot_gen_slot in range(0, 12):
        if scenario[SCE_DATA.BOT_SLOT_STATUS][bot_gen_slot]:
            create_target_bot()
            scenario_bot_index += 1

    scenario_bot_index = len(scenario_bot)
    if scenario[SCE_DATA.SCE_SPAWN_ORDER] == 1:
        show_next_bot()


def show_next_bot():
    @Name "SUB: show_next_bot"

    scenario_bot[scenario_bot_index].setInvisibility(Invis.ALL)
    scenario_bot[scenario_bot_index].setStatusEffect(null, Status.PHASED_OUT, 9999)
    scenario_bot_index += 1
    if scenario_bot_index >= len(scenario_bot):
        scenario_bot_index = 0
    scenario_bot[scenario_bot_index].setInvisibility(Invis.NONE)
    scenario_bot[scenario_bot_index].clearStatusEffect(Status.PHASED_OUT)