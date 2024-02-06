rule "Menu Setup: Create Host Menu":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.menu_type == MENU_TYPE.NONE
    @Condition data_loaded[DATA_TYPE.STATIC]

    create_stats_hud()
    create_help_hud()

    setup_menu()

    create_host_menu()

    eventPlayer.menu_type = MENU_TYPE.HOST
    eventPlayer.menu_visible = false


rule "Menu Setup: Create Non-Host Menu":
    @Event eachPlayer
    @Condition eventPlayer != hostPlayer
    @Condition eventPlayer.menu_type == MENU_TYPE.NONE
    @Condition data_loaded[DATA_TYPE.STATIC] 

    create_stats_hud()
    create_help_hud()

    setup_menu()

    create_player_menu()

    eventPlayer.menu_type = MENU_TYPE.HOST
    eventPlayer.menu_visible = false


rule "Menu Setup: Manage Player -> Host Change":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.menu_type == MENU_TYPE.PLAYER
    @Condition data_loaded[DATA_TYPE.STATIC] 

    destroy_menu()

    setup_menu()

    create_host_menu()

    eventPlayer.menu_type = MENU_TYPE.HOST
    eventPlayer.menu_visible = false


rule "Menu Setup: Manage Host -> Player Change":
    @Event eachPlayer
    @Condition eventPlayer != hostPlayer
    @Condition eventPlayer.menu_type == MENU_TYPE.HOST
    @Condition data_loaded[DATA_TYPE.STATIC] 

    destroy_menu()

    setup_menu()

    create_player_menu()

    eventPlayer.menu_type = MENU_TYPE.PLAYER
    eventPlayer.menu_visible = false


def create_stats_hud():
    @Name "SUB: create_stats_hud"

    hudSubtext(localPlayer, scenario_names[scenario_index], HudPosition.RIGHT, -9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    hudSubheader(localPlayer, "{0}{1}\n".format(strings_misc[eventPlayer.lang_type][5], scenario_authors[scenario_index]), HudPosition.RIGHT, -9998, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)

    hudSubheader([i for i in localPlayer if localPlayer.menu_visible],
    "\n{0}{1}\n\n---------------------\n{2}\n---------------------\n\n{3}\n{4}\n{5}\n{6}\n{7}\n{8}\n{9}\n{10}\n{11}\n{12}\n{13}\n{14}\n{15}\n{16}\n{17}\n{18}\n{19}\n{20}\n{21}".format(
            strings_misc[eventPlayer.lang_type][1], 
            localPlayer.high_score,
            strings_misc[localPlayer.lang_type][4],
            localPlayer.stat_data[0] if localPlayer.stat_data[0] != null else "",
            localPlayer.stat_data[1] if localPlayer.stat_data[1] != null else "",
            localPlayer.stat_data[2] if localPlayer.stat_data[2] != null else "",
            localPlayer.stat_data[3] if localPlayer.stat_data[3] != null else "",
            localPlayer.stat_data[4] if localPlayer.stat_data[4] != null else "",
            localPlayer.stat_data[5] if localPlayer.stat_data[5] != null else "",
            localPlayer.stat_data[6] if localPlayer.stat_data[6] != null else "",
            localPlayer.stat_data[7] if localPlayer.stat_data[7] != null else "",
            localPlayer.stat_data[8] if localPlayer.stat_data[8] != null else "",
            localPlayer.stat_data[9] if localPlayer.stat_data[9] != null else "",
            localPlayer.stat_data[10] if localPlayer.stat_data[10] != null else "",
            localPlayer.stat_data[11] if localPlayer.stat_data[11] != null else "",
            localPlayer.stat_data[12] if localPlayer.stat_data[12] != null else "",
            localPlayer.stat_data[13] if localPlayer.stat_data[13] != null else "",
            localPlayer.stat_data[14] if localPlayer.stat_data[14] != null else "",
            localPlayer.stat_data[15] if localPlayer.stat_data[15] != null else "",
            localPlayer.stat_data[16] if localPlayer.stat_data[16] != null else "",
            localPlayer.stat_data[17] if localPlayer.stat_data[17] != null else "",
            localPlayer.stat_data[18] if localPlayer.stat_data[18] != null else "",
            localPlayer.stat_data[19] if localPlayer.stat_data[19] != null else ""

    ),
    HudPosition.RIGHT, 
    9999, 
    Color.WHITE, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)

    hudSubheader([i for i in localPlayer],
    "{0}{1}".format(strings_misc[eventPlayer.lang_type][0], localPlayer.score),
    HudPosition.LEFT, 
    9999, 
    Color.WHITE, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)


def destroy_menu():
    @Name "SUB: destroy_menu"

    for eventPlayer.menu_index in range(0, len(eventPlayer.menu_hudtexts)):
        destroyHudText(eventPlayer.menu_hudtexts[eventPlayer.menu_index])


def create_host_menu():
    @Name "SUB: create_host_menu"

    # (Subtext) ???
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_label_color = Color.WHITE
    new_menu_label_subheader()

    # (Header) Player
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Select Language
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
    eventPlayer.action_var = ITEM_TYPE.NONE
    eventPlayer.action_var_2 = eventPlayer.menu_item_size
    set_item_data()

    new_menu_item_cycle()

    # (Selection) Change Hero
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Header) Scenario
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Select Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = scenario_names[0]

    new_menu_item_cycle()
    
    if len(scenarios) <= 1:
        eventPlayer.menu_item_hidden[eventPlayer.menu_item_size] = true

    # (Selection) Scenario Type
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Selection) Start Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()


