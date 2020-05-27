RegisterNetEvent('JAM_Pillbox:DoNotify')
RegisterNetEvent('JAM_Pillbox:GetTreated')

ESX                           = nil
local PlayerData              = {}

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
    PlayerData = ESX.GetPlayerData()
  end

  while PlayerData.job == nil do
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(100)
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

local JPB = JAM_Pillbox
Citizen.CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustPressed(1, 38) and PlayerData.job.name == 'ambulance' then
        	JPB:TreatPlayer()
        end       
    end
end)



function JPB:Start()
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end

  --self:DrawBlips()
  self:Update()
end

function Draw3DText(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function JPB:Update()
  while true do
    Citizen.Wait(0)
    local plyPed = GetPlayerPed(-1)
    local plyPos = GetEntityCoords(plyPed)
    local dist = Utils:GetVecDist(plyPos, self.HospitalPosition)
    if dist < self.LoadZoneDist then
      local closestKey,closestVal,closestDist = self:GetClosestAction(plyPos)
      if closestDist < self.DrawTextDist then
        local pos = closestVal
        local rot = self.BedRotations[closestVal] or false
        if closestKey == 1 then
          if self.PatientID then 
            Draw3DText(pos.x,pos.y,pos.z, 'Press [~r~E~s~] to check yourself out')
          else
            Draw3DText(pos.x,pos.y,pos.z, self.ActionText[closestKey])
          end
        elseif closestKey == 2 then
          if not self.LayingDown then
            Draw3DText(pos.x,pos.y,pos.z, self.ActionText[closestKey])
          end
        end
        if closestDist < self.InteractDist then
          if Utils:GetKeyPressed("E") then
            self:DoAction(self.Actions[closestKey], pos or false, rot or false)
          end
        end
      end
    else
      if self.PatientID then
        self:CheckPlayerOut()
      end
    end
  end
end

function JPB:DoAction(action, pos, rot)
  local plyPed = GetPlayerPed(-1)
  if action == "Check In" then
    if self.PatientID then
      self:CheckPlayerOut()
    else
      ESX.TriggerServerCallback('JAM_Pillbox:GetCapacity', function(capacity,id)
        if capacity >= self.MaxCapacity then
          exports['mythic_notify']:DoHudText('error', 'The hospital is currently full!')
        else
          self:CheckPlayerIn(id)
        end
      end)
    end
  elseif action == "Lay Down" and pos and rot then
    self.LayingDown = not self.LayingDown
    if self.LayingDown then
      self:PutInBed(plyPed,pos,rot.y)
    end
  end
end

function JPB:PutInBed(ped,pos,heading)
    DoScreenFadeOut(950)
    Wait(1000)
    SetEntityCoordsNoOffset(ped, pos, 0, 0, 0)
    SetEntityHeading(ped, heading)
    ESX.TriggerServerCallback('JAM_Pillbox:GetOnlineEMS', function(count)
      local animTime = self.AutoHealTimer * 1000
      if count then animTime = -1; end

      ESX.Streaming.RequestAnimDict("missfbi5ig_0",function()
        TaskPlayAnim(ped, "missfbi5ig_0", "lyinginpain_loop_steve", 8.0, 1.0, animTime, 45, 1.0, 0, 0, 0)
      end)

      Citizen.CreateThread(function(...) 
        while self.LayingDown do
          Citizen.Wait(0)
          DisableControls() -- DISABLE ALL KEYS
        end
      end)

      Wait(1000)
      DoScreenFadeIn(10000)

      if not count or count < self.MinEMSCount then
        print("Debug: No EMS Online")
        if self.UsingProgressBars then 
          exports['progressBars']:startUI((self.AutoHealTimer - 2) * 5000, "Healing")
        end

        Wait((self.AutoHealTimer - 2) * 5000)

        DoScreenFadeOut(950)
        Wait(1000)

        SetEntityHealth(ped,200)
        ClearPedBloodDamage(ped)
        ResetPedVisibleDamage(ped)
        ClearPedTasksImmediately(ped)

        if self.UsingSkeletalSystem then
          TriggerEvent('mythic_hospital:client:RemoveBleed', target) 
          TriggerEvent('mythic_hospital:client:ResetLimbs', target)
          --TriggerEvent('MF_SkeletalSystem:HealBones', "all")
        end

        if self.UsingBasicNeeds then
          TriggerEvent('esx_basicneeds:healPlayer')
        end

        local newPos = self.GetUpLocations[pos]
        SetEntityCoords(ped,newPos.x,newPos.y,newPos.z)
        SetEntityHeading(ped,newPos.w)

        Wait(1000)
        DoScreenFadeIn(1000)
        self.LayingDown = false
      else
        TriggerServerEvent('JAM_Pillbox:NotifyEMS')
        print("Debug: EMS Notified")

        local emsWaitTime = (((self.AutoHealTimer + 1) * self.OnlineEMSTimerMultiplier) * 1000)

        if self.UsingProgressBars then
          exports['progressBars']:startUI(emsWaitTime, "Sit tight, wait for an EMS")
        end

        local timer = GetGameTimer()
        while (GetGameTimer() - timer) < (((self.AutoHealTimer + 1)*self.OnlineEMSTimerMultiplier) * 1000) and not self.BeingTreated do
          Citizen.Wait(0)
          timer3 = GetGameTimer() - timer
        end
        
        exports['progressBars']:closeUI()
        if not self.BeingTreated then

          if self.UsingProgressBars then
            Citizen.Wait(500)
            exports['progressBars']:startUI((self.AutoHealTimer - 2) * 1000, "No EMS, Self healing.")
          end

          Wait((self.AutoHealTimer - 2) * 1000)

          DoScreenFadeOut(950)
          Wait(1000)

          SetEntityHealth(ped,200)
          ClearPedBloodDamage(ped)
          ResetPedVisibleDamage(ped)
          ClearPedTasksImmediately(ped)

          if self.UsingSkeletalSystem then
            TriggerEvent('mythic_hospital:client:RemoveBleed', target) 
            TriggerEvent('mythic_hospital:client:ResetLimbs', target)
            --TriggerEvent('MF_SkeletalSystem:HealBones', "all")
          end

          if self.UsingBasicNeeds then
            TriggerEvent('esx_basicneeds:healPlayer')
          end

          local newPos = self.GetUpLocations[pos]
          SetEntityCoords(ped,newPos.x,newPos.y,newPos.z)
          SetEntityHeading(ped,newPos.w)

          Wait(1000)
          DoScreenFadeIn(1000)
          self.LayingDown = false
        else
          if self.UsingProgressBars then
            Citizen.Wait(500)
            exports['progressBars']:startUI(self.HealingTimer * 1000, "You are being attended to.")
          end

          Wait((self.HealingTimer - 2) * 1000)

          DoScreenFadeOut(950)
          Wait(1000)

          SetEntityHealth(ped,200)
          ClearPedBloodDamage(ped)
          ResetPedVisibleDamage(ped)
          ClearPedTasksImmediately(ped)

          if self.UsingSkeletalSystem then
            TriggerEvent('mythic_hospital:client:RemoveBleed', target) 
            TriggerEvent('mythic_hospital:client:ResetLimbs', target)
            --TriggerEvent('MF_SkeletalSystem:HealBones', "all")
          end

          if self.UsingBasicNeeds then
            TriggerEvent('esx_basicneeds:healPlayer')
          end

          local newPos = self.GetUpLocations[pos]
          SetEntityCoords(ped,newPos.x,newPos.y,newPos.z)
          SetEntityHeading(ped,newPos.w)

          Wait(1000)
          DoScreenFadeIn(1000)
          self.LayingDown = false
        end
      end
    end)      
end

function JPB:CheckPlayerIn(id)
    self.PatientID = id
    local canDo = false
    ESX.TriggerServerCallback('esx_ambulancejob:getDeathStatus', function(isDead)
      self.ActionMarkers[#self.ActionMarkers+1] = self.BedLocations[id]
      if isDead then
        Citizen.CreateThread(function(...)
  
          TriggerServerEvent('tp_ambulancejob:setDeathStatus', false)
          DoScreenFadeOut(4500)
          Wait(5000)
          TriggerEvent('tp_ambulancejob:revive')
          local timer = GetGameTimer()
          while (GetGameTimer() - timer) < 2000 do
            Citizen.Wait(0)
            DoScreenFadeOut(1)
          end
  
          local loc = self.BedLocations[id]
          local rot = self.BedRotations[loc]
          self:PutInBed(GetPlayerPed(-1),loc,rot.y)
          self.LayingDown = true
          canDo = true
        end)
      else
        canDo = true
      end
    end)
  
    while not canDo do Citizen.Wait(0); end
    TriggerServerEvent('JAM_Pillbox:CheckIn',id)
  
    if self.UseHospitalClothing then
      local plyPed = GetPlayerPed(-1)
      TriggerEvent('skinchanger:getSkin', function(skin)
      	DisableControlAction(0, 38, true)
          exports['mythic_progbar']:Progress({
              name = "hospital_action",
              duration = 10500,
              label = "Checking In",
              useWhileDead = true,
              canCancel = true,
              controlDisables = {
                  disableMovement = true,
                  disableCarMovement = true,
                  disableMouse = false,
                  disableCombat = true,
              },
              animation = {
                  animDict = "missheistdockssetup1clipboard@base",
                  anim = "base",
                  flags = 49,
              },
              prop = {
                  model = "p_amb_clipboard_01",
                  bone = 18905,
                  coords = { x = 0.10, y = 0.02, z = 0.08 },
                  rotation = { x = -80.0, y = 0.0, z = 0.0 },
              },
              propTwo = {
                  model = "prop_pencil_01",
                  bone = 58866,
                  coords = { x = 0.12, y = 0.0, z = 0.001 },
                  rotation = { x = -150.0, y = 0.0, z = 0.0 },
              },
          }, function(status)
                if not status then
                    if skin.sex == 0 then
                       --TriggerEvent('skinchanger:loadClothes', skin, JPB.Outfits['patient_wear'].male)
                       DisableControlAction(0, 38, false)
                       exports['mythic_notify']:SendAlert('inform', 'Proceed to the ward and find your assigned bed.', 15000)
                    else
                       --TriggerEvent('skinchanger:loadClothes', skin, JPB.Outfits['patient_wear'].female)
                       DisableControlAction(0, 38, false)
                       exports['mythic_notify']:SendAlert('inform', 'Proceed to the ward and find your assigned bed.', 15000)
                    end
                end
            end)
        end)
    end
end

function JPB:CheckPlayerOut()
    TriggerServerEvent('JAM_Pillbox:CheckOut',self.PatientID)
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
        DisableControlAction(0, 38, true)
        exports['mythic_progbar']:Progress({
                name = "hospital_action",
                duration = 10500,
                label = "Checking Out",
                useWhileDead = true,
                canCancel = true,
                controlDisables = {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                },
                animation = {
                    animDict = "missheistdockssetup1clipboard@base",
                    anim = "base",
                    flags = 49,
                },
                prop = {
                    model = "p_amb_clipboard_01",
                    bone = 18905,
                    coords = { x = 0.10, y = 0.02, z = 0.08 },
                    rotation = { x = -80.0, y = 0.0, z = 0.0 },
                },
                propTwo = {
                    model = "prop_pencil_01",
                    bone = 58866,
                    coords = { x = 0.12, y = 0.0, z = 0.001 },
                    rotation = { x = -150.0, y = 0.0, z = 0.0 },
                },
            }, function(status)
                  if not status then
                      --TriggerEvent('skinchanger:loadSkin', skin)
                      DisableControlAction(0, 38, false)
                  end   
                end)
    end)
    table.remove(self.ActionMarkers, #self.ActionMarkers)
    self.PatientID = false
    self.LayingDown = false
end

function JPB:GetClosestAction(plyPos)
  local plyPos = plyPos
  local closestKey,closestVal,closestDist
  for k,v in pairs(self.ActionMarkers) do
    if v then
      local dist = Utils:GetVecDist(plyPos,v)
      if not closestDist or dist < closestDist then
        closestKey = k
        closestVal = v
        closestDist = dist
      end
    end
  end
  if not closestKey then return false,false,999999
  else return closestKey,closestVal,closestDist
  end
end

function JPB:DrawBlips()
  local blip = AddBlipForCoord(self.HospitalPosition.x, self.HospitalPosition.y, self.HospitalPosition.z)
  SetBlipSprite               (blip, 61)
  SetBlipDisplay              (blip, 3)
  SetBlipScale                (blip, 1.0)
  SetBlipColour               (blip, 1)
  SetBlipAsShortRange         (blip, false)
  SetBlipHighDetail           (blip, true)
  BeginTextCommandSetBlipName ("STRING")
  AddTextComponentString      ("Pillbox Hospital")
  EndTextCommandSetBlipName   (blip)
end

function JPB:TreatPlayer()
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local closestKey,closestVal,closestDist = self:GetClosestBed(plyPos)
  if closestDist < self.InteractDist then
    local closestPly = ESX.Game.GetClosestPlayer(closestVal)
    local closestPed = GetPlayerPed(closestPly)
    if closestPed ~= plyPed then

      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Wait(5000)
      TriggerServerEvent('JAM_Pillbox:TreatPlayer', GetPlayerServerId(closestPly))
      Wait(5000)
      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, false)
      Wait(1000)
      ClearPedTasksImmediately(plyPed)
      Wait(500)
      exports['mythic_notify']:SendAlert('inform', 'Your patient has been treated!', 15000)
    end
  end
end

function JPB:GetClosestBed(plyPos)
  local key,val,dist
  for k,v in pairs(self.BedLocations) do
    local nDist = Utils:GetVecDist(plyPos,v)
    if not dist or nDist < dist then
      key = k
      val = v
      dist = nDist
    end
  end
  if key then return key,val,dist
  else return false,false,false
  end
end

function DisableControls()
  DisableControlAction(0, 32, true) -- W
  DisableControlAction(0, 34, true) -- A
  DisableControlAction(0, 31, true) -- S
  DisableControlAction(0, 30, true) -- D
  DisableControlAction(0, 24, true) -- Attack
  DisableControlAction(0, 257, true) -- Attack 2
  DisableControlAction(0, 25, true) -- Aim
  DisableControlAction(0, 263, true) -- Melee Attack 1
  DisableControlAction(0, 45, true) -- Reload
  DisableControlAction(0, 22, true) -- Jump
  DisableControlAction(0, 44, true) -- Cover
  DisableControlAction(0, 37, true) -- Select Weapon
  DisableControlAction(0, 23, true) -- Also 'enter'?
  DisableControlAction(0, 288,  true) -- Disable phone
  DisableControlAction(0, 289, true) -- Inventory
  DisableControlAction(0, 170, true) -- Animations
  DisableControlAction(0, 167, true) -- Job
  DisableControlAction(0, 73, true) -- Disable clearing animation
  DisableControlAction(2, 199, true) -- Disable pause screen
  DisableControlAction(0, 59, true) -- Disable steering in vehicle
  DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
  DisableControlAction(0, 72, true) -- Disable reversing in vehicle
  DisableControlAction(2, 36, true) -- Disable going stealth
  DisableControlAction(0, 47, true)  -- Disable weapon
  DisableControlAction(0, 264, true) -- Disable melee
  DisableControlAction(0, 257, true) -- Disable melee
  DisableControlAction(0, 140, true) -- Disable melee
  DisableControlAction(0, 141, true) -- Disable melee
  DisableControlAction(0, 142, true) -- Disable melee
  DisableControlAction(0, 143, true) -- Disable melee
  DisableControlAction(0, 75, true)  -- Disable exit vehicle
  DisableControlAction(27, 75, true) -- Disable exit vehicle
end

Citizen.CreateThread(function(...) JPB:Start(...); end)

AddEventHandler('JAM_Pillbox:DoNotify', function(...) exports['mythic_notify']:SendAlert('error', 'Someone is in need of treatment at Pillbox, Please respond, Do not ignore.', 60000); end)
AddEventHandler('JAM_Pillbox:GetTreated', function(...) JPB.BeingTreated = true; end)

RegisterCommand('treatPlayer', function(...) JPB:TreatPlayer(...); end)