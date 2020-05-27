-----------------------------------
-------------VARIABLES-------------
-----------------------------------
X = {}
ESX = nil
Trailers = {}
Warehouses = {
	{
		storeName = "Warehouse",
		storeID   = 1,
		materials = {
			wood      = 100,
	        food      = 100,
	        mine      = 100,
	        water     = 100,
		},
		maxMaterials = {
			wood      = 200,
	        food      = 200,
	        mine      = 200,
	        water     = 200,
		},
        mainDoor  = {
        	x = -219.51,
        	y = -1162.43,
        	z = 23.02
        },
        getCharge = {
        	x = -222.34,
        	y = -1181.58,
        	z = 23.03
        },
        spawnCharge = {
        	x = -235.51,
        	y = -1164.61,
        	z = 22.95,
        	h = 272.88
        },
        leaveCharge = {
        	x = -208.25,
        	y = -1182.4,
        	z = 23.03
        },
        getBox = {
        	x = -208.48,
        	y = -1177.44,
        	z = 22.98
        }
	}
}
IDPlant = 1
local materials = {"wood","food","mine","water"}

-----------------------------------
-----------INICIALIZADOR-----------
-----------------------------------

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-----------------------------------
-------------TRANSLATES------------
-----------------------------------

Local = {
	addTrailer = "The load has been successfully loaded.",
	removeTrailer = "The load has been successfully downloaded.",
	someError  = "An error has occurred.",
	get = "You've got ",
	lingot_carbon = "Processed coal",
	lingot_iron = "an iron ingot",
	lingot_silver = "a silver ingot",
	lingot_gold = "a silver ingot",
	youNeed10 = "I'm sorry but you're missing merchandise, you need at least 10 pieces.",
	pine_processed  = 'Processed wood',
	youNeedASeed = "You need such a seed",
	noMoney = "You don't have enough money",
	youBought = "You have purchased an item",
	removeSalinity = "You have removed salinity from the water",
	removePollution = "You have removed water pollution",
	addChemists = "You have added chemicals to the water",
	addSalinity = "You have added salinity to the water",
	addPollution = "You have added water pollution",
	noBottles = "You have no bottles to clean",
	goodWashing = "You have properly cleaned all the bottles",
	noPieces = "You don't have enough pieces",
	goodPackage = "You have packaged everything correctly",
	youDontHaveEnough = "You do not have enough material.",
	goodWarehouse = "You have successfully sold your material",
	youWin = "You have earned money",
	fillwarehouse = "Fill the store"
}

-----------------------------------
---------------CONFIG--------------
-----------------------------------

