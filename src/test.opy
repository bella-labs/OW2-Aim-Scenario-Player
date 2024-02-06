settings "settings.json"

#Extensions
#!extension spawnMoreDummyBots
##!optimizeForSize

# Includes
#!include "header.opy"
#!include "initialization/custom.opy"
#!include "initialization/init.opy"
#!include "initialization/data_loader.opy"
#!include "initialization/player.opy"
#!include "data/static_data.opy"
#!include "ui/ui_framework.opy"
#!include "ui/ui_builder.opy"
#!include "actions/actions_handler.opy"
#!include "actions/utility_actions.opy"
#!include "actions/host_menu.opy"
#!include "actions/all_menu.opy"
#!include "scenario/scenario_handler.opy"
#!include "bot/bot_generation.opy"


rule "DISPLAY SCENARIO DATA":
    @Event eachPlayer
    @Team 1

    @Condition eventPlayer.isHoldingButton(Button.MELEE)
    @Condition eventPlayer.isHoldingButton(Button.RELOAD)

    smallMessage(hostPlayer, "start")
    for loop_index in range(0,78):
        smallMessage(hostPlayer, scenario[loop_index])
    smallMessage(hostPlayer, "end")