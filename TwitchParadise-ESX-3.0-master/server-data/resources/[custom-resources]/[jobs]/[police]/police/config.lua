Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.0, y = 1.0, z = 0.5 }
Config.MarkerColor                = { r = 255, g = 255, b = 255 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.gsrUpdate                = 1 * 1000          -- Change first number only, how often a new shot is logged dont set this to low keep it above 1 min - raise if you experience performans issues (default: 1 min).
Config.waterClean               = true              -- Set to false if you dont want water to clean off GSR from people who shot
Config.waterCleanTime           = 30 * 1000         -- Change first number only, Set time in water needed to clean off GSR (default: 30 sec).
Config.gsrTime                  = 30 * 60           -- Change The first number only, if you want the GSR to be auto removed faster output is minutes (default: 30 min).
Config.gsrAutoRemove            = 10 * 60 * 1000    -- Change first number only, to set the auto clean up in minuets (default: 10 min).
Config.gsrUpdateStatus          = 5 * 60 * 1000     -- Change first number only, to change how often the client updates hasFired variable dont set it to high 5-10 min should be fine. (default: 5 min).
Config.UseCharName				= true				-- This will show the suspects name in the PASSED or FAILED notification.Allows cop to make sure they checked the right person.


Config.PoliceStations = { 

	LSPD = {

		Blip = {
			Coords  = vector3(-1110.0775146484,-835.14630126953,13.336032867432),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, -29.7)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(457.84,-1011.43,27.33),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(445.91,-1024.86,28.65), heading = 0, radius = 4.0 },
					{ coords = vector3(438.57,-1026.12,28.79), heading = 0, radius = 4.0 },
					{ coords = vector3(431.17,-1026.94,28.92), heading = 0, radius = 4.0 },
					{ coords = vector3(452.16,-1024.83,28.53), heading = 0, radius = 4.0 }
				}
			},

			{
				Spawner = vector3(473.1,-1019.52,27.16),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(478.37,-1023.55,28.04), heading = 316.14, radius = 4.0 },
					{ coords = vector3(473.1,-1024.36,28.15), heading = 316.14, radius = 4.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(461.27,-981.1,42.71),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(449.2,-981.2,43.69), heading = 90.0, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(448.4, -973.2, 30.6)
		}

	},

	SSPD = {

		Blip = {
			Coords  = vector3(1855.578, 3683.289, 34.268),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(1849.393, 3689.364, 34.267)
		},

		Armories = {
			vector3(1857.354, 3689.485, 34.267)
		},

		Vehicles = {
			{
				Spawner = vector3(1870.965, 3690.172, 32.670),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(1861.27, 3679.05, 33.67), heading = 212.139, radius = 6.0 },
					{ coords = vector3(1867.02, 3683.18, 33.7), heading = 212.139, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1859.022, 3655.341, 33.072),
				InsideShop = vector3(1867.923, 3647.327, 35.823),
				SpawnPoints = {
					{ coords = vector3(1867.923, 3647.327, 35.823), heading = 348.395, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(1853.295, 3689.945, 34.267)
		}

	},

	PBPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, -29.7)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(-459.4, 6012.82, 30.5),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-462.42, 6009.66, 31.34), heading = 89.08, radius = 6.0 },
					{ coords = vector3(-454.93, 6001.96, 31.34), heading = 89.08, radius = 6.0 },
					{ coords = vector3(-447.57, 5994.38, 31.34), heading = 89.08, radius = 6.0 },
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(-462.82, 5996.97, 30.25),
				InsideShop = vector3(-475.39, 5988.52, 31.34),
				SpawnPoints = {
					{ coords = vector3(-475.4, 5988.52, 31.34), heading = 0, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(-448.99, 6012.58, 31.72)
		}

	},

	VPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, -29.7)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(-1126.43, -833.32, 13.4),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-1112.12, -854.98, 13.53), heading = 37.1, radius = 6.0 },
					{ coords = vector3(-1123.18, -862.59, 13.57), heading = 37.1, radius = 6.0 },
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(-1094.6708984375,-839.19274902344,37.700416564941),
				InsideShop = vector3(-1096.1905517578,-832.693359375,38.093082427979),
				SpawnPoints = {
					{ coords = vector3(-1096.1905517578,-832.693359375,38.093082427979), heading = 90.0, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(-1071.9161376953,-821.25152587891,5.4796876907349)
		}

	},
	VineWoodPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, -29.7)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(535.543, -22.67, 69.63),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(534.49, -26.95, 70.63), heading = 208.2, radius = 6.0 },
					{ coords = vector3(530.01, -29.33, 70.63), heading = 208.2, radius = 6.0 },
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(572.32,7.44,102.23),
				InsideShop = vector3(579.92,12.5,103.23),
				SpawnPoints = {
					{ coords = vector3(579.92,12.5,103.23), heading = 90.0, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(-1071.9161376953,-821.25152587891,-5000.4796876907349)
		},
		

	},
	RockfordPD = {

		Blip = {
			Coords  = vector3(425.1, -979.5, 30.7),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Cloakrooms = {
			vector3(452.6, -992.8, -29.7)
		},

		Armories = {
			vector3(451.7, -980.1, 30.6)
		},

		Vehicles = {
			{
				Spawner = vector3(-562.64, -144.04, 37.39),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-571.3, -143.26, 37.42), heading = 200.61, radius = 6.0 },
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(572.32,7.44,-1020.23),
				InsideShop = vector3(579.92,12.5,103.23),
				SpawnPoints = {
					{ coords = vector3(579.92,12.5,103.23), heading = 90.0, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(-1071.9161376953,-821.25152587891,-5000.4796876907349)
		},
		

	}
}

Config.AuthorizedWeapons = {
	recruit = {
		--{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 10000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	officer = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergeant = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	intendent = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	lieutenant = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	chef = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 0, nil }, price = 0 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 0 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
		--
		{ model = 'scorcher', label = 'Police Bicycle', price = 0 },
		{ model = 'policeb', label = 'Police Motobike', price = 0 },
		{ model = 'vic', label = 'Crown Victoris 2011', price = 0 },
		{ model = 'tau', label = 'Taurus', price = 0 },
		{ model = 'charger18', label = 'Dodge Charger 2018', price = 0 },
		{ model = 'charger14', label = 'Dodge Charger 2014', price = 0 },
		{ model = 'explorer16', label = 'Ford Explorer 2016', price = 0 },
		{ model = '2015polstang', label = 'Ford Mustang GT500', price = 0 },
		{ model = 'camaro', label = 'DEA Camaro', price = 0 },
		{ model = 'raptortruck', label = 'Ford Raptor', price = 0 },
		{ model = 'riot', label = 'Riot Van', price = 0 },
		{ model = 'pbus', label = 'Prison Bus', price = 0 },
		{ model = 'polschafter3', label = 'Undercover Schafter', price = 0 },
		{ model = 'policefelon', label = 'Undercover Felon', price = 0 },
		{ model = 'fbi', label = 'Undercover Muscle', price = 0 },
		{ model = 'fbi2', label = 'Undercover SUV', price = 0 },
		{ model = 'flatbed3', label = 'Flatbed', price = 0 }		

	},

	recruit = {

	},

	officer = {

	},

	sergeant = {

	},

	intendent = {


	},

	lieutenant = {

	},

	chef = {


	},

	boss = {

	}
}

Config.AuthorizedHelicopters = {
	recruit = {},

	officer = {},

	sergeant = {},

	intendent = {},

	lieutenant = {
		{ model = 'as350', label = 'Police Maverick', livery = 0, price = 0 }
	},

	chef = {
		{ model = 'as350', label = 'Police Maverick', livery = 0, price = 0 }
	},

	boss = {
		{ model = 'as350', label = 'Police Maverick', livery = 0, price = 0 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 1,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}