ESX = nil
X = {}
X.isOpen = false
X.allDone = false
X.LastShop = nil
X.Material = nil
X.ActualWarehouse = nil
X.Option = nil
X.IsSelecting = false
X.IsCarrying = false
X.IsBacking = false
X.Tons = 0
X.Distance = 0
X.Charging = false
X.IsChargingBox = false

X.Clicks = 0

X.Level = 0
X.IsFunding = false

X.IsProcessing = false

X.IsPlanting = false

X.IsDoingSomething = false
X.GreenPeace = false
X.Capitalist = false

-----------------------------------
-----------INICIALIZADOR-----------
-----------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	ESX.TriggerServerCallback('tm1_stores:getWarehouses', function(warehouses)
		Config.Warehouses = warehouses
    end)

    while Config.Warehouses == nil do
		Citizen.Wait(10)
	end

	ESX.TriggerServerCallback('tm1_stores:getRocks', function(rocks)
		Config.Rocks = rocks
    end)

    ESX.TriggerServerCallback('tm1_stores:getWoods', function(woods)
		Config.Woods = woods
    end)

    ESX.TriggerServerCallback('tm1_stores:getPlants', function(plants)
		Config.Plants = plants
    end)

    ESX.TriggerServerCallback('tm1_stores:getWaterPoints', function(waterpoints)
		Config.WaterPoints = waterpoints
    end)

    ESX.TriggerServerCallback('tm1_stores:getValves', function(valves)
		Config.Valves = valves
    end)

    while Config.Rocks == nil and Config.Woods == nil and Config.Plants == nil and Config.WaterPoints == nil and Config.Valves == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	for i,v in pairs(Config.NPCs) do
		print(v.coords.x)
		X.SpawnPed(v.model, v.coords)
	end

	X.CreateDefaultBlips()
	X.allDone = true
end)

-----------------------------------
-------------TRANSLATES------------
-----------------------------------

Local = {
	enterWarehouse  = "Press E to open store",
	cancelCharge    = "Press E to cancel charge",
	warehouse       = "Warehouse",
	wood            = "Wood",
	food            = "Food",
	mine            = "Metals",
	water           = "Water",
	loadTruck       = "Get a trailer",
	loadVan         = "Get boxes",
	getTruck        = "Press E to load your trailer with ",
	truck           = "Truck",
	van             = "Van",
	youSelect       = "You have selected to haul ",
	inLabel         = "from",
	youNeed         = "You need one",
	load            = "Load ",
	maxCharge       = "The maximum you can load is ",
	tons            = "tons",

	notenough       = "There isnt enough stock at the warehouse",
	invalidAumont   = "Invalid amount",
	haveToDelivery  = "You must make the delivery first",
	notTruckAllowed = "You cannot take the load with that vehicle.",
	haveToSit       = "You must be in your work vehicle.",
	truckPlace      = "Export goods (from the warehouse)",
	deliveryTruck   = "Press E to deliver the trailer.",
	putTheTruck     = "Leave the trailer at this point. To unhook the trailer hold H.",
	dontHaveAnyTrailer = "There is no trailer at the point.",
	trailerNotAllowed = "That trailer is not dated by the company",
	discharge       = "Wait a moment while we unload the load...",
	upToBack        = "Return to the warehouse to collect your payment",
	succesfulDelivery = "You have made the shipment correctly",
	getBox            = "Press E to load the van",
	isCharging        = "Wait a moment, we are loading the merchandise",
	correctCharge     = "The merchandise has been loaded correctly.",
	goToCharge        = "Go load the merchandise.",
	putTheVan         = "Leave the van at this point and go to the office to download.",
	infoTrucks        = "Get information about trucks",
	infoVans          = "Get information about vans",
	haveToBuy         = "You have to buy one of the following vehicles to carry merchandise",


	carbon            = "carbon ore",
	iron              = "iron ore",
	silver            = "silver ore",
	gold              = "gold ore",
	rockOf            = "",
	getPickAxe        = "Press ~INPUT_CONTEXT~ to get your work tool",
	goFundition       = "Press E to smelt ores",
	youCantMine       = "You can't chop this kind of rock.",
	fundition         = "Do you want to smelt some of those materials?",
	melt              = "melt ",
	mine              = "Mine",
	funditionLingots  = "Foundry",



	pine              = "Pine wood",
	treeOf            = "",
	woodProcesser     = "Do you want to process that wood?",
	goProcesser       = "Press E to start packing wood",
	process           = "Processer ",
	sawmill           = "Saw mill",
	convertWood       = "Wood packaging",

	nearPlant = "There's a plant too close.",
	noPHNear = "There is no plowed field nearby, Please see your GPS",
	water = "Water",
	fertilizer = "Fertilizer",
	tomato_seed = "~r~Tomatoes",
	blueberry_seed = "~p~Blueberry",
	state = "State",
	rotten = "Rotten",
	youArePlating = "You're already planting.",
	seedNotAllowed = "This seed can not be planted in this field.",
	noPlantNear = "No plants nearby",
	ready = "Ready to pick",
	pressButton = "Press ~r~E ~w~ to speak",
	water_25 = "25L carafe",
	water_50 = "50L carafe",
	fertilizer_25 = "Fertilizer of 25",
	fertilizer_50 = "Fertilizer of 50",
	seedShop = "Do you want to buy seeds?",
	tomatoSeedLabel = "Tomato seed",
	blueberrySeedLabel= "Blueberry seed",
	ph = "Tomato/Blueberry Field",
	playerNearby = "Stay away from people close to you",
	packageTomato = "Pack tomatoes",
	packageBlueberry = "Pack blueberries",


	salinity          = "~c~Salinity",
	chemists          = "~g~Chemists",
	pollution         = "~y~Pollution",
	pointWater        = "Water collection point",
	dirtyWater        = "~o~Dirty water",
	electricityDown   = "~b~Reduce salanity with the filtering system",
	dam               = "The press",
	allow             = "~g~Available",
	notAllow          = "~r~Not available",
	noActionAllow     = "That action is not allowed.",
	catCall           = "~c~Call the cat to give the pollution button",
	greenpeaceAcept   = "~c~Reach wisdom by contacting nature through GreenPeace",
	youAreCapitalist  = "Now you want me to help you? Dirty shit capitalist, out of my sight.",
	capitalistAccept  = "Do you want to join the system? You just have to support my cause. LONG LIVE THE CAPITALISM",
	youAreGreenPeacer = "Do you want to start a company now? Hello? Supporting the environment? Please...",
	toxic1            = "Open the valve to deposit chemicals in the water",
	salinity1         = "Break the salt filter a little",
	salinity2         = "Pour natural essences",
	pollution1        = "Watch people who pollute the dam",
	pollution2        = "Bathe in the creek",
	chemist1          = "Worship the lifeguard god",
	pollution3        = "Fix the contamination filter",
	salinity3         = "There seems to be a mouse next to the box, sorry, it's you. Fix the salinity filter.",
	youAreDoingSomething = "Stop what you are doing",
	noWaterPointsNearby = "There are no water collection points nearby",
	youAreRecolecting = "You are collecting water",
	waterBottle       = "Water bottle",
	bottleShop        = "Water bottle shop",
	washBottles       = "Do you want to clean the bottles?",
	washSaltBottles   = "Do you want to desalinate the bottles?",
	washBottle        = "Water bottle cleaner",
	packageWater      = "Pack water bottles",
	washSaltBottles   = "Do you want to pack your products?",
	package           = "Tomato/Blueberry packaging",

	confirm_yes       = "Yes",
	confirm_no        = "No",

	pine_processed    = "Processed pine",
	lingot_carbon     = "Processed coal",
	lingot_iron       = "Iron ingot",
	lingot_silver     = "Silver Bullion",
	lingot_gold       = "Gold ingot",
	bottleWater_package = "Water package",
	blueberry_package = "Blueberry pack",
	tomato_package    = "Tomato pack",

	sellToWarehouse   = "Do you want to sell material to the warehouse?",
	noSpace           = "There is not enough space in the warehouse",
	downTheCar        = "You have to get out of the car"
}

