ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


RegisterNetEvent('useparachute')
AddEventHandler('useparachute',function()
  if not HasPedGotWeapon(GetPlayerPed(-1), GetHashKey("GADGET_PARACHUTE"), false) then
    giveParachute()
    TriggerServerEvent('parachute:equip')
  else
    TriggerEvent('esx:showNotification', "You already have a parachute")
  end
end)

function giveParachute()
  GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("GADGET_PARACHUTE"), 150, true, true)
end




