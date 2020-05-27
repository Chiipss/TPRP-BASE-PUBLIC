 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlPressed(2, 82) then
		SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		SetPedMinGroundTimeForStungun(GetPlayerPed(-1), 7000)
	end
end)