-----------------------------------
---------------CONFIG--------------
-----------------------------------

Config = {}
Config.Warehouses = nil
Config.MaxWeight = {
	truck = 31,
	van   = 11
}
Config.TrailersModels = {
	wood = {go = "trailerlogs", back = "trflat"},
	food = {go = "trailers", back = "trailers"},
	mine = {go = "docktrailer", back = "docktrailer"},
	water = {go = "tanker2", back = "tanker2"}
}
Config.AvaliableTrucks = {
	"phantom",
	"hauler"
}
Config.AvaliableVans = {
	"burrito",
	"rumpo"

}
Config.BlipsWarehouses = {
	id = 478,
	colour = 73
}
Config.Ports = {
	{name = Local.truckPlace, id = 479, colour = 58, x = 1183.54, y = -3245.46, z = 6.03, point = {x = 1196.51, y = -3253.77, z = 7.1}}
}

-----------------------
-------CONFIG MINE-----
-----------------------
Config.Blips = {
    mine = {title=Local.mine, colour=46, id=478, x = 2952.0, y = 2748.8, z = 43.48-1},
    fundition = {title=Local.funditionLingots, colour=46, id=478, x = 1110.03, y = -2008.15, z = 31.06-1},
    sawmill = {title=Local.sawmill, colour=56, id=478, x = -552.44, y = 5348.45, z = 74.74-1},
    woodProcesser = {title=Local.convertWood, colour=56, id=478, x = -584.23, y = 5285.78, z = 70.26},
    ph1 = {title=Local.ph, colour=6, id=478, x = 1266.43, y = 1811.30, z = 82.83},
    ph2 = {title=Local.ph, colour=6, id=478, x = 1953.192, y = 4854.68, z = 45.441},
    --water = {title=Local.pointWater, colour=29, id=486, x = 1685.44, y = 42.81, z = 161.76},
    --dam = {title=Local.dam, colour=29, id=486, x = 1660.05, y = -1.34, z = 173.77},
    --waterWashBottle = {title=Local.washBottle, colour=29, id=486, x = 583.96, y = 137.95, z = 98.47},
    package = {title=Local.package, colour=6, id=478, x = -588.618, y = -1603.25, z = 26.09}
}

Config.isExperienceSystemActive = false

Config.ClicksToPickNeeded = 25
Config.DistanceToRemoveThePickaxe = 150
Config.Rocks = nil

Config.ClicksToCutNeeded = 25
Config.DistanceToRemoveTheAxe = 150
Config.Woods = nil

