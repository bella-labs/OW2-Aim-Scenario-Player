def perform_action():
    @Name "SUB: perform_action"

    eventPlayer.submenu_curr_start = eventPlayer.submenu_start_indexes[eventPlayer.submenu_index]
    eventPlayer.menu_wait_index = 0

    switch eventPlayer.submenu_index:
        case SUBMENUS.SUBMENU_MAIN:
            if eventPlayer.menu_type == MENU_TYPE.HOST:
                menu_act_host_main()
            else:
                menu_act_player_main()
            break

    if (user_controls[10] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[10]) or (user_controls[10] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[10])):
        eventPlayer.menu_wait_index = 2

    wait(menu_wait[eventPlayer.menu_wait_index])

    if RULE_CONDITION:
        goto RULE_START
        

def menu_act_host_main():
    @Name "SUB: menu_act_host_main"

    switch eventPlayer.menu_index:
        case eventPlayer.submenu_curr_start + 0:
            act_main_host_start()
            break
        case eventPlayer.submenu_curr_start + 1:
            act_main_host_sel_sce()
            break
        case eventPlayer.submenu_curr_start + 2:
            act_main_host_sel_type()
            break
        case eventPlayer.submenu_curr_start + 3:
            act_main_open_hero_sel()
            break
        case eventPlayer.submenu_curr_start + 4:
            act_main_sel_lang()
            break




def menu_act_player_main():
    @Name "SUB: menu_act_player_main"
    
    switch eventPlayer.menu_index:
        case eventPlayer.submenu_curr_start + 0:
            act_main_player_start()
            break
        case eventPlayer.submenu_curr_start + 1:
            act_main_open_hero_sel()
            break
        case eventPlayer.submenu_curr_start + 2:
            act_main_sel_lang()
            break


