local syncWithDb = true

RegisterNetEvent("doormanager:c_noDoorKey")
AddEventHandler("doormanager:c_noDoorKey", function(doorID)
    if doorID == 1 then
        ShowNotification( "Locker area door requires a key." )
    elseif doorID == 2 then
        ShowNotification( "Armory door requires a key." )
    elseif doorID == 3 then
        ShowNotification( "Captain's office door requires a key." )
    else
        ShowNotification( "Door requires a key." )
    end
end)

RegisterNetEvent("doormanager:c_getSyncData")
AddEventHandler("doormanager:c_getSyncData", function(dBresult)
    for i = 1, #dBresult do
        if doorList[i] ~= nil then
            if(dBresult[i].locked == 1) then
                doorList[i]["locked"] = true
            else
                doorList[i]["locked"] = false
            end    
        end    
    end
end)

RegisterNetEvent("doormanager:c_openDoor")
AddEventHandler("doormanager:c_openDoor", function(odID)
    local closeDoor = GetClosestObjectOfType(doorList[odID]["x"], doorList[odID]["y"], doorList[odID]["z"], 1.0, GetHashKey(doorList[odID]["objName"]), false, false, false)
    if doorList[odID]["locked"] == true then
        FreezeEntityPosition(closeDoor, false)
        doorList[odID]["locked"] = false    
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'door-lock', 0.5)
        
    end
end)

RegisterNetEvent("doormanager:c_closeDoor")
AddEventHandler("doormanager:c_closeDoor", function(cdID)
    local closeDoor = GetClosestObjectOfType(doorList[cdID]["x"], doorList[cdID]["y"], doorList[cdID]["z"], 1.0, GetHashKey(doorList[cdID]["objName"]), false, false, false)
    if doorList[cdID]["locked"] == false then
        FreezeEntityPosition(closeDoor, true)
        doorList[cdID]["locked"] = true
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'door-lock', 0.5)
    end
end)

Citizen.CreateThread(function()
    while true do
        
        if(syncWithDb) then
            TriggerServerEvent('doormanager:s_syncDoors')
            syncWithDb = false
        end

        for i = 1, #doorList do
            local playerCoords = GetEntityCoords( GetPlayerPed(-1) )		
            local playerDistance = GetDistanceBetweenCoords(playerCoords.x, playerCoords.y, playerCoords.z, doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], true)

            if(playerDistance < 1) then
                if doorList[i]["locked"] == true then
                    DrawText3d(doorList[i]["txtX"], doorList[i]["txtY"], doorList[i]["txtZ"], "[E] to unlock")
                else
                    DrawText3d(doorList[i]["txtX"], doorList[i]["txtY"], doorList[i]["txtZ"], "[E] to lock")
                end

                -- Press E key
                if IsControlJustPressed(1,51) then
                    if doorList[i]["locked"] == true then
                        TriggerServerEvent("doormanager:s_openDoor", i)
                    else
                        Wait(500)
                        TriggerServerEvent("doormanager:s_closeDoor", i)
                    end
                end
            else
		if(GetGameTimer() % 1000 == 0) then
			local closeDoor = GetClosestObjectOfType(doorList[i]["x"], doorList[i]["y"], doorList[i]["z"], 1.0, GetHashKey(doorList[i]["objName"]), false, false, false)
			FreezeEntityPosition(closeDoor, doorList[i]["locked"])
		end
            end
        end
        
        Citizen.Wait(0)
    end
end)

