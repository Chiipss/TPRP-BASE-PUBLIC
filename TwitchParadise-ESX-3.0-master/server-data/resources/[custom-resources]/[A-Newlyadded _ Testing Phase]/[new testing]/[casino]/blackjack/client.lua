ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj)
			ESX = obj 
		end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('route68_blackjack:start')
AddEventHandler('route68_blackjack:start', function()
	ESX.TriggerServerCallback('route68_blackjack:check_money', function(quantity)
		if quantity >= 100 then
			SendNUIMessage({
				type = "enableui",
				enable = true,
				coins = quantity
			})
			SetNuiFocus(true, true)
		else
			exports['mythic_notify']:SendAlert('error', 'You need 100 chips to play' , 10000)
			--ESX.ShowNotification('You need 100 chips to play')
		end
	end, '')
	--roulette_menu()
end)

RegisterNUICallback('escape', function(data, cb)
	cb('ok')
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "enableui",
		enable = false
	})
end)

RegisterNUICallback('card', function(data, cb)
	cb('ok')
	TriggerServerEvent('InteractSound_SV:PlayOnSource', 'PlayCard', 1.0)
end)

RegisterNUICallback('bet', function(data, cb)
	cb('ok')
	TriggerServerEvent('InteractSound_SV:PlayOnSource', 'betup', 1.0)
end)

RegisterNUICallback('escape2', function(data, cb)
	cb('ok')
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "enableui",
		enable = false
	})
	exports['mythic_notify']:SendAlert('error', 'You have no more tokens!' , 10000)
	--TriggerEvent('pNotify:SendNotification', {text = 'You have no more tokens!'})
end)

RegisterNUICallback('WinBet', function(data, cb)
	cb('ok')
	local count = data.bets
	TriggerServerEvent('route68_blackjack:givemoney', count, 2)
end)

RegisterNUICallback('TieBet', function(data, cb)
	cb('ok')
	local count = data.bets
	TriggerServerEvent('route68_blackjack:givemoney', count, 1)
end)

RegisterNUICallback('LostBet', function(data, cb)
	cb('ok')
	local count = data.bets
	exports['mythic_notify']:SendAlert('error', 'You lose ' ..count.. ' chips!' , 10000)
	--TriggerEvent('pNotify:SendNotification', {text = "Vous perdez "..count.." jetons!"})
end)

RegisterNUICallback('Status', function(data, cb)
	cb('ok')
	TriggerEvent('pNotify:SendNotification', {text = data.tekst})
end)

RegisterNUICallback('StartPartia', function(data, cb)
	cb('ok')
	local count = data.bets
	TriggerServerEvent('route68_blackjack:removemoney', count)
end)