Config.PH = {
	{
		id = 1,
		x = 1278.67,
		y = 1808.94,
		z = 64.3,
		radio = 50.0,
		seedsAllowed = {'tomato_seed', 'blueberry_seed'}
	},
	{
		id = 2,
		x = 1953.192,
		y = 4854.68,
		z = 45.441,
		radio = 60.0,
		seedsAllowed = {'tomato_seed', 'blueberry_seed'}
	}
}
Config.Seeds = {
	tomato_seed = {
		seed = 'tomato_seed',
		distanceNeeded = 5.0,
		object = 'prop_veg_crop_01',
		reward = 'tomato_fruit',
		price = 20,
		maxPlants = 30
	},
	blueberry_seed = {
		seed = 'blueberry_seed',
		distanceNeeded = 5.0,
		object = 'prop_plant_cane_02a',
		reward = 'blueberry_fruit',
		price = 20,
		maxPlants = 30
	}
}
Config.NPCs = {
	--[[ TOMATO MAN
	{
		name = 'OpenSeedMenu',
		coords = {
			x = 1219.14,
			y = 1848.25,
			z = 77.96,
			h = 210.0
		},
		msg = Local.pressButton,
		model = -1806291497
	},
	{
		name = '',
		coords = {
			x = 1664.64,
			y = -28.04,
			z = 195.94,
			h = 300.0
		},
		msg = nil,
		model = -264140789
	},
	{
		name = '',
		coords = {
			x = 1660.83,
			y = -24.74,
			z = 172.77,
			h = 210.0
		},
		msg = nil,
		model = 1809430156
	},
--]]
--[[
	{
		name = 'OpenBottleMenu',
		coords = {
			x = 1664.62,
			y = -18.56,
			z = 172.77,
			h = 210.0
		},
		msg = Local.pressButton,
		model = -1806291497
	},
--]]
	{
		name = 'OpenProcesserMenu',
		coords = {
			x = 583.96,
			y = 137.95,
			z = 98.47,
			h = 210.0
		},
		msg = Local.pressButton,
		model = -1806291497
	},
--[[
	{
		name = 'OpenSaltMenu',
		coords = {
			x = 1904.91,
			y = 595.82,
			z = 177.4,
			h = 120.0
		},
		msg = Local.pressButton,
		model = -1806291497
	},
--]]
	{
		name = 'OpenPackageMenu',
		coords = {
			x = -589.22,
			y = -1603.27,
			z = 26.08,
			h = 262.6
		},
		msg = Local.pressButton,
		model = -1806291497
	}
}
Config.SeedShop = {
	{label = Local.water_25, value = "water_25", price = 2},
	{label = Local.water_50, value = "water_50", price = 5},
	{label = Local.tomatoSeedLabel, value = "tomato_seed", price = 1},
	{label = Local.blueberrySeedLabel, value = "blueberry_seed", price = 1},
}
Config.SecondNeededToPlant = 8 --[More than 3 seconds pls]

Config.BottleShop = {
	{label = Local.waterBottle, value = "bottle", price = 1},
}
Config.PackageShop = {
	{label = Local.packageTomato, from = "tomato_fruit", to = "tomato_package"},
	{label = Local.packageBlueberry, from = "blueberry_fruit", to = "blueberry_package"},
	--{label = Local.packageWater, from = "full_waterBottle", to = "bottleWater_package"}
}

