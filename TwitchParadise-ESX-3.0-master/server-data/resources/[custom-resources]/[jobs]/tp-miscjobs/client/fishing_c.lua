ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0

FishTime = {a = 20000, b = 44000}
	
FishPrice = {a = 80, b = 145} --Will get clean money THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
TurtlePrice = {a = 128, b = 220} --Will get dirty money
SharkPrice = {a = 325, b = 422} --Will get dirty money

SellFish = {x = -313.811, y = -2781.239, z = 5.000} --Place where players can sell their fish
SellTurtle = {x = 3804.0, y = 4443.3, z = 3.0} --Place where players can sell their turtles 
SellShark = {x = 2517.6 , y = 4218.0, z = 38.8} --Place where players can sell their sharks

MarkerZones = { 	
    {x = -3426.7   ,y = 955.66 ,z = 7.35, xs = -3426.2  , ys = 942.4, zs = 1.1 },
	{x = -732.9     ,y = -1309.7 ,z = 4.0, xs = -725.7    , ys = -1351.5, zs = 0.5 },  
	{x = -1607.6      ,y =  5252.8 ,z = 3.0, xs = -1590.2      , ys = 5278.8, zs = 1.0 },
	{x = 3855.0        ,y =  4463.7 ,z = 1.6, xs = 3885.2       , ys =  4507.2, zs = 1.0 },
	{x = 1330.8        ,y =  4226.6 ,z = 32.9, xs = 1334.2         , ys =  4192.4, zs = 30.0 },	
}

local bait = "none"

local blip = AddBlipForCoord(SellFish.x, SellFish.y, SellFish.z)

			SetBlipSprite (blip, 356)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 0.6)
			SetBlipColour (blip, 17)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Fish selling")
			EndTextCommandSetBlipName(blip)
			
local blip2 = AddBlipForCoord(SellTurtle.x, SellTurtle.y, SellTurtle.z)

			SetBlipSprite (blip2, 68)
			SetBlipDisplay(blip2, 4)
			SetBlipScale  (blip2, 0.6)
			SetBlipColour (blip2, 49)
			SetBlipAsShortRange(blip2, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Sea Turtle dealer")
			EndTextCommandSetBlipName(blip2)
			
local blip3 = AddBlipForCoord(SellShark.x, SellShark.y, SellShark.z)

			SetBlipSprite (blip3, 68)
			SetBlipDisplay(blip3, 4)
			SetBlipScale  (blip3, 0.6)
			SetBlipColour (blip3, 49)
			SetBlipAsShortRange(blip3, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Shark meat dealer")
			EndTextCommandSetBlipName(blip3)
			
for _, info in pairs(MarkerZones) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, 455)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 0.6)
		SetBlipColour(info.blip, 20)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Boat rental")
		EndTextCommandSetBlipName(info.blip)
	end
	
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(MarkerZones) do
		
            DrawMarker(1, MarkerZones[k].x, MarkerZones[k].y, MarkerZones[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 1.0, 0, 150, 150, 100, 0, 0, 0, 0)	
		end
    end
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
while true do
	Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
end
end)
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if fishing then
--[[ 			if IsControlJustReleased(0, Keys['7']) then
				input = 7
				print("7 triggered")
			end
			if IsControlJustReleased(0, Keys['8']) then
				input = 8
				print("8 triggered")
			end
			if IsControlJustReleased(0, Keys['9']) then
				input = 9
				print("9 triggered")
			end
			 ]]
			
			if IsControlJustReleased(0, Keys['E']) then
				fishing = false
				ClearPedTasksImmediately(GetPlayerPed(-1))

				exports['mythic_notify']:SendAlert('error', 'Stopped fishing', 7000)
				--ESX.ShowNotification("~r~Stopped fishing")
			end
			if fishing then
			
				playerPed = GetPlayerPed(-1)
				local pos = GetEntityCoords(GetPlayerPed(-1))
				if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 or IsPedInAnyVehicle(GetPlayerPed(-1)) then
					
				else
					fishing = false
					exports['mythic_notify']:SendAlert('error', 'Stopped fishing', 7000)
					--ESX.ShowNotification("~r~Stopped fishing")
				end
				if IsEntityDead(playerPed) or IsEntityInWater(playerPed) then
					exports['mythic_notify']:SendAlert('error', 'Stopped fishing', 7000)
					--ESX.ShowNotification("~r~Stopped fishing")
				end
			end
			
			
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					--exports['mythic_notify']:SendAlert('inform', 'You got one!', 7000)
					TriggerServerEvent('fishing:catch', bait)
				else
					--exports['mythic_notify']:SendAlert('inform', 'You got one!', 7000)
					TriggerServerEvent('fishing:catch', bait)
				end
			end
		end

		
		
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), SellFish.x, SellFish.y, SellFish.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', "fish")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), SellShark.x, SellShark.y, SellShark.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', "shark")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), SellTurtle.x, SellTurtle.y, SellTurtle.z, true) <= 3 then
			TriggerServerEvent('fishing:startSelling', "turtle")
			Citizen.Wait(4000)
		end
		
	end
