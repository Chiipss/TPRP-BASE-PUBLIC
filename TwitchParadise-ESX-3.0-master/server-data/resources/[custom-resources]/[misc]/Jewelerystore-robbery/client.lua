-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

RegisterNetEvent('MF_Vangelico:NotifyPolice')
RegisterNetEvent('MF_Vangelico:SyncLoot')
RegisterNetEvent('MF_Vangelico:SyncCops')

local MFV = MF_Vangelico
MFV.PoliceOnline = 0
function MFV:Start(...)
  self.SoundID    = GetSoundId() 
  self.Timer      = GetGameTimer()
  self:SetupBlip()
  self.Looted = {}
  self.CurJob = ESX.GetPlayerData().job
  ESX.TriggerServerCallback('MF_Vangelico:GetLootStatus', function(loot) 
    self.LootRemaining = loot
    for k,v in pairs(self.LootRemaining) do 
      local loot = true
      local noloot = false 
      for k,v in pairs(v) do
        if v == 0 then
          if not loot then
            noloot = true
          else 
            loot = false
          end 
        else
          if noloot then noloot = false; end
          loot = true
        end
      end
      if not loot and noloot then
        self.Looted[k] = true
      end
    end
    if self.dS and self.cS then self:Update(); end
  end)
end

function MFV:Update()
  local tick = 0
  while self.cS and self.dS do
    Citizen.Wait(0)  
    tick = tick + 1
    --if self.CurJob and self.CurJob.name ~= self.PoliceJobName then
      local plyPed = GetPlayerPed(-1)
      local plyPos = GetEntityCoords(plyPed)
      if (Utils:GetVecDist(plyPos, self.VangelicoPosition) < self.LoadZoneDist) and not self.DoingAction then   
        if not self.InZone then     
          self.InZone = true
        end
        if self.PoliceOnline and self.PoliceOnline >= self.MinPoliceOnline then  
          if not self.DeletedSeats then self:DeleteSeats(); end
          local key,val,closestDist,safe = self:GetClosestMarker(plyPos)
          if closestDist < self.InteractDist then
            if not safe then              
              if self.UsingSafe then
                self.UsingSafe = false
                TriggerEvent('MF_SafeCracker:EndGame')
              end
              local lootRemains
              for k,v in pairs(self.LootRemaining[key]) do if v > 0 then lootRemains = true; end; end
              if (not self.Looted or (self.Looted and not self.Looted[key])) and lootRemains then
                Utils:DrawText3D(val.Pos.x,val.Pos.y,val.Pos.z, "Press [~r~E~s~] to break the glass.")
                if Utils:GetKeyPressed("E") then
                  self:Interact(key,val, plyPed,false)
                end
              end
            elseif not self.SafeUsed then          
              Utils:DrawText3D(self.SafePos.x,self.SafePos.y,self.SafePos.z, "Press [~r~E~s~] to attempt to crack the safe.")
              if not self.Interacting and Utils:GetKeyPressed("E") then
                self:Interact(key,val, plyPed,true)
              end
            end
          else
            if self.UsingSafe then
              self.UsingSafe = false
              TriggerEvent('MF_SafeCracker:EndGame')
            end
          end
        else
          if self.UsingSafe then
            self.UsingSafe = false
            TriggerEvent('MF_SafeCracker:EndGame')
          end
          self.InZone = false
          self.DeletedSeats = false
          self.SentCopNotify = false
          Citizen.Wait(1000)
        end
      else
        if self.UsingSafe then
          self.UsingSafe = false
          TriggerEvent('MF_SafeCracker:EndGame')
        end
        self.InZone = false
        self.DeletedSeats = false
        self.SentCopNotify = false
        Citizen.Wait(1000)
      end
    --end
  end
end     

function MFV:DeleteSeats()
  local newPos = vector3(-625.243, -223.44, 37.78)
  TriggerEvent('MF_SafeCracker:SpawnSafe', false, newPos, 0.0)
  self.DeletedSeats = true
  local objects = ESX.Game.GetObjects()
  for k,v in pairs(objects) do
    local model = GetEntityModel(v) % 0x100000000
    if model == self.SeatHash then 
      SetEntityAsMissionEntity(v,false)
      DeleteObject(v)
    end
  end
end

function MFV:SetupBlip()
  local blip = AddBlipForCoord(self.VangelicoPosition.x, self.VangelicoPosition.y, self.VangelicoPosition.z)
  SetBlipSprite               (blip, 439)
  SetBlipDisplay              (blip, 3)
  SetBlipScale                (blip, 0.6)
  SetBlipColour               (blip, 71)
  SetBlipAsShortRange         (blip, false)
  SetBlipHighDetail           (blip, true)
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ("Vangelico")
  EndTextCommandSetBlipName   (blip)
end

function MFV:GetClosestMarker(pos)
  local key,val,dist,safe
  for k,v in pairs(self.MarkerPositions) do
    local curDist = Utils:GetVecDist(pos, v.Pos.xyz)
    if not dist or curDist < dist then
      key = k
      val = v
      dist = curDist
      safe = false
    end
  end

  local curDist = Utils:GetVecDist(pos, self.SafePos)
  if not dist or curDist < dist then
    key = false
    val = false
    dist = curDist
    safe = true
  end

  if not dist then return false,false,false,false
  else return key,val,dist,safe
  end
end

