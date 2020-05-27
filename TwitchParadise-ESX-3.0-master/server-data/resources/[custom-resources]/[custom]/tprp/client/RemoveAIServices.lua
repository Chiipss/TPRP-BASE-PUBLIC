SetMaxWantedLevel(0)
for i=1, 15 do
    EnableDispatchService(i, false)
end

Citizen.CreateThread(function()
	while true do
        Wait(0)
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
        RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_CARBINERIFLE'))
        RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL'))
        RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PUMPSHOTGUN'))
        RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_PISTOL50'))
        RemoveAllPickupsOfType(GetHashKey('PICKUP_WEAPON_SMG'))
        
        SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)


        --[[ SetParkedVehicleDensityMultiplierThisFrame(0.2)
        SetVehicleDensityMultiplierThisFrame(0.1)
        SetRandomVehicleDensityMultiplierThisFrame(0.1)
        SetPedDensityMultiplierThisFrame(0.1)
        SetScenarioPedDensityMultiplierThisFrame(0.1, 0.1) ]]

        SetVehicleModelIsSuppressed(GetHashKey("rubble"), true)
        SetVehicleModelIsSuppressed(GetHashKey("dump"), true)
        SetVehicleModelIsSuppressed(GetHashKey("taco"), true)
        SetVehicleModelIsSuppressed(GetHashKey("biff"), true)
        SetVehicleModelIsSuppressed(GetHashKey("hydra"), true)
        SetVehicleModelIsSuppressed(GetHashKey("rhino"), true)
        SetVehicleModelIsSuppressed(GetHashKey("polmav"), true)
        SetVehicleModelIsSuppressed(GetHashKey("blimp"), true)
        SetVehicleModelIsSuppressed(GetHashKey("blimp2"), true)
        SetVehicleModelIsSuppressed(GetHashKey("lazer"), true)
        SetVehicleModelIsSuppressed(GetHashKey("policeb"), true)

        

        
        

    end
end)

AddEventHandler("playerSpawned", function()
    NetworkSetFriendlyFireOption(true)
    SetCanAttackFriendly(PlayerPedId(), true, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
                if IsPedArmed(ped, 6) then
            DisableControlAction(1, 140, true)
                DisableControlAction(1, 141, true)
                DisableControlAction(1, 142, true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if GetVehicleEngineHealth(vehicle) < 10 then
               SetVehicleUndriveable(vehicle, true)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = GetPlayerPed(-1)
        if GetPedMaxHealth(ped) ~= 200 and not IsEntityDead(ped) then
            SetPedMaxHealth(ped, 200)
            SetEntityHealth(ped, GetEntityHealth(ped) + 25)
        end
    end
end)

Citizen.CreateThread(function() 
    while true do
        N_0xf4f2c0d4ee209e20() 
        Wait(1000) 
    end 
end)

Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
	
		local playerPed = PlayerPedId()
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		
		if IsPedInAnyVehicle(playerPed, true) then
			DisplayRadar(true)
		else
			DisplayRadar(false)
		end
    end
end)  

--[[ Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    local ped = PlayerPedId()
        if IsPedOnVehicle(ped) then
        	local vehicle = GetPlayersLastVehicle(ped)
        	SetVehicleFrictionOverride(vehicle, 100.0)
            SetPedCanRagdoll(ped, false)
        end     
    end
end) ]]

--[[ local forceFirstPerson = true
Citizen.CreateThread(function()
    SetBlackout(false)

    while true do
        Wait(1)
        local currentView = GetFollowPedCamViewMode()
        if forceFirstPerson then
            if currentView ~= 4 then
                SetFollowPedCamViewMode(4)
                Citizen.Trace(GetFollowPedCamViewMode())
            end
            if IsControlJustReleased(0, 0) then
                SetFollowPedCamViewMode(0)
                Citizen.Trace(GetFollowPedCamViewMode())
                forceFirstPerson = false
            end
        end
    end
end)
 ]]
