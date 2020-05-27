ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()

	TriggerEvent('skinchanger:getSkin', function(skin)
		playerGender = skin.sex
	end)
end)

local pedsused = {}
local sellAmount = 0
local sellingweed = false
local alerto = false
local cooldown = false
function EndSelling()
	sellAmount = 0
	sellingweed = false
	sellingcocaine = false
	sellingcrack = false
	alerto = false
end

local zoneNames = {
AIRP = "Los Santos International Airport",
ALAMO = "Alamo Sea",
ALTA = "Alta",
ARMYB = "Fort Zancudo",
BANHAMC = "Banham Canyon Dr",
BANNING = "Banning",
BAYTRE = "Baytree Canyon", 
BEACH = "Vespucci Beach",
BHAMCA = "Banham Canyon",
BRADP = "Braddock Pass",
BRADT = "Braddock Tunnel",
BURTON = "Burton",
CALAFB = "Calafia Bridge",
CANNY = "Raton Canyon",
CCREAK = "Cassidy Creek",
CHAMH = "Chamberlain Hills",
CHIL = "Vinewood Hills",
CHU = "Chumash",
CMSW = "Chiliad Mountain State Wilderness",
CYPRE = "Cypress Flats",
DAVIS = "Davis",
DELBE = "Del Perro Beach",
DELPE = "Del Perro",
DELSOL = "La Puerta",
DESRT = "Grand Senora Desert",
DOWNT = "Downtown",
DTVINE = "Downtown Vinewood",
EAST_V = "East Vinewood",
EBURO = "El Burro Heights",
ELGORL = "El Gordo Lighthouse",
ELYSIAN = "Elysian Island",
GALFISH = "Galilee",
GALLI = "Galileo Park",
golf = "GWC and Golfing Society",
GRAPES = "Grapeseed",
GREATC = "Great Chaparral",
HARMO = "Harmony",
HAWICK = "Hawick",
HORS = "Vinewood Racetrack",
HUMLAB = "Humane Labs and Research",
JAIL = "Bolingbroke Penitentiary",
KOREAT = "Little Seoul",
LACT = "Land Act Reservoir",
LAGO = "Lago Zancudo",
LDAM = "Land Act Dam",
LEGSQU = "Legion Square",
LMESA = "La Mesa",
LOSPUER = "La Puerta",
MIRR = "Mirror Park",
MORN = "Morningwood",
MOVIE = "Richards Majestic",
MTCHIL = "Mount Chiliad",
MTGORDO = "Mount Gordo",
MTJOSE = "Mount Josiah",
MURRI = "Murrieta Heights",
NCHU = "North Chumash",
NOOSE = "N.O.O.S.E",
OCEANA = "Pacific Ocean",
PALCOV = "Paleto Cove",
PALETO = "Paleto Bay",
PALFOR = "Paleto Forest",
PALHIGH = "Palomino Highlands",
PALMPOW = "Palmer-Taylor Power Station",
PBLUFF = "Pacific Bluffs",
PBOX = "Pillbox Hill",
PROCOB = "Procopio Beach",
RANCHO = "Rancho",
RGLEN = "Richman Glen",
RICHM = "Richman",
ROCKF = "Rockford Hills",
RTRAK = "Redwood Lights Track",
SanAnd = "San Andreas",
SANCHIA = "San Chianski Mountain Range",
SANDY = "Sandy Shores",
SKID = "Mission Row",
SLAB = "Stab City",
STAD = "Maze Bank Arena",
STRAW = "Strawberry",
TATAMO = "Tataviam Mountains",
TERMINA = "Terminal",
TEXTI = "Textile City",
TONGVAH = "Tongva Hills",
TONGVAV = "Tongva Valley",
VCANA = "Vespucci Canals",
VESP = "Vespucci",
VINE = "Vinewood",
WINDF = "Ron Alternates Wind Farm",
WVINE = "West Vinewood",
ZANCUDO = "Zancudo River",
ZP_ORT = "Port of South Los Santos",
ZQ_UAR = "Davis Quartz"
}

function GetRandomNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped,true) and distance > 1.0 and distance < 25.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
            success = false
            pedsused["conf"..rped] = true
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped,fresh)
    if ped == nil then
        return false
    end
    if pedsused["conf"..ped] and fresh then
      return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end

    if not DoesEntityExist(ped) then
        return false
    end

    if IsPedAPlayer(ped) then
        return false
    end

    if IsPedFatallyInjured(ped) then
        return false
    end

    if IsPedFleeing(ped) then
        return false
    end

    if IsPedInCover(ped) or IsPedGoingIntoCover(ped) or IsPedGettingUp(ped) then
        return false
    end

    if IsPedInMeleeCombat(ped) then
        return false
    end

    if IsPedShooting(ped) then
        return false
    end

    if IsPedDucking(ped) then
        return false
    end

    if IsPedBeingJacked(ped) then
        return false
    end

    if IsPedSwimming(ped) then
        return false
    end

    if IsPedSittingInAnyVehicle(ped) or IsPedGettingIntoAVehicle(ped) or IsPedJumpingOutOfVehicle(ped) or IsPedBeingJacked(ped) then
        return false
    end

    if IsPedOnAnyBike(ped) or IsPedInAnyBoat(ped) or IsPedInFlyingVehicle(ped) then
        return false
    end

    local pedType = GetPedType(ped)
    if pedType == 6 or pedType == 27 or pedType == 29 or pedType == 28 then
        return false
    end

    return true
