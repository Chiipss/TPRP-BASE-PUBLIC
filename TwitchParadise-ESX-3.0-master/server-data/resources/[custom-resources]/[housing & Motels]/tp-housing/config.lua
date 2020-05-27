playerhousing = {}
local housing = playerhousing

TriggerEvent('esx:getSharedObject',function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject',function(obj) ESX = obj; end)
    Citizen.Wait(10)
  end
end)

-- If not using JAM Garage, we recommend advanced garage as thats what this mod is setup for.
housing.UsingJamGarage = false
housing.DrawTextDist = 3.0
housing.InteractDist = 1.5
housing.ShowEmptyHouses = true

housing.PoliceJobName = "police"