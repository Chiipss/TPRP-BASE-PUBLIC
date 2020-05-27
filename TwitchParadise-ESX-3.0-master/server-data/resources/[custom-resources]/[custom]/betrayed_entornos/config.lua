-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_Trackables = {}
local MFT = MF_Trackables

MFT.Version = '1.0.10'

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...)
  while not ESX do 
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end) 
    Citizen.Wait(0)
  end
end)

-- Only edit this.

MFT.PosX,MFT.PosY = 0.20,0.50
MFT.SizeX,MFT.SizeY = 0.22,0.20
