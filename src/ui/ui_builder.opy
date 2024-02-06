rule "Menu Setup: Create Shared HUD Elements":
    @Event global
    @Condition data_loaded[DATA_TYPE.STATIC]

    create_stats_hud()
    create_help_hud()

rule "Menu Setup: Create Host Menu":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.menu_type == MENU_TYPE.NONE
    @Condition data_loaded[DATA_TYPE.STATIC]

    setup_menu()

    create_host_menu()

    eventPlayer.menu_type = MENU_TYPE.HOST
    eventPlayer.menu_visible = false


rule "Menu Setup: Create Non-Host Menu":
    @Event eachPlayer
    @Condition eventPlayer != hostPlayer
    @Condition eventPlayer.menu_type == MENU_TYPE.NONE
    @Condition data_loaded[DATA_TYPE.STATIC] 


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

    # Scenario Name
    hudSubtext(localPlayer, scenario_names[scenario_index], HudPosition.RIGHT, -100, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    
    # Author
    hudSubheader(localPlayer, "{0}{1}\n".format(strings_hud[localPlayer.lang_type][0], scenario_authors[scenario_index]), HudPosition.RIGHT, -99, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)

    # Team Score Display
    hudSubheader([i for i in localPlayer if getNumberOfPlayers(Team.1) > 1 and game_type != GAME_TYPES.VERSUS],
    "{0}\n---------------------\n{1}\n---------------------\n\n".format(strings_hud[localPlayer.lang_type][1], team_score),
    HudPosition.RIGHT, 
    -98, 
    Color.TEAM_1, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)

    # Versus Score Display
    hudSubheader([i for i in localPlayer if scenario_type == GAME_TYPES.VERSUS],
    "{0}\n---------------------\n{1}{2}{3}{4}{5}{6}{7}{8}{9}{10}{11}{12}---------------------\n\n".format(strings_hud[localPlayer.lang_type][2], 

        "{0} : ".format(getPlayersInSlot(0, Team.1)) if getPlayersInSlot(0, Team.1) != null else "", 
        "{0}\n".format(getPlayersInSlot(0, Team.1).high_score) if getPlayersInSlot(0, Team.1) != null else "",

        "{0} : ".format(getPlayersInSlot(1, Team.1)) if getPlayersInSlot(1, Team.1) != null else "", 
        "{0}\n".format(getPlayersInSlot(1, Team.1).high_score) if getPlayersInSlot(1, Team.1) != null else "",

        "{0} : ".format(getPlayersInSlot(2, Team.1)) if getPlayersInSlot(2, Team.1) != null else "", 
        "{0}\n".format(getPlayersInSlot(2, Team.1).high_score) if getPlayersInSlot(2, Team.1) != null else "",

        "{0} : ".format(getPlayersInSlot(3, Team.1)) if getPlayersInSlot(3, Team.1) != null else "", 
        "{0}\n".format(getPlayersInSlot(3, Team.1).high_score) if getPlayersInSlot(3, Team.1) != null else "",

        "{0} : ".format(getPlayersInSlot(4, Team.1)) if getPlayersInSlot(4, Team.1) != null else "", 
        "{0}\n".format(getPlayersInSlot(4, Team.1).high_score) if getPlayersInSlot(4, Team.1) != null else "",

        "{0} : ".format(getPlayersInSlot(5, Team.1)) if getPlayersInSlot(5, Team.1) != null else "", 
        "{0}\n".format(getPlayersInSlot(5, Team.1).high_score) if getPlayersInSlot(5, Team.1) != null else "",

        "{0} : ".format(getPlayersInSlot(6, Team.1)) if getPlayersInSlot(6, Team.1) != null else "", 
        "{0}\n".format(getPlayersInSlot(6, Team.1).high_score) if getPlayersInSlot(6, Team.1) != null else ""
        ),
    HudPosition.RIGHT, 
    -97, 
    Color.TEAM_2, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)

    # Score Display
    hudSubheader([i for i in localPlayer],
    "{0}\n---------------------\n{1}\n---------------------\n\n".format(strings_hud[localPlayer.lang_type][3], localPlayer.score),
    HudPosition.RIGHT, 
    -96, 
    Color.WHITE, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)

    # High Score Display
    hudSubheader([i for i in localPlayer],
    "{0}\n---------------------\n{1}\n---------------------\n\n".format(strings_hud[localPlayer.lang_type][4], localPlayer.high_score),
    HudPosition.RIGHT, 
    -95, 
    Color.GREEN, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)

    # Previous Scores
    hudSubheader([i for i in localPlayer if localPlayer.menu_visible],
    "---------------------\n{0}\n---------------------\n\n{1}\n{2}\n{3}\n{4}\n{5}\n{6}\n{7}\n{8}\n{9}\n{10}\n{11}\n{12}\n{13}\n{14}\n{15}\n{16}\n{17}\n{18}\n{19}\n{20}".format(
            strings_hud[localPlayer.lang_type][5],
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
    -94, 
    Color.BLACK, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)

    # Strafe Progress Bar
    progressBarHud([i for i in localPlayer if localPlayer.player_scenario_status and scenario[SCE_DATA.SCE_STRAFE_PPS] > 0],  
    (localPlayer.strafe_timer - scenario[SCE_DATA.SCE_STRAFE_MIN]) / (scenario[SCE_DATA.SCE_STRAFE_MAX] - scenario[SCE_DATA.SCE_STRAFE_MIN]) * 100, 
    "{0} / {1} {2}".format(min(scenario[SCE_DATA.SCE_STRAFE_PPS] * (scenario[SCE_DATA.SCE_STRAFE_MAX] - scenario[SCE_DATA.SCE_STRAFE_MIN]), max(0,(localPlayer.strafe_timer - scenario[SCE_DATA.SCE_STRAFE_MIN]) / (scenario[SCE_DATA.SCE_STRAFE_MAX] - scenario[SCE_DATA.SCE_STRAFE_MIN]) * scenario[SCE_DATA.SCE_STRAFE_PPS] * (scenario[SCE_DATA.SCE_STRAFE_MAX] - scenario[SCE_DATA.SCE_STRAFE_MIN]))), scenario[SCE_DATA.SCE_STRAFE_PPS] * (scenario[SCE_DATA.SCE_STRAFE_MAX] - scenario[SCE_DATA.SCE_STRAFE_MIN]), strings_units[lang_type][0]), 
    HudPosition.LEFT, 
    -3, 
    rgb((100 - (localPlayer.strafe_timer - scenario[SCE_DATA.SCE_STRAFE_MIN]) / (scenario[SCE_DATA.SCE_STRAFE_MAX] - scenario[SCE_DATA.SCE_STRAFE_MIN]) * 100)/100*255,
        ((localPlayer.strafe_timer - scenario[SCE_DATA.SCE_STRAFE_MIN]) / (scenario[SCE_DATA.SCE_STRAFE_MAX] - scenario[SCE_DATA.SCE_STRAFE_MIN]))*255,
        0
    ),
    Color.WHITE,
    ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, 
    SpecVisibility.DEFAULT)

    # Game Mode Progress bar
    progressBarHud([i for i in localPlayer if localPlayer.player_scenario_status], 
    localPlayer.scenario_timer / scenario[SCE_DATA.SCE_GAME_LIMIT] * 100 if scenario[SCE_DATA.SCE_GAME_MODE] == 0 else localPlayer.player_score / scenario[SCE_DATA.SCE_GAME_LIMIT] * 100, 
    "{0} / {1} {2}".format(localPlayer.scenario_timer if scenario[SCE_DATA.SCE_GAME_MODE] == 0 else localPlayer.player_score, scenario[SCE_DATA.SCE_GAME_LIMIT], strings_units[lang_type][1] if scenario[SCE_DATA.SCE_GAME_MODE] == 0 else strings_units[lang_type][0]), 
    HudPosition.TOP, 
    -99, 
    rgb(
        (100 - localPlayer.scenario_timer / scenario[SCE_DATA.SCE_GAME_LIMIT] * 100)/100*255 if scenario[SCE_DATA.SCE_GAME_MODE] == 0 else (100 - localPlayer.player_score / scenario[SCE_DATA.SCE_GAME_LIMIT] * 100)/100*255, 
        (localPlayer.scenario_timer / scenario[SCE_DATA.SCE_GAME_LIMIT])*255 if scenario[SCE_DATA.SCE_GAME_MODE] == 0 else (localPlayer.player_score / scenario[SCE_DATA.SCE_GAME_LIMIT])*255, 
        0
    ), 
    Color.WHITE, 
    ProgressHudReeval.VISIBILITY_VALUES_AND_COLOR, 
    SpecVisibility.DEFAULT)


def destroy_menu():
    @Name "SUB: destroy_menu"

    for eventPlayer.menu_index in range(0, len(eventPlayer.menu_hudtexts)):
        destroyHudText(eventPlayer.menu_hudtexts[eventPlayer.menu_index])


def create_host_menu():
    @Name "SUB: create_host_menu"

    # (Subtext) Website Prompt
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_label_color = Color.WHITE
    new_menu_label_subheader()

    # (Header) Scenario
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Start Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

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
    eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.MODE][scenario_type]
    new_menu_item_cycle()

    # (Header) Player
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Change Hero
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Selection) Select Language
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
    new_menu_item_cycle()


