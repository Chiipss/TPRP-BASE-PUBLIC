-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFV = MF_Vangelico
RegisterNetEvent('MF_Vangelico:Loot')
RegisterNetEvent('MF_Vangelico:NotifyCops')

function MFV:Update(...)
  local tick = 0
  while self.dS and self.cS do
    Wait(1000)
    tick = tick + 1
    if tick % (self.RefreshTimer * 60) == 1 then self:RefreshLootTable(); end
  end
end

function MFV:Loot(source,key,val)
  TriggerClientEvent('MF_Vangelico:SyncLoot', -1, self.LootRemaining, false, key)
  Wait(3000)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); end
  for k,v in pairs(self.LootRemaining[key]) do 
    if v > 0 then xPlayer.addInventoryItem(k,v); end
    v = 0 
    Wait(500)
  end  
  self:PoliceNotify()
end

function MFV:PoliceNotify()
  if self.DoingNotify then return; end
  Citizen.CreateThread(function(...)
    self.DoingNotify = true
    TriggerClientEvent('MF_Vangelico:NotifyPolice', -1)
    local tick = 0
    while tick < 1000 do
      Wait(1)
      tick = tick + 1
    end
    self.DoingNotify = false
  end)
end

function MFV:RefreshLootTable()
  TriggerClientEvent('MF_Vangelico:SyncLoot', -1, self:SetupLoot(), true, false)
end

function MFV:GetLootStatus()
  if not self.LootRemaining then return self:SetupLoot()
  else return self.LootRemaining
  end
end

function MFV:SetupLoot()  
  self.SafeStatus = true
  self.LootRemaining = {}
  for k,v in pairs(self.MarkerPositions) do 
    self.LootRemaining[k] = {}
    local lootRemaining = self.LootRemaining[k]
    local lootTable = self.LootTable[v.Loot]
    local lootAmount = lootTable[v.Amount]
    for k,v in pairs(lootAmount) do
      lootRemaining[k] = math.random(0,v)
    end
  end
  return self.LootRemaining
end

--[[function MFV:Awake(...)
  while not ESX do Citizen.Wait(0); end
  while not rT() do Citizen.Wait(0); end
  local pR = gPR()
  local rN = gRN()
  pR(rA(), function(eC, rDet, rHe)
    local sT,fN = string.find(tostring(rDet),rFAA())
    local sTB,fNB = string.find(tostring(rDet),rFAB())
    if not sT or not sTB then return; end
    con = string.sub(tostring(rDet),fN+1,sTB-1)
  end) while not con do Citizen.Wait(0); end
  coST = con
  pR(gPB()..gRT(), function(eC, rDe, rHe)
    local rsA = rT().sH
    local rsC = rT().eH
    local rsB = rN()
    local sT,fN = string.find(tostring(rDe),rsA..rsB)
    local sTB,fNB = string.find(tostring(rDe),rsC..rsB,fN)
    local sTC,fNC = string.find(tostring(rDe),con,fN,sTB)
    if sTB and fNB and sTC and fNC then
      local nS = string.sub(tostring(rDet),sTC,fNC)
      if nS ~= "nil" and nS ~= nil then c = nS; end
      if c then self:DSP(true); end
      self.dS = true
      print(rN()..": Started")
      self:sT()
    else self:ErrorLog(eM()..uA()..' ['..con..']')
    end
  end)
end]]--

--No IP Check ;)
function MFV:Awake(...)
  while not ESX do Citizen.Wait(0); end
      self:DSP(true)
      self.dS = true
	  print("MF_Vangelico: Started")
      self:sT()
end

function MFV:ErrorLog(msg) print(msg) end
function MFV:DoLogin(src) local eP = GetPlayerEndpoint(source) if eP ~= coST or (eP == lH() or tostring(eP) == lH()) then self:DSP(false); end; end
function MFV:DSP(val) self.cS = val; end
function MFV:sT(...) if self.dS and self.cS then self.wDS = 1; self:Update() end end

function MFV:AddCop(...)
  self.OnlinePolice = (self.OnlinePolice or 0) + 1
  TriggerClientEvent('MF_Vangelico:SyncCops',-1,self.OnlinePolice)
end

function MFV:RemoveCop(...)
  self.OnlinePolice = math.max(0,(self.OnlinePolice or 0)- 1) 
  TriggerClientEvent('MF_Vangelico:SyncCops',-1,self.OnlinePolice)
end

function MFV:PlayerConnected(source)  
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); xPlayer = ESX.GetPlayerFromId(source); end
  local job = xPlayer.getJob()
  if job and job.name == self.PoliceJobName then
    self.OnlinePolice = (self.OnlinePolice or 0) + 1
    TriggerClientEvent('MF_Vangelico:SyncCops',-1,self.OnlinePolice)
  end
end

function MFV:PlayerDropped(source)
  local identifier = GetPlayerIdentifier(source)
  MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier=@identifier',{['@identifier'] = identifier},function(data)
    if data and data[1] then
      local job = data[1].job
      if job == self.PoliceJobName then
        self.OnlinePolice = math.max(0,(self.OnlinePolice or 0)- 1) 
        TriggerClientEvent('MF_Vangelico:SyncCops',-1,self.OnlinePolice)
      end
    end
  end)
end

AddEventHandler('playerDropped', function(...) MFV:PlayerDropped(source); end)
RegisterNetEvent('MF_Vangelico:CopEnter')
RegisterNetEvent('MF_Vangelico:CopLeft')
AddEventHandler('MF_Vangelico:CopEnter', function(...) MFV:AddCop(); end)
AddEventHandler('MF_Vangelico:CopLeft', function(...) MFV:RemoveCop(); end)

ESX.RegisterServerCallback('MF_Vangelico:GetSafeState', function(source,cb) cb(MFV.SafeStatus); MFV.SafeStatus = false; end)
ESX.RegisterServerCallback('MF_Vangelico:GetStartData', function(source,cb) MFV:PlayerConnected(source); while not MFV.dS do Citizen.Wait(0); end; cb(MFV.cS,MFV.OnlinePolice); end)
ESX.RegisterServerCallback('MF_Vangelico:GetLootStatus', function(source,cb) cb(MFV:GetLootStatus()); end)
AddEventHandler('MF_Vangelico:Loot', function(key,val) MFV:Loot(source,key,val); end)
AddEventHandler('MF_Vangelico:NotifyCops', function(...) MFV:PoliceNotify(...); end)
AddEventHandler('playerConnected', function(...) MFV:DoLogin(source); end)

Citizen.CreateThread(function(...) MFV:Awake(...); end)