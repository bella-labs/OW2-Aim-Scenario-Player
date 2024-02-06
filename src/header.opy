# Global
## Control Flow
globalvar loop_index
globalvar data_loaded
## UI
globalvar lang_type
globalvar user_controls
globalvar ui_delay
globalvar ui_inputs
## Game Mode Data
## Storage 
globalvar scenario
globalvar scenarios
globalvar scenario_index
globalvar scenario_type

globalvar scenario_names
globalvar scenario_authors

globalvar hero_array
globalvar ranges
globalvar small_steps
globalvar large_steps
globalvar help_data
globalvar item_data
globalvar menu_wait
## Strings
globalvar strings_prompt
globalvar strings_help
globalvar strings_inputs
globalvar strings_symbols
globalvar strings_host_menu
globalvar strings_host_alt
globalvar strings_player_menu
globalvar strings_player_alt
globalvar strings_hud
globalvar strings_msg
globalvar strings_units
globalvar strings_options
globalvar strings_tags

playervar scenario_names
playervar scenario_authors
playervar export_data

subroutine set_scenario
subroutine display_missing_data_msg

enum SUBMENUS:
    SUBMENU_MAIN = 0

enum INPUT_OPTIONS:
    VECT_FORWARD = 0,
    VECT_BACKWARD,
    VECT_LEFT,
    VECT_RIGHT,
    BUTTON_INTERACT,
    BUTTON_JUMP,
    BUTTON_CROUCH,
    BUTTON_MELEE,
    BUTTON_PRIMARY,
    BUTTON_SECONDARY,
    BUTTON_RELOAD,
    BUTTON_ABILITY_1,
    BUTTON_ABILITY_2,
    BUTTON_ULTIMATE

enum MENU_ACTIONS:
    MENU_TOGGLE = 0,
    MENU_UP,
    MENU_DOWN,
    MENU_STEP_LEFT,
    MENU_STEP_RIGHT,
    MENU_JUMP_LEFT,
    MENU_JUMP_RIGHT,
    MENU_NEXT_SUBITEM,
    MENU_SET_VECTOR

enum RANGE_TYPE:
    NONE = 0

enum HELP_TYPE:
    DEFAULT = 0

enum ITEM_TYPE:
    NONE = 0


enum SMALL_TYPE:
    NONE = 0,
    SM_0_01,
    SM_1

enum LARGE_TYPE:
    NONE = 0,
    LG_1,
    LG_10,

enum DATA_TYPE:
    STATIC = 0,
    CONTROLS
    
enum GENERAL_TARGET:
    VECT_X = 0,
    VECT_Y,
    VECT_Z,
    MIN,
    MAX

enum TAG_TYPE:
    NONE = 0,
    HEALTH,
    MIN_MAX,
    TARGET,
    PROFILE_STATUS,
    PROFILE_ORDER,
    VECT,
    TYPE_VECT,
    ANGLE_DIM,
    MVMT_TYPE,
    MVMT_DIR,
    CHANCE,
    SCE_TIMED,
    SCE_POINTS,
    POINTS,
    STRAFE
    

enum OPTIONS_TYPE:
    LANG = 0,
    MODE

enum PLAYER_RAND:
    XZ = 0,
    LR_IDLE,
    FB_IDLE,
    JUMP,
    CROUCH,
    PROFILE

enum XZ_DIR:
    BACKWARD = 0,
    BACKWARD_RIGHT,
    RIGHT,
    FORWARD_RIGHT,
    FORWARD,
    FORWARD_LEFT,
    LEFT,
    BACKWARD_LEFT,

enum YDIR:
    UP = 0,
    DOWN







playervar menu_visible
playervar menu_action
playervar menu_index
playervar subitem_index
playervar submenu_start_indexes
playervar submenu_index
playervar menu_help_index
playervar menu_item_help
playervar help_index
playervar menu_help_display
playervar menu_item_small_step
playervar menu_item_large_step
playervar menu_max_pos
playervar menu_label_size
playervar menu_item_size
playervar submenu_size
playervar subitem_size
playervar menu_hudtexts

playervar player_speed
playervar menu_label_color
playervar menu_item_color_off
playervar menu_item_color_on
playervar menu_item_var_tags
playervar menu_item_var_1
playervar menu_item_var_2
playervar menu_item_var_3
playervar menu_item_var_4
playervar menu_label_hidden
playervar menu_label
playervar menu_item_hidden
playervar menu_item_title_off
playervar menu_item_title_on
playervar menu_item_range



subroutine log_run

playervar menu_type
playervar lang_type

globalvar menu_color_label_header
globalvar menu_color_off_index
globalvar menu_color_on_index
globalvar menu_colors_custom

globalvar reload_menus
playervar submenu_curr_start
playervar menu_wait_index

subroutine menu_up_check
subroutine menu_down_check
subroutine update_help_data
subroutine perform_action
subroutine enable_player_input
subroutine disable_player_input

subroutine setup_menu_custom
subroutine create_host_menu
subroutine create_player_menu
subroutine destroy_menu
subroutine create_stats_hud