function MFV:Interact(key,val, plyPed, safe)
  if not safe then
    local plySkin
    local plyWeapon = GetCurrentPedWeapon(plyPed)

    local weapHash = GetSelectedPedWeapon(plyPed) % 0x100000000

    local matching = false
    for k,v in pairs(self.MeleeWeapons) do if v == weapHash then matching = true; end; end

    TriggerEvent('skinchanger:getSkin', function(skin) plySkin = skin; end)
    if not matching and plyWeapon then
      self.Looted = self.Looted or {}
      self.Looted[key] = true
      self.DoingAction = true 
      TriggerServerEvent('MF_Vangelico:Loot', key,val)
      local loot = self.LootRemaining[key]

      TaskTurnPedToFaceCoord(plyPed, val.Pos.x, val.Pos.y, val.Pos.z, -1)
      Wait(1500)

      ESX.Streaming.RequestAnimDict('missheist_jewel', function(...)
        TaskPlayAnim( plyPed, "missheist_jewel", "smash_case_tray_a", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )     
      end)
      Wait(500)

      if not HasNamedPtfxAssetLoaded("scr_jewelheist") then RequestNamedPtfxAsset("scr_jewelheist"); end
      while not HasNamedPtfxAssetLoaded("scr_jewelheist") do Citizen.Wait(0); end    

      if not self.SentCopNotify then
        TriggerServerEvent('MF_Vangelico:NotifyCops')
      end

      SetPtfxAssetNextCall("scr_jewelheist")
      StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", val.Pos.x, val.Pos.y, val.Pos.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)                
      PlaySoundFromCoord(-1, "Glass_Smash", val.Pos.x, val.Pos.y, val.Pos.z, 0, 0, 0, 0)
      Wait(25000)

      ClearPedTasksImmediately(plyPed)
      Wait(1000)
      

      self.DoingAction = false
    elseif not plyWeapon then
      ESX.ShowNotification("You need something to break the glass with.")
    elseif matching then
      ESX.ShowNotification("You can't break the glass with this.")      
    end
  else 
    self.SafeUsed = true
    ESX.TriggerServerCallback('MF_Vangelico:GetSafeState', function(canUse)
      if canUse then
        self.UsingSafe = true
        TriggerEvent('MF_SafeCracker:StartMinigame', self.SafeRewards)
        self:SpawnGuardNPC()
      else
        ESX.ShowNotification("Somebody has already cracked this safe.")
      end
    end)
  end
end

function MFV:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    ESX.TriggerServerCallback('MF_Vangelico:GetStartData', function(retVal,cops) self.PoliceOnline = cops; self.dS = true; self.cS = retVal; end)
    while not self.dS do Citizen.Wait(0); end
    self.PlayerData = ESX.GetPlayerData()
    self:Start()
end

function MFV:SpawnGuardNPC()
  TriggerServerEvent('MF_Vangelico:NotifyCops')
  local nearby = ESX.Game.GetPlayersInArea(self.VangelicoPosition, 20.0)

  local hk = GetHashKey('s_m_m_security_01')
  if not HasModelLoaded(hk) then RequestModel(hk); end
  while not HasModelLoaded(hk) do RequestModel(hk); Citizen.Wait(0); end

  for k,v in pairs(nearby) do
    Citizen.CreateThread(function()
      local plyPed = GetPlayerPed(v)
      local plyPos = GetEntityCoords(plyPed)
      local newPed = CreatePed(4, hk, self.BobSpawnPos, 0.0, true, true)

      SetPedRelationshipGroupHash(newPed, GetHashKey("AMBIENT_GANG_MEXICAN"))
      SetPedRelationshipGroupDefaultHash(newPed, GetHashKey("AMBIENT_GANG_MEXICAN"))

      GiveWeaponToPed(newPed, GetHashKey('weapon_stungun'), 1000, false, true)
      SetPedDropsWeaponsWhenDead(newPed,false)

      --TaskGo
      TaskGotoEntityAiming(newPed, plyPed, 3.0, 5.0)
      Wait(5000)

      local timer = GetGameTimer() 
      local dist = Utils:GetVecDist(plyPos,GetEntityCoords(newPed))
      while dist > 10.0 do
        Citizen.Wait(100)
        plyPos = GetEntityCoords(GetPlayerPed(v))
        dist = Utils:GetVecDist(plyPos,GetEntityCoords(newPed))       
      end
      ClearPedTasksImmediately(newPed)
      Citizen.Wait(1000)
      TaskCombatPed(newPed,GetPlayerPed(v), 0, 16)
      TaskShootAtEntity(newPed, GetPlayerPed(v), -1, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
    end)
  end
end

function MFV:DoNotifyPolice(...)
  if not ESX then return; end
  local plyData = ESX.GetPlayerData()
  if plyData.job.name == self.PoliceJobName then
    ESX.ShowNotification('Somebody is robbing Vangelicos jewelry store.')
  end
end

function MFV:DoSyncLoot(loot,new,key)
  if not self.LootRemaining then return; end
  self.LootRemaining = loot
  if key and self.Looted then self.Looted[key] = true; end
  if new then
    self.SafeUsed = false
    self.Looted = {}
  end
end

function MFV:SetJob(job)
  self.CurJob = job;
  local lastData = self.PlayerData
  if lastData.job.name == self.PoliceJobName then
    TriggerServerEvent('MF_Vangelico:CopLeft')
  elseif lastData.job.name ~= self.PoliceJobName and job.name == self.PoliceJobName then
    TriggerServerEvent('MF_Vangelico:CopEnter')
  end
  self.PlayerData = ESX.GetPlayerData()
end

AddEventHandler('MF_Vangelico:NotifyPolice', function(...) MFV:DoNotifyPolice(...); end)
AddEventHandler('MF_Vangelico:SyncLoot', function(loot,new,key) MFV:DoSyncLoot(loot,new,key); end)
AddEventHandler('MF_Vangelico:SyncCops', function(cops) MFV.PoliceOnline = cops; end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) MFV:SetJob(job); end)

Citizen.CreateThread(function(...) MFV:Awake(...); end)