Config.Packages = {
	wood = {
		'pine_processed'
	},
	mine = {
		'lingot_carbon',
		'lingot_iron',
		'lingot_silver',
		'lingot_gold'
	},
	water = {
		'bottleWater_package'
	},
	food = {
		'blueberry_package',
		'tomato_package'
	}
}
-----------------------------------
-------------HILO PRINC------------
-----------------------------------
local inMenu = false
Citizen.CreateThread(function()
	while X.allDone == false do
		Citizen.Wait(0)
	end
	X.CreateWarehousesBlips()
	X.CreatePortsBlips()
	while true do
		Citizen.Wait(10)
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)
		for i,v in pairs(Config.Warehouses) do
			local distance = X.Get3DDistance(v.mainDoor.x, v.mainDoor.y, v.mainDoor.z, coords.x, coords.y, coords.z)

			-------------
			--ALMACENES--
			-------------
			if distance < 50.0 then
				X.DrawMarker(39,v.mainDoor.x, v.mainDoor.y, v.mainDoor.z,255,255,0,1.0,1.0,1.0)
				if distance < 1.5 then
					if X.IsSelecting == false and X.IsCarrying == false and X.IsBacking == false then
						ESX.ShowHelpNotification(Local.enterWarehouse)
						if IsControlJustReleased(0, 38) then
							ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
								X.OpenWarehouse(warehouse)
						    end, v.storeID)
						end
					elseif X.IsSelecting == false and X.IsCarrying == true then
						ESX.ShowHelpNotification(Local.haveToDelivery)
					elseif X.IsSelecting == false and X.IsCarrying == false and X.IsBacking == true then
						ESX.ShowHelpNotification(Local.deliveryTruck)
						if IsControlJustReleased(0, 38) then
							local vehicle, distance = ESX.Game.GetClosestVehicle({x = v.leaveCharge.x, y = v.leaveCharge.y, z = v.leaveCharge.z})
							if distance <= 8.0 and X.Option == 'truck' then
								local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
								ESX.TriggerServerCallback('tm1_stores:getTrailer', function(trailer)
									if trailer.plate == plate then
										ESX.ShowNotification(Local.succesfulDelivery)
										--exports['mythic_notify']:SendAlert('success', Local.succesfulDelivery, 5000)
										DeleteEntity(vehicle)
										ESX.Game.DeleteVehicle(vehicle)
										LastVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
										DeleteEntity(LastVehicle)
										ESX.Game.DeleteVehicle(LastVehicle)
										TriggerServerEvent('tm1_stores:payTons', X.Tons)
										X.ClearVars()
									else
										ESX.ShowNotification(Local.trailerNotAllowed)
										--exports['mythic_notify']:SendAlert('success', Local.trailerNotAllowed, 5000)
									end
								end, plate)
							elseif distance <= 8.0 and X.Option == 'van' then
								local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
								ESX.TriggerServerCallback('tm1_stores:getTrailer', function(trailer)
									if trailer.plate == plate then
										ESX.ShowNotification(Local.succesfulDelivery)
										--exports['mythic_notify']:SendAlert('success', Local.succesfulDelivery, 5000)
										LastVehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
										DeleteEntity(LastVehicle)
										ESX.Game.DeleteVehicle(LastVehicle)
										TriggerServerEvent('tm1_stores:payTons',X.Tons)
										X.ClearVars()
									else
									end
								end, plate)
							else
								ESX.ShowNotification(Local.dontHaveAnyVehicle)
								--exports['mythic_notify']:SendAlert('success', Local.dontHaveAnyVehicle, 5000)
							end
						end
					elseif X.IsSelecting == false then
						ESX.ShowHelpNotification(Local.cancelCharge)
						--exports['mythic_notify']:SendAlert('success', Local.cancelCharge, 5000)
						if IsControlJustReleased(0, 38) then
							X.CancelCharging()
						end
					end
				end
			end

			------------
			--CARGADOR--
			------------
			if X.IsSelecting == true and X.ActualWarehouse ~= nil and X.Material ~= nil and (X.Option == 'truck' or X.Option == 'van') then
				local distanceToGet = X.Get3DDistance(v.getCharge.x, v.getCharge.y, v.getCharge.z, coords.x, coords.y, coords.z)
				if distanceToGet < 50.0 then
					X.DrawMarker(21,v.getCharge.x, v.getCharge.y, v.getCharge.z,0,0,255,1.0,1.0,1.0)
					if distanceToGet < 3.5 then
						ESX.ShowHelpNotification(Local.getTruck.."~g~"..Local[X.Material].."~w~. ("..Local.maxCharge.."~y~"..Config.MaxWeight[X.Option].."~w~ "..Local.tons..")")
						--exports['mythic_notify']:SendAlert('success', Local.getTruck..""..Local[X.Material]..". ("..Local.maxCharge..""..Config.MaxWeight[X.Option].." "..Local.tons..")", 5000)
						if IsControlJustReleased(0, 38) then
							if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
								X.OpenGetCharge()
							else
								ESX.ShowNotification(Local.haveToSit)
								--exports['mythic_notify']:SendAlert('success', Local.haveToSit, 5000)
							end
						end
					end
				end
			end

			---------------------
			---INDICADOR CARGA---
			---------------------
			if X.IsBacking == true and X.ActualWarehouse ~= nil and X.Material ~= nil and (X.Option == 'truck' or X.Option == 'van') then
				local distanceToLeave = X.Get3DDistance(v.leaveCharge.x, v.leaveCharge.y, v.leaveCharge.z, coords.x, coords.y, coords.z)
				if distanceToLeave < 50.0 then
					X.DrawMarker(29,v.leaveCharge.x, v.leaveCharge.y, v.leaveCharge.z,0,0,255,1.0,1.0,1.0)
					if distanceToLeave < 3.5 then				
						if distanceToLeave < 3.5 and X.Option == 'truck' then
							ESX.ShowHelpNotification(Local.putTheTruck)
							--exports['mythic_notify']:SendAlert('success', Local.putTheTruck, 5000)
						elseif distanceToLeave < 3.5 and X.Option == 'van' then
							ESX.ShowHelpNotification(Local.putTheVan)
							--exports['mythic_notify']:SendAlert('success', Local.putTheVan, 5000)
						end
					end
				end
			end

			-----------------
			--COGER LA CAJA--
			-----------------
			if X.IsChargingBox == true and X.ActualWarehouse ~= nil and X.Material ~= nil then
				local distanceToBox = X.Get3DDistance(v.getBox.x, v.getBox.y, v.getBox.z, coords.x, coords.y, coords.z)
				if distanceToBox < 50.0 then
					X.DrawMarker(29,v.getBox.x, v.getBox.y, v.getBox.z,0,0,255,1.0,1.0,1.0)
					if distanceToBox < 3.5 then				
						ESX.ShowHelpNotification(Local.getBox)
						--exports['mythic_notify']:SendAlert('success', Local.getBox, 5000)
						if IsControlJustReleased(0, 38) then
							if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
								if X.IsAValidVan() then
									X.IsChargingBox = false
									ESX.ShowNotification(Local.isCharging)
									--exports['mythic_notify']:SendAlert('success', Local.isCharging, 5000)
									local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
									local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
									FreezeEntityPosition(vehicle,true)
									Citizen.Wait(8000)
									FreezeEntityPosition(vehicle,false)
									TriggerServerEvent('tm1_stores:addTrailer', X.Trim(plate), X.Tons)
									X.IsChargingBox = false
									X.IsCarrying = true
								else
									ESX.ShowNotification(Local.notTruckAllowed)
									--exports['mythic_notify']:SendAlert('success', Local.notTruckAllowed, 5000)
								end
							else
								ESX.ShowNotification(Local.haveToSit)
								--exports['mythic_notify']:SendAlert('success', Local.haveToSit, 5000)
							end
						end
					end
				end
			end

			-------
			--IDA--
			-------
			if X.IsCarrying == true and X.ActualWarehouse ~= nil and X.Material ~= nil and (X.Option == 'truck' or X.Option == 'van') then
				for i,v in pairs(Config.Ports) do
					local distanceToGet = X.Get3DDistance(v.x, v.y, v.z, coords.x, coords.y, coords.z)
					local distanceToDelivery = X.Get3DDistance(v.point.x, v.point.y, v.point.z, coords.x, coords.y, coords.z)
					if distanceToGet < 50.0 then
						X.DrawMarker(29,v.x, v.y, v.z,0,0,255,1.0,1.0,1.0)
						X.DrawMarker(21,v.point.x, v.point.y, v.point.z,0,0,255,1.0,1.0,1.0)
						if distanceToGet < 5.0 and X.Option == 'truck' then
							ESX.ShowHelpNotification(Local.putTheTruck)
							--exports['mythic_notify']:SendAlert('success', Local.putTheTruck, 5000)
						elseif distanceToGet < 3.5 and X.Option == 'van' then
							ESX.ShowHelpNotification(Local.putTheVan)
							--exports['mythic_notify']:SendAlert('success', Local.putTheVan, 5000)
						end
						if distanceToDelivery < 3.5 and X.Charging == false then
							ESX.ShowHelpNotification(Local.deliveryTruck)
							--exports['mythic_notify']:SendAlert('success', Local.deliveryTruck, 5000)
							if IsControlJustReleased(0, 38) then
								local vehicle, distance = ESX.Game.GetClosestVehicle({x = v.x, y = v.y, z = v.z})
								if distance <= 4.0 then
									local plate = X.Trim(GetVehicleNumberPlateText(vehicle))
									ESX.TriggerServerCallback('tm1_stores:getTrailer', function(trailer)
										if trailer ~= nil and trailer.plate == plate and X.Option == 'truck' then
											local coordsV = GetEntityCoords(vehicle)
											ESX.ShowNotification(Local.discharge)
											--exports['mythic_notify']:SendAlert('success', Local.discharge, 5000)
											X.Charging = true
											Citizen.Wait(8000)
											ESX.ShowNotification(Local.upToBack)
											--exports['mythic_notify']:SendAlert('success', Local.upToBack, 5000)
											ESX.Game.DeleteVehicle(vehicle)
											DeleteEntity(vehicle)
											Citizen.Wait(1000)
											ESX.Game.SpawnVehicle(Config.TrailersModels[X.Material].back, coordsV, 0.0, function(vehicle)
												SetVehicleNumberPlateText(vehicle, plate)			
												X.Tons = trailer.tons
												X.IsCarrying = false
												X.IsBacking = true
												X.Distance = X.Get3DDistance(coords.x, coords.y, coords.z, X.LastShop.mainDoor.x, X.LastShop.mainDoor.y, X.LastShop.mainDoor.z)
												X.Charging = false

											end)
										elseif trailer ~= nil and trailer.plate == plate and X.Option == 'van' then
											ESX.ShowNotification(Local.discharge)
											--exports['mythic_notify']:SendAlert('success', Local.discharge, 5000)
											X.Charging = true
											Citizen.Wait(8000)
											ESX.ShowNotification(Local.upToBack)
											--exports['mythic_notify']:SendAlert('success', Local.upToBack, 5000)
											X.Charging = false
											X.IsCarrying = false
											X.IsBacking = true
											X.Distance = X.Get3DDistance(coords.x, coords.y, coords.z, X.LastShop.mainDoor.x, X.LastShop.mainDoor.y, X.LastShop.mainDoor.z)
											X.Charging = false
										else
											ESX.ShowNotification(Local.trailerNotAllowed)
											--exports['mythic_notify']:SendAlert('success', Local.trailerNotAllowed, 5000)
										end
									end, X.Trim(plate))
								else
									ESX.ShowNotification(Local.dontHaveAnyVehicle)
									--exports['mythic_notify']:SendAlert('success', Local.dontHaveAnyVehicle, 5000)
								end
							end
						end
					end
				end
			end
		end

		-------
		--MINA--
		-------
		local distanceMine = X.Get3DDistance(Config.Blips.mine.x,Config.Blips.mine.y,Config.Blips.mine.z,coords.x,coords.y,coords.z)
	    if distanceMine > Config.DistanceToRemoveThePickaxe then
	    	if GetCurrentPedWeapon(GetPlayerPed(-1),"WEAPON_BATTLEAXE",true) then
	        	RemoveWeaponFromPed(GetPlayerPed(-1),"WEAPON_BATTLEAXE")
	    	end
	    else
	    	X.CanPick(coords)
	    	if distanceMine < 50 then
	    		X.DrawMarker(1,Config.Blips.mine.x,Config.Blips.mine.y,Config.Blips.mine.z,132, 23,255,1.5001, 1.5001, 1.5001)
	        	if distanceMine < 1.5 then
	          		X.DisplayHelpText(Local.getPickAxe)
	          		if IsControlJustReleased(1,38) then
	              		GiveWeaponToPed(GetPlayerPed(-1),"WEAPON_BATTLEAXE",1,false,true)
	          		end
	        	end
	      	end
	    end
	    if X.Get3DDistance(coords.x,coords.y,coords.z,Config.Blips.fundition.x,Config.Blips.fundition.y,Config.Blips.fundition.z) < 1.5 then
	      	X.DrawText3D({x = Config.Blips.fundition.x, y = Config.Blips.fundition.y, z = 31.057}, Local.goFundition)
	      	if IsControlJustReleased(1,38) and X.IsFunding == false then
	       		X.OpenFundition()
	      	end
	    end

	    --------------
		--ASERRADERO--
		--------------
		local distanceWood = X.Get3DDistance(Config.Blips.sawmill.x,Config.Blips.sawmill.y,Config.Blips.sawmill.z,coords.x,coords.y,coords.z)
	    if distanceWood > Config.DistanceToRemoveTheAxe then
	    	if GetCurrentPedWeapon(GetPlayerPed(-1),"WEAPON_HATCHET",true) then
	        	RemoveWeaponFromPed(GetPlayerPed(-1),"WEAPON_HATCHET")
	    	end
	    else
	    	X.CanPickW(coords)
	    	if distanceWood < 50 then
	    		X.DrawMarker(1,Config.Blips.sawmill.x,Config.Blips.sawmill.y,Config.Blips.sawmill.z,132, 23,255,1.5001, 1.5001, 1.5001)
	        	if distanceWood < 1.5 then
	          		X.DisplayHelpText(Local.getPickAxe)
	          		if IsControlJustReleased(1,38) then
	              		GiveWeaponToPed(GetPlayerPed(-1),"WEAPON_HATCHET",1,false,true)
	          		end
	        	end
	      	end
	    end
	    if X.Get3DDistance(coords.x,coords.y,coords.z,Config.Blips.woodProcesser.x,Config.Blips.woodProcesser.y,Config.Blips.woodProcesser.z) < 1.5 then
	      	X.DrawText3D({x = Config.Blips.woodProcesser.x, y = Config.Blips.woodProcesser.y, z = Config.Blips.woodProcesser.z}, Local.goProcesser)
	      	if IsControlJustReleased(1,38) and X.IsProcessing == false then
	       		X.OpenProcesser()
	      	end
	    end

	 	-----------
		--PLANTAS--
		-----------
	    for k1,v1 in pairs(Config.PH) do
	    	local distancePH = X.Get3DDistance(v1.x,v1.y,v1.z,coords.x,coords.y,coords.z)
	    	if distancePH <= v1.radio then
	    		if Config.Plants[v1.id] then
				    for k,v in pairs(Config.Plants[v1.id]) do
				    	if X.IsPlanting == false then
					    	if X.Get3DDistance(coords.x,coords.y,coords.z,v.x,v.y,v.z) < 3.0 then
					    		X.Draw3DTextPlants(v)
					    		if IsControlJustReleased(1,38) and X.IsPlanting == false then
					    			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				    				if closestDistance > 5.0 or closestDistance == -1 then
				    					if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
							    			if v.rot <= 0 then
							    				X.IsPlanting = true
							    				X.RemoveLowPlant({x = v.x, y = v.y, z = v.z + 1.55}, v.id, v.seed)
							    			elseif v.percent >= 100 then
							    				X.IsPlanting = true
							    				X.HarvestPlant({x = v.x, y = v.y, z = v.z + 1.55}, v.id, v.seed)
							    			end
							    		else
											ESX.ShowNotification(Local.downTheCar)
											--exports['mythic_notify']:SendAlert('success', Local.downTheCar, 5000)
							    		end
						    		else
										ESX.ShowNotification(Local.playerNearby)
										--exports['mythic_notify']:SendAlert('success', Local.playerNearby, 5000)
							    	end
					    		end
					    	end
					    end
				    end
				end
			end
	    end
		
        for k,v in pairs(Config.NPCs) do
            if X.Get3DDistance(v.coords.x,v.coords.y,v.coords.z,coords.x,coords.y,coords.z) < 3.0 then
                X.DrawText3D({x = v.coords.x, y = v.coords.y, z = v.coords.z + 2}, v.msg)
				if IsControlJustReleased(1,38) and v.msg ~= nil then
                    X[v.name]()
                    inMenu = true
                end
            elseif X.Get3DDistance(v.coords.x,v.coords.y,v.coords.z,coords.x,coords.y,coords.z) > 3.0 and X.Get3DDistance(v.coords.x,v.coords.y,v.coords.z,coords.x,coords.y,coords.z) < 5.0 and inMenu == true then
                print("dickhead")
                inMenu = false
                ESX.UI.Menu.CloseAll()
            end
        end

	    --------
		--AGUA--
		-------
		--[[]
		local distanceWater = X.Get3DDistance(Config.Blips.water.x,Config.Blips.water.y,Config.Blips.water.z,coords.x,coords.y,coords.z)
		if distanceWater < 50.0 then
			for k,v in pairs(Config.WaterPoints) do
				if X.Get3DDistance(v.x,v.y,v.z,coords.x,coords.y,coords.z) < 2.5 then
					X.Draw3DTextWater(v)
				end
			end
		end
		if Config.Valves then
			for k,v in pairs(Config.Valves) do
				if X.Get3DDistance(v.x,v.y,v.z,coords.x,coords.y,coords.z) < 2.5 then
					if v.isAvaliable == true then
						X.DrawText3D({x = v.x, y = v.y, z = v.z + 0.15}, "~w~["..Local.allow.."~w~]")
					else
						X.DrawText3D({x = v.x, y = v.y, z = v.z + 0.15}, "~w~["..Local.notAllow.."~w~]")
					end
					X.DrawText3D({x = v.x, y = v.y, z = v.z}, "~w~["..Local[v.name].."~w~]")
					if IsControlJustReleased(1,38) then
						if v.isAvaliable == true then
							local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
							print(closestDistance)
					    	if closestDistance > 5.0 or closestDistance == -1 then
					    		if X.IsDoingSomething == false then
					    			if v.name == 'greenpeaceAcept' and X.Capitalist == false then
					    				X.GreenPeace = true
					    				X.IsDoingSomething = true
						    			X.DoAction(v)
					    			elseif v.name == 'greenpeaceAcept' and X.Capitalist == true then 
					    				ESX.ShowNotification(Local.youAreCapitalist)
					    			elseif v.name == 'capitalistAccept' and X.GreenPeace == true then
					    				ESX.ShowNotification(Local.youAreGreenPeacer)
					    			elseif v.name == 'capitalistAccept' and X.GreenPeace == false then
					    				X.Capitalist = true
					    				X.IsDoingSomething = true
						    			X.DoAction(v)
						    		else
						    			X.Capitalist = true
					    				X.IsDoingSomething = true
						    			X.DoAction(v)
					    			end
					    		end
				    		else
					    		ESX.ShowNotification(Local.playerNearby)
					    	end
						else
							ESX.ShowNotification(Local.noActionAllow)
						end
					end
				end
			end
		end
		--]]
	end