Config = {}
Config.Rocks = { 
    {x = 2972.36, y = 2775.44, z = 39.24, health = 25, data = "carbon", max = 25},
    {x = 2968.64, y = 2775.64, z = 39.48, health = 5,  data = "gold", max = 5},
    {x = 2964.44, y = 2773.96, z = 40.04, health = 25, data = "carbon", max = 25},
    {x = 2951.16, y = 2768.52, z = 39.84, health = 10,  data = "silver", max = 10},
    {x = 2947.2, y = 2765.96, z = 40.36, health = 14, data = "iron", max = 14},
    {x = 2937.2, y = 2771.92, z = 39.88, health = 25, data = "carbon", max = 25},
    {x = 2927.28, y = 2792.41, z = 40.49, health = 5, data = "gold", max = 5},
    {x = 2925.56, y = 2796.48, z = 41.44, health = 10, data = "silver", max = 10},
    {x = 2921.44, y = 2799.32, z = 42.16, health = 14, data = "iron", max = 14},
    {x = 2938.52, y = 2812.64, z = 43.4, health = 5, data = "gold", max = 5},
    {x = 2951.32, y = 2816.32, z = 42.92, health = 25, data = "carbon", max = 25},
    {x = 2971.96, y = 2798.68, z = 42.16, health = 14, data = "iron", max = 14},
    {x = 2979.08, y = 2790.48, z = 41.6, health = 10, data = "silver", max = 10}
}
Config.Woods = { 
	{x = -557.61, y = 5419.43, z = 63.2, health = 20, data = "pine", max = 20},
	{x = -561.81, y = 5421.32, z = 62.17, health = 20, data = "pine", max = 20},
	{x = -577.57, y = 5427.06, z = 59.06, health = 20, data = "pine", max = 20},
	{x = -551.8, y = 5445.49, z = 64.1, health = 20, data = "pine", max = 20},
	{x = -586.12, y = 5447.83, z = 60.32, health = 20, data = "pine", max = 20},
	{x = -591.61, y = 5449.7, z = 59.6, health = 20, data = "pine", max = 20},
	{x = -594.04, y = 5451.61, z = 59.44, health = 20, data = "pine", max = 20},
	{x = -582.08, y = 5470.29, z = 59.48, health = 20, data = "pine", max = 20},
	{x = -577.1, y = 5468.9, z = 60.75, health = 20, data = "pine", max = 20},
	{x = -572.57, y = 5468.12, z = 61.43, health = 20, data = "pine", max = 20},
	{x = -560.16, y = 5460.29, z = 63.63, health = 20, data = "pine", max = 20},
	{x = -563.14, y = 5457.28, z = 63.15, health = 20, data = "pine", max = 20}
}
Config.WaterPoints = {
	{id = 1, x = 1695.61, y = 45.24, z = 161.77, salinity = 40, chemists = 0, pollution = 40},
	{id = 2, x = 1696.32, y = 40.75, z = 161.77, salinity = 40, chemists = 0, pollution = 40},
	{id = 3, x = 1690.87, y = 39.44, z = 161.77, salinity = 40, chemists = 0, pollution = 40},
	{id = 4, x = 1684.76, y = 39.49, z = 161.77, salinity = 40, chemists = 0, pollution = 40},
	{id = 5, x = 1676.91, y = 38.42, z = 161.77, salinity = 40, chemists = 0, pollution = 40}
}
Config.Valves = {
	{id = 1, type = "salinity", quantity = 25, seconds = 60, x = 1665.29, y = -0.58, z = 166.12, name = "electricityDown", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_HAMMERING'},
	{id = 2, type = "pollution", quantity = 25, seconds = 60, x = 1666.72, y = -62.66, z = 174.17, name = "catCall", isAvaliable = true, animSeconds = 5, anim = {lib = 'timetable@jimmy@doorknock@', anim = 'knockdoor_idle'}},
	{id = 3, type = "pollution", quantity = 100, seconds = 300, x = 1664.64, y = -28.04, z = 196.94, name = "greenpeaceAcept", isAvaliable = true, animSeconds = 10, anim = {lib = "anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", anim = "high_center"}},
	{id = 4, type = "pollution", quantity = -100, seconds = 3600, x = 1660.83, y = -24.74, z = 173.77, name = "capitalistAccept", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_SMOKING'},
	{id = 5, type = "chemists", quantity = 50, seconds = 150, x = 1928.47, y = 592.85, z = 175.67, name = "toxic1", isAvaliable = true, animSeconds = 10, anim = {lib = "mini@repair", anim = "fixing_a_ped"}},
	{id = 6, type = "salinity", quantity = -25, seconds = 600, x = 1877.00, y = 288.48, z = 164.305, name = "salinity1", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_CONST_DRILL'},
	{id = 7, type = "salinity", quantity = 50, seconds = 150, x = 1718.81, y = -71.47, z = 171.78, name = "salinity2", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_GARDENER_LEAF_BLOWER'},
	{id = 8, type = "pollution", quantity = 30, seconds = 150, x = 1662.12, y = 23.09, z = 180.87, name = "pollution1", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_BINOCULARS'},
	{id = 9, type = "pollution", quantity = -40, seconds = 600, x = 1856.69, y = 236.66, z = 161.01 , name = "pollution2", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_BUM_WASH'},
	{id = 10, type = "chemists", quantity = 50, seconds = 150, x = 1664.74, y = 1.68, z = 173.77 , name = "chemist1", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_YOGA'},
	{id = 11, type = "pollution", quantity = 25, seconds = 150, x = 1672.83, y = -27.42, z = 173.77 , name = "pollution3", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_WELDING'},
	{id = 11, type = "salinity", quantity = 25, seconds = 150, x = 1917.33, y = 585.79, z = 176.37 , name = "salinity3", isAvaliable = true, animSeconds = 10, anim = 'WORLD_HUMAN_WELDING'},
}
Config.Plants = {
	
}
Config.CycleGrowSeconds = 5
Config.CycleWaterSeconds = 14

 Config.BasePrices = {
 	bottleWater_package = 240,
 	blueberry_package = 65,
 	tomato_package = 65,
 	lingot_carbon = 90,
 	lingot_iron = 290,
 	lingot_silver = 360,
 	lingot_gold = 425,
 	pine_processed = 108
 } 
 Config.TonsPrice = 25
-----------------------------------
--------------EVENTOS--------------
-----------------------------------

ESX.RegisterServerCallback('tm1_stores:getWarehouses', function(source, cb)
	cb(Warehouses)
end)

ESX.RegisterServerCallback('tm1_stores:getWarehouse', function(source, cb, shop)
	cb(X.GetShop(shop))
end)

ESX.RegisterServerCallback('tm1_stores:getMaterial', function(source, cb, shop, material)
	cb(X.GetMaterial(shop, material))
end)

ESX.RegisterServerCallback('tm1_stores:getMaxMaterial', function(source, cb, shop, material)
	cb(X.GetMaxMaterial(shop, material))
end)

ESX.RegisterServerCallback('tm1_stores:getTrailers', function(source, cb)
	cb(Trailers)
end)

ESX.RegisterServerCallback('tm1_stores:getTrailer', function(source, cb, plate)
	cb(X.GetTrailer(plate))
end)

ESX.RegisterServerCallback('tm1_stores:getRocks', function(source, cb)
	cb(Config.Rocks)
end)

ESX.RegisterServerCallback('tm1_stores:getWoods', function(source, cb)
	cb(Config.Woods)
end)

ESX.RegisterServerCallback('tm1_stores:getPlants', function(source, cb)
	cb(Config.Plants)
end)

ESX.RegisterServerCallback('tm1_stores:getWaterPoints', function(source, cb)
	cb(Config.WaterPoints)
end)

ESX.RegisterServerCallback('tm1_stores:getValves', function(source, cb)
	cb(Config.Valves)
end)

ESX.RegisterServerCallback('tm1_stores:haveMoney', function(source, cb, money)
	cb(nil)
end)

ESX.RegisterUsableItem('tomato_seed', function(source)
	TriggerClientEvent('tm1_stores:plant', source, 'tomato_seed')
end)

ESX.RegisterUsableItem('blueberry_seed', function(source)
	TriggerClientEvent('tm1_stores:plant', source, 'blueberry_seed')
end)

ESX.RegisterUsableItem('wateringcan', function(source)
	TriggerClientEvent('tm1_stores:addWater', source, 25)
end)

ESX.RegisterUsableItem('lowgradefert', function(source)
	TriggerClientEvent('tm1_stores:addFertilizer', source, 25)
end)

ESX.RegisterUsableItem('highgradefert', function(source)
	TriggerClientEvent('tm1_stores:addFertilizer', source, 50)
end)

ESX.RegisterUsableItem('tomato_seed', function(source)
	TriggerClientEvent('tm1_stores:plant', source, 'tomato_seed')
end)

ESX.RegisterUsableItem('tomato_seed', function(source)
	TriggerClientEvent('tm1_stores:plant', source, 'tomato_seed')
end)

ESX.RegisterUsableItem('bottle', function(source)
	TriggerClientEvent('tm1_stores:takeWater', source)
end)

RegisterServerEvent('tm1_stores:addMaterial')
AddEventHandler('tm1_stores:addMaterial', function(warehouse, material,quantity)
	X.AddMaterial(warehouse, material, quantity)
end)

RegisterServerEvent('tm1_stores:removeMaterial')
AddEventHandler('tm1_stores:removeMaterial', function(warehouse, material,quantity)
	X.RemoveMaterial(warehouse, material, quantity)
end)

RegisterServerEvent('tm1_stores:setMaterial')
AddEventHandler('tm1_stores:setMaterial', function(warehouse, material,quantity)
	X.SetMaterial(warehouse, material, quantity)
end)

RegisterServerEvent('tm1_stores:addTrailer')
AddEventHandler('tm1_stores:addTrailer', function(plate, tons)
	if X.AddTrailer(plate, tons) == true then
		TriggerClientEvent('esx:showNotification', source, Local.addTrailer)
	else
		TriggerClientEvent('esx:showNotification', source, Local.someError)
	end
end)

RegisterServerEvent('tm1_stores:removeTrailer')
AddEventHandler('tm1_stores:removeTrailer', function(plate)
	if X.RemoveTrailer(plate) == true then
		TriggerClientEvent('esx:showNotification', source, Local.removeTrailer)
	else
		TriggerClientEvent('esx:showNotification', source, Local.someError)
	end
end)

RegisterServerEvent('tm1_stores:giveMineral')
AddEventHandler('tm1_stores:giveMineral', function(mineral)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.addInventoryItem(mineral.."_piece", 1)
	end
end)

RegisterServerEvent('tm1_stores:getData')
AddEventHandler('tm1_stores:getData',function(data)
	Rocks = data
	TriggerClientEvent('tm1_stores:getDataClients',-1,Rocks)
end)

RegisterServerEvent('tm1_stores:getJob')
AddEventHandler('tm1_stores:getJob',function()
	local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer then
		TriggerClientEvent('tm1_stores:setJob',source,xPlayer.job.name)
	end
end)

RegisterServerEvent('tm1_stores:craft')
AddEventHandler('tm1_stores:craft',function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local quantityMineral = xPlayer.getInventoryItem(item.."_piece")
		if quantityMineral.count >= 10 then
			xPlayer.removeInventoryItem(item.."_piece",10)
			Wait(500)
			xPlayer.addInventoryItem("lingot_"..item,1)
			TriggerClientEvent('esx:showNotification', source, Local.get..Local["lingot_"..item])
		else
			TriggerClientEvent('esx:showNotification', source, Local.youNeed10)
		end
	end
end)

RegisterServerEvent('pop_university:setMineLevel')
AddEventHandler('pop_university:setMineLevel',function(skills)
	local level = X.CalculateLevel(skills)
	TriggerClientEvent('pop_university:setMineLevel',source,level)
end)

RegisterServerEvent('tm1_stores:giveWood')
AddEventHandler('tm1_stores:giveWood', function(wood)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.addInventoryItem(wood.."_wood", 1)
	end
end)

RegisterServerEvent('tm1_stores:getDataWood')
AddEventHandler('tm1_stores:getDataWood',function(data)
	Woods = data
	TriggerClientEvent('tm1_stores:getDataClientsWoods',-1,Woods)
end)

RegisterServerEvent('tm1_stores:craftWood')
AddEventHandler('tm1_stores:craftWood',function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local quantityWood = xPlayer.getInventoryItem(item.."_wood")
		if quantityWood.count >= 10 then
			xPlayer.removeInventoryItem(item.."_wood",10)
			Wait(500)
			xPlayer.addInventoryItem(item.."_processed",1)
			TriggerClientEvent('esx:showNotification', source, Local.get..Local[item.."_processed"])
		else
			TriggerClientEvent('esx:showNotification', source, Local.youNeed10)
		end
	end
end)

RegisterServerEvent('tm1_stores:plant')
AddEventHandler('tm1_stores:plant',function(seed, x, y, z, id)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local quantityWood = xPlayer.getInventoryItem(seed.seed)
		if quantityWood.count >= 1 then
			xPlayer.removeInventoryItem(seed.seed, 1)
			if seed.seed == "tomato_seed" then
				X.AddPant(seed, {x = x, y = y, z = z - 2.2}, source, id)
			elseif seed.seed == "blueberry_seed" then
				X.AddPant(seed, {x = x, y = y, z = z - 2.2}, source, id)
			else
				X.AddPant(seed, {x = x, y = y, z = z}, source, id)
			end
		else
			TriggerClientEvent('esx:showNotification', source, Local.youNeedASeed)
		end
	end
end)

RegisterServerEvent('tm1_stores:removePlant')
AddEventHandler('tm1_stores:removePlant',function(id, coords)
	for k,v in pairs(Config.Plants) do
		for k1, v1 in pairs(v) do
			if v1.id == id then
				table.remove(v, k1)
				TriggerClientEvent('tm1_stores:removePlant', v1.source, coords)
			end
		end
	end
end)

RegisterServerEvent('tm1_stores:addWater')
AddEventHandler('tm1_stores:addWater',function(id, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    for k,v in pairs(Config.Plants) do
        for k1, v1 in pairs(v) do
            if v1.id == id then
                local plus = v1.water + quantity
                if plus > 100 then
                    v1.water = 100
                else
                    v1.water = v1.water + quantity
                end
            end
        end
    end
end)

RegisterServerEvent('tm1_stores:addFertilizer')
AddEventHandler('tm1_stores:addFertilizer',function(id, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    if quantity == 25 then
        xPlayer.removeInventoryItem("lowgradefert",1)
    elseif quantity == 50 then
        xPlayer.removeInventoryItem("highgradefert",1)
    else
        return
    end
    for k,v in pairs(Config.Plants) do
        for k1, v1 in pairs(v) do
            if v1.id == id then
                local plus = v1.fertilizer + quantity
                if plus > 100 then
                    v1.fertilizer = 100
                else
                    v1.fertilizer = plus
                end
            end
        end
    end
end)

RegisterServerEvent('tm1_stores:harvestPlant')
AddEventHandler('tm1_stores:harvestPlant',function(id, seed)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		for k,v in pairs(Config.Plants) do
			for k1, v1 in pairs(v) do
				if v1.id == id then
					table.remove(v, k1)
					Citizen.Wait(500)
					local number = X.GetNumberOfPieces(seed.maxPlants, v1)
					xPlayer.addInventoryItem(seed.reward,number)
				end
			end
		end
	end
end)

RegisterServerEvent('tm1_stores:buyItem')
AddEventHandler('tm1_stores:buyItem',function(seed, price)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if (price <= xPlayer.getMoney()) then
			xPlayer.removeMoney(price)
			Citizen.Wait(500)
			xPlayer.addInventoryItem(seed,1)
			TriggerClientEvent('esx:showNotification', source, Local.youBought)
		else
			TriggerClientEvent('esx:showNotification', source, Local.noMoney)
		end
	end
end)


RegisterServerEvent('tm1_stores:doSomething')
AddEventHandler('tm1_stores:doSomething',function(valve)
	local valveType = valve.type
	local quantity = valve.quantity
	if valveType == 'salinity' then
		if X.RemoveSalinity(quantity) then
			X.SetTimeValve(valve.id, valve.seconds)
			if quantity > 0 then
				TriggerClientEvent('esx:showNotification', source, Local.removeSalinity)
			else
				TriggerClientEvent('esx:showNotification', source, Local.addSalinity)
			end
		end
	elseif valveType == 'chemists' then
		if X.AddChemists(quantity) then
			X.SetTimeValve(valve.id, valve.seconds)
			if quantity > 0 then
				TriggerClientEvent('esx:showNotification', source, Local.addChemists)
			else
				TriggerClientEvent('esx:showNotification', source, Local.removeChemists)
			end
		end
	elseif valveType == 'pollution' then
		if X.RemovePollution(quantity) then
			X.SetTimeValve(valve.id, valve.seconds)
			if quantity > 0 then
				TriggerClientEvent('esx:showNotification', source, Local.removePollution)
			else
				TriggerClientEvent('esx:showNotification', source, Local.addPollution)
			end
		end
	end
end)

RegisterServerEvent('tm1_stores:addWaterBottle')
AddEventHandler('tm1_stores:addWaterBottle',function(point)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		if point.salinity > 40 then
			xPlayer.removeInventoryItem("waterBottle",1)
			xPlayer.addInventoryItem("salt_waterBottle",1)
			return true
		elseif point.pollution > 40 then
			xPlayer.removeInventoryItem("waterBottle",1)
			xPlayer.addInventoryItem("pollution_waterBottle",1)
			return true
		elseif point.chemists > 80 then
			xPlayer.removeInventoryItem("waterBottle",1)
			xPlayer.addInventoryItem("toxic_waterBottle",1)
			return true
		elseif point.chemists < 20 then
			xPlayer.removeInventoryItem("waterBottle",1)
			xPlayer.addInventoryItem("bactery_waterBottle",1)
			return true
		else
			xPlayer.removeInventoryItem("waterBottle",1)
			xPlayer.addInventoryItem("dirty_waterBottle",1)
			return true
		end
	end
end)

RegisterServerEvent('tm1_stores:washBottles')
AddEventHandler('tm1_stores:washBottles',function(point)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local bottles = xPlayer.getInventoryItem('dirty_waterBottle').count
		if bottles > 0 then
			xPlayer.removeInventoryItem("dirty_waterBottle",bottles)
			xPlayer.addInventoryItem("full_waterBottle",bottles)
			TriggerClientEvent('esx:showNotification', source, Local.goodWashing)
		else
			TriggerClientEvent('esx:showNotification', source, Local.noBottles)
		end
	end
end)

RegisterServerEvent('tm1_stores:washSaltBottles')
AddEventHandler('tm1_stores:washSaltBottles',function(point)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local bottles = xPlayer.getInventoryItem('salt_waterBottle').count
		if bottles > 0 then
			xPlayer.removeInventoryItem("salt_waterBottle",bottles)
			xPlayer.addInventoryItem("dirty_waterBottle",bottles)
			TriggerClientEvent('esx:showNotification', source, Local.goodWashing)
		else
			TriggerClientEvent('esx:showNotification', source, Local.noBottles)
		end
	end
end)

RegisterServerEvent('tm1_stores:package')
AddEventHandler('tm1_stores:package',function(from,to)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local pieces = xPlayer.getInventoryItem(from).count
		local rest = pieces % 10
		local totalPieces = pieces - rest
		print(totalPieces)
		if totalPieces >= 10 then
			xPlayer.removeInventoryItem(from,totalPieces)
			Citizen.Wait(500)
			xPlayer.addInventoryItem(to,totalPieces / 10)
			TriggerClientEvent('esx:showNotification', source, Local.goodPackage)
		else
			TriggerClientEvent('esx:showNotification', source, Local.noPieces)
		end
	end
end)

RegisterServerEvent('tm1_stores:fillWarehouses')
AddEventHandler('tm1_stores:fillWarehouses',function(id, material, item, tons)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		local pieces = xPlayer.getInventoryItem(item).count
		
		if pieces >= tons then
			local shop = X.GetShop(id)
			local piecesWarehouse = shop.materials[material]
			local maxPieces = shop.maxMaterials[material]
			local percent = 1.2 - ((piecesWarehouse * 100) / maxPieces) / 100
			local money = tons * Config.BasePrices[item] * percent
			print(tons.."->"..percent.."->"..money.." | "..piecesWarehouse.."->"..maxPieces)
			xPlayer.addMoney(money)
			xPlayer.removeInventoryItem(item,tons)
			Citizen.Wait(500)
			X.AddMaterial(id, material, tons)
			TriggerClientEvent('esx:showNotification', source, Local.goodWarehouse)
		else
			TriggerClientEvent('esx:showNotification', source, Local.youDontHaveEnough)
		end
	end
end)

RegisterServerEvent('tm1_stores:payTons')
AddEventHandler('tm1_stores:payTons', function ( tons )
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.addMoney(tons * Config.TonsPrice)
		TriggerClientEvent('esx:showNotification', source, Local.youWin)
	end
end)
-----------------------------------
-------------FUNCIONES-------------
-----------------------------------
X.Round = function(value, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

X.IsAValidMaterial = function(material)
	for k,v in pairs(materials) do
		if v == material then
			return true
		end
	end

	return false
end

X.IsAValidWarehouse = function(warehouse)
	for k,v in pairs(Warehouses) do
		if v.storeName == warehouse or v.storeID == warehouse then
			return true
		end
	end

	return false
end

X.GetShop = function(id)
	for k,v in pairs(Warehouses) do
		if v.storeID == id or v.storeName == id then
			return v
		end
	end

	return {}
end

X.AddMaterial = function(warehouse, material, quantity)
	if quantity > 0 and X.IsAValidMaterial(material) and X.IsAValidWarehouse(warehouse) then
		for i,v in pairs(Warehouses) do
			if v.storeName == warehouse or v.storeID == warehouse then
				total = v.materials[material] + quantity
				if total <= v.maxMaterials[material] then
					v.materials[material] = total
					return true
				end
			end
		end
	end
	return false
end

X.SetMaterial = function(warehouse, material, quantity)
	if quantity > 0 and X.IsAValidMaterial(material) and X.IsAValidWarehouse(warehouse) then
		for i,v in pairs(Warehouses) do
			if v.storeName == warehouse or v.storeID == warehouse then
				if quantity <= v.maxMaterials[material] and quantity > 0then
					v.materials[material] = quantity
					return true
				end
			end
		end
	end
	return false
end

X.RemoveMaterial = function(warehouse, material, quantity)
	if quantity > 0 and X.IsAValidMaterial(material) and X.IsAValidWarehouse(warehouse) then
		for i,v in pairs(Warehouses) do
			if v.storeName == warehouse or v.storeID == warehouse then
				total = v.materials[material] - quantity
				if total >= 0 then
					v.materials[material] = total
					return true
				end
			end
		end
	end
	return false
end

X.GetMaterial = function(warehouse, material)
	if X.IsAValidMaterial(material) and X.IsAValidWarehouse(warehouse) then
		for i,v in pairs(Warehouses) do
			if v.storeName == warehouse or v.storeID == warehouse then
				return v.materials[material]
			end
		end
	end
	return false
end

X.GetMaxMaterial = function(warehouse, material)
	if X.IsAValidMaterial(material) and X.IsAValidWarehouse(warehouse) then
		for i,v in pairs(Warehouses) do
			if v.storeName == warehouse or v.storeID == warehouse then
				return v.maxMaterials[material]
			end
		end
	end
	return false
end

X.GetTrailer = function(plate)
	for k,v in pairs(Trailers) do
		if v.plate == plate then
			return v
		end
	end

	return nil
end

X.GetIndexOfTrailer = function(plate)
	for k,v in pairs(Trailers) do
		if v.plate == plate then
			return k
		end
	end

	return nil
end

X.AddTrailer = function(plate, tons)
	if X.GetTrailer(plate) == nil then
		table.insert(Trailers, {plate = plate, tons = tons})
		return true
	end

	return false
end

X.RemoveTrailer = function(plate)
	local index = X.GetIndexOfTrailer(plate)
	if index ~= nil then
		table.remove(Trailers, index)
		return true
	end

	return false
end

X.ReloadRocks = function()
	for i,v in pairs(Config.Rocks) do
		if v.health < v.max then
			v.health = v.health + 1
		end
	end
	TriggerClientEvent('tm1_stores:getDataClientsRocks',-1,Config.Rocks)
end

X.ReloadWoods = function()
	for i,v in pairs(Config.Woods) do
		if v.health < v.max then
			v.health = v.health + 1
		end
	end
	TriggerClientEvent('tm1_stores:getDataClientsWoods',-1,Config.Woods)
end

X.StartReloads = function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1200000) -- treereload (Now 10 mins instead of 60 seconds)
			print("Mother nature doing her thing")
			X.ReloadRocks()
			X.ReloadWoods()
		end
	end)
end

X.AddPant = function(seed, coords, source, id)
	if Config.Plants[id] == nil then
		Config.Plants[id] = {}
	end
	table.insert(Config.Plants[id], {id = IDPlant, source = source, rot = 100, seed = seed.seed, percent = -2, water = 27, fertilizer = 26, reward = seed.reward, x = coords.x, y = coords.y, z = coords.z})
	IDPlant = IDPlant + 1
	TriggerClientEvent('tm1_stores:plantSeed', source, seed, coords)
	TriggerClientEvent('tm1_stores:refreshPlants', -1, Config.Plants)
end

X.GrowPlants = function()
	for k,v in pairs(Config.Plants) do
		for k1, v1 in pairs(v) do
			if v1.water > 0 and v1.percent <= 100 then
				if v1.fertilizer ~= 0 then
					v1.percent = v1.percent + 1
					v1.water = v1.water - 1
					if v1.water % 2 == 0 then
						v1.fertilizer = v1.fertilizer - 1
					end
				else
					v1.water = v1.water - 1
				end
			else
				if v1.percent >= 100 then
					if v1.fertilizer > 0 then
						v1.fertilizer = v1.fertilizer - 1
					else
						v1.rot = v1.rot - 1
					end
				else
					if v1.fertilizer > 0 then
						v1.fertilizer = v1.fertilizer - 1
					end
					v1.rot = v1.rot - 5
				end

			end
		end
	end
	TriggerClientEvent('tm1_stores:refreshPlants', -1, Config.Plants)
end

X.StartGrow = function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(Config.CycleGrowSeconds * 1000)
			X.GrowPlants()
		end
	end)
end

X.GetNumberOfPieces = function(pieces, v)
	local number = pieces * X.Round((v.rot / 100), 0)
	return number
end
--[[
X.StartWater = function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(Config.CycleWaterSeconds * 1000)
			X.ChangeWater()
		end
	end)
end

X.ChangeWater = function()
	for i,v in pairs(Config.WaterPoints) do
		if v.salinity >= 0 and v.salinity < 100 then
			v.salinity = v.salinity + 1
		end

		if v.chemists > 0 and v.chemists <= 100 then
			local random = math.random(0,100)
			if random > 50 and random <= 100 then
				v.chemists = v.chemists - 1
			end
		end

		if v.pollution >= 0 and v.pollution < 100 then
			local random = math.random(0,100)
			if random > 50 and random <= 100 then
				v.pollution = v.pollution + 1
			end
		end
	end
	TriggerClientEvent('tm1_stores:refreshWater', -1, Config.WaterPoints)
end


X.RemoveSalinity = function(quantity)
	for k,v in pairs(Config.WaterPoints) do
		v.salinity = v.salinity - quantity
		if v.salinity < 0 then
			v.salinity = 0
		elseif v.salinity > 100 then
			v.salinity = 100
		end
	end
	return true
end

X.RemovePollution = function(quantity)
	for k,v in pairs(Config.WaterPoints) do
		v.pollution = v.pollution - quantity
		if v.pollution < 0 then
			v.pollution = 0
		elseif v.pollution > 100 then
			v.pollution = 100
		end
	end
	return true
end

X.AddChemists = function(quantity)
	for k,v in pairs(Config.WaterPoints) do
		v.chemists = v.chemists + quantity
		if v.chemists > 100 then
			v.chemists = 100
		elseif v.chemists < 0 then
			v.chemists = 0
		end
	end
	return true
end

X.SetIsAvaliable = function(id, bool)
	for k,v in pairs(Config.Valves) do
		if v.id == id then
			v.isAvaliable = bool
		end
	end
end

X.SetTimeValve = function(id, seconds)
	Citizen.CreateThread(function()
		X.SetIsAvaliable(id, false)
		TriggerClientEvent('tm1_stores:refreshValves', -1, Config.Valves)
		Citizen.Wait(seconds * 1000)
		X.SetIsAvaliable(id, true)
		TriggerClientEvent('tm1_stores:refreshValves', -1, Config.Valves)
	end)
end
--]]
-------------------
--UNIVERSIDAD------
-------------------

X.CalculateLevel = function(skills)
	local level = 0
	for i,v in pairs(skills) do
		if v == "carbon" or v == "hierro" or v == "plata" or v == "oro" then
			level = level + 1
		end
	end
	return level
end

X.StartReloads()
X.StartGrow()
--X.StartWater()


------------------------------------
--------------COMANDOS--------------
------------------------------------
TriggerEvent('es:addGroupCommand', 'fillwarehouse', 'admin', function(source, args, user)
	local id = tonumber(args[1])
	local material = tonumber(args[2])
	local quantity = tonumber(args[3])
	
	if #args < 1 then
		if #args < 2 then
			if #args < 3 then
				X.AddMaterial(id, material, quantity)
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You have to put a quantity.")
			end
		else
			TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You have to put a material.")
		end
	else
		TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "You have to put an ID.")
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = Local.fillwarehouse, params = {{name = "id", help = "ID"}, {name = "material", help = "material"}, {name = "quantity", help = "Quantity"}}})
