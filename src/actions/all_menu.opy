def act_main_sel_lang():
    @Name "SUB: act_main_sel_lang"

    eventPlayer.action_var = eventPlayer.lang_type
    eventPlayer.action_var_2 = eventPlayer.menu_index
    eventPlayer.action_var_3 = OPTIONS_TYPE.LANG
    act_general_change_list_var_1()
    eventPlayer.lang_type = eventPlayer.action_result
    if eventPlayer.action_var != eventPlayer.action_result:
        update_language()
    

def act_main_open_hero_sel():
    @Name "SUB: act_main_open_hero_sel"

    eventPlayer.setAllowedHeroes(eventPlayer.getAllowedHeroes().exclude(eventPlayer.getCurrentHero()))
    eventPlayer.resetHeroAvailability()
    eventPlayer.menu_visible = false


def act_main_player_start():
    @Name "SUB: act_main_player_start"

    if game_type != 2:
        smallMessage(hostPlayer, "    {0} {1}".format(eventPlayer, strings_misc[hostPlayer.lang_type][3]))
    else:
        start_player_scenario()
    
