def act_main_host_sel_sce():
    @Name "SUB: act_main_host_sel_sce"

    scenario_index += 1
    if scenario_index >= len(scenarios):
        scenario_index = 0
    scenario = scenarios[scenario_index]


def act_main_host_sel_type():
    @Name "SUB: act_main_host_sel_type"

    eventPlayer.action_var = game_type
    eventPlayer.action_var_2 = eventPlayer.menu_index
    eventPlayer.action_var_3 = OPTIONS_TYPE.MODE
    act_general_change_list_var_1()
    game_type = eventPlayer.action_result
    if eventPlayer.action_var != eventPlayer.action_result:
        if eventPlayer.action_var != 2:
            stop_scenario()
        else:
            stop_player_scenario()


def act_main_host_start():
    @Name "SUB: act_main_host_start"

    if eventPlayer.player_scenario_status:
        if game_type != 2:
            stop_scenario()
        else:
            stop_player_scenario()
        eventPlayer.menu_item_title_off[0] = strings_host_menu[eventPlayer.lang_type][2]
    else:
        
        if game_type != 2:
            start_scenario()
        else:
            start_player_scenario()
        eventPlayer.menu_item_title_off[0] = strings_host_alt[eventPlayer.lang_type][0]
            
    eventPlayer.menu_item_title_on[0] = eventPlayer.menu_item_title_off[0]
    