--[[ Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        DisableControlAction(0, 0, true)             
    end
end)




Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    local currentView = GetFollowPedCamViewMode()
        if IsDisabledControlJustReleased(0, 0) then
            if not IsPedInAnyVehicle(PlayerPedId()) then
            --print("I PRESSED V")
            print(currentView)
                if currentView == 4 then
                    print("THIRD PERSON")
                    SetFollowPedCamViewMode(0)
                    --Citizen.Trace(GetFollowPedCamViewMode())
                end
                if currentView == 0 then
                    print("FIRST PERSON")
                    SetFollowPedCamViewMode(4)
                    --Citizen.Trace(GetFollowPedCamViewMode())
                end
            else
                if currentView == 4 then
                    print("THIRD PERSON")
                    SetFollowVehicleCamViewMode(0)
                    --Citizen.Trace(GetFollowPedCamViewMode())
                end
                if currentView == 0 then
                    print("FIRST PERSON")
                    SetFollowVehicleCamViewMode(4)
                    --Citizen.Trace(GetFollowPedCamViewMode())
                end
            end
        end               
    end
end) ]]

--[[ Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    local currentView = GetFollowPedCamViewMode()
        if IsDisabledControlJustReleased(0, 0) then
            if IsPedInAnyVehicle(PlayerPedId()) then
                print(currentView)
            --print("I PRESSED V")
                if currentView == 4 then
                    print("THIRD PERSON")
                    SetFollowVehicleCamViewMode(0)
                    --Citizen.Trace(GetFollowPedCamViewMode())
                end
                if currentView == 0 then
                    print("FIRST PERSON")
                    SetFollowVehicleCamViewMode(4)
                    --Citizen.Trace(GetFollowPedCamViewMode())
                end
            end
        end               
    end
end) ]]





--[[ 2 = first 
4 = third ]]

-- Code to check instanceID
--[[
Citizen.CreateThread(function()
        while true do
        Citizen.Wait(1)
 
    local ped = GetPlayerPed(PlayerId())
    local coords = GetEntityCoords(ped, false)
    local heading = GetEntityHeading(ped)
    local interior = GetInteriorFromEntity(GetPlayerPed(PlayerId()))
    local heading = math.floor(heading * 100)/100
    local coordsX = math.floor(coords.x * 100)/100
    local coordsY = math.floor(coords.y * 100)/100
    local coordsZ = math.floor(coords.z * 100)/100
 
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.3)
                SetTextColour(255, 255, 255, 255)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(tostring("X: " .. coordsX .. " Y: " .. coordsY .. " Z: " .. coordsZ .. " HEADING: " .. heading .. " INSTANCE: " .. interior))
                DrawText(0.010, 0.010)
    end
end)
--]]


RegisterCommand('livery', function(source, args)
    local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    local liveryID = tonumber(args[1])
        SetVehicleLivery(Veh, liveryID)
end, false)
    
    
RegisterCommand('extra', function(source, args)
    local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
    local extraID = tonumber(args[1])
    if IsVehicleExtraTurnedOn(Veh, extraID) then
        SetVehicleExtra(Veh, extraID, true)
    else
        SetVehicleExtra(Veh, extraID, false)
    end
end, false) 

Citizen.CreateThread(function()
	TriggerEvent('chat:addSuggestion', '/extra', '', {
		{ name="ID", help="try 1 > 14 to see what extras the vehicle has, Do the command again to remove." }
	})
end)




-------------------------------------------------------------------------------------------------------------------



local WaitTime = 100 -- How often do you want to update the status (In MS)
local onlinePlayers = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        onlinePlayers = #GetActivePlayers() 
    end
end)

DensityMultiplier = 1.0
playerMultiplier = 0
robbing = false


aidsareas = {
    [1] = { ["x"] = 1822.8262939453, ["y"] = 2248.7468261719, ["z"] = 53.709140777588}, --Intersection splitting place near the jail.
    [2] = { ["x"] = 1704.5872802734, ["y"] = 3506.8410644531, ["z"] = 36.429180145264}, -- near jail
    [3] = { ["x"] = 1726.2159423828, ["y"] = 2536.3801269531, ["z"] = 45.564891815186}, -- near jail
    [4] = { ["x"] = 148.81317138672, ["y"] = 6529.986328125, ["z"] = 31.715270996094}, --peleto
    [5] = { ["x"] = -383.93887329102, ["y"] = 5997.466796875, ["z"] = 31.456497192383},
	[6] = { ["x"] = 2062.81640625, ["y"] = 3721.5895996094, ["z"] = 33.070247650146},
	[7] = { ["x"] = -216.88275146484, ["y"] = 6320.8959960938, ["z"] = 31.454381942749},
	[8] = { ["x"] = -3100.7924804688, ["y"] = 1186.4498291016, ["z"] = 20.33984375},
	[9] = { ["x"] = -2704.9948730469, ["y"] = 2305.4291992188, ["z"] = 18.006093978882},
	[10] =  { ['x'] = -551.43, ['y'] = 271.11, ['z'] = 82.97 },
	[11] =  { ['x'] = 534.99, ['y'] = -3105.27, ['z'] = 34.56 },
    [12] =  { ['x'] = 2396.26,['y'] = 3112.3,['z'] = 48.15 },
    [13] = { ['x'] = 189.742 ,['y'] = -930.015 ,['z'] = 30.687 }, --legion square
    [14] = { ['x'] = -94.372 ,['y'] = -722.368 ,['z'] = 43.894 }, -- overpass near legion
}


