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
globalvar strings_misc


playervar scenario_names
playervar scenario_authors
playervar export_data

subroutine set_scenario
subroutine load_missing_data_message

enum SUBMENUS:
    SUBMENU_MAIN = 0,
    SUBMENU_SCENARIO,
    SUBMENU_BOT,
    SUBMENU_PROFILE

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
    NONE = 0,
    SLOT,
    HERO,
    PERCENT,
    ANGLE,
    TIME,
    SCALAR,
    VECTOR,
    POINTS,

enum HELP_TYPE:
    DEFAULT = 0,
    CYCLE,
    CYCLE_TOGGLE,
    CYCLE_OVERRIDE,
    SUBITEM_CYCLE,
    SUBITEM_TOGGLE,
    SUBITEM_VECT,
    SUBITEM_VECT_OPT

enum ITEM_TYPE:
    NONE = 0,
    SLOT,
    TOGGLE_SLOT,
    OVERRIDE_SLOT,
    VECTOR,
    SCALAR,
    SCORE_TIME,
    SCORE_POINTS,
    POINTS,
    STRAFE,
    TYPE_VECT,
    BOUNDARY,
    DISTANCE,
    HERO,
    HEALTH,
    SPEED,
    SCALE,
    PROF_STATUS,
    ORDER,
    MVMT_TYPE,
    MVMT_DIR,
    CHANCE


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
    BOT,
    MENU,
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
    TOGGLE = 0,
    GAME_TYPE,
    TARGET,
    SPAWN,
    FACING,
    BOUNDS,
    PROFILE,
    MVMT_TYPE,
    SCE_MODE,
    SCE_ORDER

enum PLAYER_INDEXES:
    PROFILE = 0

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




subroutine log_run

playervar menu_loaded

globalvar menu_color_label_header
globalvar menu_color_off_index
globalvar menu_color_on_index
globalvar menu_colors_custom

globalvar reload_menus


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

enum MENU_TYPE:
    NONE = 0,
    HOST,
    PLAYER