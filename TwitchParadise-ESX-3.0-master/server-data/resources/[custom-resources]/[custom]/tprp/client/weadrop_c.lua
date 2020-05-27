local key = 56 -- Key pressed for drop!

--Drop your weapon fonction
RegisterNetEvent("dropweapon")
AddEventHandler('dropweapon', function()
	local ped = PlayerPedId()
	local wep = GetSelectedPedWeapon(ped)
	
	local hasWeapon, weaponHash = GetCurrentPedWeapon(ped, false)

	if hasWeapon then

		if DoesEntityExist(ped) and not IsEntityDead(ped) then
			SetPedDropsInventoryWeapon(ped, wep, 0, 2.0, 0, -1)
			GiveWeaponToPed(ped, 0xA2719263, 0, 0, 1)
			ShowNotification("~w~You dropped your ~r~weapon ~w~on the ground.")
		end
	else
		ShowNotification("~w~You don't have a weapon selected.") 
	end
end)

--Notification fonction
function ShowNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

--Keybinding fonction
Citizen.CreateThread(function()
	while true do
		Wait(0)
			if IsControlJustPressed(1, key) then
				TriggerServerEvent("drops")
			end
		end 
end)
