ESX = nil

local cachedData = {}

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

ESX.RegisterServerCallback("tp-financemenu:getFinancedVehicles", function(source, callback)
	local player = ESX.GetPlayerFromId(source)

	if player then
		local sqlQuery = [[
			SELECT
				plate, vehicle, finance, financetimer
			FROM
				owned_vehicles
			WHERE
				owner = @cid and finance > 0
		]]

		MySQL.Async.fetchAll(sqlQuery, {
			["@cid"] = player["identifier"],
			--["@garage"] = garage
		}, function(responses)
			local playerVehicles = {}

			for key, vehicleData in ipairs(responses) do
				table.insert(playerVehicles, {
					["plate"] = vehicleData["plate"],
					["props"] = json.decode(vehicleData["vehicle"]),
					["finance"] = vehicleData["finance"],
					["financetimer"] = vehicleData["financetimer"]
				})
			end

			callback(playerVehicles)
		end)
	else
		callback(false)
	end
end)

ESX.RegisterServerCallback("tp-financemenu:getMinimumPayment", function(source, callback, plate)
	local player = ESX.GetPlayerFromId(source)
	if player then
		local sqlQuery = [[
			SELECT
				retailprice
			FROM
				owned_vehicles
			WHERE
				plate = @plate
		]]

		MySQL.Async.fetchAll(sqlQuery, {
			["@plate"] = plate
		}, function(responses)
			if responses[1] then
				minimumPayment = (responses[1].retailprice / 10)
				minimumPayment = round(minimumPayment)
				print("Calculated Min: " .. minimumPayment)
			else
				callback(false)
			end
		end)
	else
		callback(false)
		print("Something different broke")
	end

	if player then
		local sqlQuery = [[
			SELECT
				finance
			FROM
				owned_vehicles
			WHERE
				plate = @plate
		]]

		MySQL.Async.fetchAll(sqlQuery, {
			["@plate"] = plate
		}, function(responses)
			if responses[1] then
				financeleft = (responses[1].finance)
				financeleft = round(financeleft)
				print("Finance Left: " .. financeleft)
			else
				callback(false)
			end
		end)
	else
		callback(false)
		print("Something different broke")
	end

	Citizen.Wait(100)
	
	-- COMPARE IF MINIMUM PAYMENT GRABBED FROM RETAIL PRICE IS MORE THAN THE AMOUNT OF FINANCE OUTSTANDING
	-- IF SO, MINIMUM PAYMENT BECOMES THE AMOUNT OF FINANCE LEFT -- STOPS BREAKING PEOPLE :D
	if financeleft < minimumPayment then
		minimumPayment = financeleft
		exactmin = true
	else
		exactmin = false
	end

	local callbackstring = {}
	callbackstring.value1 = minimumPayment
	callbackstring.value2 = exactmin

	callback(callbackstring)
end)

function round(num)
    under = math.floor(num)
    upper = math.floor(num) + 1
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end