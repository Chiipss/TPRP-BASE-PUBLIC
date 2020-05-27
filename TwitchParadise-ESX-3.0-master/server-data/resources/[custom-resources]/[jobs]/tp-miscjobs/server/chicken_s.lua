-------------------------
--Written by Tościk#9715-
-------------------------

local maxZywych = 10   -- max ammount of live chickens you can hold
local MaxMartweKurczaki = 20   -- how many dead chickens you can hold
local MaxZapakowanychKurczakow = 20    --how many packed chickens you can hold
local GotowkaSprzedaz = 45   --ammount of money you get for 2 packaged chickens

-----------------------------
---nizej lepiej nie ruszaj---
-----------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('tost:wkladajKurczki')
AddEventHandler('tost:wkladajKurczki', function()
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local zywyKurczak = xPlayer.getInventoryItem('alive_chicken').count

if zywyKurczak < maxZywych then
Citizen.Wait(1000)
xPlayer.addInventoryItem('alive_chicken', 5)
Wait(1500)
else
--TriggerClientEvent('esx:showNotification', source, '~y~Jednorazowo możesz mieć max ~g~'..maxZywych.. '~y~ kurczaków.')
TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You can only hold ' ..maxZywych.. ' chickens at once!'})
Wait(2500)
end
end)

RegisterServerEvent('tostKurczaki:przerob')
AddEventHandler('tostKurczaki:przerob', function(opcja)
local _source = source
local xPlayer = ESX.GetPlayerFromId(source)
local zywyKurczak = xPlayer.getInventoryItem('alive_chicken').count
local MartwyKurczak = xPlayer.getInventoryItem('slaughtered_chicken').count
local ZapakowanyKurczak = xPlayer.getInventoryItem('packaged_chicken').count

if opcja == 1 then
	if zywyKurczak > 0 and MartwyKurczak < MaxMartweKurczaki then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('alive_chicken', 1)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('slaughtered_chicken', 2)
	Wait(1500)
	else
	--TriggerClientEvent('esx:showNotification', source, '~y~Y ~g~'..MaxMartweKurczaki.. '~y~ martwych kurczaków.')
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You can only hold ' ..MaxMartweKurczaki.. ' Dead chickens at once!'})
	Wait(2500)
	end
end

if opcja == 2 then
	if MartwyKurczak > 0 and ZapakowanyKurczak < MaxZapakowanychKurczakow then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('slaughtered_chicken', 2)
	Citizen.Wait(1000)
	xPlayer.addInventoryItem('packaged_chicken', 2)
	Wait(1500)
	else
	--TriggerClientEvent('esx:showNotification', source, '~y~Jednorazowo możesz mieć max ~g~'..MaxMartweKurczaki.. '~y~ martwych kurczaków.')
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You can only hold ' ..MaxMartweKurczaki.. ' Dead chickens at once!'})
	Wait(2500)
	end
end

if opcja == 3 then
	if ZapakowanyKurczak > 0 then
	Citizen.Wait(1000)
	xPlayer.removeInventoryItem('packaged_chicken', 2)
	xPlayer.addMoney(GotowkaSprzedaz)
	--TriggerClientEvent('esx:showNotification', source, '~g~Otrzymujesz ~y~'..GotowkaSprzedaz.. '$ ~g~za dwa kartony kurczaków.')
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You Sold $' ..GotowkaSprzedaz.. ' worth of packaged chicken!'})
	Wait(1500)
	end
end

end)
