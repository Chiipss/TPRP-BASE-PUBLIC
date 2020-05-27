Config = {}
Config.Locale = 'en'
Config.PoliceNumberRequired = 2
Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	-- Example
	--[[ {
		objName = 'v_ilev_ph_door01',
		objCoords  = {x = 434.747, y = -980.618, z = 30.839},
		textCoords = {x = 434.747, y = -981.50, z = 31.50},
		authorizedJobs = { 'police' },
		locked = false,
		distance = 2
	}, ]]
	--Piston enterence 
	{
		objHash = -1033001619,
		objCoords  = {x = 1819.129, y = 2593.64, z = 46.099},
		textCoords = {x = 1819.218, y = 2594.602, z = 46.077},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = -1033001619,
		objCoords  = {x = 1826.466, y = 2585.271, z = 46.099},
		textCoords = {x = 1826.333, y = 2586.316, z = 46.077},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = -1033001619,
		objCoords  = {x = 1827.726, y = 2584.6, z = 46.099},
		textCoords = {x = 1828.695, y = 2584.6, z = 46.077},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = -1033001619,
		objCoords  = {x = 1837.697, y = 2585.697, z = 46.099},
		textCoords = {x = 1837.685, y = 2586.384, z = 46.077},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = -1033001619,
		objCoords  = {x = 1834.002, y = 2591.111, z = 46.099},
		textCoords = {x = 1834.03, y = 2592.146, z = 46.077},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = -1033001619,
		objCoords  = {x = 1837.714, y = 2595.185, z = 46.099},
		textCoords = {x = 1837.786, y = 2594.247, z = 46.077},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	--Medical room 
	{
		objHash = 262839150,
		objCoords  = {x = 1791.682, y = 2551.343, z = 46.092},
		textCoords = {x = 1791.589, y = 2552.492, z = 46.077},
		authorizedJobs = { 'police', 'ambulance' },
		locked = true,
		distance = 2
	},

	--Armoury
	{
		objHash = 1028191914,
		objCoords  = {x = 1783.137, y = 2548.623, z = 45.97},
		textCoords = {x = 1783.178, y = 2547.453, z = 45.877},
		authorizedJobs = { 'police', 'ambulance' },
		locked = true,
		distance = 2
	},
	{
		objHash = 1028191914,
		objCoords  = {x = 1782.014, y = 2545.443, z = 45.97},
		textCoords = {x = 1780.849, y = 2545.389, z = 45.798},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = 1028191914,
		objCoords  = {x = 1784.653, y = 2550.299, z = 45.98},
		textCoords = {x = 1785.723, y = 2550.333, z = 45.798},
		authorizedJobs = { 'police', 'ambulance' },
		locked = true,
		distance = 2
	},

	--Main prison doors.
	{
		objHash = 262839150,
		objCoords  = {x = 1791.114, y = 2593.204, z = 46.31},
		textCoords = {x = 1791.114, y = 2593.204, z = 46.31},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = 1645000677,
		objCoords  = {x = 1791.063, y = 2594.403, z = 46.31},
		textCoords = {x = 1791.063, y = 2594.403, z = 46.31},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

	--main cell open doors

	{
		objHash = 430324891,
		objCoords  = {x = 1785.807, y = 2590.021, z = 44.79},
		textCoords = {x = 1786.907, y = 2589.621, z = 45.65},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3
	},

	{
		objHash = 1028191914,
		objCoords  = {x = 1783.890, y = 2599.207, z = 45.97},
		textCoords = {x = 1783.890, y = 2598.107, z = 45.97},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3
	},

	{
		objHash = 1028191914,
		objCoords  = {x = 1785.977, y = 2566.896, z = 45.98},
		textCoords = {x = 1784.977, y = 2566.896, z = 45.98},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 3
	},

	{
		objHash = 1645000677,
		objCoords  = {x = 1776.125, y = 2551.352, z = 46.09},
		textCoords = {x = 1776.125, y = 2552.352, z = 46.09},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.2
	},

	{
		objHash = 631614199,
		objCoords  = {x = -1073.832, y = -827.357, z = 6.436},
		textCoords = {x = -1072.967, y = -827.121, z = 5.496},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},


	--
	{
		objHash = 631614199,
		objCoords  = {x = -1087.408, y = -829.488, z = 5.479},
		textCoords = {x = -1086.808, y = -829.250, z = 5.779},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
--
	{
		objHash = 631614199,
		objCoords  = {x = -1086.251, y = -827.473, z = 5.479},
		textCoords = {x = -1086.651, y = -826.873, z = 5.479},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
--
	{
		objHash = 631614199,
		objCoords  = {x = -1089.057, y = -829.786, z = 5.479},
		textCoords = {x = -1089.657, y = -829.386, z = 5.479},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

--
	{
		objHash = 631614199,
		objCoords  = {x = -1088.581, y = -824.363, z = 5.479},
		textCoords = {x = -1088.776, y = -823.836, z = 5.479},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
--

	{
		objHash = 631614199,
		objCoords  = {x = -1091.499, y = -826.559, z = 5.479},
		textCoords = {x = -1091.814, y = -826.192, z = 5.479},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
--
	{
		objHash = 631614199,
		objCoords  = {x = -1090.778, y = -821.344, z = 5.479},
		textCoords = {x = -1091.172, y = -820.657, z = 5.479},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
--
	{
		objHash = 631614199,
		objCoords  = {x = -1093.753, y = -823.632, z = 5.489},
		textCoords = {x = -1094.217, y = -823.011, z = 5.476},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
--
	{
		objHash = 631614199,
		objCoords  = {x = -1096.247, y = -820.347, z = 5.551},
		textCoords = {x = -1096.649, y = -819.925, z = 5.479},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

	{
		objHash = -1255368438,
		objCoords  = {x = -1077.567, y = -824.695, z = 11.182},
		textCoords = {x = -1078.146, y = -825.103, z = 11.037},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

	{
		objHash = -1255368438,
		objCoords  = {x = -1079.627, y = -826.253, z = 11.182},
		textCoords = {x = -1079.147, y = -825.885, z = 11.036},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

	{
		objHash = -147325430,
		objCoords  = {x = -1070.787, y = -834.051, z = 5.63},
		textCoords = {x = -1071.417, y = -833.211, z = 5.479},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

	{
		objHash = 1028191914,
		objCoords  = {x = 1787.711, y = 2606.000, z = 50.73},
		textCoords = {x = 1787.419, y = 2607.111, z = 50.549},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

	{
		objHash = 262839150,
		objCoords  = {x = 1786.384, y = 2600.229, z = 46.08917},
		textCoords = {x = 1785.235, y = 2600.169, z = 45.969},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},

	--Solitary
	{
		objHash = 430324891,
		objCoords  = {x = 1767.339, y = 2607.431, z = 49.551},
		textCoords = {x = 1767.325, y = 2606.444, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.1
	},
	{
		objHash = 1028191914,
		objCoords  = {x = 1764.96, y = 2608.425, z = 50.73},
		textCoords = {x = 1764.927, y = 2607.274, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.2
	},
	{
		objHash = 430324891,
		objCoords  = {x = 1763.167, y = 2600.222, z = 49.54},
		textCoords = {x = 1764.201, y = 2600.207, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2.1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1762.774, y = 2596.512, z = 50.67},
		textCoords = {x = 1762.685, y = 2597.417, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1765.197, y = 2597.699, z = 50.67},
		textCoords = {x = 1765.283, y = 2596.767, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1762.78, y = 2593.568, z = 50.67},
		textCoords = {x = 1762.779, y = 2594.408, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1765.19, y = 2594.759, z = 50.67},
		textCoords = {x = 1765.308, y = 2593.818, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1765.19, y = 2591.819, z = 50.67},
		textCoords = {x = 1765.257, y = 2590.89, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1762.779, y = 2590.629, z = 50.67},
		textCoords = {x = 1762.677, y = 2591.567, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1762.766, y = 2587.677, z = 50.67},
		textCoords = {x = 1762.732, y = 2588.612, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},
	{
		objHash = 871712474,
		objCoords  = {x = 1765.192, y = 2588.867, z = 50.67},
		textCoords = {x = 1765.27, y = 2587.933, z = 50.550},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1
	},

	--Main Prison Area
	{
		objHash = 1028191914,
		objCoords  = {x = 1780.352, y = 2596.023, z = 50.83},
		textCoords = {x = 1779.305, y = 2596.023, z = 50.850},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},
	{
		objHash = 1028191914,
		objCoords  = {x = 1774.917, y = 2593.757, z = 45.972},
		textCoords = {x = 1775.011, y = 2592.596, z = 45.798},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 2
	},


	--
	--Paleto PD
	--

	--Back Doors 
	{
		objHash = -2023754432,
		objCoords  = {x = -447.236, y = 6002.317, z = 31.840},
		textCoords = {x = -446.509, y = 6001.596, z = 31.716},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.8
	},
	{
		objHash = -2023754432,
		objCoords  = {x = -450.966, y = 6006.086, z = 31.990},
		textCoords = {x = -451.768, y = 6006.922, z = 31.916},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--Reception (First room)
	{
		objHash = -2023754432,
		objCoords  = {x = -450.713, y = 6016.371, z = 31.865},
		textCoords = {x = -449.952, y = 6015.668, z = 31.865},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--(Set1)
	{
		objHash = -2023754432,
		objCoords  = {x = -442.857, y = 6010.958, z = 31.865},
		textCoords = {x = -442.091, y = 6011.671, z = 31.865},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = -2023754432,
		objCoords  = {x = -441.018, y = 6012.795, z = 31.865},
		textCoords = {x = -441.721, y = 6011.957, z = 31.865},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--(Set2)
	{
		objHash = -2023754432,
		objCoords  = {x = -449.565, y = 6008.538, z = 31.865},
		textCoords = {x = -448.854, y = 6007.775, z = 31.865},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = -2023754432,
		objCoords  = {x = -447.728, y = 6006.702, z = 31.865},
		textCoords = {x = -448.461, y = 6007.443, z = 31.865},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--Stairs
	{
		objHash = 749848321,
		objCoords  = {x = -447.767, y = 6005.191, z = 31.865},
		textCoords = {x = -447.143, y = 6004.444, z = 31.999},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--(Set1)
	{
		objHash = -2023754432,
		objCoords  = {x = -442.655, y = 6009.300, z = 31.865},
		textCoords = {x = -441.956, y = 6008.566, z = 31.865},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = -2023754432,
		objCoords  = {x = -440.815, y = 6007.460, z = 31.865},
		textCoords = {x = -441.607, y = 6008.157, z = 31.865},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--Armoury
	{
		objHash = 749848321,
		objCoords  = {x = -437.041, y = 6003.705, z = 31.865},
		textCoords = {x = -436.447, y = 6002.944, z = 31.999},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = 749848321,
		objCoords  = {x = -439.157, y = 5998.157, z = 31.865},
		textCoords = {x = -438.486, y = 5998.825, z = 31.999},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = 749848321,
		objCoords  = {x = -440.421, y = 5998.603, z = 31.865},
		textCoords = {x = -441.108, y = 5999.262, z = 31.665},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--Interigation Room 
	{
		objHash = 749848321,
		objCoords  = {x = -436.627, y = 6002.548, z = 28.140},
		textCoords = {x = -437.336, y = 6001.882, z = 27.990},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--Evidence Room 
	{
		objHash = -1320876379,
		objCoords  = {x = -436.515, y = 6007.844, z = 28.140},
		textCoords = {x = -435.837, y = 6008.616, z = 27.990},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = -1320876379,
		objCoords  = {x = -434.677, y = 6009.680, z = 28.140},
		textCoords = {x = -435.409, y = 6008.944, z = 27.990},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	--Cells 
	{
		objHash = -1927754726,
		objCoords  = {x = -438.228, y = 6006.167, z = 28.140},
		textCoords = {x = -438.975, y = 6005.432, z = 28.190},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = -1927754726,
		objCoords  = {x = -442.108, y = 6010.052, z = 28.140},
		textCoords = {x = -442.853, y = 6009.313, z = 28.190},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},
	{
		objHash = -1927754726,
		objCoords  = {x = -444.368, y = 6012.223, z = 28.140},
		textCoords = {x = -445.028, y = 6011.407, z = 28.190},
		authorizedJobs = { 'police' },
		locked = true,
		distance = 1.4
	},



	--WARD c ICU PILLVBOX DOORS

	{
		objHash = -1700911976,
		objCoords  = {x = 348.433, y = -588.745, z = 43.43},
		textCoords = {x = 348.433, y = -588.245, z = 43.43},
		authorizedJobs = { 'ambulance', 'police', 'offambulance', 'offpolice' },
		locked = false,
		distance = 1.2
	},

	{
		objHash = -434783486,
		objCoords  = {x = 349.313, y = -586.326, z = 43.43},
		textCoords = {x = 349.313, y = -587.326, z = 43.43},
		authorizedJobs = { 'ambulance', 'police', 'offambulance', 'offpolice' },
		locked = false,
		distance = 1.2
	},

	{
		objHash = 854291622,
		objCoords  = {x = 313.480, y = -595.458, z = 43.43},
		textCoords = {x = 313.080, y = -596.458, z = 43.43},
		authorizedJobs = { 'ambulance', 'police', 'offambulance', 'offpolice' },
		locked = true,
		distance = 2
	},

	{
		objHash = 854291622,
		objCoords  = {x = 309.133, y = -597.751, z = 43.43},
		textCoords = {x = 308.133, y = -597.351, z = 43.43},
		authorizedJobs = { 'ambulance', 'police', 'offambulance', 'offpolice' },
		locked = true,
		distance = 2
	},

	--LOST MC
	{
		objHash = 1335311341,
		objCoords  = {x = 959.382, y = -120.451, z = 75.161},
		textCoords = {x = 958.846, y = -120.923, z = 75.011},
		authorizedJobs = { 'cardealer' },
		locked = true,
		distance = 2
	},
	{
		objHash = 190770132,
		objCoords  = {x = 981.150, y = -103.255, z = 74.99},
		textCoords = {x = 981.632, y = -102.840, z = 74.847},
		authorizedJobs = { 'cardealer'},
		locked = true,
		distance = 2
	},

	--FlyWheels Garage 



}