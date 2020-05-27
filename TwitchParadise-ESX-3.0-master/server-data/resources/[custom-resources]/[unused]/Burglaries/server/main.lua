ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local LowItems = {
	{name = "watch", label = "Watch"}, 
    {name = "iron", label = "Iron"}, 
    {name = "phone", label = "Phone"}, 
    {name = "chocolate", label = "Chocolate"}, 
    {name = "cigarett", label = "Cigarett"}, 
    {name = "clothe", label = "Clothe"}, 
    {name = "cupcake", label = "Cupcake"}, 
    {name = "lighter", label = "Lighter"}, 
    {name = "rose", label = "Rose"}, 
    {name = "umbrella", label = "Umbrella"}
}
local MedItems = {
	{name = "ring", label = "Ring"}, 
	{name = "watch", label = "Watch"}, 
	{name = "gold", label = "Gold"}, 
	{name = "phone", label = "Phone"}, 
	{name = "champagne", label = "Champagne"}, 
	{name = "clothe", label = "Clothe"}, 
	{name = "cupcake", label = "Cupcake"}, 
	{name = "rose", label = "Rose"}, 
	{name = "umbrella", label = "Umbrella"}, 
	{name = "wine", label = "Wine"}
}
local HighItems = {
	{name = "jewels", label = "Jewels"}, 
	{name = "ring", label = "Ring"}, 
	{name = "gold", label = "Gold"}, 
	{name = "diamond", label = "Diamond"}, 
	{name = "champagne", label = "Champagne"}, 
	{name = "clothe", label = "Clothe"}, 
	{name = "rose", label = "Rose"}, 
	{name = "umbrella", label = "Umbrella"}, 
	{name = "whisky", label = "Whisky"}
}

ESX.RegisterServerCallback("suku:FetchBurglaryData", function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer == nil then return; end
    local Identifier = xPlayer.identifier

    MySQL.Async.fetchAll("SELECT burglaries FROM player_burglaries WHERE identifier = @identifier", { 
        ["@identifier"] = Identifier 
    }, function(result)
        if result[1] ~= nil then
            local burglaryList = json.decode(result[1].burglaries)
            cb(burglaryList)
        else
            cb(nil)
        end
	end)
end)

RegisterServerEvent("suku:WriteBurglariesToDB")
AddEventHandler("suku:WriteBurglariesToDB", function(burglaryList)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer == nil then return; end
    local Identifier = xPlayer.identifier

    MySQL.Async.execute('INSERT INTO player_burglaries (identifier, burglaries) VALUES (@identifier, @burglaries)', {
        ['@identifier'] = Identifier,
        ['@burglaries'] = json.encode(burglaryList)
    })
end)

RegisterServerEvent("suku:UpdateBurglariesToDB")
AddEventHandler("suku:UpdateBurglariesToDB", function(BurglaryLocations)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer == nil then return; end
    local Identifier = xPlayer.identifier

	MySQL.Async.execute("UPDATE player_burglaries SET burglaries = @burglaries WHERE identifier = @identifier", { 
        ['@identifier'] = Identifier, 
        ['@burglaries'] = json.encode(BurglaryLocations)
    })
end)

RegisterServerEvent("suku:BreakPicklock")
AddEventHandler("suku:BreakPicklock", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("lockpick")
    if item.count > 0 and amount > 0 then
        xPlayer.removeInventoryItem("lockpick", amount)
    end
end)

RegisterServerEvent("suku:RewardPlayerSearchHouseSpot")
AddEventHandler("suku:RewardPlayerSearchHouseSpot", function(type)
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemList = items
        if type == "low" then
            randomSeed = math.random(1, #LowItems)
            randomAmount = math.random(1, 3)
            chance = math.random(1, 15)
    
            local item = LowItems[randomSeed]
            xPlayer.addInventoryItem(item.name, randomAmount)
            if chance == 3 or chance == 13 then
                chanceSeed = math.random(1, #LowItems)
                chanceAmount = math.random(1, 3)
                xPlayer.addInventoryItem(LowItems[chanceSeed].name, chanceAmount)
            end
            TriggerClientEvent("suku:NotifyBurgPlayer",source, 'success', 'You found '..tostring(item.label)..' x'..tostring(randomAmount))

        elseif type == "med" then
            randomSeed = math.random(1, #MedItems)
            randomAmount = math.random(1, 5)
            chance = math.random(1, 20)
    
            if chance == 7 or chance == 11 then
                TriggerClientEvent("suku:NotifyBurgPlayer",source, 'error', 'You found nothing')
            else
                local item = MedItems[randomSeed]
                xPlayer.addInventoryItem(item.name, randomAmount)
                if chance == 3 or chance == 13 then
                    chanceSeed = math.random(1, #MedItems)
                    xPlayer.addInventoryItem(MedItems[chanceSeed].name, 1)
                end
                TriggerClientEvent("suku:NotifyBurgPlayer",source, 'success', 'You found '..tostring(item.label)..' x'..tostring(randomAmount))
            end
        elseif type == "high" then
            randomSeed = math.random(1, #HighItems)
            randomAmount = math.random(1, 3)
            chance = math.random(1, 25)
    
            if chance == 1 or chance == 11 or chance == 25 then
                TriggerClientEvent("suku:NotifyBurgPlayer",source, 'error', 'You found nothing')
            else
                local item = HighItems[randomSeed]
                xPlayer.addInventoryItem(item.name, randomAmount)
                if chance == 3 or chance == 13 then
                    chanceSeed = math.random(1, #HighItems)
                    xPlayer.addInventoryItem(HighItems[chanceSeed].name, 1)
                end
                TriggerClientEvent("suku:NotifyBurgPlayer",source, 'success', 'You found '..tostring(item.label)..' x'..tostring(randomAmount))
            end
        end
end)

ESX.RegisterServerCallback("suku:DoesPlayerHaveItem", function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem(item)
    if item.count > 0 then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('suku:StartBurglaryBlip')
AddEventHandler('suku:StartBurglaryBlip', function(isrobbing, location)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
	
	local cops = 0
	for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
			cops = cops + 1
		end
	end

    if isrobbing then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'police' then
                TriggerClientEvent('suku:SetBurglaryBlip', xPlayers[i], location)
                TriggerClientEvent('suku:ManageBlip', xPlayers[i], true)
			end
		end
	end
end)