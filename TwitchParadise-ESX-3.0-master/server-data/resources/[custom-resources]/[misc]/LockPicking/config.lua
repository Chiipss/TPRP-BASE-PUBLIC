MF_LockPicking = {}
local MFL = MF_LockPicking
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

MFL.LockTolerance = 10.0
MFL.TextureDict = "MF_LockPicking"
MFL.AudioBank = "SAFE_CRACK"