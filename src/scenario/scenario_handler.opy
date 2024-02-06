rule "Set Player Scenario Status to Global Scenario Status":
    @Event eachPlayer
    @Team 1
    @Condition game_type != 2
    @Condition scenario_status != eventPlayer.player_scenario_status

    eventPlayer.player_scenario_status = scenario_status


def start_scenario():
    @Name "SUB: start_scenario"


def stop_scenario():
    @Name "SUB: stop_scenario"


def start_player_scenario():
    @Name "SUB: start_player_scenario"


def stop_player_scenario():
    @Name "SUB: stop_player_scenario"


    
