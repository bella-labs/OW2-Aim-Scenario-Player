def log_run():
    @Name "SUB: log_run"

    for eventPlayer.stat_formatter in range(20, 0, -1):
        eventPlayer.stat_data[eventPlayer.stat_formatter] = eventPlayer.stat_data[eventPlayer.stat_formatter - 1]

    eventPlayer.stat_data[0] = eventPlayer.score