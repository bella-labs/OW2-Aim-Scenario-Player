rule "Set Player Scenario Status to Global Scenario Status":
    @Event eachPlayer
    @Team 1
    @Condition game_type != 2
    @Condition scenario_status != eventPlayer.player_scenario_status

    eventPlayer.player_scenario_status = scenario_status


def start_scenario():
    @Name "SUB: start_scenario"

    reset_scenario()
    setup_all_players()


def stop_scenario():
    @Name "SUB: stop_scenario"

    scenario_status = false
    if not eventPlayer.menu_visible:
        eventPlayer.setMoveSpeed(100)
        eventPlayer.setGravity(100)


def start_player_scenario():
    @Name "SUB: start_player_scenario"

    setup_player()


def stop_player_scenario():
    @Name "SUB: stop_player_scenario"


def setup_all_players():
    @Name "SUB: setup_all_players"

    disable_player_input()

    getPlayers(Team.1).teleport(scenario[SCENARIO_DATA.SCE_PLAYER_SPAWN])
    getPlayers(Team.1).setFacing(scenario[SCENARIO_DATA.SCE_PLAYER_FACING], Relativity.TO_WORLD)
    getPlayers(Team.1).setGravity(scenario[SCENARIO_DATA.SCE_PLAYER_GRAVITY])

    smallMessage(getPlayers(Team.1), "  3")
    wait(1)
    smallMessage(getPlayers(Team.1), "  2")
    wait(1)
    smallMessage(getPlayers(Team.1), "  1")
    wait(1)

    getPlayers(Team.1).player_speed = scenario[SCENARIO_DATA.SCE_PLAYER_SPEED]
    enable_player_input()

    bigMessage(getPlayers(Team.1), "Start")

    smallMessage(hostPlayer, scenario[SCENARIO_DATA.SCE_GAME_MODE])
    if scenario[SCENARIO_DATA.SCE_GAME_MODE] == 0:
        smallMessage(hostPlayer, scenario[SCENARIO_DATA.SCE_GAME_LIMIT])
        getPlayers(Team.1).scenario_timer = scenario[SCENARIO_DATA.SCE_GAME_LIMIT]
        chase(getPlayers(Team.1).scenario_timer, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    else:
        getPlayers(Team.1).scenario_timer = 0
        chase(getPlayers(Team.1).scenario_timer, 9999, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    
    scenario_status = true


def setup_player():
    @Name "SUB: setup_player"

    disable_player_input()

    eventPlayer.teleport(scenario[SCENARIO_DATA.SCE_PLAYER_SPAWN])
    eventPlayer.setFacing(scenario[SCENARIO_DATA.SCE_PLAYER_FACING], Relativity.TO_WORLD)
    eventPlayer.setGravity(scenario[SCENARIO_DATA.SCE_PLAYER_GRAVITY])

    smallMessage(eventPlayer, "  3")
    wait(1)
    smallMessage(eventPlayer, "  2")
    wait(1)
    smallMessage(eventPlayer, "  1")
    wait(1)

    eventPlayer.player_speed = scenario[SCENARIO_DATA.SCE_PLAYER_SPEED]
    enable_player_input()

    bigMessage(eventPlayer, "Start")

    smallMessage(hostPlayer, scenario[SCENARIO_DATA.SCE_GAME_MODE])
    if scenario[SCENARIO_DATA.SCE_GAME_MODE] == 0:
        smallMessage(hostPlayer, scenario[SCENARIO_DATA.SCE_GAME_LIMIT])
        eventPlayer.scenario_timer = scenario[SCENARIO_DATA.SCE_GAME_LIMIT]
        chase(eventPlayer.scenario_timer, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    else:
        eventPlayer.scenario_timer = 0
        chase(eventPlayer.scenario_timer, 9999, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    
    scenario_status = true


def reset_scenario():
    @Name "SUB: reset_scenario"

    