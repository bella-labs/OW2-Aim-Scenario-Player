rule "Load Static Data":
    @Event global

    hero_array =    [
                        Hero.TRACER,
                        Hero.REAPER,
                        Hero.WIDOWMAKER,
                        Hero.PHARAH,
                        Hero.REINHARDT,
                        Hero.MERCY,
                        Hero.TORBJORN,
                        Hero.HANZO,
                        Hero.WINSTON,
                        Hero.ZENYATTA,
                        Hero.BASTION,
                        Hero.SYMMETRA,
                        Hero.ZARYA,
                        Hero.MCCREE,
                        Hero.SOLDIER,
                        Hero.LUCIO,
                        Hero.ROADHOG,
                        Hero.JUNKRAT,
                        Hero.DVA,
                        Hero.MEI,
                        Hero.GENJI,
                        Hero.ANA,
                        Hero.SOMBRA,
                        Hero.ORISA,
                        Hero.DOOMFIST,
                        Hero.MOIRA,
                        Hero.BRIGITTE,
                        Hero.HAMMOND,
                        Hero.ASHE,
                        Hero.BAPTISTE,
                        Hero.SIGMA,
                        Hero.ECHO,
                        Hero.SOJOURN,
                        Hero.JUNKER_QUEEN,
                        Hero.KIRIKO,
                        Hero.RAMATTRA,
                        Hero.LIFEWEAVER,
                        Hero.ILLARI,
                        Hero.MAUGA
                        #Hero.VENTURE
                        #Hero.SPACE_RANGER 
                    ]

    ranges =    [   
                    ["N/A", "N/A"], # None
                    [0,11], # Slot
                    [0,len(hero_array)-1], # Hero
                    [0,100], # Percentage
                    [0,179], # Angle
                    [0,600], # Time
                    [0, 1000], # Scalar
                    [-1000,1000], # Vector
                    [0, 1000000] # Score
                ]

    small_steps =   [
                        "N/A", 
                        0.01, 
                        1
                    ]

    large_steps =   [
                        "N/A",
                        1,
                        10
                    ]

    help_data = [
                    [0,0,0,0,0,0,0,0,0,0], # Default
                    [0,0,1,1,1,1,0,0,1,1], # Cycle List
                    [0,0,1,1,3,3,0,0,1,1], # Cycle Toggle
                    [0,0,1,1,4,4,0,0,3,1], # Cycle Override
                    [0,0,1,1,1,1,1,1,1,1], # Subitem Cycle
                    [0,0,2,2,2,2,1,1,1,1], # Subitem Cycle List + Toggle
                    [0,0,1,1,1,1,1,1,2,1], # Subitem Vector List
                    [0,0,2,2,2,2,1,1,2,1]  # Subitem Vector Toggle
                    ] 
    
    item_data = [
                        [ # None
                            TAG_TYPE.NONE,
                            [],
                            [],
                            [],
                            [HELP_TYPE.DEFAULT],
                            HELP_TYPE.DEFAULT
                        ],
                        [ # SLOT
                            TAG_TYPE.NONE,
                            [RANGE_TYPE.SLOT],
                            [SMALL_TYPE.SM_1],
                            [LARGE_TYPE.LG_1],
                            HELP_TYPE.CYCLE
                        ],
                        [ # TOGGLE_SLOT
                            TAG_TYPE.NONE,
                            [RANGE_TYPE.SLOT],
                            [SMALL_TYPE.SM_1],
                            [LARGE_TYPE.LG_1],
                            HELP_TYPE.CYCLE_TOGGLE
                        ],
                        [ # OVERRIDE_SLOT
                            TAG_TYPE.NONE,
                            [RANGE_TYPE.SLOT],
                            [SMALL_TYPE.SM_1],
                            [LARGE_TYPE.LG_1],
                            HELP_TYPE.CYCLE_OVERRIDE
                        ],
                        [ # VECTOR
                            TAG_TYPE.VECT,
                            [RANGE_TYPE.VECTOR, RANGE_TYPE.VECTOR, RANGE_TYPE.VECTOR],
                            [SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_1, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_VECT
                        ],
                        [ # SCALAR
                            TAG_TYPE.NONE,
                            [RANGE_TYPE.SCALAR],
                            [SMALL_TYPE.SM_1],
                            [LARGE_TYPE.LG_10],
                            HELP_TYPE.CYCLE
                        ],
                        [ # SCORE_TIME
                            TAG_TYPE.SCE_TIMED,
                            [RANGE_TYPE.NONE, RANGE_TYPE.TIME],
                            [SMALL_TYPE.NONE, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.NONE, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_TOGGLE
                        ],
                        [ # SCORE_POINTS
                            TAG_TYPE.SCE_POINTS,
                            [RANGE_TYPE.NONE, RANGE_TYPE.POINTS],
                            [SMALL_TYPE.NONE, SMALL_TYPE.SM_1],
                            [LARGE_TYPE.NONE, LARGE_TYPE.LG_10],
                            HELP_TYPE.SUBITEM_TOGGLE
                        ],
                        [ # POINTS
                            TAG_TYPE.POINTS,
                            [RANGE_TYPE.SCALAR, RANGE_TYPE.SCALAR, RANGE_TYPE.SCALAR],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_1, SMALL_TYPE.SM_1],
                            [LARGE_TYPE.LG_10, LARGE_TYPE.LG_10, LARGE_TYPE.LG_10],
                            HELP_TYPE.SUBITEM_CYCLE
                        ],
                        [ # STRAFE
                            TAG_TYPE.STRAFE,
                            [RANGE_TYPE.SCALAR, RANGE_TYPE.TIME, RANGE_TYPE.TIME],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_10, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_CYCLE
                        ],
                        [ # TYPE_VECT
                            TAG_TYPE.TYPE_VECT,
                            [RANGE_TYPE.NONE, RANGE_TYPE.VECTOR, RANGE_TYPE.VECTOR, RANGE_TYPE.VECTOR],
                            [SMALL_TYPE.NONE, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.NONE, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_VECT_OPT
                        ],
                        [ # BOUNDARY
                            TAG_TYPE.ANGLE_DIM,
                            [RANGE_TYPE.ANGLE, RANGE_TYPE.SCALAR, RANGE_TYPE.SCALAR, RANGE_TYPE.SCALAR],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_10, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_VECT
                        ],
                        [ # DISTANCE
                            TAG_TYPE.MIN_MAX,
                            [RANGE_TYPE.PERCENT, RANGE_TYPE.PERCENT],
                            [SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_CYCLE
                        ],
                        [ # HERO
                            TAG_TYPE.NONE,
                            [RANGE_TYPE.NONE, RANGE_TYPE.NONE, RANGE_TYPE.HERO],
                            [SMALL_TYPE.NONE, SMALL_TYPE.NONE, SMALL_TYPE.SM_1],
                            [],
                            HELP_TYPE.CYCLE_TOGGLE
                        ],
                        [ # HEALTH
                            TAG_TYPE.HEALTH,
                            [RANGE_TYPE.SCALAR, RANGE_TYPE.VECTOR, RANGE_TYPE.TIME],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_1, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_10, LARGE_TYPE.LG_10, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_CYCLE
                        ],
                        [ # SPEED
                            TAG_TYPE.TARGET,
                            [RANGE_TYPE.NONE, RANGE_TYPE.SCALAR, RANGE_TYPE.SCALAR, RANGE_TYPE.SCALAR],
                            [SMALL_TYPE.NONE, SMALL_TYPE.SM_1, SMALL_TYPE.SM_1, SMALL_TYPE.SM_1],
                            [LARGE_TYPE.NONE, LARGE_TYPE.LG_10, LARGE_TYPE.LG_10, LARGE_TYPE.LG_10],
                            HELP_TYPE.SUBITEM_TOGGLE
                        ],
                        [ # SCALE
                            TAG_TYPE.TARGET,
                            [RANGE_TYPE.NONE, RANGE_TYPE.PERCENT, RANGE_TYPE.PERCENT, RANGE_TYPE.PERCENT],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_1, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_10, LARGE_TYPE.LG_10, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_TOGGLE
                        ],
                        [ # PROF_STATUS
                            TAG_TYPE.PROFILE_STATUS,
                            [RANGE_TYPE.SLOT, RANGE_TYPE.PERCENT],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_1],
                            [LARGE_TYPE.LG_1, LARGE_TYPE.LG_10],
                            HELP_TYPE.CYCLE_TOGGLE
                        ],
                        [ # ORDER
                            TAG_TYPE.PROFILE_ORDER,
                            [RANGE_TYPE.NONE, RANGE_TYPE.TIME, RANGE_TYPE.TIME],
                            [SMALL_TYPE.NONE, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.NONE, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_VECT_OPT
                        ],
                        [ # MVMT_TYPE
                            TAG_TYPE.MVMT_TYPE,
                            [RANGE_TYPE.NONE, RANGE_TYPE.SCALAR, RANGE_TYPE.TIME],
                            [SMALL_TYPE.NONE, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.NONE, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_TOGGLE
                        ],
                        [ # MVMT_DIR
                            TAG_TYPE.MVMT_DIR,
                            [RANGE_TYPE.PERCENT, RANGE_TYPE.TIME, RANGE_TYPE.TIME],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_10, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_CYCLE
                        ],
                        [ # CHANCE
                            TAG_TYPE.CHANCE,
                            [RANGE_TYPE.PERCENT, RANGE_TYPE.TIME, RANGE_TYPE.TIME, RANGE_TYPE.TIME],
                            [SMALL_TYPE.SM_1, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01, SMALL_TYPE.SM_0_01],
                            [LARGE_TYPE.LG_10, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1, LARGE_TYPE.LG_1],
                            HELP_TYPE.SUBITEM_CYCLE
                        ]
                    ]

    menu_wait = [0.10, 0.05, 0.01]

                    

rule "Load Language Data":
    @Event global

    data_loaded[DATA_TYPE.STATIC] = false

    strings_prompt = [
        [
            "Hold", 
            "Press",
            "to",
            "close",
            "open",
            "menu",
            "to override the currently selected slot",
            "to override all slots",
            "Slot is disabled in bot settings"
        ],
        [
            "", 
            "",
            "",
            "",
            "",
            "",
            ""
        ],
        [
            "", 
            "",
            "",
            "",
            "",
            "",
            ""
        ]
    ]

    strings_help = [
        [
            ["Previous Item"],
            ["Next Item"],
            ["Select Item", "-", "Previous Option / -"],
            ["Select Item", "+", "Next Option / +"],
            ["Select Item", "-", "Previous Option / -", "Toggle All", "Override All"],
            ["Select Item", "+", "Next Option / +", "Toggle Selected", "Override Selected"],
            ["N/A", "Previous Subitem"],
            ["N/A", "Next Subitem"],
            ["Select Item", "N/A", "Set Vector to Current", "Confirm Override"],
            ["N/A", "Turbo Cycle"]
        ],
        [
            [""],
            [""],
            ["", "-", " / -"],
            ["", "+", " / +"],
            ["", "-", " / -", "", ""],
            ["", "+", " / +", "", ""],
            ["", ""],
            ["", "", "", ""]
        ],
        [
            [""],
            [""],
            ["", "-", " / -"],
            ["", "+", " / +"],
            ["", "-", " / -", "", ""],
            ["", "+", " / +", "", ""],
            ["", ""],
            ["", "", "", ""]
        ]
    ]

    strings_inputs = [
        [
            "Forward", 
            "Backward",
            "Left",
            "Right"
        ], 
        [
            "",
            "",
            "",
            ""
        ],
        [
            "",
            "",
            "",
            ""
        ]
    ]

    strings_symbols = ["—————————————————————————\n"]

    strings_host_menu = [
        [
            "",
            "Player",
            "Change Hero",
            "Scenario",
            "Select Scenario",
            "Scenario Type",
            "Start Scenario"
        ],
        [

        ],
        [

        ]

    ]

    strings_host_alt = [
        [
            "Stop Scenario"
        ],
        [

        ],
        [

        ]
    ]

    strings_player_menu =   [
        [
            "",
            "Player",
            "Change Hero",
            "Scenario",
            "Start Scenario"
        ],
        [

        ],
        [
            
        ]
    ]

    strings_player_alt = [
        [
            "Stop Scenario",
            "Request Host Start Scenario"
        ],
        [

        ],
        [

        ]
    ]
    strings_misc = [
        [
            "Current Score: ",
            "Highest Score: "
        ]
    ]
    
    data_loaded[DATA_TYPE.STATIC] = true
