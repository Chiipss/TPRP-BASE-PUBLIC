Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--Pacific Vault
	{
		objName = 'v_ilev_bk_vaultdoor',
		objYaw = -200.0,
		objCoords  = vector3(255.228, 223.930, 102.426),
		textCoords = vector3(255.228, 223.930, 102.426),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	--
	-- Mission Row First Floor
	--

	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police', 'offpolice' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Armory
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = -90.0,
		objCoords  = vector3(452.6, -982.7, 30.6),
		textCoords = vector3(453.0, -982.6, 31.7),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- To downstairs (double doors)

	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.3, -988.7, 30.6)
			}
		}
	},

	-- New doble doors (leading to downstair stuff near cells)

	{
		textCoords = vector3(465.5, -990.0, 25.4),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 90.0,
				objCoords = vector3(465.5, -989.1, 24.9)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = -90.0,
				objCoords = vector3(465.5, -990.4, 24.9)
			}
		}
	},

	{
		textCoords = vector3(452.0, -983.8, 26.8),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(450.7, -983.8, 26.8)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(453.7, -983.8, 26.8)
			}
		}
	},
	{
		textCoords = vector3(446.1, -986.6, 26.8),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = -90.0,
				objCoords = vector3(446.1, -987.7, 26.8)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 90.0,
				objCoords = vector3(446.1, -985.1, 26.8)
			}
		}
	},

	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	-- To Back
	{
		objName = 'v_ilev_gtdoor',
		objYaw = 0.0,
		objCoords  = vector3(463.4, -1003.5, 25.0),
		textCoords = vector3(464.0, -1003.5, 25.5),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},

	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 18,
		size = 2
	},

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = 'v_ilev_shrfdoor',
		objYaw = 30.0,
		objCoords  = vector3(1855.1, 3683.5, 34.2),
		textCoords = vector3(1855.1, 3683.5, 35.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = false
	},
	--Front interior right-door.
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 210.0,
		objCoords  = vector3(1857.254, 3690.12, 34.2),
		textCoords = vector3(1856.344, 3689.788, 34.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objYaw = 300.0,
		objCoords  = vector3(1844.264, 3694.152, 34.416),
		textCoords = vector3(1844.7, 3693.207, 34.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 28.782,
		objCoords  = vector3(1847.133, 3689.946, 34.418),
		textCoords = vector3(1847.7, 3690.507, 34.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 209.105,
		objCoords  = vector3(1849.4, 3691.206, 34.41842),
		textCoords = vector3(1848.498, 3690.713, 34.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 120.598,
		objCoords  = vector3(1851.288, 3681.87, 34.41656),
		textCoords = vector3(1850.762, 3682.781, 34.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 300.176,
		objCoords  = vector3(1849.982, 3684.115, 34.41656),
		textCoords = vector3(1850.430, 3683.159, 34.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_rc_door2',
		objYaw = 30.176,
		objCoords  = vector3(1846.414, 3682.625, 30.411),
		textCoords = vector3(1847.314, 3683.140, 30.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 30.176,
		objCoords  = vector3(1852.921, 3686.407, 30.413),
		textCoords = vector3(1852.036, 3686.01, 30.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 29.875,
		objCoords  = vector3(1856.16, 3688.269, 30.413),
		textCoords = vector3(1855.33, 3687.776, 30.347),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		textCoords = vector3(-443.5, 6016.3, 32.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_shrf2door',
				objYaw = -45.0,
				objCoords  = vector3(-443.1, 6015.6, 31.7),
			},

			{
				objName = 'v_ilev_shrf2door',
				objYaw = 135.0,
				objCoords  = vector3(-443.9, 6016.6, 31.7)
			}
		}
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 12,
		size = 2
	},

	--[[ car dealer gates
	{
		objName = 'prop_facgate_08',
		objCoords  = vector3(-37.5, -1075.7, 25.7),
		textCoords = vector3(-37.5, -1078.7, 27.7),
		authorizedJobs = { 'cardealer' },
		locked = false,
		distance = 12,
		size = 2
	},
	{
		objName = 'prop_facgate_08',
		objCoords  = vector3(-20.8, -1117.6, 25.9),
		textCoords = vector3(-23.8, -1117.6, 27.9),
		authorizedJobs = { 'cardealer' },
		locked = false,
		distance = 12,
		size = 2
	},
	--]]
	
							{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(472.2,-1003.44,24.91),
		textCoords = vector3(472.2,-1003.44,24.91),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},
						{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(476.4,-1003.44,24.91),
		textCoords = vector3(476.4,-1003.44,24.91),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},
					{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(480.72,-1003.44,24.91),
		textCoords = vector3(480.72,-1003.44,24.91),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},
				{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(480.76,-996.59,24.91),
		textCoords = vector3(480.76,-996.59,24.91),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},
			{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(476.44,-996.55,24.91),
		textCoords = vector3(476.44,-996.55,24.91),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},
		{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(472.22,-996.51,24.91),
		textCoords = vector3(472.22,-996.51,24.91),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},		
		{
		objName = 'v_ilev_gtdoor',
		objCoords  = vector3(467.85,-996.53,24.91),
		textCoords = vector3(467.85,-996.53,24.91),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},	
	-- Side entrance doors
	{
		textCoords = vector3(445.9, -999.0, 30.7),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_gtdoor',
				objYaw = 180.0,
				objCoords = vector3(447.2, -999.0, 30.7)
			},

			{
				objName = 'v_ilev_gtdoor',
				objYaw = 0.0,
				objCoords = vector3(444.6, -999.0, 30.7)
			}
		}
	},
	
	{
		objName = 'v_ilev_ph_gendoor005',
		objYaw = 90.0,
		objCoords  = vector3(450.1, -981.4, 30.8),
		textCoords = vector3(450.1, -982.2, 31.0),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},		
	{
		objName = 'v_ilev_ph_gendoor005',
		objCoords  = vector3(450.1, -984.0, 30.8),
		textCoords = vector3(450.1, -984.0, -100.8),
		objYaw = -90.0,
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,


	},	
	{
		objHash = -305065920,
		objCoords  = vector3(946.2, -984.7, 41.5),
		textCoords = vector3(946.2, -984.3, 40.3),
		--objYaw = -90.0,
		authorizedJobs = { 'mechanic', 'offmechanic', 'police', 'offpolice', 'cardealer' },
		locked = true,
		distance = 14,
		size = 1


	},
	--LOST MC
	{
		objHash = -930593859,
		objCoords  = vector3(956.452, -137.839, 73.57),
		textCoords = vector3(960.37744140625,-139.955,74.47876739502),
		--objYaw = -90.0,
		authorizedJobs = { 'cardealer'},
		locked = true,
		distance = 14,
		size = 1


	},
	{
		objHash = -197537718,
		objCoords  = vector3(982.379, -125.366, 75.03),
		textCoords = vector3(982.48175048828,-125.40828704834,74.045082092285),
		--objYaw = -90.0,
		authorizedJobs = { 'cardealer'},
		locked = true,
		distance = 14,
		size = 1


	},

	{
		objName = 'v_ilev_carmod3door',
		objCoords  = vector3(963.166, -117.329, 75.29),
		textCoords = vector3(963.11645507813,-117.40911102295,74.363487243652),
		--objYaw = 100.0,
		authorizedJobs = { 'cardealer'},
		locked = true,
		distance = 0,


	},
	{
		objName = 'v_ilev_carmod3door',
		objCoords  = vector3(968.760, -112.109, 75.29),
		textCoords = vector3(968.90191650391,-112.1771697998,74.353179931641),
		--objYaw = 100.0,
		authorizedJobs = { 'cardealer'},
		locked = true,
		distance = 10,


	},

	----------------------

	{
		objName = 'v_ilev_roc_door3',
		objCoords  = vector3(948.7, -964.4, 39.8),
		textCoords = vector3(948.7, -963.8, 40.2),
		objYaw = 90.0,
		authorizedJobs = { 'mechanic', 'offmechanic', 'police', 'offpolice', 'cardealer' },
		locked = true,


	},
	{
		objName = 'v_ilev_roc_door2',
		objCoords  = vector3(955.6, -971.5, 39.9),
		textCoords = vector3(955.0, -971.5, 40.2),
		objYaw = 180.0,
		authorizedJobs = { 'mechanic', 'offmechanic', 'police', 'offpolice', 'cardealer' },
		locked = true,


	},	

	--
	-- Addons
	--
	
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_facgate_08',
		objCoords  = vector3(410.7606, -1027.048, 28.40136),
		textCoords = vector3(410.7606, -1024.500, 30.40136),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true,
		distance = 14,
		size = 1
    },
    
    -----------------------------------------
    ------------- VAGOS TACOS ---------------
    -----------------------------------------
    {
		objHash = -176100808,
		objCoords  = vector3(13.552, -1605.699, 29.523),
		textCoords = vector3(12.93,-1605.342,30.0),
		authorizedJobs = {'vagos'},
        locked = true,
        objYaw = 320.0,
    },
    {
		objHash = -176100808,
		objCoords  = vector3(9.33, -1599.93, 29.523),
		textCoords = vector3(8.92,-1600.43, 30.0),
		authorizedJobs = {'vagos'},
        locked = true,
        objYaw = 49.8,
    },
    {
		objHash = -176100808,
		objCoords  = vector3(19.526,-1599.98,29.523),
        textCoords  = vector3(19.076974868774,-1599.4967041016,29.389762878418),
        objYaw = 320.0,
		authorizedJobs = {'vagos'},
		locked = true,
    },
    {
		objHash = -176100808,
		objCoords  = vector3(20.349, -1603.969, 29.523),
        textCoords  = vector3(19.84,-1604.59,29.3906),
        objYaw = 50.0,
		authorizedJobs = {'vagos'},
		locked = true,
    },

    -----------------------------------
    ------------- LSWC ----------------
    -----------------------------------
    {
        objHash = 534758478,
        objCoords  = vector3(-1879.15300,2056.40600,141.13410),
        textCoords = vector3(-1878.9384,2056.9335,140.984),
        objYaw = 250.0,
        authorizedJobs = {'lswc'},
        locked = true,
    },
    {
        objHash = -710818483,
        objCoords  = vector3(-1860.67200,2057.72700,135.68900),
        textCoords = vector3(-1860.69384,2058.472, 135.459),
        objYaw = 269.7,
        authorizedJobs = {'lswc'},
        locked = true,
    },
    {
        objHash = -710818483,
        objCoords  = vector3(-1864.813, 2057.723, 135.689),
        textCoords = vector3(-1864.816,2058.445,135.445),
        objYaw = 269.7,
        authorizedJobs = {'lswc'},
        locked = true,
    },
    {
        objHash = 534758478,
        objCoords  = vector3(-1885.679, 2060.775, 145.731),
        textCoords = vector3(-1885.0921630859,2060.3237304688,145.9),
        objYaw = 160.0,
        authorizedJobs = {'lswc'},
        locked = true,
    },
    {
        objHash = 534758478,
        objCoords  = vector3(-1883.23, 2059.88, 145.73),
        textCoords = vector3(-1884.0040283203,2060.1755371094,145.9),
        objYaw = 340.0,
        authorizedJobs = {'lswc'},
        locked = true,
	},
	
	{
		objName = 'v_ilev_ph_gendoor006',
		objYaw = 180.0,
		objCoords  = vector3(466.75,-1003.46, 25.05),
		textCoords = vector3(467.52,-1003.52, 25.05),
		authorizedJobs = { 'police', 'offpolice' },
		locked = true
	},

	{ -- Extra Cell 5
        objName = 'v_ilev_gtdoor',
        objCoords  = vector3(480.63, -997.90, 24.91),
        textCoords = vector3(479.89, -997.77, 24.91),
        authorizedJobs = { 'police', 'offpolice' },
        locked = true,
        objYaw = 180.0

    },
    
    { -- Extra Cell 2
        objName = 'v_ilev_gtdoor',
        objCoords  = vector3(471.32, -998.32, 24.91),
        textCoords = vector3(471.22, -996.51, 24.91),
        authorizedJobs = { 'police', 'offpolice' },
        locked = true,
        objYaw = 180.0,

    },        
    
    { -- Extra Cell 1
        objName = 'v_ilev_gtdoor',
        objCoords  = vector3(469.10, -997.90, 25.04),
        textCoords = vector3(468.48, -998.28, 25.04),
        authorizedJobs = { 'police', 'offpolice' },
        locked = true,
        objYaw = 180.0,
    },

    { -- Extra Cell 3
        objName = 'v_ilev_gtdoor',
        objYaw = 180.0,
        objCoords  = vector3(474.86, -997.90, 25.04),
        textCoords = vector3(474.11, -997.52, 25.04),
        authorizedJobs = { 'police', 'offpolice' },
        locked = true
    },

    { -- Extra Cell 4
        objName = 'v_ilev_gtdoor',
        objCoords  = vector3(477.75, -997.90, 25.04),
        textCoords = vector3(476.80, -997.88, 25.04),
        authorizedJobs = { 'police', 'offpolice' },
        locked = true,
        objYaw = 180.0,
    },

    -------------------------
    ---- VANILLA UNICORN ----
    -------------------------

    { -- Office to Parking Lot  
        objName = 'prop_magenta_door',
        objCoords  = vector3(96.091, -1284.854, 29.438),
        textCoords = vector3(95.5861, -1285.3039, 29.3800),
        authorizedJobs = { 'vanillaunicorn' },
        locked = true,
        objYaw = 210.0,
    },

    { -- Office to Dressing Room  
        objName = 'v_ilev_roc_door2',
        objCoords  = vector3(99.083, -1293.701, 29.418),
        textCoords = vector3(99.5963, -1293.2485, 29.3687),
        authorizedJobs = { 'vanillaunicorn' },
        locked = true,
        objYaw = 30.0,
    },

    { -- Dressing Room to Main Area 
        objName = 'v_ilev_door_orangesolid',
        objCoords  = vector3(113.98, -1297.43, 29.418),
        textCoords = vector3(113.6468, -1296.8188, 29.5687),
        authorizedJobs = { 'vanillaunicorn' },
        locked = true,
        objYaw = 300.0,
    },

    { -- Parking Lot to Main Area 
        objName = 'prop_strip_door_01',
        objCoords  = vector3(127.955, -1298.503, 29.419),
        textCoords = vector3(128.513,-1298.195, 29.369),
        authorizedJobs = { 'vanillaunicorn' },
        locked = true,
        objYaw = 30.0,
    },

    -------------------------
    ---- DIAMOND CASINO  ----
    -------------------------

    { -- Management Doors
		textCoords = vector3(946.91247558594, 40.86861038208, 25.617230224609),
		authorizedJobs = { 'diamondcasino' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objHash = 21324050,
				objYaw = 327.80,
				objCoords = vector3(945.852, 41.5786, 25.8209)
			},

			{
				objHash = 21324050,
				objYaw = 148.224,
				objCoords = vector3(947.981, 40.2479, 25.8209)
			}
		}
	},

    { -- Entrance Doors
		textCoords = vector3(1006.0042, 73.7319, 23.4763),
		authorizedJobs = { 'diamondcasino' },
		locked = true,
		distance = 2.5,
		doors = {
			{
				objHash = 680601509,
				objYaw = 237.80,
				objCoords = vector3(1006.497, 74.605, 23.426)
			},

			{
				objHash = 680601509,
				objYaw = 58.21,
				objCoords = vector3(1005.43, 72.909, 23.426)
			}
		}
    },
    
    -------------------------
    ----- MERRYWEATHER  -----
    -------------------------

    { -- Office Door 1
        objName = 'v_ilev_ss_door01',
        objCoords  = vector3(585.969, -3117.248, 18.918),
        textCoords = vector3(585.90228271484, -3117.9396972656, 18.768583297729),
        authorizedJobs = { 'merryweather' },
        locked = true,
        objYaw = 90.0,
    },
    { -- Office Door 2
        objName = 'v_ilev_ss_door01',
        objCoords  = vector3(552.47, -3117.248, 18.918),
        textCoords = vector3(552.21557617188, -3117.8979492188, 18.768398284912),
        authorizedJobs = { 'merryweather' },
        locked = true,
        objYaw = 90.0,
    },
    { -- Gate 1
		objName = 'prop_gate_docks_ld',
		objYaw = 180.0,
		objCoords  = vector3(476.327, -3115.92, 5.1623),
		textCoords = vector3(478.99395751953, -3116.203125, 6.5700612068176),
		authorizedJobs = { 'merryweather' },
		locked = true,
		distance = 10,
		size = 2
    },
    { -- Gate 2
		objName = 'prop_gate_docks_ld',
		objYaw = 0.0,
		objCoords  = vector3(492.2758, -3115.93, 5.1623),
		textCoords = vector3(489.51806640625,-3116.0261230469, 6.5700597763062),
		authorizedJobs = { 'merryweather' },
		locked = true,
		distance = 10,
		size = 2
	},
    { -- Pawn Shop Door
        objName = 'v_ilev_tort_door',
        objCoords  = vector3(134.395, -2204.09, 7.51433),
        textCoords = vector3(134.33181762695, -2203.4694824219, 7.3598127365112),
        authorizedJobs = { 'merryweather' },
        locked = true,
        objYaw = 270.0,
    },
}