end


RegisterNetEvent('np-esquina:iniciar')
AddEventHandler('np-esquina:iniciar', function(pol)
	if sellingweed then
		EndSelling()
		return
	end
	if cooldown then
		exports['mythic_notify']:DoLongHudText('error', 'You can only sell once every 5 minutes.')
		return
	end
	
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    local zone = tostring(GetNameOfZone(x, y, z))
    local Area = zoneNames[tostring(zone)]

    if (Area == "West Vinewood") or (Area == "Vespucci Beach") or (Area == "Davis") or (Area == "Chamberlain Hills") then
			exports['mythic_notify']:DoHudText('inform', 'People know you are selling, Wait for someone to approach you')
	    	sellingweed = true
	    	cooldown = true
    else
		exports['mythic_notify']:DoHudText('error', 'You cant do this here.')
		return
	end

    local plyStartCoords = GetEntityCoords(GetPlayerPed(-1))
    while sellingweed do

    	Wait(15000)
		if sellingweed then
			local curCoords = GetEntityCoords(GetPlayerPed(-1))
			local dstCheck = GetDistanceBetweenCoords(plyStartCoords,curCoords)
			
			if dstCheck > 45.0 then
				exports['mythic_notify']:DoHudText('inform', 'You walked away from the area')
				EndSelling()
			end

			local RandomNPC = GetRandomNPC()
			local saleprice = math.random(200,250) + (pol * 20)
			local cant = math.random(5)
			if RandomNPC then
				exports['mythic_notify']:DoHudText('inform', 'A buyer is coming')
			end
			TriggerEvent("AllowSale",RandomNPC,saleprice,cant)
		end
 

    end

	exports['mythic_notify']:DoHudText('inform', 'You stopped selling!')

    Wait(300000)
    cooldown = false
end)

RegisterNetEvent('MovePed')
AddEventHandler("MovePed",function(p)
    local usingped = p

    local nm1 = math.random(6,9) / 100
    local nm2 = math.random(6,9) / 100
    nm1 = nm1 + 0.3
    nm2 = nm2 + 0.3
    if math.random(10) > 5 then
      nm1 = 0.0 - nm1
    end

    if math.random(10) > 5 then
      nm2 = 0.0 - nm2
    end

    local moveto = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), nm1, nm2, 0.0)
    TaskGoStraightToCoord(usingped, moveto, 1.0, 30.0, 0.0, 0.0)
    SetPedKeepTask(usingped, true) 

    local dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(usingped), false)
    local toolong = 0
    local lastcheck = GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1)))

    while dist > 3.5 and toolong < 600 and GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1))) > 1.5 do
    	local dstmoved = lastcheck - GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1)))
    	if dstmoved < 0.5 then
    		toolong = toolong + 20
    	end
      toolong = toolong + 1
      TaskGoStraightToCoord(usingped, moveto, 1.0, 30.0, 0.0, 0.0)
      dist = GetDistanceBetweenCoords(moveto, GetEntityCoords(usingped), false)
      Citizen.Wait(1000)
      lastcheck = GetDistanceBetweenCoords(GetEntityCoords(usingped),GetEntityCoords(GetPlayerPed(-1)))
    end

    if toolong > 500 then
    	TaskWanderStandard(usingped, 10.0, 10)
    else 
    	
	    TaskLookAtEntity(usingped, GetPlayerPed(-1), 5500.0, 2048, 3)
	    TaskTurnPedToFaceEntity(usingped, GetPlayerPed(-1), 5500)
	    if not sellingweed then
		    TaskStartScenarioInPlace(usingped, "WORLD_HUMAN_BUM_STANDING", 0, 1)
		end
    end


end)

