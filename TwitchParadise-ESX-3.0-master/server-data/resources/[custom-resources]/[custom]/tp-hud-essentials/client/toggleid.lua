local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 2000
local displayIDHeight = 1.2 --Height of ID above players head(starts at center body mass)

--Set Default Values for Colors


function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1.5/dist)*2.0
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(2)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlPressed(1, 57) then
            for i=0,255 do
                N_0x31698aa80e0223f8(i) -- Remove Gamertags
            end

            for id = 0, 255 do
                if  ((NetworkIsPlayerActive( id ))) then
                ped = GetPlayerPed(id)
                blip = GetBlipFromEntity(ped) 
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                --x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )

                x2, y2, z2 = table.unpack( GetPedBoneCoords( GetPlayerPed( id ), 4103) ) -- Get skull coords. Should fix overlaping ID's when 2 people in a car.
                
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))

                if(ignorePlayerNameDistance) then
						red = 255
						green = 255
						blue = 255
						DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                end

                if ((distance < playerNamesDist)) then
                    if not (ignorePlayerNameDistance) then

                            --[[ if showme then
                                TriggerServerEvent('3dme:shareDisplay', 'Checking Government IDs')
                                showme = false
                            end ]]
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
                    end
                end  
            end
        end
        elseif not IsControlPressed(1, 243) then
            DrawText3D(0, 0, 0, "")
        end
    end
end)

--[[ function showing()
    if showme then
        Citizen.Wait(5000)
        showme = false
    end
end ]]

Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if showme == false then
            Citizen.Wait(7250)
            showme = true
        end
    end     
end)
