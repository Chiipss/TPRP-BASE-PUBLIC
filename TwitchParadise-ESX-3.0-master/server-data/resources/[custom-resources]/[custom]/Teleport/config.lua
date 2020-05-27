--[[ 
----------TEMPLATE

	zoneXFromOutToIn = {
		x = obviously X,
		y = obviously Y,
		z = obviously Z,
		w = obviously WIDTH,
		h = obviously HEIGHT,		
		visible = true,
		t = obviously TYPE,
		color = {
			r = obviously RED,
			g = obviously GREEN,
			b = obviously BLUE
		}
	},

If you don't want the marker to be visible, you're not obliged to
type more data after it:

	zoneXFromOutToIn = {
		x = obviously X,
		y = obviously Y,
		z = obviously Z,
		w = obviously WIDTH,
		h = obviously HEIGHT,		
		visible = false
	},
]]
-- To get a list of available marker go to https://docs.fivem.net/game-references/markers/

Config = {}

-- C key by default
Config.actionKey = 38

-- markers AKA Teleporters
Config.zones = {
	
--[[ 	WeedEnter = {           --This is the entrance where you go to enter the weed warehouse
		x = 2221.858,
		y = 5614.81,
		z = 54.902,
		w = 2.0,
		h = 1.0,
		visible = true, -- Set this to true to make the marker visible. False to disable it.
		t = 29,          -- This is the marker. You can change it https://docs.fivem.net/game-references/markers
		color = {
			r = 0,
			g = 102,
			b = 0,
			a = 50
		}
		
	},
	
	WeedExit = {          --This is the exit where you go to exit the weed warehouse
		x = 1038.863,
		y = -3197.662,
		z = -38.17,
		w = 2.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0,
			a = 50
		}
		
	}, ]]
	
	MoneyWashEnter = {
		x = 1639.516,
		y = 4879.4,
		z = 42.141,
		w = 2.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0,
			a = 50
		}
		
	},
	
	MoneyWashExit = {
		x = 1138.146,
		y = -3199.096,
		z = -39.666,
		w = 2.0,
		h = 1.0,
		visible = true,
		t = 29,
		color = {
			r = 0,
			g = 102,
			b = 0,
			a = 50
		}
		
	},

	MethEnter = {
		x = 1386.659,
		y = 3622.805,
		z = 35.012,
		w = 2.0,
		h = 1.0,		
		visible = true,
		t = 1,
		color = {
			r = 102,
			g = 0,
			b = 0,
			a = 50
		}
	},
	
	MethExit = {
		x = 1012.136,
		y = -3202.527,
		z = -38.993,
		w = 2.0,
		h = 1.0,		
		visible = true,
		t = 1,
		color = {
			r = 102,
			g = 0,
			b = 0,
			a = 50
		}
	},

	CokeEnter = {
		x = 47.842,
		y = 3701.961,
		z = 40.722,
		w = 1.0,
		h = 1.0,		
		visible = true,
		t = 1,
		color = {
			r = 255,
			g = 255,
			b = 255,
			a = 50
		}
	},
	
	CokeExit = {
		x = 1103.190,
		y = -3197.156,
		z = -39.393,
		w = 1.0,
		h = 1.0,		
		visible = true,
		t = 1,
		color = {
			r = 255,
			g = 255,
			b = 255,
			a = 50
		}
	},

	PDenter = {           --This is the entrance where you go to enter the weed warehouse
		x = 2476.051,
		y = -384.189,
		z = 94.401,
		w = 2.0,
		h = 1.0,
		visible = true, -- Set this to true to make the marker visible. False to disable it.
		t = 20,          -- This is the marker. You can change it https://docs.fivem.net/game-references/markers
		color = {
			r = 0,
			g = 0,
			b = 520,
			a = 50
		}
		
	},
	
	PDexit = {          --This is the exit where you go to exit the weed warehouse
		x = 2129.011,
		y = 2925.653,
		z = -61.902,
		w = 2.0,
		h = 1.0,
		visible = true,
		t = 20,          -- This is the marker. You can change it https://docs.fivem.net/game-references/markers
		color = {
			r = 0,
			g = 0,
			b = 520,
			a = 50
		}
		
	},

	EMenter = {           --This is the entrance where you go to enter the weed warehouse
		x = 309.924,
		y = -602.851,
		z = 43.283,
		w = 1.0,
		h = 0.5,
		visible = false, -- Set this to true to make the marker visible. False to disable it.
		t = 20,          -- This is the marker. You can change it https://docs.fivem.net/game-references/markers
		color = {
			r = 0,
			g = 0,
			b = 520,
			a = 50
		}
		
	},
	
	EMexit = {          --This is the exit where you go to exit the weed warehouse
		x = 338.466,
		y = -583.929,
		z = 74.166,
		w = 2.0,
		h = 1.0,
		visible = false,
		t = 20,          -- This is the marker. You can change it https://docs.fivem.net/game-references/markers
		color = {
			r = 0,
			g = 0,
			b = 520,
			a = 50
		}
		
	},

	LiftEnter = {           --This is the entrance where you go to enter the weed warehouse
		x = 2154.972,
		y = 2920.973,
		z = -81.075,
		w = 1.5,
		h = 1.0,
		visible = true, -- Set this to true to make the marker visible. False to disable it.
		t = 20,          -- This is the marker. You can change it https://docs.fivem.net/game-references/markers
		color = {
			r = 0,
			g = 0,
			b = 520,
			a = 50
		}
		
	},
	
	LiftExit = {          --This is the exit where you go to exit the weed warehouse
		x = 2154.972,
		y = 2920.973,
		z = -61.902,
		w = 1.5,
		h = -1.0,
		visible = true,
		t = 20,
		color = {
			r = 0,
			g = 0,
			b = 520,
			a = 50
		}
		
    },
    
    CasinoEnter = {
        x = 930.80, 
        y = 44.36, 
        z = 80.12,
		w = 2.5,
		h = 1.0,
		visible = true,
		t = 27,
		color = {
			r = 147,
			g = 206,
			b = 255,
			a = 128
		}
    },

    CasinoExit = {
        x = 927.340,
		y = 44.763,
		z = 30.15,
		w = 2.5,
		h = 1.0,
		visible = true,
		t = 27,
		color = {
			r = 147,
			g = 206,
			b = 255,
			a = 128
		}
    },

    VUBarEnter = {
        x = 108.44746398926, 
        y =- 1305.0439453125, 
        z = 27.78,
		w = 2.5,
		h = 1.0,
		visible = true,
		t = 27,
		color = {
			r = 147,
			g = 206,
			b = 255,
			a = 128
		}
    },

    VUBarExit = { 
        x = 124.15617370605,
        y = -1280.0794677734,
        z = 28.30,
		w = 2.5,
		h = 1.0,
		visible = true,
		t = 27,
		color = {
			r = 147,
			g = 206,
			b = 255,
			a = 128
		}
    }

}

