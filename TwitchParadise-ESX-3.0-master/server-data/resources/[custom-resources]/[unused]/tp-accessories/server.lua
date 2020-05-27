ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_accessoryPack:pay')
AddEventHandler('esx_accessoryPack:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(Config.Price)
	if Config.Mythic then
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = Config.ItemPurchased .. ESX.Math.GroupDigits(Config.Price), length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
	elseif Config.Pnotif then
		TriggerClientEvent("pNotify:SendNotification", -1, {text = Config.ItemPurchased .. ESX.Math.GroupDigits(Config.Price), type = "error", queue = "lmao", timeout = 10000, layout = "bottomCenter"})
	else
		TriggerClientEvent('esx:showNotification', _source, Config.ItemPurchased .. ESX.Math.GroupDigits(Config.Price))
	end
end)

RegisterServerEvent('esx_accessoryPack:removeItem')
AddEventHandler('esx_accessoryPack:removeItem', function(name, item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	print(name, item)
	if item == 'mask' then
		MySQL.Sync.execute('DELETE FROM `masks` WHERE owner = @owner AND name = @name', {
			['@name']  = name,
			['@owner'] = xPlayer.identifier
		})
	elseif item == 'helmet' then
		MySQL.Sync.execute('DELETE FROM `helmets` WHERE owner = @owner AND name = @name', {
			['@name']  = name,
			['@owner'] = xPlayer.identifier
		})
	elseif item == 'ears' then
		MySQL.Sync.execute('DELETE FROM `ears` WHERE owner = @owner AND name = @name', {
			['@name']  = name,
			['@owner'] = xPlayer.identifier
		})
	elseif item == 'glasses' then
		MySQL.Sync.execute('DELETE FROM `glasses` WHERE owner = @owner AND name = @name', {
			['@name']  = name,
			['@owner'] = xPlayer.identifier
		})
	elseif item == 'bags' then
		MySQL.Sync.execute('DELETE FROM `bags` WHERE owner = @owner AND name = @name', {
			['@name']  = name,
			['@owner'] = xPlayer.identifier
		})
	end
end)

RegisterServerEvent('esx_accessoryPack:save')
AddEventHandler('esx_accessoryPack:save', function(name, item, skin)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if item == 'mask' then
		local itemSkin = {}
		local item1 = string.lower(item) .. '_1'
		local item2 = string.lower(item) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		local storedInfo = json.encode(itemSkin)
		MySQL.Async.execute('INSERT INTO masks (owner, name, data) VALUES (@owner, @name, @data)', {
			['@data']  = storedInfo,
			['@name']  = name,
			['@owner'] = xPlayer.identifier,
		})
	elseif item == 'helmet' then
		local itemSkin = {}
		local item1 = string.lower(item) .. '_1'
		local item2 = string.lower(item) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		local storedInfo = json.encode(itemSkin)
		MySQL.Async.execute('INSERT INTO helmets (owner, name, data) VALUES (@owner, @name, @data)', {
			['@data']  = storedInfo,
			['@name']  = name,
			['@owner'] = xPlayer.identifier,
		})
	elseif item == 'ears' then
		local itemSkin = {}
		local item1 = string.lower(item) .. '_1'
		local item2 = string.lower(item) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		local storedInfo = json.encode(itemSkin)
		MySQL.Async.execute('INSERT INTO ears (owner, name, data) VALUES (@owner, @name, @data)', {
			['@data']  = storedInfo,
			['@name']  = name,
			['@owner'] = xPlayer.identifier,
		})
	elseif item == 'glasses' then
		local itemSkin = {}
		local item1 = string.lower(item) .. '_1'
		local item2 = string.lower(item) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		local storedInfo = json.encode(itemSkin)
		MySQL.Async.execute('INSERT INTO glasses (owner, name, data) VALUES (@owner, @name, @data)', {
			['@data']  = storedInfo,
			['@name']  = name,
			['@owner'] = xPlayer.identifier,
		})
	elseif item == 'bags' then
		local itemSkin = {}
		local item1 = string.lower(item) .. '_1'
		local item2 = string.lower(item) .. '_2'
		itemSkin[item1] = skin[item1]
		itemSkin[item2] = skin[item2]
		local storedInfo = json.encode(itemSkin)
		MySQL.Async.execute('INSERT INTO bags (owner, name, data) VALUES (@owner, @name, @data)', {
			['@data']  = storedInfo,
			['@name']  = name,
			['@owner'] = xPlayer.identifier,
		})
	end
end)

ESX.RegisterServerCallback('esx_accessoryPack:get', function(source, cb, accessory)
	local xPlayer = ESX.GetPlayerFromId(source)
	local hasAces = false
	local skinTab = {}
	
	if accessory == 'ears' then
		MySQL.Async.fetchAll('SELECT * FROM `ears` WHERE `owner` = @identifier', {['@identifier'] = xPlayer.identifier}, function(data)
			if data[1] ~= nil then
				hasAces = true
				for k,v in pairs(data) do
					table.insert(skinTab, v)
				end
			else
				hasAces = false
			end
			cb(hasAces, skinTab)
		end)
	elseif accessory == 'helmet' then
		MySQL.Async.fetchAll('SELECT * FROM `helmets` WHERE `owner` = @identifier', {['@identifier'] = xPlayer.identifier}, function(data)
			if data[1] ~= nil then
				hasAces = true
				for k,v in pairs(data) do
					table.insert(skinTab, v)
				end
			else
				hasAces = false
			end
			cb(hasAces, skinTab)
		end)
	elseif accessory == 'glasses' then
		MySQL.Async.fetchAll('SELECT * FROM `glasses` WHERE `owner` = @identifier', {['@identifier'] = xPlayer.identifier}, function(data)
			if data[1] ~= nil then
				hasAces = true
				for k,v in pairs(data) do
					table.insert(skinTab, v)
				end
			else
				hasAces = false
			end
			cb(hasAces, skinTab)
		end)
	elseif accessory == 'mask' then
		MySQL.Async.fetchAll('SELECT * FROM `masks` WHERE `owner` = @identifier', {['@identifier'] = xPlayer.identifier}, function(data)
			if data[1] ~= nil then
				hasAces = true
				for k,v in pairs(data) do
					table.insert(skinTab, v)
				end
			else
				hasAces = false
			end
			cb(hasAces, skinTab)
		end)
	elseif accessory == 'bags' then
		MySQL.Async.fetchAll('SELECT * FROM `bags` WHERE `owner` = @identifier', {['@identifier'] = xPlayer.identifier}, function(data)
			if data[1] ~= nil then
				hasAces = true
				for k,v in pairs(data) do
					table.insert(skinTab, v)
				end
			else
				hasAces = false
			end
			cb(hasAces, skinTab)
		end)
	end
end)

ESX.RegisterServerCallback('esx_accessoryPack:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(xPlayer.get('money') >= Config.Price)
end)