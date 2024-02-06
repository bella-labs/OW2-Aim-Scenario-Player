rule "Set Player Scenario Status to Global Scenario Status":
    @Event eachPlayer
    @Team 1
    @Condition game_type != GAME_TYPES.VERSUS
    @Condition scenario_status != eventPlayer.player_scenario_status

    eventPlayer.player_scenario_status = scenario_status


rule "Update High Score Timed":
    @Event eachPlayer
    @Team 1
    @Condition scenario[SCE_DATA.SCE_GAME_MODE] == 0
    @Condition eventPlayer.score > eventPlayer.high_score

    eventPlayer.high_score = eventPlayer.score


rule "Update High Score Score Limit":
    @Event eachPlayer
    @Team 1
    @Condition scenario[SCE_DATA.SCE_GAME_MODE] == 1
    @Condition eventPlayer.score < eventPlayer.high_score

    eventPlayer.high_score = eventPlayer.score


def start_scenario():
    @Name "SUB: start_scenario"

    reset_scenario()
    setup_all_players()


def stop_scenario():
    @Name "SUB: stop_scenario"

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

    teleport_all_players()
    getPlayers(Team.1).setFacing(scenario[SCE_DATA.SCE_PLAYER_FACING], Relativity.TO_WORLD)
    getPlayers(Team.1).setGravity(scenario[SCE_DATA.SCE_PLAYER_GRAVITY])

    smallMessage(getPlayers(Team.1), "  3")
    wait(1)
    smallMessage(getPlayers(Team.1), "  2")
    wait(1)
    smallMessage(getPlayers(Team.1), "  1")
    wait(1)

    getPlayers(Team.1).player_speed = scenario[SCE_DATA.SCE_PLAYER_SPEED]
    enable_player_input()

    bigMessage(getPlayers(Team.1), "Start")

    smallMessage(hostPlayer, scenario[SCE_DATA.SCE_GAME_MODE])
    if scenario[SCE_DATA.SCE_GAME_MODE] == 0:
        smallMessage(hostPlayer, scenario[SCE_DATA.SCE_GAME_LIMIT])
        getPlayers(Team.1).scenario_timer = scenario[SCE_DATA.SCE_GAME_LIMIT]
        chase(getPlayers(Team.1).scenario_timer, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    else:
        getPlayers(Team.1).scenario_timer = 0
        chase(getPlayers(Team.1).scenario_timer, 9999, rate=1, ChaseReeval.DESTINATION_AND_RATE)


def setup_player():
    @Name "SUB: setup_player"

    disable_player_input()

    eventPlayer.teleport(scenario[SCE_DATA.SCE_PLAYER_SPAWN])
    eventPlayer.setFacing(scenario[SCE_DATA.SCE_PLAYER_FACING], Relativity.TO_WORLD)
    eventPlayer.setGravity(scenario[SCE_DATA.SCE_PLAYER_GRAVITY])

    smallMessage(eventPlayer, "  3")
    wait(1)
    smallMessage(eventPlayer, "  2")
    wait(1)
    smallMessage(eventPlayer, "  1")
    wait(1)

    eventPlayer.player_speed = scenario[SCE_DATA.SCE_PLAYER_SPEED]
    enable_player_input()

    bigMessage(eventPlayer, "Start")

    smallMessage(hostPlayer, scenario[SCE_DATA.SCE_GAME_MODE])
    if scenario[SCE_DATA.SCE_GAME_MODE] == 0:
        smallMessage(hostPlayer, scenario[SCE_DATA.SCE_GAME_LIMIT])
        eventPlayer.scenario_timer = scenario[SCE_DATA.SCE_GAME_LIMIT]
        chase(eventPlayer.scenario_timer, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    else:
        eventPlayer.scenario_timer = 0
        chase(eventPlayer.scenario_timer, 9999, rate=1, ChaseReeval.DESTINATION_AND_RATE)


def reset_scenario():
    @Name "SUB: reset_scenario"

    
def teleport_all_players():
    @Name "SUB: teleport_all_players"

    if getNumberOfPlayers(Team.1) > 1:
        