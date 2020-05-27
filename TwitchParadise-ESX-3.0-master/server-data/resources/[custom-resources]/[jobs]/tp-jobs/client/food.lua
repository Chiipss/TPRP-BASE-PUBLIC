X.Plant = function(seed, coords)
	Citizen.CreateThread(function()
		X.startScenario("WORLD_HUMAN_GARDENER_PLANT")
		exports["t0sic_loadingbar"]:StartDelayedFunction('Planting seeds', 10000, function()
		--Citizen.Wait((Config.SecondNeededToPlant - 3)* 1000)
		ClearPedTasks(PlayerPedId())
		Citizen.Wait(3 * 1000)
		ESX.Game.SpawnObject(seed.object, coords, function(object)
			FreezeEntityPosition(object,true)
		end)
		
		X.IsPlanting = false
	end)
end)
end

X.RemoveLowPlant = function(coords, id, seed)
	Citizen.CreateThread(function()
		local object, distance = ESX.Game.GetClosestObject(Config.Seeds[seed].object, coords)
		X.startScenario("WORLD_HUMAN_GARDENER_PLANT")
		exports["t0sic_loadingbar"]:StartDelayedFunction('Removing plant', 10000, function()
		--Citizen.Wait((Config.SecondNeededToPlant - 3)* 1000)
		ClearPedTasks(PlayerPedId())
		Citizen.Wait(3 * 1000)
		ESX.Game.DeleteObject(object)
		TriggerServerEvent('tm1_stores:removePlant', id, coords)
		SetEntityAsMissionEntity(object, false, true)
		Citizen.Wait(2 * 1000)
		X.IsPlanting = false
	end)
end)
end

X.HarvestPlant = function(coords, id, seed)
	Citizen.CreateThread(function()
		local object, distance = ESX.Game.GetClosestObject(Config.Seeds[seed].object, coords)
		X.startScenario("WORLD_HUMAN_GARDENER_PLANT")
		exports["t0sic_loadingbar"]:StartDelayedFunction('Harvesting', 10000, function()
		--Citizen.Wait((Config.SecondNeededToPlant - 3)* 1000)
		TriggerServerEvent('tm1_stores:harvestPlant', id, Config.Seeds[seed])
		ClearPedTasks(PlayerPedId())
		Citizen.Wait(3 * 1000)
		ESX.Game.DeleteObject(object)
		Citizen.Wait(2 * 1000)
		X.IsPlanting = false
	end)
end)
end

X.IsThisSeedAllowed = function(seed, ph)
	for k,v in pairs(ph.seedsAllowed) do
		if v == seed then
			return true
		end
	end

	return false
end

X.AddWater = function(id, quantity)
	Citizen.CreateThread(function()
		TriggerServerEvent('tm1_stores:addWater', id, quantity)
		X.startScenario("CODE_HUMAN_MEDIC_KNEEL")
		exports["t0sic_loadingbar"]:StartDelayedFunction('Watering', 5000, function()
		--Citizen.Wait(5* 1000)
		ClearPedTasks(PlayerPedId())	
		X.IsPlanting = false
	end)
end)
end

X.AddFertilizer = function(id, quantity)
	Citizen.CreateThread(function()
		TriggerServerEvent('tm1_stores:addFertilizer', id, quantity)
		X.startScenario("CODE_HUMAN_MEDIC_KNEEL")
		exports["t0sic_loadingbar"]:StartDelayedFunction('Fertilizing', 5000, function()
		--Citizen.Wait(5* 1000)
		ClearPedTasks(PlayerPedId())	
		X.IsPlanting = false
	end)
end)
end

X.OpenSeedMenu = function()
	local elements = Config.SeedShop
	exports['mythic_notify']:SendAlert('inform', 'You can plant these here seeds over in those fields in front of me', 15000)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'warehouse_load', {
		title    = Local.seedShop,
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value then
			TriggerServerEvent('tm1_stores:buyItem', data.current.value, data.current.price)
		end
	end,
	function(data, menu)
		menu.close()
	end
	)
end

X.Draw3DTextPlants = function(v)
	if v.rot > 0 then
		if v.percent < 100 then
			X.DrawText3D({x = v.x, y = v.y, z = v.z + 2}, "~w~["..Local[v.seed].."~w~] : "..v.percent.."%")
		else
			X.DrawText3D({x = v.x, y = v.y, z = v.z + 2}, "~w~["..Local[v.seed].."~w~] : ~g~"..Local.ready)
		end
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.9}, "~w~[~b~"..Local.water.."~w~] : "..v.water.."L")
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.8}, "~w~[~y~"..Local.fertilizer.."~w~] : "..v.fertilizer.."%")
	end
	if v.rot > 50 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.7}, "~w~[~g~"..Local.state.."~w~] : "..v.rot.."%")
	elseif v.rot > 25 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.7}, "~w~[~y~"..Local.state.."~w~] : "..v.rot.."%")
	elseif v.rot > 12 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.7}, "~w~[~o~"..Local.state.."~w~] : "..v.rot.."%")
	elseif v.rot > 0 then
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.7}, "~w~[~r~"..Local.state.."~w~] : "..v.rot.."%")
	else
		X.DrawText3D({x = v.x, y = v.y, z = v.z + 1.7}, "~w~[~r~"..Local.rotten.."~w~]")	
	end
end