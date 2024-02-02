rule "Menu Setup: Create Host Menu":
    @Event eachPlayer
    @Condition eventPlayer == hostPlayer
    @Condition data_loaded[DATA_TYPE.STATIC]
    @Condition eventPlayer.menu_loaded == 0

    setup_menu_custom()
    create_submenu_main()
    eventPlayer.menu_loaded = 1
    eventPlayer.menu_visible = false


rule "Menu Setup: Create Non-Host Menu":
    @Event eachPlayer
    @Condition eventPlayer != hostPlayer
    @Condition data_loaded[DATA_TYPE.STATIC] 

    eventPlayer.menu_loaded = 2
    eventPlayer.menu_visible = false


def setup_menu_custom():
    @Name "SUB: setup_menu_custom"

    menu_color_on_index = rgb(100,200,240) 
    menu_color_label_subtext = rgb(255,150,80)

    menu_colors_custom[0] = rgb(255,100,120)
    menu_colors_custom[1] = rgb(100,200,120)
    menu_colors_custom[2] = rgb(240,120,100) 
    menu_colors_custom[3] = rgb(230,190,60) 
    menu_colors_custom[4] = rgb(110,150,250)

def create_submenu_main():
    @Name "SUB: create_submenu_main"

    # (Subtext) Documentation prompt
    increment_for_menu_label()
    eventPlayer.menu_label[eventPlayer.menu_label_size] = "TEST"
    new_menu_label_subheader()