end)

-----------------------------------
-----------NUI CALLBACKS-----------
-----------------------------------

RegisterNUICallback('NUIFocusOff', function()
    X.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeUI'})
end)

RegisterNUICallback('sell', function(data, cb)
	local myData = data
	local warehouse = data.companyName
    X.OpenSetMenu(warehouse)
end)

RegisterNUICallback('get', function(data, cb)
	local myData = data
	local warehouse = data.companyName
    X.OpenGetMenu(warehouse)
end)

-----------------------------------
-------------FUNCIONES-------------
-----------------------------------
X.GetPercent = function(actual, max)
	return X.Round(((actual * 100) / max), 1)
end

X.IsAValidTruck = function()
	for i,v in pairs(Config.AvaliableTrucks) do
		if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(v)) then 
			return true
		end
	end

	return false
end

X.IsAValidVan = function()
	for i,v in pairs(Config.AvaliableVans) do
		if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey(v)) then 
			return true
		end
	end

	return false
end

X.OpenWarehouse = function(warehouse)
    X.isOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({type = 'openNUI',
    storeName = warehouse.storeName,
    storeID = warehouse.storeID,
    wood  = X.GetPercent(warehouse.materials.wood, warehouse.maxMaterials.wood),
    food  = X.GetPercent(warehouse.materials.food, warehouse.maxMaterials.food),
    mine  = X.GetPercent(warehouse.materials.mine, warehouse.maxMaterials.mine)})
    --water = X.GetPercent(warehouse.materials.water, warehouse.maxMaterials.water)})