def create_player_menu():
    @Name "SUB: create_player_menu"

    # (Subtext) ???
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subheader()

    # (Header) Player
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Select Language
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]

    eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
    set_item_data()

    new_menu_item_cycle()

    # (Selection) Change Hero
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Header) Scenario
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Start Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()


def set_item_data():
    @Name "SUB: set_item_data"

    eventPlayer.menu_item_var_tags[eventPlayer.action_var_2] = strings_tags[eventPlayer.lang_type][item_data[eventPlayer.action_var][0]]
    eventPlayer.menu_item_range[eventPlayer.action_var_2] = item_data[eventPlayer.action_var][1]
    eventPlayer.menu_item_small_step[eventPlayer.action_var_2] = item_data[eventPlayer.action_var][2]
    eventPlayer.menu_item_large_step[eventPlayer.action_var_2] = item_data[eventPlayer.action_var][3]
    eventPlayer.menu_item_help[eventPlayer.action_var_2] = help_data[item_data[eventPlayer.action_var][4]]


def update_language():
    @Name "SUB: update_language"
    if eventPlayer.menu_type == MENU_TYPE.HOST:
        # (Subtext) ???
        eventPlayer.menu_label[0] = strings_host_menu[eventPlayer.lang_type][0]
        # (Header) Player
        eventPlayer.menu_label[1] = strings_host_menu[eventPlayer.lang_type][1]
        # (Selection) Select Language
        eventPlayer.menu_item_title_off[0] = strings_host_menu[eventPlayer.lang_type][2]
        eventPlayer.menu_item_title_on[0] = eventPlayer.menu_item_title_off[0]
        eventPlayer.menu_item_var_1[0] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
        # (Selection) Change Hero
        eventPlayer.menu_item_title_off[1] = strings_host_menu[eventPlayer.lang_type][3]
        eventPlayer.menu_item_title_on[1] = eventPlayer.menu_item_title_off[1]
        # (Header) Scenario
        eventPlayer.menu_label[2] = strings_host_menu[eventPlayer.lang_type][4]
        # (Selection) Select Scenario
        eventPlayer.menu_item_title_off[2] = strings_host_menu[eventPlayer.lang_type][5]
        eventPlayer.menu_item_title_on[2] = eventPlayer.menu_item_title_off[2]
        # (Selection) Scenario Type
        eventPlayer.menu_item_title_off[3] = strings_host_menu[eventPlayer.lang_type][6]
        eventPlayer.menu_item_title_on[3] = eventPlayer.menu_item_title_off[3]
        ##eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = scenario_names[0]
        # (Selection) Start Scenario
        eventPlayer.menu_item_title_off[4] = strings_host_menu[eventPlayer.lang_type][7]
        eventPlayer.menu_item_title_on[4] = eventPlayer.menu_item_title_off[4]
    else:
        # (Subtext) ???
        eventPlayer.menu_label[0] = "{0}{1}{2}".format(strings_symbols[0], strings_host_menu[eventPlayer.lang_type][0], strings_symbols[0])
        # (Header) Player
        eventPlayer.menu_label[1] = strings_player_menu[eventPlayer.lang_type][1]
        # (Selection) Select Language
        eventPlayer.menu_item_title_off[0] = strings_host_menu[eventPlayer.lang_type][2]
        eventPlayer.menu_item_title_on[0] = eventPlayer.menu_item_title_off[0]
        eventPlayer.menu_item_var_1[0] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
        # (Selection) Change Hero
        eventPlayer.menu_item_title_off[1] = strings_player_menu[eventPlayer.lang_type][2]
        eventPlayer.menu_item_title_on[1] = eventPlayer.menu_item_title_off[1]
        # (Header) Scenario
        eventPlayer.menu_label[2] = strings_player_menu[eventPlayer.lang_type][3]
        # (Selection) Start Scenario
        eventPlayer.menu_item_title_off[2] = strings_player_menu[eventPlayer.lang_type][4]
        eventPlayer.menu_item_title_on[2] = eventPlayer.menu_item_title_off[2]
    
    update_help_data()