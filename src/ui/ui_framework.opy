rule "Menu Initialization: Set Static Global Variables":
    @Event global

    # Menu Colors

    #menu_color_label_header = Color.WHITE
    #menu_color_on_index = Color.SKY_BLUE
    menu_color_off_index = Color.WHITE

    menu_color_on_index = rgb(100,200,240) 
    menu_color_label_header = rgb(255,150,80)

    menu_colors_custom[0] = rgb(255,100,120)
    menu_colors_custom[1] = rgb(100,200,120)
    #menu_colors_custom[2] = rgb(240,120,100) 
    #menu_colors_custom[3] = rgb(230,190,60) 
    #menu_colors_custom[4] = rgb(110,150,250)


rule "Menu Input Listener: Toggle Menu":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_loaded != 0
    @Condition (user_controls[0] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[0]) or (user_controls[0] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[0]))

    wait(ui_delay, Wait.ABORT_WHEN_FALSE)

    if eventPlayer.menu_visible:
        eventPlayer.menu_visible = false
    else:
        eventPlayer.menu_visible = true


rule "Menu Input Listener: Menu Up": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[1] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[1]) or (user_controls[1] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[1]))

    menu_up_check()
    while eventPlayer.menu_item_hidden[eventPlayer.menu_index] :
        menu_up_check()

    update_help_data()
    wait(0.1, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Menu Input Listener: Menu Down":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[2] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[2]) or (user_controls[2] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[2]))

    menu_down_check()
    while eventPlayer.menu_item_hidden[eventPlayer.menu_index] :
        menu_down_check()

    update_help_data()
    wait(0.1, Wait.ABORT_WHEN_FALSE)
    if RULE_CONDITION:
        goto RULE_START


rule "Menu Input Listener: Step Left": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[3] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[3]) or (user_controls[3] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[3]))

    eventPlayer.menu_action = MENU_ACTIONS.MENU_STEP_LEFT
    perform_action()


rule "Menu Input Listener: Step Right": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[4] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[4]) or (user_controls[4] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[4]))

    eventPlayer.menu_action = MENU_ACTIONS.MENU_STEP_RIGHT
    perform_action()


rule "Menu Input Listener: Jump Left": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[5] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[5]) or (user_controls[5] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[5]))

    eventPlayer.menu_action = MENU_ACTIONS.MENU_JUMP_LEFT
    perform_action()


rule "Menu Input Listener: Jump Right": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[6] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[6]) or (user_controls[6] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[6]))

    eventPlayer.menu_action = MENU_ACTIONS.MENU_JUMP_RIGHT
    perform_action()


rule "Menu Input Listener: Previous Subitem": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[7] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[7]) or (user_controls[7] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[7]))

    if eventPlayer.subitem_index[eventPlayer.menu_index] > 0:
        eventPlayer.subitem_index[eventPlayer.menu_index] -= 1
    else:
        eventPlayer.subitem_index[eventPlayer.menu_index] = eventPlayer.subitem_size[eventPlayer.menu_index]

    update_help_data()


rule "Menu Input Listener: Next Subitem": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[8] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[8]) or (user_controls[8] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[8]))

    if eventPlayer.subitem_index[eventPlayer.menu_index] < eventPlayer.subitem_size[eventPlayer.menu_index]:
        eventPlayer.subitem_index[eventPlayer.menu_index] += 1
    else:
        eventPlayer.subitem_index[eventPlayer.menu_index] = 0

    update_help_data()


rule "Menu Input Listener: Set Vector": 
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 
    @Condition (user_controls[9] <= INPUT_OPTIONS.VECT_RIGHT and eventPlayer.getThrottle() == ui_inputs[9]) or (user_controls[9] > INPUT_OPTIONS.VECT_RIGHT and eventPlayer.isHoldingButton(ui_inputs[9]))

    eventPlayer.menu_action = MENU_ACTIONS.MENU_SET_VECTOR
    perform_action()


rule "Menu Controls: Toggle On Setup":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible 

    disable_player_input()

    
rule "Menu Controls: Toggle Off Setup Player":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.menu_visible == false

    eventPlayer.player_speed = 100
    enable_player_input()