end

X.CloseWarehouse = function()
	X.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeUI'})
end

X.Get3DDistance = function(x1, y1, z1, x2, y2, z2)
	local a = (x1 - x2) * (x1 - x2)
	local b = (y1 - y2) * (y1 - y2)
	local c = (z1 - z2) * (z1 - z2)
    return math.sqrt(a + b + c)
end

X.DrawMarker = function(typeOfMarker,x,y,z,r,g,b,sizeX,sizeY,SizeZ)
	DrawMarker(typeOfMarker, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, sizeX,sizeY,SizeZ, r,g,b, 100, false, true, 2, true, false, false, false)
end

X.Round = function(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

Citizen.CreateThread(function ()
	X.isOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({type = 'closeUI'})
end)

X.CreateWarehousesBlips = function()
	Citizen.CreateThread(function()
	    for _, info in pairs(Config.Warehouses) do
	      info.blip = AddBlipForCoord(info.mainDoor.x, info.mainDoor.y, info.mainDoor.z)
	      SetBlipSprite(info.blip, Config.BlipsWarehouses.id)
	      SetBlipDisplay(info.blip, 4)
	      SetBlipScale(info.blip, 0.6)
	      SetBlipColour(info.blip, Config.BlipsWarehouses.colour)
	      SetBlipAsShortRange(info.blip, true)
		  BeginTextCommandSetBlipName("STRING")
	      AddTextComponentString(info.storeName)
	      EndTextCommandSetBlipName(info.blip)
	    end
	end)
end

X.CreatePortsBlips = function()
	Citizen.CreateThread(function()
	    for _, info in pairs(Config.Ports) do
	      info.blip = AddBlipForCoord(info.x, info.y, info.z)
	      SetBlipSprite(info.blip, info.id)
	      SetBlipDisplay(info.blip, 4)
	      SetBlipScale(info.blip, 0.6)
	      SetBlipColour(info.blip, info.colour)
	      SetBlipAsShortRange(info.blip, true)
		  BeginTextCommandSetBlipName("STRING")
	      AddTextComponentString(info.name)
	      EndTextCommandSetBlipName(info.blip)
	    end
	end)
end

X.DisplayHelpText = function(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

X.startAnim = function(lib, anim)
  ESX.Streaming.RequestAnimDict(lib, function()
    TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
  end)
end

X.startScenario = function(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

X.DrawText3D = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 1.2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.55 * scale)
		SetTextFont(0)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry('STRING')
		SetTextCentre(1)

		AddTextComponentString(text)
		DrawText(x, y)
	end
end

X.Trim = function(str)
	if str then 
		if type(str) ~= "string" then str = tostring(str) end
		return (str:gsub("^%s*(.-)%s*$", "%1"))
	end

	return ""
end

X.FinishWork = function()
	
end

X.ClearVars = function()
	X.LastShop = nil
	X.Material = nil
	X.ActualWarehouse = nil
	X.Option = nil
	X.IsSelecting = false
	X.IsCarrying = false
	X.IsBacking = false
	X.Tons = 0
	X.Distance = 0
	X.Charging = false
	X.IsChargingBox = false
end

X.SpawnPed = function(model, coords)
	model           = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
	local x = coords.x
	local y = coords.y
	local z = coords.z
	local h = coords.h

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end

		ped = CreatePed(5, model, x, y, z, h, false, false)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		SetPedFleeAttributes(ped, 0, 0)
	end)
end

X.OpenSetMenu = function(id)
	local elements = {}

	ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
		X.LastShop = warehouse
	    table.insert(elements, {value = "wood" , valueLabel = Local.wood ,  material = X.LastShop.materials.wood, maxMaterial =  X.LastShop.maxMaterials.wood, label = "<span style='color: orange;'>Wood</span><b> : "..X.LastShop.materials.wood.."/"..X.LastShop.maxMaterials.wood.."</b>"})
	    table.insert(elements, {value = "food" , valueLabel = Local.food ,  material = X.LastShop.materials.food, maxMaterial =  X.LastShop.maxMaterials.food, label = "<span style='color: green;'>Foods</span><b> : "..X.LastShop.materials.food.."/"..X.LastShop.maxMaterials.food.."</b>"})
	    table.insert(elements, {value = "mine" , valueLabel = Local.mine ,  material = X.LastShop.materials.mine, maxMaterial =  X.LastShop.maxMaterials.mine, label = "<span style='color: yellow;'>Ores</span><b> : "..X.LastShop.materials.mine.."/"..X.LastShop.maxMaterials.mine.."</b>"})
	    --table.insert(elements, {value = "water", valueLabel = Local.water,  material = X.LastShop.materials.water, maxMaterial = X.LastShop.maxMaterials.water, label = "<span style='color: cyan;'>Agua</span><b> : "..X.LastShop.materials.water.."/"..X.LastShop.maxMaterials.water.."</b>"})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse', {
			title    = Local.warehouse,
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			if data.current.value then
				X.OpenMaterials(id, data.current.value)
			end
		end,
		function(data, menu)
			isMenuOpened = false
			menu.close()
		end
		)
    end, id)
