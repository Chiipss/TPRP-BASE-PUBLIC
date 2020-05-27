ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('WellDoPizza:Zaplata')
AddEventHandler('WellDoPizza:Zaplata', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addMoney(75)
   TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You got $75 for pizza delivery.'})
    --TriggerClientEvent('pNotify:SendNotification', source, {text = 'You got $50 for pizza delivery.'})
end)

RegisterServerEvent('WellDoPizza:PobierzKaucje')
AddEventHandler('WellDoPizza:PobierzKaucje', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.removeMoney(500)
    TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You left a $500 deposit for renting a car.'})
    --TriggerClientEvent('pNotify:SendNotification', source, {text = 'You were taken $1500 for renting a car.'})
end)

RegisterServerEvent('WellDoPizza:OddajKaucje')
AddEventHandler('WellDoPizza:OddajKaucje', function(info)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    
    if info == 'zakonczenie' then
        xPlayer.addMoney(850)
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'You got $350 extra for deliveries and the deposit has been returned to you.'})
      --  TriggerClientEvent('pNotify:SendNotification', source, {text = 'You got $350 extra for deliveries and the deposit has been returned to you.'})
    end
end)


--TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Hype! Custom Styling!', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