def menu_up_check():
    @Name "SUB: menu_up_check"

    # If the menu index is equal to the start of the submenu start location
    if eventPlayer.menu_index - eventPlayer.submenu_start_indexes[eventPlayer.submenu_index] <= 0:
        # then loop to the end of the submenu
        eventPlayer.menu_index = eventPlayer.submenu_start_indexes[eventPlayer.submenu_index+1] - 1
    else:
        # otherwise move up 1 on the menu.
        eventPlayer.menu_index -= 1


def menu_down_check():
        @Name "SUB: menu_down_check"    

    # If the menu index is equal to the end of our submenu
    if eventPlayer.menu_index >= eventPlayer.submenu_start_indexes[eventPlayer.submenu_index+1] - 1:
        # then loop to the start of the submenu
        eventPlayer.menu_index = eventPlayer.submenu_start_indexes[eventPlayer.submenu_index]
    else:
        # then move down 1 on the menu.
        eventPlayer.menu_index += 1


def create_help_hud():
    @Name "SUB: create_help_hud"
    # Displays the left HUD menu help.
    eventPlayer.menu_help_index = help_data[HELP_TYPE.DEFAULT]
    
    eventPlayer.menu_help_display = [   
                            strings_help[lang_type][0][eventPlayer.menu_help_index[0]], 
                            strings_help[lang_type][1][eventPlayer.menu_help_index[1]], 
                            strings_help[lang_type][2][eventPlayer.menu_help_index[2]], 
                            strings_help[lang_type][3][eventPlayer.menu_help_index[3]], 
                            strings_help[lang_type][4][eventPlayer.menu_help_index[4]], 
                            strings_help[lang_type][5][eventPlayer.menu_help_index[5]], 
                            strings_help[lang_type][6][eventPlayer.menu_help_index[6]], 
                            strings_help[lang_type][7][eventPlayer.menu_help_index[7]], 
                            strings_help[lang_type][8][eventPlayer.menu_help_index[8]],
                            strings_help[lang_type][9][eventPlayer.menu_help_index[9]],
                        ]

    hudSubheader([i for i in localPlayer], 
    "{0}{1}{2}{3}{4}{5}{6}{7}{8}{9}{10}{11}{12}".format("{0} {1} {2} {3} {4}\n".format(strings_prompt[lang_type][0] if ui_delay > 0 else strings_prompt[lang_type][1], strings_inputs[lang_type][user_controls[0]] if user_controls[0] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[0]), strings_prompt[lang_type][2], strings_prompt[lang_type][3] if eventPlayer.menu_visible else strings_prompt[lang_type][4], strings_prompt[lang_type][5]), 
        strings_symbols[0], 
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[1]] if user_controls[1] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[1]), eventPlayer.menu_help_display[0]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[2]] if user_controls[2] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[2]), eventPlayer.menu_help_display[1]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[3]] if user_controls[3] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[3]), eventPlayer.menu_help_display[2]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[4]] if user_controls[4] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[4]), eventPlayer.menu_help_display[3]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[5]] if user_controls[5] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[5]), eventPlayer.menu_help_display[4]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[6]] if user_controls[6] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[6]), eventPlayer.menu_help_display[5]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[7]] if user_controls[7] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[7]), eventPlayer.menu_help_display[6]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[8]] if user_controls[8] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[8]), eventPlayer.menu_help_display[7]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[9]] if user_controls[9] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[9]), eventPlayer.menu_help_display[8]) if eventPlayer.menu_visible else "",
        "{0} : {1}\n".format(strings_inputs[lang_type][user_controls[10]] if user_controls[10] <= INPUT_OPTIONS.VECT_RIGHT else buttonString(ui_inputs[10]), eventPlayer.menu_help_display[9]) if eventPlayer.menu_visible else "",
        strings_symbols[0] if eventPlayer.menu_visible else ""),
        HudPosition.LEFT,
        -1,
        Color.WHITE,
        HudReeval.VISIBILITY_AND_STRING,
        SpecVisibility.DEFAULT)


