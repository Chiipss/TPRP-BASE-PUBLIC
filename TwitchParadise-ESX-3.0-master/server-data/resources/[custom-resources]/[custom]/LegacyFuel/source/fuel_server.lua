ESX = nil

if Config.UseESX then
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

	RegisterServerEvent('fuel:pay')
	AddEventHandler('fuel:pay', function(price)
		local xPlayer = ESX.GetPlayerFromId(source)
		local amount = ESX.Math.Round(price)

		if price > 0 then
			xPlayer.removeMoney(amount)
		end
	end)
end

RegisterServerEvent('fuel:giveJerry')
AddEventHandler('fuel:giveJerry', function()
	local xPlayer  = ESX.GetPlayerFromId(source)
	if xPlayer then
		xPlayer.addInventoryItem('WEAPON_PETROLCAN', 1)
	end
end)
