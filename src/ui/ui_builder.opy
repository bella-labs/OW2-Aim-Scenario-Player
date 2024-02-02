playervar stat_data
playervar stat_formatter
playervar score
playervar high_score

rule "Menu Setup: Create Host Menu":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.menu_loaded == MENU_TYPE.NONE
    @Condition data_loaded[DATA_TYPE.STATIC]

    create_stats_hud()
    create_help_hud()

    setup_menu()

    create_host_menu()

    eventPlayer.menu_loaded = MENU_TYPE.HOST
    eventPlayer.menu_visible = false


rule "Menu Setup: Create Non-Host Menu":
    @Event eachPlayer
    @Condition eventPlayer != hostPlayer
    @Condition eventPlayer.menu_loaded == MENU_TYPE.NONE
    @Condition data_loaded[DATA_TYPE.STATIC] 

    create_stats_hud()
    create_help_hud()

    setup_menu()

    create_player_menu()

    eventPlayer.menu_loaded = MENU_TYPE.HOST
    eventPlayer.menu_visible = false


rule "Menu Setup: Manage Player -> Host Change":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.menu_loaded == MENU_TYPE.PLAYER
    @Condition data_loaded[DATA_TYPE.STATIC] 

    destroy_menu()

    setup_menu()

    create_host_menu()

    eventPlayer.menu_loaded = MENU_TYPE.HOST
    eventPlayer.menu_visible = false



rule "Menu Setup: Manage Host -> Player Change":
    @Event eachPlayer
    @Condition eventPlayer != hostPlayer
    @Condition eventPlayer.menu_loaded == MENU_TYPE.HOST
    @Condition data_loaded[DATA_TYPE.STATIC] 

    destroy_menu()

    setup_menu()

    create_player_menu()

    eventPlayer.menu_loaded = MENU_TYPE.PLAYER
    eventPlayer.menu_visible = false


def log_run():
    @Name "SUB: log_run"

    for eventPlayer.stat_formatter in range(20, 0, -1):
        eventPlayer.stat_data[eventPlayer.stat_formatter] = eventPlayer.stat_data[eventPlayer.stat_formatter - 1]

    eventPlayer.stat_data[0] = eventPlayer.score

    
def create_stats_hud():
    @Name "SUB: create_stats_hud"

    hudSubtext(eventPlayer, scenario_names[scenario_index], HudPosition.RIGHT, -9999, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)
    hudSubheader(eventPlayer, scenario_authors[scenario_index], HudPosition.RIGHT, -9998, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.ALWAYS)

    hudSubheader([i for i in localPlayer if localPlayer.menu_visible],
    "{0}\n{1}\n{2}\n{3}\n{4}\n{5}\n{6}\n{7}\n{8}\n{9}\n{10}\n{11}\n{12}\n{13}\n{14}\n{15}\n{16}\n{17}\n{18}\n{19}".format(
            "Previous Scores:",
            eventPlayer.stat_data[0] if eventPlayer.stat_data[0] != null else "",
            eventPlayer.stat_data[1] if eventPlayer.stat_data[1] != null else "",
            eventPlayer.stat_data[2] if eventPlayer.stat_data[2] != null else "",
            eventPlayer.stat_data[3] if eventPlayer.stat_data[3] != null else "",
            eventPlayer.stat_data[4] if eventPlayer.stat_data[4] != null else "",
            eventPlayer.stat_data[5] if eventPlayer.stat_data[5] != null else "",
            eventPlayer.stat_data[6] if eventPlayer.stat_data[6] != null else "",
            eventPlayer.stat_data[7] if eventPlayer.stat_data[7] != null else "",
            eventPlayer.stat_data[8] if eventPlayer.stat_data[8] != null else "",
            eventPlayer.stat_data[9] if eventPlayer.stat_data[9] != null else "",
            eventPlayer.stat_data[10] if eventPlayer.stat_data[10] != null else "",
            eventPlayer.stat_data[11] if eventPlayer.stat_data[11] != null else "",
            eventPlayer.stat_data[12] if eventPlayer.stat_data[12] != null else "",
            eventPlayer.stat_data[13] if eventPlayer.stat_data[13] != null else "",
            eventPlayer.stat_data[14] if eventPlayer.stat_data[14] != null else "",
            eventPlayer.stat_data[15] if eventPlayer.stat_data[15] != null else "",
            eventPlayer.stat_data[16] if eventPlayer.stat_data[16] != null else "",
            eventPlayer.stat_data[17] if eventPlayer.stat_data[17] != null else "",
            eventPlayer.stat_data[18] if eventPlayer.stat_data[18] != null else "",
            eventPlayer.stat_data[19] if eventPlayer.stat_data[19] != null else ""

    ),
    HudPosition.RIGHT, 
    9999, 
    Color.BLACK, 
    HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, 
    SpecVisibility.ALWAYS)

    hudSubheader([i for i in localPlayer],
    "{0}{1}\n  {2}{3}".format(strings_misc[lang_type][0], localPlayer.score, strings_misc[lang_type][1], localPlayer.high_score),
    HudPosition.LEFT, 
    9999, 
    Color.BLACK, 
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
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subheader()

    # (Header) Player
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Change Hero
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Header) Scenario
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_host_menu[lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Select Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()
    #if len(scenarios) <= 1:
    #    eventPlayer.menu_item_hidden[eventPlayer.menu_item_size] = true

    # (Selection) Scenario Type
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Selection) Start Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_host_menu[lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()
 

def create_player_menu():
    @Name "SUB: create_player_menu"

    # (Subtext) ???
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subheader()

    # (Header) Player
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Change Hero
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_player_menu[lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()

    # (Header) Scenario
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = strings_player_menu[lang_type][eventPlayer.menu_max_pos]
    new_menu_label_subtext()

    # (Selection) Start Scenario
    increment_for_menu_item()
    eventPlayer.menu_item_title_off[eventPlayer.menu_item_size] = strings_player_menu[lang_type][eventPlayer.menu_max_pos]
    eventPlayer.menu_item_title_on[eventPlayer.menu_item_size] = eventPlayer.menu_item_title_off[eventPlayer.menu_item_size]
    new_menu_item_selection()