def update_help_data():
    @Name "SUB: update_help_data"

    eventPlayer.menu_help_index = eventPlayer.menu_item_help[eventPlayer.menu_index]
    for eventPlayer.help_index in range(0, len(strings_help[lang_type]), 1):
        if (eventPlayer.help_index == 2 or eventPlayer.help_index == 3) and (eventPlayer.menu_help_index[eventPlayer.help_index] == 1 or eventPlayer.menu_help_index[eventPlayer.help_index] == 2):
            eventPlayer.menu_help_display[eventPlayer.help_index] = "{0}{1}".format(strings_help[lang_type][eventPlayer.help_index][eventPlayer.menu_help_index[eventPlayer.help_index]], small_steps[eventPlayer.menu_item_small_step[eventPlayer.menu_index][eventPlayer.subitem_index[eventPlayer.menu_index]]])
        elif (eventPlayer.help_index == 4 or eventPlayer.help_index == 5) and (eventPlayer.menu_help_index[eventPlayer.help_index] == 1 or eventPlayer.menu_help_index[eventPlayer.help_index] == 2):
            eventPlayer.menu_help_display[eventPlayer.help_index] = "{0}{1}".format(strings_help[lang_type][eventPlayer.help_index][eventPlayer.menu_help_index[eventPlayer.help_index]], large_steps[eventPlayer.menu_item_large_step[eventPlayer.menu_index][eventPlayer.subitem_index[eventPlayer.menu_index]]])
        else:
            eventPlayer.menu_help_display[eventPlayer.help_index] = strings_help[lang_type][eventPlayer.help_index][eventPlayer.menu_help_index[eventPlayer.help_index]]


def setup_menu():
    @Name "SUB: setup_menu"

    # Default Menu Variables
    eventPlayer.submenu_index = 0
    eventPlayer.submenu_start_indexes[0] = 0
    eventPlayer.submenu_start_indexes[1] = 1
    eventPlayer.menu_max_pos = -1
    eventPlayer.menu_label_size = -1
    eventPlayer.menu_item_size = -1
    eventPlayer.submenu_size = 0

    
def enable_player_input():
    @Name "SUB: enable_player_input"

    eventPlayer.allowButton(Button.INTERACT)
    eventPlayer.allowButton(Button.JUMP)
    eventPlayer.allowButton(Button.CROUCH)
    eventPlayer.allowButton(Button.MELEE)
    eventPlayer.allowButton(Button.PRIMARY_FIRE)
    eventPlayer.allowButton(Button.SECONDARY_FIRE)
    eventPlayer.allowButton(Button.RELOAD)
    eventPlayer.allowButton(Button.ABILITY_1)
    eventPlayer.allowButton(Button.ABILITY_2)
    eventPlayer.allowButton(Button.ULTIMATE)
    eventPlayer.setMoveSpeed(eventPlayer.player_speed)


def disable_player_input():
    @Name "SUB: disable_player_input"

    eventPlayer.disallowButton(Button.INTERACT)
    eventPlayer.disallowButton(Button.JUMP)
    eventPlayer.disallowButton(Button.CROUCH)
    eventPlayer.disallowButton(Button.MELEE)
    eventPlayer.disallowButton(Button.PRIMARY_FIRE)
    eventPlayer.disallowButton(Button.SECONDARY_FIRE)
    eventPlayer.disallowButton(Button.RELOAD)
    eventPlayer.disallowButton(Button.ABILITY_1)
    eventPlayer.disallowButton(Button.ABILITY_2)
    eventPlayer.disallowButton(Button.ULTIMATE)
    eventPlayer.setMoveSpeed(0)


def increment_for_menu_label():
    @Name "SUB: increment_menu_label"

    eventPlayer.menu_max_pos += 1
    eventPlayer.menu_label_size += 1
    eventPlayer.menu_label_color[eventPlayer.menu_label_size] = menu_color_label_header

    
