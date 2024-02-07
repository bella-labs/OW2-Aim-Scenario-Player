rule "Target Bot Initalization":
    @Event eachPlayer
    @Team 2

    # Set Owner Player
    eventPlayer.owner_player = getPlayersInSlot(0, Team.1)
    # Set Movement Direction
    eventPlayer.target_mvmt_dir = vect(0,0,0)
    # Set Disabled Movements
    eventPlayer.disabled_hori = [0,0,0,0,0,0,0,0]
    eventPlayer.disabled_vert = [0,0]
    eventPlayer.disabled_boundary = [-1, -1, -1, -1]


def create_target_bot():
    @Name "SUB: create_target_bot"

    bot_gen_hero = random.choice(scenario[SCE_DATA.BOT_HERO_POOL][bot_gen_slot])
    bot_gen_team = Team.2
    bot_gen_position = scenario[SCE_DATA.BOT_SPAWN_VECT][bot_gen_slot]
    bot_gen_facing = normalize(scenario[SCE_DATA.BOT_FACING_VECT][bot_gen_slot])
    createDummy(bot_gen_hero, bot_gen_team, bot_gen_slot, bot_gen_position, bot_gen_facing)

    scenario_bot[scenario_bot_index] = getPlayersInSlot(bot_gen_slot, Team.2)

    scenario_bot[scenario_bot_index].startForcingName("{0}{1}".format(strings_msg[lang_type][2], bot_gen_slot))

    if scenario[SCE_DATA.SCE_SPAWN_ORDER] == 1:
        scenario_bot[scenario_bot_index].setInvisibility(Invis.ALL)
        scenario_bot[scenario_bot_index].setStatusEffect(null, Status.PHASED_OUT, 9999)

    if scenario[SCE_DATA.BOT_HEALTH][bot_gen_slot] == 0:
        scenario_bot[scenario_bot_index].setStatusEffect(eventPlayer, Status.UNKILLABLE, 9999)