doorList = {
    -- Mission Row To locker room & roof
    [1] = { ["objName"] = "v_ilev_ph_gendoor004", ["x"]= 449.698, ["y"]= -986.469,["z"]= 30.689,["locked"]= true,["txtX"]=450.104,["txtY"]=-986.388,["txtZ"]=31.739},
    -- Mission Row Armory
    [2] = { ["objName"] = "v_ilev_arm_secdoor", ["x"]= 452.618, ["y"]= -982.702,["z"]= 30.689,["locked"]= true,["txtX"]=453.079,["txtY"]=-982.600,["txtZ"]=31.739},
    -- Mission Row Captain Office
    [3] = { ["objName"] = "v_ilev_ph_gendoor002", ["x"]= 447.238, ["y"]= -980.630,["z"]= 30.689,["locked"]= true,["txtX"]=447.200,["txtY"]=-980.010,["txtZ"]=31.739},
    -- Mission Row To downstairs right
    [4] = { ["objName"] = "v_ilev_ph_gendoor005", ["x"]= 443.97, ["y"]= -989.033,["z"]= 30.689,["locked"]= true,["txtX"]=444.020,["txtY"]=-989.445,["txtZ"]=31.739},
    -- Mission Row To downstairs left
    [5] = { ["objName"] = "v_ilev_ph_gendoor005", ["x"]= 445.37, ["y"]= -988.705,["z"]= 30.689,["locked"]= true,["txtX"]=445.350,["txtY"]=-989.445,["txtZ"]=31.739},
    -- Mission Row Main cells
    [6] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 464.0, ["y"]= -992.265,["z"]= 24.9149,["locked"]= true,["txtX"]=463.465,["txtY"]=-992.664,["txtZ"]=25.064},
    -- Mission Row Cell 1
    [7] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.381, ["y"]= -993.651,["z"]= 24.914,["locked"]= true,["txtX"]=461.806,["txtY"]=-993.308,["txtZ"]=25.064},
    -- Mission Row Cell 2
    [8] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.331, ["y"]= -998.152,["z"]= 24.914,["locked"]= true,["txtX"]=461.806,["txtY"]=-998.800,["txtZ"]=25.064},
    -- Mission Row Cell 3
    [9] = { ["objName"] = "v_ilev_ph_cellgate", ["x"]= 462.704, ["y"]= -1001.92,["z"]= 24.914,["locked"]= true,["txtX"]=461.806,["txtY"]=-1002.450,["txtZ"]=25.064},
    -- Mission Row Backdoor in
    [10] = { ["objName"] = "v_ilev_gtdoor", ["x"]= 464.126, ["y"]= -1002.78,["z"]= 24.9149,["locked"]= true,["txtX"]=464.100,["txtY"]=-1003.538,["txtZ"]=26.064},
    -- Mission Row Backdoor out
    [11] = { ["objName"] = "v_ilev_gtdoor", ["x"]= 464.18, ["y"]= -1004.31,["z"]= 24.9152,["locked"]= true,["txtX"]=464.100,["txtY"]=-1003.538,["txtZ"]=26.064},
    -- Mission Row Rooftop In
    --[12] = { ["objName"] = "v_ilev_gtdoor02", ["x"]= 465.467, ["y"]= -983.446,["z"]= 43.6918,["locked"]= true,["txtX"]=464.361,["txtY"]=-984.050,["txtZ"]=44.834},
    -- Mission Row Rooftop Out
    --[13] = { ["objName"] = "v_ilev_gtdoor02", ["x"]= 462.979, ["y"]= -984.163,["z"]= 43.6919,["locked"]= true,["txtX"]=464.361,["txtY"]=-984.050,["txtZ"]=44.834},
    -- rear main doors
    [12] = { ["objName"] = "v_ilev_rc_door2", ["x"]= 467.3716, ["y"]= -1014.452,["z"]= 26.5362,["locked"]= true,["txtX"]=468.09,["txtY"]=-1014.452,["txtZ"]=27.1362},
    -- rear main doors
	[13] = { ["objName"] = "v_ilev_rc_door2", ["x"]= 469.9679, ["y"]= -1014.452,["z"]= 26.5362,["locked"]= true,["txtX"]=469.35,["txtY"]=-1014.452,["txtZ"]=27.1362},
   
}

function DrawText3d(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    if onScreen then
        SetTextScale(0.3, 0.3)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end