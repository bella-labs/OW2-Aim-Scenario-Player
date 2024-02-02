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
        scenario_index = 0
        scenario = scenarios[scenario_index]
    else:
        load_missing_data_message()

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())


def load_missing_data_message():
    @Name "SUB: load_missing_data_message"

    