end

X.OpenMaterials = function(id, material)
	local elements = {}

	for k,v in pairs(Config.Packages[material]) do
		table.insert(elements, {value = v, label = Local[v]} )
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse_packages', {
		title    = Local.warehouse,
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value then
			X.OpenGetterMenu(id, material, data.current.value)
		end
	end,
	function(data, menu)
		isMenuOpened = false
		menu.close()
	end
	)
end

X.OpenGetterMenu = function(id, material, item)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'warehouse_charge',
	{
		title = Local.sellToWarehouse,
	}, function(data, menu)
		local parameter = data.value
		local tons = tonumber(parameter)
		if tons then
			ESX.TriggerServerCallback('tm1_stores:getWarehouse', function(warehouse)
				local quantityInWarehouse = warehouse.materials[material]
				local maxCapacity = warehouse.maxMaterials[material]
				if quantityInWarehouse + tons <= maxCapacity then
					TriggerServerEvent('tm1_stores:fillWarehouses', id, material, item, tons)
				else
					ESX.ShowNotification(Local.noSpace)
					--exports['mythic_notify']:SendAlert('success', Local.noSpace, 5000)
				end
				menu.close()
			end, id)
		end
		ESX.UI.Menu.CloseAll()
	end, function(data, menu)
		menu.close()
	end)