def increment_for_menu_item():
    @Name "SUB: increment_for_menu_item"

    eventPlayer.menu_max_pos += 1
    eventPlayer.menu_item_size += 1
    eventPlayer.submenu_start_indexes[eventPlayer.submenu_size+1] = eventPlayer.menu_item_size+1
    eventPlayer.menu_item_color_off[eventPlayer.menu_item_size] = menu_color_off_index
    eventPlayer.menu_item_color_on[eventPlayer.menu_item_size] = menu_color_on_index
    eventPlayer.subitem_index[eventPlayer.menu_item_size] = 0
    eventPlayer.subitem_size[eventPlayer.menu_item_size] = 0

    eventPlayer.menu_item_var_tags[eventPlayer.menu_item_size] = ["", "", "", ""]
    eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = ""
    eventPlayer.menu_item_var_2[eventPlayer.menu_item_size] = ""
    eventPlayer.menu_item_var_3[eventPlayer.menu_item_size] = ""
    eventPlayer.menu_item_var_4[eventPlayer.menu_item_size] = ""
    eventPlayer.menu_item_help[eventPlayer.menu_item_size] = help_data[HELP_TYPE.DEFAULT]


def increment_for_submenu_item():
    @Name "SUB: increment_for_new_submenu"

    eventPlayer.menu_max_pos = -1
    eventPlayer.submenu_size += 1


def new_menu_label_header():
    @Name "SUB: new_menu_label_header"

    hudHeader([i for i in localPlayer if eventPlayer.menu_visible
        and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size)
        and eventPlayer.menu_label_hidden[evalOnce(eventPlayer.menu_label_size)] != true], 
    "{0}".format(eventPlayer.menu_label[evalOnce(eventPlayer.menu_label_size)]),
    HudPosition.TOP,
    evalOnce(eventPlayer.menu_max_pos),
    eventPlayer.menu_label_color[evalOnce(eventPlayer.menu_label_size)],
    HudReeval.VISIBILITY_STRING_AND_COLOR,
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_label_subheader():
    @Name "SUB: new_menu_label_subheader"

    hudSubheader([i for i in localPlayer if eventPlayer.menu_visible
        and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size)
        and eventPlayer.menu_label_hidden[evalOnce(eventPlayer.menu_label_size)] != true], 
    "{0}".format(eventPlayer.menu_label[evalOnce(eventPlayer.menu_label_size)]),
    HudPosition.TOP,
    evalOnce(eventPlayer.menu_max_pos),
    eventPlayer.menu_label_color[evalOnce(eventPlayer.menu_label_size)],
    HudReeval.VISIBILITY_STRING_AND_COLOR,
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_label_subtext():
    @Name "SUB: new_menu_label_subtext"

    hudSubtext([i for i in localPlayer if eventPlayer.menu_visible
        and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size)
        and eventPlayer.menu_label_hidden[evalOnce(eventPlayer.menu_label_size)] != true], 
    "{0}".format(eventPlayer.menu_label[evalOnce(eventPlayer.menu_label_size)]),
    HudPosition.TOP,
    evalOnce(eventPlayer.menu_max_pos),
    eventPlayer.menu_label_color[evalOnce(eventPlayer.menu_label_size)],
    HudReeval.VISIBILITY_STRING_AND_COLOR,
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())
    

def new_menu_item_selection():
    @Name "SUB: new_menu_item_selection"

    hudSubheader(
    localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else "■  {0}".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)]), 
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos),
     eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_item_toggle():
    @Name "SUB: new_menu_item_toggle"

    hudSubheader(localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else "■  {0}: {1}".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)]), 
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos), 
    eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_item_cycle():
    @Name "SUB: new_menu_item_cycle"

    hudSubheader(localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) 
    else "■ {0} ←  {1}  → ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)]), 
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos), 
    eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())
    

