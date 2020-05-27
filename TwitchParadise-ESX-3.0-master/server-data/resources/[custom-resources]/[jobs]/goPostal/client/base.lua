local missionblip = nil
local blip = nil 
local vehicle = nil

function DrawText3d(x,y,z, text, alpha)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.5, 0.5)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, alpha)
        SetTextDropshadow(0, 0, 0, 0, alpha)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        SetDrawOrigin(x,y,z, 0)
        DrawText(0.0, 0.0)
        ClearDrawOrigin()
    end
end

function getParkingPosition(spots)
  for id,v in pairs(spots) do 
   if GetClosestVehicle(v.x, v.y, v.z, 3.0, 0, 70) == 0 then  
    return true, v
   end
  end 
  TriggerEvent('chatMessage', '^1Parking Spots Full, Please Wait')
 end

function drawTxt(text)
  SetTextFont(0)
  SetTextProportional(0)
  SetTextScale(0.32, 0.32)
  SetTextColour(0, 255, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(1, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextCentre(1)
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(0.5, 0.93)
end

function SetWorkPlace(x,y,z)
 if DoesBlipExist(blip) then RemoveBlip(blip) end
 blip = AddBlipForCoord(x, y, z)
 SetBlipSprite (blip, 430)
 SetBlipDisplay(blip, 4)
 SetBlipScale  (blip, 0.8)
 SetBlipColour (blip, 18)
 SetBlipAsShortRange(blip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Place of Work")
 EndTextCommandSetBlipName(blip)
end 

function SpawnJobVehicle(model, x,y,z)
 if DoesEntityExist(vehicle) then DeleteVehicle(vehicle) end
 local vehiclehash = GetHashKey(model)
 RequestModel(vehiclehash)
 while not HasModelLoaded(vehiclehash) do
  Citizen.Wait(0)
 end
 vehicle = CreateVehicle(vehiclehash, x,y,z, GetEntityHeading(PlayerPedId()), true, false)
 SetVehicleDirtLevel(vehicle, 0)
 TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
 SetVehicleHasBeenOwnedByPlayer(vehicle, true)
 SetEntityAsMissionEntity(vehicle, true, true)
 SetVehicleMod(vehicle,16, 20)
 SetVehicleEngineOn(vehicle, true)
 SetVehicleLivery(vehicle, vehlivery)
 DecorSetInt(vehicle, "_Fuel_Level", 80000)
end

function SetJobBlip(x,y,z)
 if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
 missionblip = AddBlipForCoord(x,y,z)
 SetBlipSprite(missionblip, 164)
 SetBlipColour(missionblip, 53)
 SetBlipRoute(missionblip, true)
 BeginTextCommandSetBlipName("STRING")
 AddTextComponentString("Destination")
 EndTextCommandSetBlipName(missionblip)
end

function RemoveJobBlip()
 if DoesBlipExist(missionblip) then RemoveBlip(missionblip) end
end

function Notify(message) 
 exports['mythic_notify']:SendAlert('inform', message, 10000)
 --exports.pNotify:SendNotification({text = message})
end

function LoadAnim(animDict)
  RequestAnimDict(animDict)

  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(10)
  end
end

function LoadModel(model)
  RequestModel(model)

  while not HasModelLoaded(model) do
    Citizen.Wait(10)
  end
end
