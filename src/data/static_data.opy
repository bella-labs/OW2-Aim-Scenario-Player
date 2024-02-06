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
                ] 
    
    item_data = [
                        [ # None
                            TAG_TYPE.NONE,
                            [],
                            [],
                            [],
                            [HELP_TYPE.DEFAULT],
                            HELP_TYPE.DEFAULT
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
            "————————————————\nFor Help Visit:\nASP.bellalabs.dev\n————————————————\n",
            "Scenario",
            "Start Scenario",
            "Select Scenario",
            "Scenario Type",
            "Player",
            "Change Hero",
            "Language"
        ],
        [
            "————————————————\nTest0\nASP.bellalabs.dev\n————————————————\n",
            "Test1",
            "Test2",
            "Test3",
            "Test4",
            "Test5",
            "Test6",
            "언어"
        ],
        [
            "————————————————\nx0\nASP.bellalabs.dev\n————————————————\n",
            "x1",
            "x3",
            "x4",
            "x5",
            "x6",
            "x7",
            "语言"
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
            "————————————————\nFor Help Visit:\nASP.bellalabs.dev\n————————————————\n",
            "Scenario",
            "Start Scenario",
            "Player",
            "Change Hero",
            "Language"
        ],
        [
            "————————————————\nTest0\nASP.bellalabs.dev\n————————————————\n",
            "Test1",
            "Test2",
            "Test3",
            "Test4",
            "언어"
        ],
        [
            "————————————————\nx0\nASP.bellalabs.dev\n————————————————\n",
            "x1",
            "x3",
            "x4",
            "x5",
            "语言"
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
    
    strings_options = [
        [
            ["English", "한국어", "中文"],
            ["Challenge", "Freeplay", "Versus"]
        ],
        [
            ["English", "한국어", "中文"]
        ],
        [
            ["English", "한국어", "中文"]
        ]
    ]

    strings_tags = [
        [
            ""
        ],
        [
            ""
        ],
        [
            ""
        ]
    ]

    strings_hud = [
        [
            "By: ",
            "Team Score",
            "Versus Scores",
            "Player Score",
            "Player High Score",
            "Previous Scores"

        ]
    ]

    strings_msg = [
        [
            "No Scenario Data Loaded",
            "Wants to Start the Scenario",
            "Bot #"

        ]
    ]

    strings_units = [
        [
            "Points",
            "Seconds"

        ]
    ]
    
    data_loaded[DATA_TYPE.STATIC] = true