def create_player_menu():
    @Name "SUB: create_player_menu"

    # (Subtext) Website Prompt
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_label_color = Color.WHITE
    new_menu_label_subheader()

    # (Header) Scenario
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Start Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Header) Player
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Change Hero
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Selection) Select Language
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_player_menu[eventPlayer.lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    eventPlayer.menu_item_var_1[eventPlayer.menu_item_size] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
    new_menu_item_cycle()


def set_item_data():
    @Name "SUB: set_item_data"

    eventPlayer.menu_item_var_tags[eventPlayer.action_var_2] = strings_tags[eventPlayer.lang_type][item_data[eventPlayer.action_var][0]]
    eventPlayer.menu_item_range[eventPlayer.action_var_2] = item_data[eventPlayer.action_var][1]
    eventPlayer.menu_item_small_step[eventPlayer.action_var_2] = item_data[eventPlayer.action_var][2]
    eventPlayer.menu_item_large_step[eventPlayer.action_var_2] = item_data[eventPlayer.action_var][3]
    eventPlayer.menu_item_help[eventPlayer.action_var_2] = help_data[item_data[eventPlayer.action_var][4]]


def update_language():
    @Name "SUB: update_language"
    eventPlayer.update_index[0] = -1
    eventPlayer.update_index[1] = -1
    if eventPlayer.menu_type == MENU_TYPE.HOST:
        # (Subtext) ???
        eventPlayer.update_index[0] += 1
        eventPlayer.menu_label[eventPlayer.update_index[0]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        # (Header) Scenario
        eventPlayer.update_index[0] += 1
        eventPlayer.menu_label[eventPlayer.update_index[0]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        # (Selection) Start Scenario
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        # (Selection) Select Scenario
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        # (Selection) Scenario Type
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        # (Header) Player
        eventPlayer.update_index[0] += 1
        eventPlayer.menu_label[eventPlayer.update_index[0]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        # (Selection) Change Hero
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        # (Selection) Select Language
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_host_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        eventPlayer.menu_item_var_1[eventPlayer.update_index[1]] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
    else:
        # (Subtext) ???
        eventPlayer.update_index[0] += 1
        eventPlayer.menu_label[eventPlayer.update_index[0]] = strings_player_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        # (Header) Scenario
        eventPlayer.update_index[0] += 1
        eventPlayer.menu_label[eventPlayer.update_index[0]] = strings_player_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        # (Selection) Start Scenario
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_player_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        # (Header) Player
        eventPlayer.update_index[0] += 1
        eventPlayer.menu_label[eventPlayer.update_index[0]] = strings_player_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        # (Selection) Change Hero
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_player_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        # (Selection) Select Language
        eventPlayer.update_index[1] += 1
        eventPlayer.menu_item_title_off[eventPlayer.update_index[1]] = strings_player_menu[eventPlayer.lang_type][eventPlayer.update_index[0] + eventPlayer.update_index[1] + 1]
        eventPlayer.menu_item_title_on[eventPlayer.update_index[1]] = eventPlayer.menu_item_title_off[eventPlayer.update_index[1]]
        eventPlayer.menu_item_var_1[eventPlayer.update_index[1]] = strings_options[eventPlayer.lang_type][OPTIONS_TYPE.LANG][eventPlayer.lang_type]
    
    update_help_data()