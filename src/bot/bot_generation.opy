def create_target_bot():
    @Name "SUB: create_target_bot"
    
    bot_gen_hero = random.choice(scenario[SCE_DATA.BOT_HERO_POOL][bot_gen_slot])
    bot_gen_team = Team.2
    bot_gen_position = scenario[SCE_DATA.BOT_SPAWN_VECT][bot_gen_slot]
    bot_gen_facing = normalize(scenario[SCE_DATA.BOT_FACING_VECT][bot_gen_slot])
    createDummy(bot_gen_hero, bot_gen_team, bot_gen_slot, bot_gen_position, bot_gen_facing)

    getPlayersInSlot(bot_gen_slot, bot_gen_team).startForcingName("{0}{1}".format(strings_msg[lang_type][2], bot_gen_slot))

    if scenario[SCE_DATA.BOT_HEALTH][bot_gen_slot] == 0:
        getPlayersInSlot(bot_gen_slot, bot_gen_team).setStatusEffect(eventPlayer, Status.UNKILLABLE, 9999)