
local hangar1ID = nil
local hangar2ID = nil
local gotowka = {a = 100, b = 200} -- zakres od ile do ile wynosi gotowka za wykonanie misji
-----------------------------------
local MisjaAktywna = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

AddEventHandler('playerDropped', function(DropReason)

	if hangar1ID == source then
	hangar1ID = nil
	end
	
	if hangar2ID == source then
	hangar2ID = nil
	end
	
end)

RegisterServerEvent('tostdostawa:przejmijHangar')
AddEventHandler('tostdostawa:przejmijHangar', function(ktory)

if ktory == '1' then
	if hangar1ID == nil then
		hangar1ID = source
		TriggerClientEvent('esx:showNotification', source, '~g~You are taking over the hangar.')
		TriggerClientEvent('esx:showNotification', source, '~g~Now only you can perform orders here.')
		TriggerClientEvent("tostdostawa:maszHangar", source)
	else
		TriggerClientEvent('esx:showNotification', source, '~y~This hangar is already taken by ID ~r~'..hangar1ID)
	end
elseif ktory == '2' then
	if hangar2ID == nil then
		hangar2ID = source
		TriggerClientEvent('esx:showNotification', source, '~g~You are taking over the hangar.')
		TriggerClientEvent('esx:showNotification', source, '~g~Now only you can perform orders here.')
		TriggerClientEvent("tostdostawa:maszHangar", source)
	else
		TriggerClientEvent('esx:showNotification', source, '~y~This hangar is already taken by ID ~r~'..hangar2ID)
	end
end

end)



RegisterServerEvent('tostdostawa:wykonanieMisji')
AddEventHandler('tostdostawa:wykonanieMisji', function(premia)
local _source = source
local xPlayer = ESX.GetPlayerFromId(_source)
local LosujSiano = math.random(gotowka.a,gotowka.b)

if premia == 'nie' then
xPlayer.addMoney(LosujSiano)
TriggerClientEvent('esx:showNotification', _source, '~g~You get $'..LosujSiano..' for delivery')
Wait(2500)
else
xPlayer.addMoney(premia)
Wait(2500)
end

end)

RegisterServerEvent('tostdostawa:OdszedlDalekoo')
AddEventHandler('tostdostawa:OdszedlDalekoo', function()

	if hangar1ID == source then
	hangar1ID = nil
	end
	
	if hangar2ID == source then
	hangar2ID = nil
	end
	
end)