RegisterNetEvent('AllowSale')
AddEventHandler('AllowSale', function(NPC,saleprice,cant)
	local timer = 0
	TriggerEvent("MovePed",NPC)
	local startdst = GetDistanceBetweenCoords(GetEntityCoords(NPC),GetEntityCoords(GetPlayerPed(-1)))
	while true do
		if not canPedBeUsed(NPC,false) then
			return
		end
		local curdst = GetDistanceBetweenCoords(GetEntityCoords(NPC),GetEntityCoords(GetPlayerPed(-1)))
		if curdst-2 > startdst then
			TaskWanderStandard(NPC, 10.0, 10)
			return
		end
		local x,y,z=table.unpack(GetEntityCoords(NPC))
		if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z,true) < 10.0 then
			if cant == 1 then
					DrawText3DTest(x,y,z, "[E] Sell "..cant.." Cocaine baggies for $" .. saleprice .. " | [H] Get out of here")
				else
					DrawText3DTest(x,y,z, "[E] Sell "..cant.." Cocaine baggies for $" .. saleprice .. " | [H] Get out of here")
				end
				if IsControlJustReleased(2,38) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z,true) < 2.0 then
				-- e stroke
				ClearPedTasks(NPC)
				ClearPedSecondaryTask(NPC)

				TaskTurnPedToFaceEntity(NPC, GetPlayerPed(-1), 1.0)

				SellDrugs(NPC,saleprice,cant)
				return
			end
			if IsControlJustReleased(2,74) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),x,y,z,true) < 5.0 then
				-- h stroke
				TaskWanderStandard(NPC, 10.0, 10)
				return
			end
		end
		timer = timer + 1
		if timer > 60000 then
			TaskWanderStandard(NPC, 10.0, 10)
			return
		end
		Wait(1)
	end
end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 



function giveAnim(NPC)

    if ( DoesEntityExist( NPC ) and not IsEntityDead( NPC ) ) then 
    	
	        loadAnimDict( "random@mugging4" )
	        TaskPlayAnim( NPC, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
	        Wait(1000)


        loadAnimDict( "mp_safehouselost@" )

        TaskPlayAnim( NPC, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    
    end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)

		local playerCoords = GetEntityCoords(PlayerPedId())
		streetName,_ = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z)
		streetName = GetStreetNameFromHashKey(streetName)
	end
end)

function SellDrugs(NPC,saleprice,cant)

	local success = true

	Citizen.Wait(500)

	PlayAmbientSpeech1(NPC, "Chat_State", "Speech_Params_Force")
	Wait(1000)

	local crds = GetEntityCoords(NPC)
	local crds2 = GetEntityCoords(GetPlayerPed(-1))

	if GetDistanceBetweenCoords(crds,crds2) > 5.0 or not DoesEntityExist(NPC) or IsEntityDead(NPC) then

		return
	end
	
	local porros = false

	ESX.TriggerServerCallback('np-esquina:porroscant', function(val)
		if val == true then
			porros = true
		elseif val == "vacio" then
			porros = "vacio"
		end
		
		if porros == "vacio" then
			EndSelling()
			exports['mythic_notify']:DoHudText('error', 'You dont have the amount I need')
			TaskWanderStandard(NPC, 10.0, 10)
			return
		end

		if porros == false and sellingweed then
			exports['mythic_notify']:DoHudText('error', 'You dont have the amount I need')
			 TaskWanderStandard(NPC, 10.0, 10)
			 return
		end	

		if sellingweed then
			sellAmount = sellAmount + cant
			if math.random(50) < sellAmount then
				if not alerto then
					local ub = GetEntityCoords(GetPlayerPed(-1))
                    fal = "Anonimo"
                    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                    local zone = tostring(GetNameOfZone(x, y, z))
                    local Area = zoneNames[tostring(zone)]
					local msg = "There is a person in ".. Area .. " selling Cocaine!"
					tex = fal..": "..msg
					TriggerServerEvent('chat:entorno',tex, ub.x, ub.y, ub.z, true)
					alerto = true
				end
			end
			
			PlayAmbientSpeech1(NPC, "Generic_Thanks", "Speech_Params_Force_Shouted_Critical")
			giveAnim(NPC)
			TriggerServerEvent('np-esquina:pagar',cant,saleprice)
			giveAnim(GetPlayerPed(-1))
			if cant == 1 then
				exports['mythic_notify']:DoHudText('success', 'You sold '..cant..' joint $'..saleprice*cant)
			else
				exports['mythic_notify']:DoHudText('success', 'You sold '..cant..' joint $'..saleprice*cant)
			end

			local mth = math.random(1,100)
			if mth <= 5 then

				local playerPed = PlayerPedId()
				local playerCoords = GetEntityCoords(playerPed)

				TriggerServerEvent('esx_outlawalert:drugSaleInProgress', {
					x = ESX.Math.Round(playerCoords.x, 1),
					y = ESX.Math.Round(playerCoords.y, 1),
					z = ESX.Math.Round(playerCoords.z, 1)
				}, streetName, playerGender)
			end

			Wait(4000)
			TaskWanderStandard(NPC, 10.0, 10)
		end
	end,cant,saleprice)
end

function DrawText3DTest(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.31, 0.31)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function loadModel(modelName)
    RequestModel(GetHashKey(modelName))
    while not HasModelLoaded(GetHashKey(modelName)) do
        RequestModel(GetHashKey(modelName))
        Citizen.Wait(1)
    end
end

function loadAnim( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 