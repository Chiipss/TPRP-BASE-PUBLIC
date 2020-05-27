local ESX = nil

local cachedSafes = {}

TriggerEvent('esx:getSharedObject', function(obj) 
	ESX = obj 
end)

RegisterServerEvent("safebreach:globalEvent")
AddEventHandler("safebreach:globalEvent", function(options)
    -- ESX.Trace((options["event"] or "none") .. " triggered to all clients.")

	if options["data"] and options["data"]["save"] then
		if not cachedSafes[options["data"]["store"]] then
			cachedSafes[options["data"]["store"]] = {
				["breacher"] = GetPlayerName(source),
				["safeCoords"] = options["data"]["doorCoords"],
				["timeBreached"] = os.time()
			}
		end

		cachedSafes[options["data"]["store"]]["saveData"] = options["data"]
	end

    TriggerClientEvent("safebreach:eventHandler", -1, options["event"] or "none", options["data"] or nil)
end)

ESX.RegisterServerCallback("safebreach:checkSafeBreaches", function(source, cb)
	local player = ESX.GetPlayerFromId(source)

	if player then
		for safeStore, safeData in pairs(cachedSafes) do
			if safeData["saveData"] then
				TriggerClientEvent("safebreach:eventHandler", source, "open_door", safeData["saveData"])
			end
		end

		cb(true)
	else
		cb(false)	
	end
end)

ESX.RegisterServerCallback("safebreach:checkIfSafeIsBreachable", function(source, cb, safe)
	local player = ESX.GetPlayerFromId(source)

	if player then
		if cachedSafes[safe] then
			cb(false)
		else
			TriggerEvent('tprp:GetJobCount', 'police', function(count)
				cb(count >= Config.PoliceRequired)
			end)
			--[[
			local policeMen = 0
			local players = ESX.GetPlayers()

			for i = 1, #players do
				local player = ESX.GetPlayerFromId(players[i])

				if player and player["job"]["name"] == "police" then
					policeMen = policeMen + 1
				end
			end
			]]
		end
	else
		cb(false)	
	end
end)

ESX.RegisterServerCallback("safebreach:safeBreached", function(source, cb, safeData)
	local player = ESX.GetPlayerFromId(source)

	if player then
		if cachedSafes[safeData["store"]] then
			cb(false)

			return
		end

		cachedSafes[safeData["store"]] = {
			["breacher"] = player["name"],
			["safeCoords"] = safeData["doorCoords"],
			["timeBreached"] = os.time()
		}

		StartTimer(safeData)

		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback("safebreach:receiveReward", function(source, cb, reward)
	local player = ESX.GetPlayerFromId(source)

	if player then
		if reward then
			if reward == "money" then
				local rewardAmount = math.random(Config.RandomCashReward[1], Config.RandomCashReward[2])

				player.addMoney(rewardAmount)

				TriggerClientEvent("esx:showNotification", source, "You stole $" .. rewardAmount)
			else
				player.addInventoryItem("champagne", 1)

				TriggerClientEvent("esx:showNotification", source, "You stole the bottle.")
				TriggerClientEvent("tp:setToFalse", -1)

                Citizen.Wait(100)

				local mth = math.random(1,10)

				if mth <=4 then
                    -- TriggerServerEvent("tp:gruppeItemFromServer", source, "securityblack", 1) --Gruppe
                    player.addInventoryItem("securityblack", 1)
				end
			end


			cb(true)
		else
			cb(false)
		end
	else
		cb(false)
	end
end)

StartTimer = function(safeData)
	Citizen.CreateThread(function()
		while (os.time() - cachedSafes[safeData["store"]]["timeBreached"]) < Config.SafeCooldown do
			Citizen.Wait(0)
		end

		cachedSafes[safeData["store"]] = nil

		TriggerClientEvent("safebreach:eventHandler", -1, "close_door", {
			["store"] = safeData["store"],
			["safeCoords"] = safeData["doorCoords"],
			["doorRotation"] = safeData["doorRotation"]
		})
	end)
end
