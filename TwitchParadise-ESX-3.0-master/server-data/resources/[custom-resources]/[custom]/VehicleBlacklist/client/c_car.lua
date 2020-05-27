local currentVehicle = 0
local currentSeat = 0

function ShowNotification( text )
   SetNotificationTextEntry( "STRING" )
   AddTextComponentString( text )
   DrawNotification( false, false )
end

function GetPedVehicleSeat(ped)
    local vehicle = GetVehiclePedIsIn(ped, false)
    for i=-2,GetVehicleMaxNumberOfPassengers(vehicle) do
        if(GetPedInVehicleSeat(vehicle, i) == ped) then return i end
    end
  return -2
end

local vehicles = {
      --{ hash="-475225213" }, -- police trainer
      --{ hash="666014468" }, -- police cruiser
      --{ hash="2038038420" }, -- police stanier
      --{ hash="-1537810200" }, -- police buffalo
      --{ hash="-1309990298" }, -- fbi buffalo
      --{ hash="-64097686" }, -- fbi granger
      --{ hash="-35776806" }, -- sheriff cruiser
      --{ hash="-2007311232" }, -- sheriff buffalo
      --{ hash="-239432727" }, -- sheriff towtruck
      --{ hash="-545384401" }, -- highway cruiser
      --{ hash="-57703123" }, -- highway buffalo
      --{ hash="2005531687" }, -- highway byke
      { hash="782665360" }, -- Tank.
      { hash="970385471" }, -- hydra.

}

function VehicleList()
    local get_ped = PlayerPedId()
    local currentVehicle = GetVehiclePedIsIn(get_ped)
    local model = GetEntityModel(currentVehicle)
    local currentHash = GetHashKey(model, _r)

    for i, pos in ipairs(vehicles) do
    local hash = pos.hash
    
    if ( tostring(currentHash) == hash ) then
      return true
    end
  end
  return false
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local lastVehicle = -1
local isInBlacklistedVehicle = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)

    local get_ped = PlayerPedId()

    if IsPedInAnyVehicle(get_ped, false) then
      local vehicleId = GetVehiclePedIsIn(get_ped, false)

      if vehicleId ~= lastVehicle then
        lastVehicle = vehicleId

        local currentSeat = GetPedVehicleSeat(get_ped)
        local blacklisted = VehicleList()

        if blacklisted and currentSeat == -1 then
          TriggerServerEvent("s_IsCarDriveable")
        elseif blacklisted == false and currentSeat == -1 then
          TriggerEvent("c_Driveable")
        end
      end
    else
      lastVehicle = -1
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)

    if isInBlacklistedVehicle and lastVehicle > 0 then
      SetVehicleUndriveable(lastVehicle, true)
    elseif not isInBlacklistedVehicle and lastVehicle > 0 then
      SetVehicleUndriveable(lastVehicle, false)
    end
  end
end)

-- Makes car drivable for police officers and admins
RegisterNetEvent("c_Driveable")
AddEventHandler("c_Driveable", function()
  isInBlacklistedVehicle = false
end)

-- Makes cars undrivable for civilians
RegisterNetEvent("c_Undriveable")
AddEventHandler("c_Undriveable", function()
    isInBlacklistedVehicle = true
   TriggerEvent("c_text", "This vehicle requires Military clearence, Please vacate.", 2000)
end)

-- Show in game text message at the bottom of screen
AddEventHandler("c_text", function(text, time)
  ClearPrints()
  SetTextEntry_2("STRING")
  AddTextComponentString(text)
  DrawSubtitleTimed(time, 1)
end)
