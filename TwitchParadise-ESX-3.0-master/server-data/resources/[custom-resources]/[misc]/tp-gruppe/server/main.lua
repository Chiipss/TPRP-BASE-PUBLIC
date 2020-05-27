---======================---
---Written by Tościk#9715---
---======================---
--[[ local neededPolice = 0  		--<< potrzebni policjanci do aktywacji misji
local resetTimer = 600 * 1000	    --<< timer co ile mozna robic misje, domyslnie 600 sekund
local minimumPay = 22000 				--<< ile minimum mozesz dostac z rabunku
local maximumPay = 30000 				--<< ile maximum mozesz dostac z rabunku ]]
--local payForLocation = 10 		--<< ile kosztuje aktywacja misji (czystej z banku)
-----------------------------------
--[[ local MisjaAktywna = 0
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end) ]]

--[[ RegisterServerEvent('tp_gruppe:akceptujto')
AddEventHandler('tp_gruppe:akceptujto', function() ]]
	--local copsOnDuty = 0
	--local Players = ESX.GetPlayers()
	--[[ local _source = source ]]
	--local xPlayer = ESX.GetPlayerFromId(_source)
	--local accountMoney = 0
	--accountMoney = xPlayer.getAccount('bank').money


	--[[ if MisjaAktywna == 0 then ]]
		--if accountMoney < payForLocation then
			--TriggerClientEvent('esx:showNotification', source, '~ r ~ You need $ 5,000 in the bank to accept the mission')
		--else
--[[ 			TriggerEvent('tprp:GetJobCount', 'police', function(count)
				if (count >= neededPolice) then
					TriggerClientEvent("tp_gruppe:Pozwolwykonac", _source)
					OdpalTimer()
				else
					TriggerClientEvent('esx:showNotification', source, '~ r ~ You need at least ~ g ~'..neededPolice.. '~ r ~ LSPD to activate the mission.')
				end
			end) ]]
			--[[
			for i = 1, #Players do
				local xPlayer = ESX.GetPlayerFromId(Players[i])
				if xPlayer["job"]["name"] == "police" then
				copsOnDuty = copsOnDuty + 1
				end
			end
			if copsOnDuty >= neededPolice then
				TriggerClientEvent("tp_gruppe:Pozwolwykonac", _source)
				xPlayer.removeAccountMoney('bank', payForLocation)
				OdpalTimer()
			else
				TriggerClientEvent('esx:showNotification', source, '~ r ~ You need at least ~ g ~'..neededPolice.. '~ r ~ LSPD to activate the mission.')
			end]]
		--end
--[[ 	else
		TriggerClientEvent('esx:showNotification', source, '~ r ~ Someone is already doing this mission')
	end
end)

function OdpalTimer()
	MisjaAktywna = 1
	Wait(resetTimer)
	MisjaAktywna = 0
end

RegisterServerEvent('tp_gruppe:zawiadompsy')
AddEventHandler('tp_gruppe:zawiadompsy', function(x, y, z) 
    TriggerClientEvent('tp_gruppe:infodlalspd', -1, x, y, z)
end)

RegisterServerEvent('tp_gruppe:graczZrobilnapad')
AddEventHandler('tp_gruppe:graczZrobilnapad', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local paymentForRob = math.random(minimumPay,maximumPay)
	xPlayer.addMoney(paymentForRob)
	TriggerClientEvent('esx:showNotification', source, 'Youre taking ~ g ~'..paymentForRob..'$ ~ w ~ from the van')
	Wait(2500)
end)


RegisterNetEvent('tp_gruppe:removeC4')
AddEventHandler('tp_gruppe:removeC4', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeInventoryItem('c4', 1)
	exports['mythic_notify']:SendAlert('error', 'Removed 1x C4 from your inventory', 8000)
end) ]] 

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

Trucks = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('securityblack', function(source)
	TriggerClientEvent("tp:gruppeCard", source)
end)


RegisterServerEvent('tp:gruppeItem')
AddEventHandler('tp:gruppeItem', function(item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, amount)  
    TriggerClientEvent('esx:showNotification', source, 'You found an interesting item in the van!')
end)

RegisterServerEvent('tp:gruppe:addPlate')
AddEventHandler('tp:gruppe:addPlate', function(truckPlate)
	table.insert(Trucks, tostring(truckPlate))
end)

ESX.RegisterServerCallback('tp:gruppe:checkPlate', function(source, cb, plate)
	if #Trucks ~= 0 then
		for k, v in pairs(Trucks) do
			if v == plate then
				cb(false) -- truck already robbed before
				break
			end
		end
	end
	cb(true)
end)

RegisterServerEvent('tp_gruppe:SendPlayerToPd')
AddEventHandler('tp_gruppe:SendPlayerToPd', function(x, y, z) 
    TriggerClientEvent('tp_gruppe:informPD', -1, x, y, z)
end)

RegisterServerEvent("tp:removeIDcard")
AddEventHandler("tp:removeIDcard", function() 
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("securityblack", 1) 
end)

RegisterServerEvent('tp_gruppe:giveDirtyCash')
AddEventHandler('tp_gruppe:giveDirtyCash', function(amount)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local amount = amount
    xPlayer.addAccountMoney('black_money', amount)
	TriggerClientEvent('esx:showNotification', source, 'You\'re taking ~g~$'..amount..' ~w~from the van')
end)