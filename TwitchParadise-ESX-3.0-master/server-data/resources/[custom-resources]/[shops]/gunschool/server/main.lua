ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--[[ AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('tp_gunschool:loadLicenses', source, licenses)
	end)
end) ]]

RegisterNetEvent('tp_gunschool:addLicense')
AddEventHandler('tp_gunschool:addLicense', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			--[[ TriggerClientEvent('tp_gunschool:loadLicenses', _source, licenses) ]]
		end)
	end)
end)

RegisterNetEvent('tp_gunschool:pay')
AddEventHandler('tp_gunschool:pay', function(price)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeMoney(price)
	TriggerClientEvent('esx:showNotification', _source, _U('you_paid', ESX.Math.GroupDigits(price)))
end)

ESX.RegisterServerCallback('tp_gunschool:canAfford', function(source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        cb(true)
    else
        cb(false)
    end

end)