end)


				
Citizen.CreateThread(function()
	while true do
		Wait(1)
		
		DrawMarker(27, SellFish.x, SellFish.y, SellFish.z-0.97 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, SellTurtle.x, SellTurtle.y, SellTurtle.z-0.97 , 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 255, 255, 255, 200, 0, 0, 0, 0)
		DrawMarker(27, SellShark.x, SellShark.y, SellShark.z-0.97, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 2.0, 255, 255, 255, 200, 0, 0, 0, 0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local wait = math.random(FishTime.a , FishTime.b)
		Wait(wait)
			if fishing then
				pause = true
				correct = math.random(7,9)
				exports['mythic_notify']:SendAlert('inform', 'You feel a bite...', 10000)
				--ESX.ShowNotification("~g~Fish is taking the bait \n ~h~Press " .. correct .. " to catch it")
				input = 0
				pausetimer = 0
			end
			
	end
end)

RegisterNetEvent('fishing:message')
AddEventHandler('fishing:message', function(message)
	ESX.ShowNotification(message)
end)
RegisterNetEvent('fishing:break')
AddEventHandler('fishing:break', function()
	fishing = false
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('fishing:spawnPed')
AddEventHandler('fishing:spawnPed', function()
	
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
		while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
			Citizen.Wait( 1 )
		end
	local pos = GetEntityCoords(GetPlayerPed(-1))
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('fishing:setbait')
AddEventHandler('fishing:setbait', function(bool)
	bait = bool
	print(bait)
end)

RegisterNetEvent('fishing:fishstart')
AddEventHandler('fishing:fishstart', function()
	
	
	
	playerPed = GetPlayerPed(-1)
	local pos = GetEntityCoords(GetPlayerPed(-1))
	print('started fishing' .. pos)
	if IsPedInAnyVehicle(playerPed) then
		exports['mythic_notify']:SendAlert('error', 'You can not fish from a vehicle', 7000)
		--ESX.ShowNotification("~y~You can not fish from a vehicle")
	else
		if pos.y >= 7700 or pos.y <= -4000 or pos.x <= -3700 or pos.x >= 4300 then
			exports['mythic_notify']:SendAlert('success', 'Fishing started', 7000)
			exports['mythic_notify']:SendAlert('inform', 'Press [E] to cancel', 15000)
			--ESX.ShowNotification("~g~Fishing started")
			TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_STAND_FISHING", 0, true)
			fishing = true
		else
			exports['mythic_notify']:SendAlert('error', 'You need to go further away from shore', 12000)
			--ESX.ShowNotification("~y~You need to go further away from the shore")
		end
	end
	
end, false)


Citizen.CreateThread(function()
    while true do
	Citizen.Wait(0)
		if fishing == true then
			DisablePlayerFiring(ped, true) -- Disable weapon firing
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(1, 37, true) -- disable weapon select
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 142, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 63, true) -- veh turn left
			DisableControlAction(0, 245, true) -- veh turn right
			DisableControlAction(0, 71, true) -- veh forward
			DisableControlAction(0, 72, true) -- veh backwards
			DisableControlAction(0, 75, true) -- disable exit vehicle
			DisableControlAction(0, 30, true) -- disable left/right
			DisableControlAction(0, 31, true) -- disable forward/back
			DisableControlAction(0, 36, true) -- INPUT_DUCK
			DisableControlAction(0, 56, true) -- F9
			DisableControlAction(0, 21, true) -- disable sprint
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
	
        for k in pairs(MarkerZones) do
        	local ped = PlayerPedId()
            local pedcoords = GetEntityCoords(ped, false)
            local distance = Vdist(pedcoords.x, pedcoords.y, pedcoords.z, MarkerZones[k].x, MarkerZones[k].y, MarkerZones[k].z)
            if distance <= 1.40 then

					DisplayHelpText('Press E to rent a boat')
					
					if IsControlJustPressed(0, Keys['E']) and IsPedOnFoot(ped) then
						OpenBoatsMenu(MarkerZones[k].xs, MarkerZones[k].ys, MarkerZones[k].zs)
					end 
			elseif distance < 1.45 then
				ESX.UI.Menu.CloseAll()
            end
        end
    end
end)

function OpenBoatsMenu(x, y , z)
	local ped = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
	local elements = {}
	
	
		table.insert(elements, {label = '<span style="color:green;">Dinghy</span> <span style="color:red;">$250</span>', value = 'boat'})
		table.insert(elements, {label = '<span style="color:green;">Suntrap</span> <span style="color:red;">$480</span>', value = 'boat6'}) 
		table.insert(elements, {label = '<span style="color:green;">Jetmax</span> <span style="color:red;">$600</span>', value = 'boat5'}) 	
		table.insert(elements, {label = '<span style="color:green;">Toro</span> <span style="color:red;">$800</span>', value = 'boat2'}) 
		table.insert(elements, {label = '<span style="color:green;">Marquis</span> <span style="color:red;">$800</span>', value = 'boat3'}) 
		table.insert(elements, {label = '<span style="color:green;">Tug boat</span> <span style="color:red;">$800</span>', value = 'boat4'})
		
	--If user has police job they will be able to get free Police Predator boat
	if PlayerData.job.name == "police" then
		table.insert(elements, {label = '<span style="color:green;">Police Predator</span>', value = 'police'})
	end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'client',
    {
		title    = 'Rent a boat',
		align    = 'bottom-right',
		elements = elements,
    },
	
	
	function(data, menu)

	if data.current.value == 'boat' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 250) 
		exports['mythic_notify']:SendAlert('success', 'You rented a boat for $250', 12000)
		--TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 2500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "dinghy4")
	end
	
	if data.current.value == 'boat2' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 480) 
		exports['mythic_notify']:SendAlert('success', 'You rented a boat for $480', 12000)
		--TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 5500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "TORO")
	end
	
	if data.current.value == 'boat3' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 600) 
		exports['mythic_notify']:SendAlert('success', 'You rented a boat for $600', 12000)
		--TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 6000)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "MARQUIS")
	end

	if data.current.value == 'boat4' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 800) 
		exports['mythic_notify']:SendAlert('success', 'You rented a boat for $800', 12000)
		--TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 7500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "tug")
	end
	
	if data.current.value == 'boat5' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 800) 
		exports['mythic_notify']:SendAlert('success', 'You rented a boat for $800', 12000)
		--TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 4500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "jetmax")
	end
	
	if data.current.value == 'boat6' then
		ESX.UI.Menu.CloseAll()

		TriggerServerEvent("fishing:lowmoney", 800) 
		exports['mythic_notify']:SendAlert('success', 'You rented a boat for $800', 12000)
		--TriggerEvent("chatMessage", 'You rented a boat for', {255,0,255}, '$' .. 3500)
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "suntrap")
	end
	
	
	if data.current.value == 'police' then
		ESX.UI.Menu.CloseAll()
        exports['mythic_notify']:SendAlert('success', 'You took out a boat', 12000)
		--TriggerEvent("chatMessage", 'You took out a boat')
		SetPedCoordsKeepVehicle(ped, x, y , z)
		TriggerEvent('esx:spawnVehicle', "predator")
	end
	ESX.UI.Menu.CloseAll()
	

    end,
	function(data, menu)
		menu.close()
		end
	)
end
