--[[
	--Example on Item Check 
	  local bandage = exports["disc-inventoryhud"]:itemCheck('bandage',1) -- this is the item to check if is in inventory
  Citizen.Wait(500)
  if bandage then
	-- Trigger the event if we have the item
 else
	--print("naww")
 end
 TriggerClientEvent('mythic_phone:client:InstallApp', xPlayer.source, "twitter")
	TriggerClientEvent('mythic_phone:client:UseSDCard',xPlayer.source)
TriggerClientEvent("esx_status:remove", xPlayer.source, 'stress', 100000)  -- remove stress
TriggerClientEvent("esx_status:add", xPlayer.source, 'stress', 100000) -- add stress
]]

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent("keen:useableItem") 
AddEventHandler("keen:useableItem", function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    if item.itemId == "bread" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('bread', 1)

	    TriggerClientEvent('esx_status:add', source, 'hunger', 200000)
	    TriggerClientEvent('esx_basicneeds:onEat', source)
	    TriggerClientEvent('esx:showNotification', source, _U('used_bread'))

    elseif item.itemId == "licenseplate" then
        TriggerClientEvent('jsfour-licenseplate', source)

    elseif item.itemId == "nitrocannister" then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent('nitro:onUse', _source)

    elseif item.itemId == "wrench" then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)
	    TriggerClientEvent('wrench:onUse', _source)

    elseif item.itemId == "lockpick" then
        TriggerClientEvent('lockpick:vehicleUse', source, "lockpick")

    elseif item.itemId == "chocolate" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('chocolate', 1)

	    TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	    TriggerClientEvent('esx_status:add', source, 'thirst', 40000)
	    TriggerClientEvent('esx_basicneeds:onEatChocolate', source)
	    TriggerClientEvent('esx:showNotification', source, _U('used_chocolate'))

    elseif item.itemId == "sandwich" then
        local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sandwich', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 150000)
	TriggerClientEvent('esx_status:add', source, 'thirst', 70000)
	TriggerClientEvent('esx_basicneeds:onEatSandwich', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_sandwich'))

    elseif item.itemId == "hamburger" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('hamburger', 1)

	    TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	    TriggerClientEvent('esx_status:add', source, 'thirst', 70000)
	    TriggerClientEvent('esx_basicneeds:onEat', source)
	    TriggerClientEvent('esx:showNotification', source, _U('used_hamburger'))

    elseif item.itemId == "cupcake" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('cupcake', 1)

	    TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	    TriggerClientEvent('esx_status:add', source, 'thirst', 30000)
	    TriggerClientEvent('esx_basicneeds:onEatCupCake', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_cupcake'))
        
    elseif item.itemId == "chips" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('chips', 1)

	    TriggerClientEvent('esx_status:add', source, 'hunger', 250000)
	    TriggerClientEvent('esx_status:add', source, 'thirst', 30000)
	    TriggerClientEvent('esx_basicneeds:onEatChips', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_chips'))
    
    elseif item.itemId == "water" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('water', 1)

	    TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	    TriggerClientEvent('esx_status:add', source, 'hunger', 30000)
	    TriggerClientEvent('esx_basicneeds:onDrink', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_water'))
        
    elseif item.itemId == "cocacola" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('cocacola', 1)

	    TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	    TriggerClientEvent('esx_status:add', source, 'hunger', 60000)
	    TriggerClientEvent('esx_basicneeds:onDrinkCocaCola', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_cocacola'))
    
    elseif item.itemId == "icetea" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('icetea', 1)

	    TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	    TriggerClientEvent('esx_status:add', source, 'hunger', 80000)
	    TriggerClientEvent('esx_basicneeds:onDrinkIceTea', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_icetea'))
    
    elseif item.itemId == "coffe" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('coffe', 1)

	    TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	    TriggerClientEvent('esx_status:add', source, 'hunger', 40000)
	    TriggerClientEvent('esx_basicneeds:onDrinkCoffe', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_coffe'))	
        
    elseif item.itemId == "wine" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('wine', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 100000)
	    TriggerClientEvent('esx_basicneeds:onDrinkWine', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_wine'))
        
    elseif item.itemId == "beer" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('beer', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	    TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_beer'))
    
    elseif item.itemId == "vodka" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('vodka', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 350000)
	    TriggerClientEvent('esx_basicneeds:onDrinkVodka', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_vodka'))
        
    elseif item.itemId == "whiskey" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('whisky', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	    TriggerClientEvent('esx_basicneeds:onDrinkWhisky', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_whisky'))
        
    elseif item.itemId == "tequila" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('tequila', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 200000)
	    TriggerClientEvent('esx_basicneeds:onDrinkTequila', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_tequila'))
        
    elseif item.itemId == "milk" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('milk', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', -100000)
	    TriggerClientEvent('esx_basicneeds:onDrinkMilk', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_milk'))
    
    elseif item.itemId == "gintonic" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('gintonic', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 150000)
	    TriggerClientEvent('esx_basicneeds:onDrinkGin', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_gintonic'))
        
    elseif item.itemId == "absinthe" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('absinthe', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 400000)
	    TriggerClientEvent('esx_basicneeds:onDrinkAbsinthe', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_absinthe'))
        
    elseif item.itemId == "champagne" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('champagne', 1)

	    TriggerClientEvent('esx_status:add', source, 'drunk', 50000)
	    TriggerClientEvent('esx_basicneeds:onDrinkChampagne', source)
        TriggerClientEvent('esx:showNotification', source, _U('used_champagne'))
        
    elseif item.itemId == "armour" then
        local xPlayer = ESX.GetPlayerFromId(source)
	    xPlayer.removeInventoryItem('armour', 1)
        TriggerClientEvent('esx_armour:armour', source)
        
    elseif item.itemId == "jumelles" then
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('jumelles:Active', source)
    
    elseif item.itemId == "citizenid" then
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('citizenid:showid', source)

    elseif item.itemId == "advrepairkit" then
        TriggerEvent(":tp:advrepairkit", source)

    elseif item.itemId == "clamp" then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent('tp_clamp:onUse', _source)
        
    elseif item.itemId == "clamp_key" then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent('tp_clampKey:onUse', _source)

    elseif item.itemId == "dentpuller" then
        TriggerEvent("tp:dentpuller", source)

    elseif item.itemId == "repairkit" then
        TriggerEvent("tp:repairkit", source)

    elseif item.itemId == "scubba" then
        local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent('police:woxy', _source)

    elseif item.itemId == "tyrekit" then
        TriggerEvent("tp:tyrekit", source)

    elseif item.itemId == "notepad" then
        local _source  = source
        local xPlayer   = ESX.GetPlayerFromId(_source)
        TriggerClientEvent('lkrp_notepad:note', _source)
        TriggerClientEvent('lkrp_notepad:OpenNotepadGui', _source)
        Citizen.Wait(100)
        xPlayer.removeInventoryItem('notepad', 1)

    elseif item.itemId == "tuning_laptop" then
        local _source = source
        TriggerClientEvent("tuner:open", _source)

    elseif item.itemId == "contract" then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)
        TriggerClientEvent('tp2_contract:getVehicle', _source)
        
    elseif item.itemId == "silencer" then
        local xPlayer = ESX.GetPlayerFromId(source)	
        TriggerClientEvent('eden_accesories:silencer', source)

    elseif item.itemId == "flashlight" then
        local xPlayer = ESX.GetPlayerFromId(source)	
        TriggerClientEvent('eden_accesories:flashlight', source)

    elseif item.itemId == "grip" then
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent('eden_accesories:grip', source)

    elseif item.itemId == "yusuf" then
        local xPlayer = ESX.GetPlayerFromId(source)

        TriggerClientEvent('eden_accesories:yusuf', source)

    elseif item.itemId == "pAmmo" then
        local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeInventoryItem('pAmmo', 1)
        TriggerClientEvent('nfw_wep:pAmmo', source)

    elseif item.itemId == "mgAmmo" then
        local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeInventoryItem('mgAmmo', 1)
        TriggerClientEvent('nfw_wep:mgAmmo', source)

    elseif item.itemId == "arAmmo" then
        local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeInventoryItem('arAmmo', 1)
        TriggerClientEvent('nfw_wep:arAmmo', source)

    elseif item.itemId == "sgAmmo" then
        local xPlayer = ESX.GetPlayerFromId(source)

        xPlayer.removeInventoryItem('sgAmmo', 1)
        TriggerClientEvent('nfw_wep:sgAmmo', source)

    elseif item.itemId == "medikit" then
        TriggerEvent("tp:medikit", source)

    elseif item.itemId == "bandage" then
        TriggerEvent("tp:bandage", source)

    elseif item.itemId == "gauze" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    TriggerClientEvent('mythic_hospital:items:gauze', source)
        xPlayer.removeInventoryItem('gauze', 1)
        
    elseif item.itemId == "bandage" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    TriggerClientEvent('mythic_hospital:items:bandage', source)
        xPlayer.removeInventoryItem('bandage', 1)
        
    elseif item.itemId == "firstaid" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    TriggerClientEvent('mythic_hospital:items:firstaid', source)
        xPlayer.removeInventoryItem('firstaid', 1)
        
    elseif item.itemId == "medkit" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    TriggerClientEvent('mythic_hospital:items:medkit', source)
	    xPlayer.removeInventoryItem('medkit', 1)

    elseif item.itemId == "vicodin" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    TriggerClientEvent('mythic_hospital:items:vicodin', source)
        xPlayer.removeInventoryItem('vicodin', 1)
        
    elseif item.itemId == "hydrocodone" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    TriggerClientEvent('mythic_hospital:items:hydrocodone', source)
        xPlayer.removeInventoryItem('hydrocodone', 1)
    
    elseif item.itemId == "morphine" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    TriggerClientEvent('mythic_hospital:items:morphine', source)
        xPlayer.removeInventoryItem('morphine', 1)
        
    elseif item.itemId == "blowpipe" then
        local _source = source
	    local xPlayer  = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('blowpipe', 1)

	    TriggerClientEvent('esx_mechanicjob:onHijack', _source)
        TriggerClientEvent('esx:showNotification', _source, _U('you_used_blowtorch'))
        
    elseif item.itemId == "fixkit" then
        local _source = source
	    local xPlayer  = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('fixkit', 1)

	    TriggerClientEvent('esx_mechanicjob:onFixkit', _source)
        TriggerClientEvent('esx:showNotification', _source, _U('you_used_repair_kit'))
        
    elseif item.itemId == "tomato_seed" then
        TriggerClientEvent('tm1_stores:plant', source, 'tomato_seed')

    elseif item.itemId == "blueberry_seed" then
        TriggerClientEvent('tm1_stores:plant', source, 'blueberry_seed')

    elseif item.itemId == "wateringcan" then
        TriggerClientEvent('tm1_stores:addWater', source, 25)

    elseif item.itemId == "lowgradefert" then
        TriggerClientEvent('tm1_stores:addFertilizer', source, 25)

    elseif item.itemId == "highgradefert" then
        TriggerClientEvent('tm1_stores:addFertilizer', source, 50)

    elseif item.itemId == "turtlebait" then
        TriggerEvent("tp:turtlebait", source)

    elseif item.itemId == "fishbait" then
        TriggerEvent("tp:fishbait", source)

    elseif item.itemId == "fishingrod" then
        local _source = source
        TriggerClientEvent('fishing:fishstart', source)
        
    elseif item.itemId == "pomaranacza" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('pomaranacza', 1)

        TriggerClientEvent('esx_status:add', source, 'hunger', 40000)
	    TriggerClientEvent('esx_basicneeds:onEat', source)
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'You ate an orange'})
        
    elseif item.itemId == "jablka" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('jablka', 1)

	    TriggerClientEvent('esx_status:add', source, 'hunger', 400000)
	    TriggerClientEvent('esx_basicneeds:onEat', source)
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'You ate an apple'})
        
    elseif item.itemId == "sok" then
        local xPlayer = ESX.GetPlayerFromId(source)

	    xPlayer.removeInventoryItem('sok', 1)

	    TriggerClientEvent('esx_status:add', source, 'thirst', 400000)
	    TriggerClientEvent('esx_basicneeds:onDrink', source)
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'You drank some juice'})
        
    elseif item.itemId == "thermite" then
        TriggerEvent("tp:thermite", source)

    elseif item.itemId == "highgrademaleseed" then
        TriggerEvent("tp:highgrademaleseed", source)

    elseif item.itemId == "dopebag" then
        TriggerEvent("tp:doprbag", source)

    elseif item.itemId == "bagofdope" then
        TriggerEvent("tp:bagofdope", source)

    elseif item.itemId == "weed" then
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.removeInventoryItem('weed', 1)
        TriggerClientEvent('smokeweed:onPot', _source)

    elseif item.itemId == "wateringcan" then
        TriggerEvent("tp:wateringcan", source)

    elseif item.itemId == "purifiedwater" then
        TriggerEvent("tp:purifiedwater", source)

    elseif item.itemId == "lowgradefert" then
        TriggerEvent("tp:lowgradefert", source)

    elseif item.itemId == "highgradefert" then
        TriggerEvent("tp:highgradefert", source)

    elseif item.itemId == "coca_leaf" then
        TriggerEvent("tp:coca_leaf", source)

    elseif item.itemId == "coke_pooch" then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.removeInventoryItem('coke_pooch', 1)
        TriggerClientEvent('sniffcoke:onUse', _source)
        
    elseif item.itemId == "coke" then
        local _source = source
	    local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.removeInventoryItem('coke', 1)
        TriggerClientEvent('sniffFake:onUse', _source)
        
    elseif item.itemId == "radio" then
        local xPlayer = ESX.GetPlayerFromId(source)
	    TriggerClientEvent('ls-radio:use', source)
    end
end)


--[[   Not sure if we use these
ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fixkit', 1)

	TriggerClientEvent('esx_mechanicjob:onFixkit', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('you_used_repair_kit'))
end)

ESX.RegisterUsableItem('carokit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carokit', 1)

	TriggerClientEvent('esx_mechanicjob:onCarokit', _source)
	TriggerClientEvent('esx:showNotification', _source, _U('you_used_body_kit'))
end)

	
]]


