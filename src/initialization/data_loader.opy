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
        display_missing_data_msg()

    destroyDummy(eventPlayer.getTeam(), eventPlayer.getSlot())


def display_missing_data_msg():
    @Name "SUB: display_missing_data_msg"

    increment_for_menu_label()
    eventPlayer.menu_label[0] = strings_msg[eventPlayer.lang_type][1]
    new_menu_label_subheader()