function checkAids()

	local plyCoords = GetEntityCoords(GetPlayerPed(-1))
	local aids = 9999.0
	local returninfo = false
	for i = 1, #aidsareas do
		local distance = GetDistanceBetweenCoords(aidsareas[i]["x"],aidsareas[i]["y"],aidsareas[i]["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
		if distance < 350.0 and aids > distance then
			aids = distance
			returninfo = true
		end
	end
	return returninfo
end


Citizen.CreateThread( function()
	while true do
        Citizen.Wait(1000)

        WalkingMultiplier = string.format("%.2f", ((80 - (onlinePlayers - 0))/260)) -- Outside of aids areas
        DrivingMultiplier = string.format("%.2f", ((80 - (onlinePlayers - 0))/750)) -- Driving in aids areas.

        local plyCoords = GetEntityCoords(GetPlayerPed(-1))
        local driving = false
        local playerPed = GetPlayerPed(-1)
		local currentVehicle = GetVehiclePedIsIn(playerPed, false)
		local inveh = IsPedInAnyVehicle(playerPed, true)

        if inveh then
			local driverPed = GetPedInVehicleSeat(currentVehicle, -1)

        	if GetPlayerPed(-1) == driverPed then
        		driving = true
            else
                driving = false
            end
        end

		local plyCoords = GetEntityCoords(GetPlayerPed(-1))
        local aids = checkAids()
        
		if plyCoords["z"] < -25 or aids then
            if driving then
                DensityMultiplier = DrivingMultiplier
            else
                DensityMultiplier = 0.0
            end
        else
            DensityMultiplier = WalkingMultiplier
        end
	end
end)


isAllowedToSpawn = true
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        --print(DensityMultiplier)
		if GetDistanceBetweenCoords(958.76,-141.4, 74.51, GetEntityCoords(GetPlayerPed(-1))) > 200.0 and driving then
            SetPedDensityMultiplierThisFrame(0.0)
		else
			SetPedDensityMultiplierThisFrame(0.5)
		end
		    SetParkedVehicleDensityMultiplierThisFrame(DensityMultiplier) --was 1.0
		    SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
            SetRandomVehicleDensityMultiplierThisFrame(DensityMultiplier)
            SetParkedVehicleDensityMultiplierThisFrame(0.2)
            SetVehicleDensityMultiplierThisFrame(DensityMultiplier)
            SetScenarioPedDensityMultiplierThisFrame(0.5, 0.5)
	end
end)

--[[ if inveh then
    local driverPed = GetPedInVehicleSeat(currentVehicle, -1)

    if GetPlayerPed(-1) == driverPed then
        driving = true
    end

     if not driving and isAllowedToSpawn then
         isAllowedToSpawn = false
     elseif driving and not isAllowedToSpawn then
         isAllowedToSpawn = true
     end
else
    if not isAllowedToSpawn then
        isAllowedToSpawn = true
    end
end

local plyCoords = GetEntityCoords(GetPlayerPed(-1))
local aids = checkAids()
if plyCoords["z"] < -25 or aids then
    isAllowedToSpawn = false
end        

if isAllowedToSpawn then
    DensityMultiplier = 0.2
else
    if aids then 
        DensityMultiplier = 0.1 -- this is the one that gets called
    else
        DensityMultiplier = 0.0
    end
    
end ]]


RegisterCommand('roll', function(source, args, rawCommand)
    local number = math.random(1,6)
    loadAnimDict("anim@mp_player_intcelebrationmale@wank")
    TaskPlayAnim(GetPlayerPed(-1), "anim@mp_player_intcelebrationmale@wank", "wank", 8.0, 1.0, -1, 49, 0, 0, 0, 0)
    Citizen.Wait(1500)
    ClearPedTasks(GetPlayerPed(-1))
    TriggerServerEvent('3dme:shareDisplay', 'You Rolled: '..number)
end)
   
function loadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict( dict )
        Citizen.Wait(5)
    end
end



