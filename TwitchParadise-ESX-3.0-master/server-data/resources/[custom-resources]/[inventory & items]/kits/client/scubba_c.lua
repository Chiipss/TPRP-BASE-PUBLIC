--[[ local playerPed = GetPlayerPed(-1)
SetEnableScuba(GetPlayerPed(-1),true)
SetPedMaxTimeUnderwater(GetPlayerPed(-1), 400.00) ]]



oxygenTank = 25.0
oxyOn = false
attachedProp = 0
attachedProp2 = 0

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function VehicleInFront()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, PlayerPedId(), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end



RegisterNetEvent('police:woxy')
AddEventHandler('police:woxy', function()
	local vehFront = VehicleInFront()
	if vehFront > 0 then
		TriggerServerEvent("tp:subbaRemove")
			loadAnimDict('anim@narcotics@trash')
		TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 3800, 49, 3.0, 0, 0, 0)		
		exports["t0sic_loadingbar"]:StartDelayedFunction('Grabbing Scubba Gear', 4000, function() 
				loadAnimDict('anim@narcotics@trash')
			TaskPlayAnim(PlayerPedId(),'anim@narcotics@trash', 'drop_front',0.9, -8, 1900, 49, 3.0, 0, 0, 0)	  		
			TriggerEvent("UseOxygenTank")
			--SetEnableScuba(PlayerPedId(),true)
		end)
	else
		exports['mythic_notify']:SendAlert('error', 'You need to be near a vehicle to do this.', 7000)
	end
end)

RegisterNetEvent("RemoveOxyTank")
AddEventHandler("RemoveOxyTank",function()
	if oxygenTank > 25.0 then
		oxygenTank = 25.0
		TriggerEvent('menu:hasOxygenTank', false)
	end
end)

RegisterNetEvent("UseOxygenTank")
AddEventHandler("UseOxygenTank",function()
	oxygenTank = 100.0
	TriggerEvent('menu:hasOxygenTank', true) 
end)

Citizen.CreateThread(function()

	while true do
		Wait(1)
		if oxygenTank > 0 and IsPedSwimmingUnderWater(PlayerPedId()) then
			SetPedDiesInWater(PlayerPedId(), false)
			if oxygenTank > 25.0 then
				oxygenTank = oxygenTank - 0.005
			else
				oxygenTank = oxygenTank - 2.0
			end
		else
			if IsPedSwimmingUnderWater(PlayerPedId()) then
				oxygenTank = oxygenTank - 0.1
				SetPedDiesInWater(PlayerPedId(), true)
			end
		end

		if not IsPedSwimmingUnderWater( PlayerPedId() ) and oxygenTank < 25.0 then
			oxygenTank = oxygenTank + 0.01
			if oxygenTank > 25.0 then
				oxygenTank = 25.0
			end
		end

		if oxygenTank > 25.0 and not oxyOn then
			oxyOn = true
			attachProp("p_s_scuba_tank_s", 24818, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0)
			attachProp2("p_s_scuba_mask_s", 12844, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0)
		elseif oxyOn and oxygenTank <= 25.0 then
			oxyOn = false
			removeAttachedProp()
			removeAttachedProp2()
		end
		if not oxyOn then
			Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	    Citizen.Wait(1000)
		if IsPedSwimmingUnderWater(PlayerPedId()) then
			if oxygenTank <= 0.0 then
				exports['mythic_notify']:SendAlert('error', 'Oxygen Level Dangerously Low ' ..oxygenTank..' units', 650)
			elseif oxygenTank <= 25.0 then
				exports['mythic_notify']:SendAlert('inform', 'Oxygen Level Dangerously Low ' ..oxygenTank..' units', 650)
			else
				exports['mythic_notify']:SendAlert('inform', 'Oxygen Level ' ..oxygenTank..' units', 650)
			end
		end	        
	end
end)

function removeAttachedProp2()
	DeleteEntity(attachedProp2)
	attachedProp2 = 0
end
function removeAttachedProp()
	DeleteEntity(attachedProp)
	attachedProp = 0
end
function attachProp2(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp2()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp2 = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	--exports["isPed"]:GlobalObject(attachedProp2)
	AttachEntityToEntity(attachedProp2, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end
function attachProp(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
	removeAttachedProp()
	attachModel = GetHashKey(attachModelSent)
	boneNumber = boneNumberSent 
	local bone = GetPedBoneIndex(PlayerPedId(), boneNumberSent)
	--local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Citizen.Wait(100)
	end
	attachedProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
	--exports["isPed"]:GlobalObject(attachedProp)
	AttachEntityToEntity(attachedProp, PlayerPedId(), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
	SetModelAsNoLongerNeeded(attachModel)
end