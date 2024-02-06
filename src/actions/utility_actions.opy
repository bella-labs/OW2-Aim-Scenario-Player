def act_general_change_list():
    @Name "SUB: act_general_change_list"

    eventPlayer.action_result = eventPlayer.action_var
    switch eventPlayer.menu_action:
        case MENU_ACTIONS.MENU_STEP_LEFT:
        case MENU_ACTIONS.MENU_JUMP_LEFT:
            eventPlayer.action_result -= 1
            break
        case MENU_ACTIONS.MENU_STEP_RIGHT:
        case MENU_ACTIONS.MENU_JUMP_RIGHT:
            eventPlayer.action_result += 1
            break

    if eventPlayer.action_result < 0:
        eventPlayer.action_result = len(strings_options[eventPlayer.lang_type][eventPlayer.action_var_3])-1
    elif eventPlayer.action_result >= len(strings_options[eventPlayer.lang_type][eventPlayer.action_var_3]):
        eventPlayer.action_result = 0


def act_general_change_list_var_1():
    @Name "SUB: act_general_change_list_var_1"

    act_general_change_list()
    eventPlayer.menu_item_var_1[eventPlayer.action_var_2] = strings_options[eventPlayer.lang_type][eventPlayer.action_var_3][eventPlayer.action_result]
