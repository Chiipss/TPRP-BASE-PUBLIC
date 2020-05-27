-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFT = MF_Trackables
local RSC = ESX.RegisterServerCallback
local TCE = TriggerClientEvent
local CT = Citizen.CreateThread

function MFT:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
     -- print("MF_Trackables: Started")
      self:sT()
end

function MFT:ErrorLog(msg) print(msg) end
function MFT:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFT:DSP(val) self.cS = val; end
function MFT:sT(...) 
  if self.dS and self.cS then
    self:Update()
  end
end

function MFT:Update(...) 
  while self.dS and self.cS do 
    Citizen.Wait(0)
  end
end

function MFT.Notify(source,msg,pos,job,mensaje,id)
  TCE('MF_Trackables:DoNotify',source,msg,pos,job,mensaje,id)
end

function MFT.NotifyAll(source,msg,pos,job,mensaje,id)
  TCE('MF_Trackables:DoNotify',-1,msg,pos,job,mensaje,id)
end

function MFT.Respond(source,id)
  TCE('MF_Trackables:Responding',-1,id)
end

NewEvent(true,MFT.Notify,'MF_Trackables:Notify')
NewEvent(true,MFT.NotifyAll,'MF_Trackables:NotifyAll')
NewEvent(true,MFT.Respond,'MF_Trackables:Respond')

CT(function(...) MFT:Awake(...); end)
RSC('MF_Trackables:GetStartData', function(s,c) local m = MFT; while not m.dS or not m.cS do Citizen.Wait(0); end; c(m.cS); end)