def new_menu_item_percentage():
    @Name "SUB: new_menu_item_percentage"

    hudSubheader(localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) 
    else "■ {0} ←  {1}%  → ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)]), 
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos), 
    eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_item_toggle_list():
    @Name "SUB: new_menu_item_toggle_list"

    hudSubheader(localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) 
    else "■ {0}    ←  {1}  →    {2}    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)]), 
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos), 
    eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_item_2var():
    @Name "SUB: new_menu_item_2var"

    eventPlayer.subitem_size[eventPlayer.menu_item_size] = 1

    hudSubheader(localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) 
    else "■ {0}    ←  {1}{2}  →    {3}{4}    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)])  if eventPlayer.subitem_index[evalOnce(eventPlayer.menu_item_size)] == 0
    else "■ {0}    {1}{2}  ←    {3}{4}  →    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)]),
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos), 
    eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_item_3var():
    @Name "SUB: new_menu_item_3var"

    eventPlayer.subitem_size[eventPlayer.menu_item_size] = 2

    hudSubheader(localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) 
    else "■ {0}    ←  {1}{2}  →    {3}{4}    {5}{6}    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][2], eventPlayer.menu_item_var_3[evalOnce(eventPlayer.menu_item_size)])  if eventPlayer.subitem_index[evalOnce(eventPlayer.menu_item_size)] == 0
    else "■ {0}    {1}{2}    ←  {3}{4}  →    {5}{6}    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][2], eventPlayer.menu_item_var_3[evalOnce(eventPlayer.menu_item_size)])  if eventPlayer.subitem_index[evalOnce(eventPlayer.menu_item_size)] == 1
    else "■ {0}    {1}{2}    {3}{4}    ←  {5}{6}  →    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][2], eventPlayer.menu_item_var_3[evalOnce(eventPlayer.menu_item_size)]),
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos), 
    eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())


def new_menu_item_4var():
    @Name "SUB: new_menu_item_3var"

    eventPlayer.subitem_size[eventPlayer.menu_item_size] = 3

    hudSubheader(localPlayer if eventPlayer.menu_visible and eventPlayer.submenu_index == evalOnce(eventPlayer.submenu_size) and eventPlayer.menu_item_hidden[evalOnce(eventPlayer.menu_item_size)] != true else [],
    "{0}".format(eventPlayer.menu_item_title_off[evalOnce(eventPlayer.menu_item_size)]) if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) 
    else "■ {0}     ←  {1}{2}  →    {3}{4}    {5}{6}    {7}{8}    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][2], eventPlayer.menu_item_var_3[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][3], eventPlayer.menu_item_var_4[evalOnce(eventPlayer.menu_item_size)])  if eventPlayer.subitem_index[evalOnce(eventPlayer.menu_item_size)] == 0
    else "■ {0}     {1}{2}    ←  {3}{4}  →    {5}{6}    {7}{8}    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][2], eventPlayer.menu_item_var_3[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][3], eventPlayer.menu_item_var_4[evalOnce(eventPlayer.menu_item_size)])  if eventPlayer.subitem_index[evalOnce(eventPlayer.menu_item_size)] == 1
    else "■ {0}     {1}{2}    {3}{4}    ←  {5}{6}  →    {7}{8}    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][2], eventPlayer.menu_item_var_3[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][3], eventPlayer.menu_item_var_4[evalOnce(eventPlayer.menu_item_size)])  if eventPlayer.subitem_index[evalOnce(eventPlayer.menu_item_size)] == 2
    else "■ {0}     {1}{2}    {3}{4}    {5}{6}    ←  {7}{8}  →    ".format(eventPlayer.menu_item_title_on[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][0], eventPlayer.menu_item_var_1[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][1], eventPlayer.menu_item_var_2[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][2], eventPlayer.menu_item_var_3[evalOnce(eventPlayer.menu_item_size)], eventPlayer.menu_item_var_tags[evalOnce(eventPlayer.menu_item_size)][3], eventPlayer.menu_item_var_4[evalOnce(eventPlayer.menu_item_size)]),
    HudPosition.TOP, 
    evalOnce(eventPlayer.menu_max_pos), 
    eventPlayer.menu_item_color_off[evalOnce(eventPlayer.menu_item_size)] if eventPlayer.menu_index != evalOnce(eventPlayer.menu_item_size) else eventPlayer.menu_item_color_on[evalOnce(eventPlayer.menu_item_size)], 
    HudReeval.VISIBILITY_STRING_AND_COLOR, 
    SpecVisibility.DEFAULT)
    eventPlayer.menu_hudtexts.append(getLastCreatedText())