end
------------------------------
-------------BLIPS------------
------------------------------
X.CreateDefaultBlips = function()
Citizen.CreateThread(function()
  Citizen.Wait(0)
  for _, info in pairs(Config.Blips) do
    info.blip = AddBlipForCoord(info.x, info.y, info.z)
    SetBlipSprite(info.blip, info.id)
    SetBlipDisplay(info.blip, 4)
    SetBlipScale(info.blip, 0.6)
    SetBlipColour(info.blip, info.colour)
    SetBlipAsShortRange(info.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(info.title)
    EndTextCommandSetBlipName(info.blip)
  end
end)
end

--------------------------------
-------------EVENTOS------------
--------------------------------

RegisterNetEvent('tm1_stores:getDataClientsWoods')
AddEventHandler('tm1_stores:getDataClientsWoods',function(data)
    Config.Woods = data
end)

RegisterNetEvent('pop_university:setMineLevel')
AddEventHandler('pop_university:setMineLevel',function(totalLevel)
    X.Level = totalLevel
end)

RegisterNetEvent('tm1_stores:getDataClientsRocks')
AddEventHandler('tm1_stores:getDataClientsRocks',function(data)
    Config.Rocks = data
end)

RegisterNetEvent('tm1_stores:plant')
AddEventHandler('tm1_stores:plant', function(seed)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
		if X.IsPlanting == false then
			for k,v in pairs(Config.PH) do
				if X.Get3DDistance(v.x, v.y, v.z, coords.x, coords.y, coords.z) < v.radio then
					local minDistance = 999999.0
					if Config.Plants[v.id] ~= nil then
						for k1,v1 in pairs(Config.Plants[v.id]) do
							local distance = X.Get3DDistance(v1.x, v1.y, v1.z, coords.x, coords.y, coords.z)
							if distance < minDistance then
								minDistance = distance
							end
						end
					end
					if Config.Seeds[seed].distanceNeeded < minDistance or minDistance == 999999.0 then
						if X.IsThisSeedAllowed(seed, v) then
							TriggerServerEvent('tm1_stores:plant', Config.Seeds[seed], coords.x, coords.y, coords.z, v.id)
							return nil
						else
							--ESX.ShowNotification(Local.seedNotAllowed)
							exports['mythic_notify']:SendAlert('success', Local.seedNotAllowed, 5000)
							return nil
						end
					else
						--ESX.ShowNotification(Local.nearPlant)
						exports['mythic_notify']:SendAlert('success', Local.nearPlant, 5000)
						return nil
					end
				end
			end
		else
			--ESX.ShowNotification(Local.youArePlating)
			exports['mythic_notify']:SendAlert('success', Local.youArePlating, 5000)
			return nil
		end
	else
		--ESX.ShowNotification(Local.downTheCar)
		exports['mythic_notify']:SendAlert('success', Local.downTheCar, 5000)
		return nil
	end
	--ESX.ShowNotification(Local.noPHNear)
	exports['mythic_notify']:SendAlert('success', Local.noPHNear, 5000)
end)

RegisterNetEvent('tm1_stores:plantSeed')
AddEventHandler('tm1_stores:plantSeed', function(seed, coords)
	X.IsPlanting = true
	X.Plant(seed, coords)
end)

RegisterNetEvent('tm1_stores:refreshPlants')
AddEventHandler('tm1_stores:refreshPlants', function(plants)
	Config.Plants = plants
end)

RegisterNetEvent('tm1_stores:addWater')
AddEventHandler('tm1_stores:addWater', function(quantity)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	for k,v in pairs(Config.Plants) do
		for k1,v1 in pairs(v) do
			if X.Get3DDistance(v1.x, v1.y, v1.z, coords.x, coords.y, coords.z) < 3.0 then
				X.IsPlanting = true
				X.AddWater(v1.id, quantity)
				return nil
			end
		end
	end
	--ESX.ShowNotification(Local.noPlantNear)
	exports['mythic_notify']:SendAlert('success', Local.noPlantNear, 5000)
end)

RegisterNetEvent('tm1_stores:addFertilizer')
AddEventHandler('tm1_stores:addFertilizer', function(quantity)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	for k,v in pairs(Config.Plants) do
		for k1,v1 in pairs(v) do
			if X.Get3DDistance(v1.x, v1.y, v1.z, coords.x, coords.y, coords.z) < 3.0 then
				X.IsPlanting = true
				X.AddFertilizer(v1.id, quantity)
				return nil
			end
		end
	end
	--ESX.ShowNotification(Local.noPlantNear)
	exports['mythic_notify']:SendAlert('success', Local.noPlantNear, 5000)
end)
--[[
RegisterNetEvent('tm1_stores:refreshWater')
AddEventHandler('tm1_stores:refreshWater', function(water)
	Config.WaterPoints = water
end)
--]]
RegisterNetEvent('tm1_stores:refreshValves')
AddEventHandler('tm1_stores:refreshValves', function(valves)
	Config.Valves = valves
end)

RegisterNetEvent('tm1_stores:takeWater')
AddEventHandler('tm1_stores:takeWater', function(seed)
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	if X.IsDoingSomething == false then
		for k,v in pairs(Config.WaterPoints) do
			if X.Get3DDistance(v.x, v.y, v.z, coords.x, coords.y, coords.z) < 3.0 then
				X.GetWater(v)
				--ESX.ShowNotification(Local.youAreRecolecting)
				exports['mythic_notify']:SendAlert('success', Local.youAreRecolecting, 5000)
				return nil
			end
		end
	else
		--ESX.ShowNotification(Local.youAreDoingSomething)
		exports['mythic_notify']:SendAlert('success', Local.youAreDoingSomething, 5000)
		return nil
	end
	--ESX.ShowNotification(Local.noWaterPointsNearby)
	exports['mythic_notify']:SendAlert('success', Local.noWaterPointsNearby, 5000)
end)

RegisterNetEvent('tm1_stores:removePlant')
AddEventHandler('tm1_stores:removePlant', function(coords)
	local object, distance = ESX.Game.GetClosestObject('', coords)
	ESX.Game.DeleteObject(object)
end)