def act_main_sel_lang():
    @Name "SUB: act_main_sel_lang"

    eventPlayer.lang_type = eventPlayer.action_result
    

def act_main_open_hero_sel():
    @Name "SUB: act_main_open_hero_sel"

    eventPlayer.setAllowedHeroes(eventPlayer.getAllowedHeroes().exclude(eventPlayer.getCurrentHero()))
    eventPlayer.resetHeroAvailability()
    eventPlayer.menu_visible = false


def act_main_player_start():
    @Name "SUB: act_main_player_start"

    switch lang_type:
        case 0:
            smallMessage(hostPlayer, "    {0} {1}".format(eventPlayer, strings_misc[0][2]))
            break
        case 1:
            smallMessage(hostPlayer, "    {0} {1}".format(eventPlayer, strings_misc[1][2]))
            break
        case 2:
            smallMessage(hostPlayer, "    {0} {1}".format(eventPlayer, strings_misc[2][2]))
            break
    
