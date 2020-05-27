lockpicking = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

lockpicking.Version = '1.0.11'

lockpicking.LockTolerance = 5.0
lockpicking.UsingLockpickItem = true
lockpicking.TextureDict = "lockpicking"
lockpicking.AudioBank = "SAFE_CRACK"