-- Landing point, keep the same name as markers
Config.point = {

	WeedEnter = {           --This is where you land when you use the entrance teleport.
		x = 1066.009,
		y = -3183.386,
		z = -39.164
	},
	
	WeedExit = {             --This is where you land when you use the exit teleport.
		x = 2220.113,
		y = 5603.523,
		z = 54.706
	},

	MethEnter = {
		x = 998.629,
		y = -3199.545,
		z = -36.394
	},
	
	MethExit = {
		x = 1395.33,
		y = 3623.705,  
		z = 35.012
	},

	CokeEnter = {
		x = 1088.636,
		y = -3188.551, 
		z = -38.993
	},
	
	CokeExit = {
		x = 41.412,
		y = 3705.19, 
		z = 40.719
	},
	
	MoneyWashEnter = {
		x = 1118.405,
		y = -3193.687,
		z = -40.394
	},
	
	MoneyWashExit = {
		x = 1639.008,
		y = 4870.545,
		z = 42.03
	},

	PDenter = {           --This is where you land when you use the entrance teleport.
		x = 2129.011,
		y = 2921.653,
		z = -61.902
	},
	
	PDexit = {             --This is where you land when you use the exit teleport.
		x = 2479.051,
		y = -384.189,
		z = 94.401
	},

	EMenter = {           --This is where you land when you use the entrance teleport.
		x = 341.038,
		y = -585.019,
		z = 74.166
	},
	
	EMexit = {             --This is where you land when you use the exit teleport.
		x = 309.092,
		y = -602.404,
		z = 43.292
	},


	LiftEnter = {
		x = 2152.972,
		y = 2921.174,
		z = -61.902,
	},
	
	LiftExit = {
		x = 2156.972,
		y = 2921.174,
		z = -81.075
    },
    
    CasinoEnter = {
        x = 938.3118,
        y = 38.0782,
        z = 25.3172
    },

    CasinoExit = {
        x = 929.417, 
        y = 42.245, 
        z = 81.093
    },

    VUBarEnter = {
        x =124.24136352539, 
        y =-1279.8488769531, 
        z =29.269550323486
    },

    VUBarExit = {
        x = 108.44746398926, 
        y =- 1305.0439453125, 
        z = 27.78,
    }
}


-- Automatic teleport list (no need to puseh E key in the marker)
Config.auto = {
	'LiftEnter',
	'LiftExit',
	'PDenter',
	'PDexit',
	'EMenter',
	'EMexit',
	'WeedEnter',
	'WeedExit',
	'MoneyWashEnter',
	'MoneyWashExit',
	'CokeEnter',
	'CokeExit',
	'MethEnter',
    'MethExit',
    'CasinoEnter',
    'CasinoExit'
}