### Menu Labels
subroutine increment_for_menu_label
subroutine new_menu_label_header
subroutine new_menu_label_subheader
subroutine new_menu_label_subtext
### Menu Items
subroutine increment_for_menu_item
subroutine new_menu_item_selection
subroutine new_menu_item_toggle
subroutine new_menu_item_cycle
subroutine new_menu_item_2var
subroutine new_menu_item_3var
subroutine new_menu_item_4var

subroutine act_main_sel_lang
subroutine act_main_open_hero_sel
subroutine act_main_player_start
subroutine subact_main_alert_host
subroutine act_main_host_sel_sce
subroutine act_main_host_sel_type
subroutine act_main_host_start

enum MENU_TYPE:
    NONE = 0,
    HOST,
    PLAYER



playervar action_var
playervar action_var_2
playervar action_var_3
playervar action_result
playervar general_small
playervar general_large
playervar general_range_min
playervar general_range_max

subroutine act_general_change_list
subroutine act_general_change_list_var_1

globalvar game_type
globalvar scenario_status
playervar player_scenario_status

subroutine start_scenario
subroutine stop_scenario
subroutine start_player_scenario
subroutine stop_player_scenario

subroutine reset_scenario

playervar lang_index


enum SCENARIO_DATA:
    SCE_PLAYER_SPAWN = 0,
    SCE_PLAYER_FACING,
    SCE_PLAYER_SPEED,
    SCE_PLAYER_GRAVITY,
    SCE_GAME_MODE,
    SCE_GAME_LIMIT,
    SCE_SPAWN_ORDER,
    SCE_RESPAWN_MIN,
    SCE_RESPAWN_MAX,
    SCE_BS_POINTS,
    SCE_HS_POINTS,
    SCE_ELIM_POINTS,
    SCE_STRAFE_PPS,
    SCE_STRAFE_MIN,
    SCE_STRAFE_MAX,
    SCE_CUSTOM_STATUS,
    BOT_SLOT_STATUS,
    BOT_SPAWN_TYPE,
    BOT_SPAWN_VECT,
    BOT_FACING_TYPE,
    BOT_FACING_VECT,
    BOT_BOUND_TYPE,
    BOT_BOUND_POS,
    BOT_BOUND_ANGLE,
    BOT_BOUND_DIM,
    BOT_DIST_MIN,
    BOT_DIST_MAX,
    BOT_HERO_POOL,
    BOT_HEALTH,
    BOT_HPS,
    BOT_HPS_WAIT,
    BOT_SPEED_TYPE,
    BOT_SPEED_MIN,
    BOT_SPEED_MAX,
    BOT_SPEED_TARGET,
    BOT_SCALE_TYPE,
    BOT_SCALE_MIN,
    BOT_SCALE_MAX,
    BOT_SCALE_TARGET,
    BOT_GRAVITY,
    BOT_PROFILE_WEIGHTS,
    BOT_PROFILE_MAX_WEIGHT,
    BOT_PROFILE_TYPE,
    BOT_PROFILE_MIN,
    BOT_PROFILE_MAX,
    MVMT_HORI_TYPE,
    MVMT_HORI_IMPULSE,
    MVMT_HORI_INTERVAL,
    MVMT_WEIGHTS,
    MVMT_MAX_WEIGHT,
    MVMT_LEFT_MIN,
    MVMT_LEFT_MAX,
    MVMT_RIGHT_MIN,
    MVMT_RIGHT_MAX,
    MVMT_FWD_MIN,
    MVMT_FWD_MAX,
    MVMT_BACK_MIN,
    MVMT_BACK_MAX,
    MVMT_VERT_TYPE,
    MVMT_VERT_IMPULSE,
    MVMT_VERT_INTERVAL,
    MVMT_JUMP_CHANCE,
    MVMT_JUMP_INTERVAL,
    MVMT_JUMP_MIN,
    MVMT_JUMP_MAX,
    MVMT_CROUCH_CHANCE,
    MVMT_CROUCH_INTERVAL,
    MVMT_UNCROUCH_MIN,
    MVMT_UNCROUCH_MAX,
    MVMT_LR_IDLE_CHANCE,
    MVMT_LR_IDLE_INTERVAL,
    MVMT_LR_IDLE_MIN,
    MVMT_LR_IDLE_MAX,
    MVMT_FB_IDLE_CHANCE,
    MVMT_FB_IDLE_INTERVAL,
    MVMT_FB_IDLE_MIN,
    MVMT_FB_IDLE_MAX


enum GAME_TYPES:
    CHALLENGE = 0,
    FREEPLAY,
    VERSUS

playervar owner_player
playervar target_mvmt_dir
playervar disabled_hori
playervar disabled_vert
playervar disabled_boundary

subroutine setup_all_players
subroutine setup_player

subroutine menu_act_host_main
subroutine menu_act_player_main

globalvar match_timer

playervar stat_data
playervar stat_formatter
playervar score
playervar high_score

subroutine set_item_data
playervar update_index

playervar scenario_timer
playervar strafe_timer
playervar player_score

globalvar team_score

subroutine teleport_all_players
globalvar bad_data