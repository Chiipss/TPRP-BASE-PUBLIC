robbery.awake = function()
  while not ESX do Wait(0); end
  while not ESX.IsPlayerLoaded do Wait(0); end
  local resName = GetCurrentResourceName()
  ESX.TriggerServerCallback(resName..':getStartData', function(cops)
    robbery.cops = cops
    robbery.start()
  end)
end

robbery.start = function()
  if Config.ShowBlip then robbery.setupBlips(); end
  RequestStreamedTextureDict("mpleaderboard")
  robbery.plyData = ESX.GetPlayerData()
  robbery.update()
end

robbery.setupBlips = function()
  for k,v in pairs(Config.Entrys) do
    local blip = AddBlipForCoord(v.x, v.y, v.z)
    SetBlipDisplay              (blip, Config.BlipDisplay)
    SetBlipScale                (blip, Config.BlipScale)
    SetBlipColour               (blip, Config.BlipCol)
    SetBlipSprite               (blip, Config.BlipSprite)
    SetBlipAsShortRange         (blip, Config.BlipShort)
    SetBlipAlpha                (blip, Config.BlipAlpha)
    BeginTextCommandSetBlipName ("STRING")
    AddTextComponentString      (Config.BlipText)
    EndTextCommandSetBlipName   (blip)
  end
end

robbery.soundLevel = 0.0
robbery.lastKeyPress = 0

robbery.update = function()
  while true do
    if not robbery.inHouse then
      local closest,closestDist = robbery.getClosestEntry()
      if closestDist < Config.ActDist then
        if robbery.cops and robbery.cops >= Config.MinCopsOnline and not robbery.tryHouse then
          if Config.UseDraw3D then
            if robbery.plyData.job.name == Config.PoliceJob then
              ESX.Game.Utils.DrawText3D(closest, "Press [E] To Raid Property.",1,7)
            else
              ESX.Game.Utils.DrawText3D(closest, "Press [E] To Break In.",1,7)
            end
          end
          if IsControlJustReleased(0, 38) then
            Wait(1000)
            robbery.tryEnter(closest)
          end
        end
      end
    else
      local exitDist =  utils.vecDist(robbery.inHouse.exit,GetEntityCoords(GetPlayerPed(-1)))
      if exitDist and exitDist < Config.ActDist then
        if Config.UseDraw3D then
          ESX.Game.Utils.DrawText3D(robbery.inHouse.exit.xyz + vector3(0.0,0.0,1.0), "Press [E] To Leave.",1,7)
        else
          ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to leave.")
        end
        if IsControlJustReleased(0, 38) then
          robbery.doLeave()
        end
      end

      if robbery.plyData.job.name ~= Config.PoliceJob then
        local closest,closestDist = robbery.getClosestLoot()
        if closestDist < Config.ActDist then
          if Config.UseDraw3D then
            local pos = (robbery.inHouse.exit.xyz + closest)
            ESX.Game.Utils.DrawText3D(pos, "Press [E] to try loot the "..robbery.currentInterior.loot[closest].tab..".",1,7)
          else
            ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to try loot the "..robbery.currentInterior.loot[closest].tab..".")
          end

          local time = GetGameTimer()
          if IsControlJustPressed(0, 38) and ((time - robbery.lastKeyPress) > 500) then
            robbery.lastKeyPress = time
            robbery.tryLoot(closest)
          end
        end
      end
    end
    if robbery.plyData.job and robbery.plyData.job.name ~= Config.PoliceJob then
      robbery.getSoundLevel()
    end
    Wait(0)
  end
end

robbery.getSoundLevel = function()
    if robbery.inHouse then
      local plyPed = GetPlayerPed(-1)
      local speed = math.floor( utils.vecLength(GetEntityVelocity(plyPed)))
      local isStealth = GetEntitySpeed(plyPed)
      local isShooting = IsPedShooting(plyPed)
      local soundAdder = 0.02
      local soundTaker = 0.01
      if isStealth <= 1.4 then
        if speed > 0 then
          robbery.soundLevel = math.min(100.0,robbery.soundLevel + soundAdder)
        else          
          robbery.soundLevel = math.max(0.0,robbery.soundLevel - (soundTaker * 2.0))
        end
      elseif isStealth >= 1.5 then
        if speed > 1 then
          robbery.soundLevel = math.min(100.0,robbery.soundLevel + (soundAdder * 10.0))
        elseif speed > 0 then          
          robbery.soundLevel = math.min(100.0,robbery.soundLevel + (soundAdder * 5.0))
        else
          robbery.soundLevel = math.max(0.0,robbery.soundLevel - soundTaker)
        end
      end

    if isShooting then
      if not robbery.lastShot or (GetGameTimer() - robbery.lastShot) > 1000 then
        robbery.lastShot = GetGameTimer()
        robbery.soundLevel = math.min(100.0,robbery.soundLevel + 50.0)
      end
    end

    DrawRect(0.9,0.8, 0.010, 0.2, 15,15,15, 0.5)
    DrawRect(0.9,0.8, 0.009, 0.2*( (robbery.soundLevel or 50.0) /100.0), 155,15,15, 0.5)

    local sprite = "leaderboard_audio_3"
    if robbery.soundLevel >= 99.0 then
      if robbery.inHouse and not robbery.inHouse.pedAttacked then
        robbery.inHouse.pedAttacked = true
        if DoesEntityExist(robbery.inHouse.ped) and not IsEntityDead(robbery.inHouse.ped) then
          TriggerServerEvent('robbery:alert',robbery.inHouse.entry)
          TriggerServerEvent('robbery:pedAttack',robbery.inHouse.entry,robbery.inHouse.exit)
        end
      end
    elseif robbery.soundLevel > 80.0 then
      if not robbery.lastWarn or ((GetGameTimer() - robbery.lastWarn) > 5000) then
        robbery.lastWarn = GetGameTimer()
        exports['mythic_notify']:SendAlert('error', 'Youre making alot of noise!', 10000)
        --ESX.ShowNotification("~r~You're making alot of noise!~s~")
      end
    elseif robbery.soundLevel > 40.0 then
      sprite = "leaderboard_audio_2"
    else
      sprite = "leaderboard_audio_1"
    end

    DrawSprite("mpleaderboard",sprite,0.9,0.67, 0.025, 0.05, 0.0, 155,15,15, 1.0)
  else
    robbery.soundLevel = math.max(0.0,robbery.soundLevel - 0.01) 
  end
  return robbery.soundLevel
end

robbery.getClosestLoot = function()
  local closest,closestDist
  local pos = GetEntityCoords(GetPlayerPed(-1))
  if robbery.inHouse and robbery.inHouse.exit then
    local t = robbery.inHouse.exit
    for k,v in pairs(robbery.currentInterior.loot) do
      local dist =  utils.vecDist(pos,robbery.inHouse.exit.xyz + k)
      if not closestDist or dist < closestDist then
        closestDist = dist
        closest = k
      end
    end
  end
  if closest and closestDist then
    return closest,closestDist
  else
    return false,99999
  end
end

robbery.getClosestEntry = function()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local closest,closestDist
  for k,v in pairs(Config.Entrys) do
    local dist =  utils.vecDist(pos,v)
    if not closestDist or dist < closestDist then
      closestDist = dist
      closest = v
    end
  end
  if closest and closestDist then
    return closest,closestDist
  else
    return false,9999
  end
end

robbery.tryEnter = function(loc)
  ESX.TriggerServerCallback('robbery:getHouseData', function(data)
  if data and data.locked then
    robbery.plyData = ESX.GetPlayerData()
    local job = robbery.plyData.job
    if job and job.name == Config.PoliceJob then
      robbery.doEnter(loc)
    else
      local inv = ESX.GetPlayerData().inventory;
      local found = false
      if Config.NeedLockpick then
        for key,val in pairs(inv) do
          if val.name == Config.LockpickItemName then
            if val.count and val.count > 0 then
              found = true
            else
              if val.count and val.count <= 0 then
                exports['mythic_notify']:SendAlert('error', 'You dont have a lockpick', 10000)
                return
              end
            end
          end
        end
      end
      hour = GetClockHours()
      if hour >= 0 and hour <= 8 then
        print(hour) 
        if found or not Config.NeedLockpick then
          robbery.tryHouse = loc
          while not HasAnimDictLoaded("mini@safe_cracking") do RequestAnimDict("mini@safe_cracking"); Citizen.Wait(0); end
            TaskPlayAnim(GetPlayerPed(-1), "mini@safe_cracking", "idle_base", 8.0, 8.0, -1, 1, 0, 0, 0, 0 )
              if Config.MinigameForEntry then
                Citizen.Wait(1000)
                robbery.currentInterior = data
                TriggerEvent('lockpicking:StartMinigame', 5, 'robbery:lockpickResult')
              else
                robbery.currentInterior = data
                local wTime = (Config.TimeForLockpick and Config.TimeForLockpick*1000 or 5000)
                if Config.UsingProgressBar then exports["progressBars"]:startUI(wTime,"Lockpicking..."); end
                Citizen.Wait(wTime)
                if Config.NeedLockpick and Config.TakeLockpick then
                  TriggerServerEvent('robbery:takeLockpick')
                end
                robbery.lockpickResult(true)
              end
            end
        else
          exports['mythic_notify']:SendAlert('error', 'Dont you think its a little bright out?', 10000)
        end
      end
    else
      robbery.doEnter(loc)
      robbery.currentInterior = data
    end
  end,loc)
end

robbery.lockpickResult = function(res)
  ClearPedTasksImmediately(GetPlayerPed(-1))
  if res then
    print("TRY HOUSE: "..tostring(robbery.tryHouse))
    robbery.doEnter(robbery.tryHouse)
    TriggerServerEvent('robbery:unlockHouse',robbery.tryHouse)
    robbery.tryHouse = nil
  else
    exports['mythic_notify']:SendAlert('error', 'You alerted the police', 10000)
    --ESX.ShowNotification("You alerted the police.")
    TriggerServerEvent('robbery:alert',robbery.tryHouse)
    robbery.tryHouse = nil
  end
end

robbery.doEnter = function(loc)
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do Citizen.Wait(10); end

  local pedHash = GetHashKey("PLAYER")
  local copHash = GetHashKey("COP")

  robbery.plyData = ESX.GetPlayerData()
  if robbery.plyData.job.name == Config.PoliceJob then
    local ped = GetPlayerPed(-1)
    SetPedRelationshipGroupHash(ped,copHash)
    SetPedRelationshipGroupDefaultHash(ped,copHash)
  else
    local ped = GetPlayerPed(-1)
    SetPedRelationshipGroupHash(ped,plyHash)
    SetPedRelationshipGroupDefaultHash(ped,plyHash)    
  end

  TriggerEvent('vSync:toggle',false) 
  SetWeatherTypePersist('EXTRASUNNY') 
  SetWeatherTypeNow('EXTRASUNNY')
  SetWeatherTypeNowPersist('EXTRASUNNY')
  NetworkOverrideClockTime(23, 0, 0)

  local nP = {x = loc.x, y = loc.y, z = loc.z - 20.0, h = loc.w - 45.0}
  local house = exports.mythic_interiors:CreateTier1HouseFurnished(nP, false)
  while not house or not house[1] do Citizen.Wait(0); end
  robbery.inHouse = {}
  for k,v in pairs(house) do
    if v and v.backdoor then
      robbery.inHouse["offsets"] = v
    else 
      robbery.inHouse["objects"] = v
    end
  end

  robbery.inHouse.entry = loc
  robbery.inHouse.exit = vector4(nP.x + 3.69, nP.y - 15.08, nP.z + 1.5, nP.h)

  if robbery.lastHouse and robbery.lastHouse.exit ~= robbery.inHouse.exit then
    robbery.soundLevel = 0.0
  end

  robbery.lastHouse = robbery.inHouse

  ESX.TriggerServerCallback('robbery:getPed', function(spawnPed,spawnLoc)
    if spawnPed then
      robbery.spawnPed(spawnLoc)
    end
  end,loc,robbery.inHouse.exit)
end

robbery.doLeave = function()
  local loc = robbery.inHouse.entry
  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do Citizen.Wait(10); end

  robbery.plyData = ESX.GetPlayerData()
  local plyJob = robbery.plyData.job
  if plyJob.name ~= Config.PoliceJob then
    TriggerServerEvent('robbery:leave', loc)
  end

  TriggerEvent('vSync:toggle',true) 
  TriggerServerEvent('vSync:requestSync')

  local plyPed = GetPlayerPed(-1)
  SetEntityCoords(plyPed, loc.x, loc.y, loc.z-1.0, 0, 0, 0, false)
  SetEntityHeading(plyPed, loc.w)

  Citizen.Wait(100)

  for k,v in pairs(robbery.inHouse.objects) do
    SetEntityAsMissionEntity(v,true,true)
    DeleteObject(v)
    DeleteEntity(v)
  end

  DoScreenFadeIn(1000)
  robbery.inHouse = nil
end

robbery.pedAttacked = function(pos)
  robbery.inHouse.pedAttacked = true

  local hash = GetHashKey("csb_jackhowitzer")
  RequestModel(hash)
  while not HasModelLoaded(hash) do RequestModel(hash); Wait(10); end

  local ped = CreatePed(4, hash, pos.x,pos.y,pos.z, 273.0, true,false)
  robbery.inHouse.ped = ped
  FreezeEntityPosition(ped,true)

  local dict = 'mp_bedmid'
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do Citizen.Wait(0); end

  TaskPlayAnim(ped, dict, 'f_getout_r_bighouse', 8.0, 8.0, -1, 2, true,true,true)
  Wait(700)
  FreezeEntityPosition(ped,false)
  Wait(1300)

  GiveWeaponToPed(ped, GetHashKey("WEAPON_PISTOL50"), 1000, false,true)
  SetPedDropsWeaponsWhenDead(ped,false)

  local relHash = GetHashKey("HATES_PLAYER")
  local plyHash = GetHashKey("PLAYER")
  local copHash = GetHashKey("COP")

  SetRelationshipBetweenGroups(5, relHash, plyHash)
  SetRelationshipBetweenGroups(5, plyHash, relHash)
  SetRelationshipBetweenGroups(2, copHash, relHash)
  SetRelationshipBetweenGroups(2, relHash, copHash)

  SetPedRelationshipGroupHash(ped,relHash)
  SetPedRelationshipGroupDefaultHash(ped,relHash)

  TaskCombatPed(ped, GetPlayerPed(-1), 0, 16)

  Citizen.CreateThread(function()
    Wait(120000)
    SetEntityAsNoLongerNeeded(ped)
  end)
end

robbery.delPed = function(loc)
  if robbery.inHouse and robbery.inHouse.ped and robbery.inHouse.entry.xyz == loc.xyz then
    robbery.inHouse.pedAttacked = true
    SetEntityAsMissionEntity(robbery.inHouse.ped,true,true)
    DeleteEntity(robbery.inHouse.ped)
  end
end

robbery.tryLoot = function(pos)
  ESX.TriggerServerCallback('robbery:tryLoot', function(looted)
    local plyPed = GetPlayerPed(-1)
    if not looted then
      FreezeEntityPosition(plyPed,true)
      if Config.UsingProgressBar then
        exports.progressBars:startUI(Config.InteractTimer * 1000, "Searching")
      end
      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Wait(Config.InteractTimer * 1000)

      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, false)
      Wait(1500)

      ClearPedTasksImmediately(plyPed)
      TriggerServerEvent('robbery:looted',robbery.currentInterior.loot[pos].tab,robbery.currentInterior.difficulty)
    else
      ESX.ShowNotification("There is nothing to loot here.")
    end
    FreezeEntityPosition(plyPed,false)
  end, robbery.inHouse.entry, pos)
end

robbery.alertPolice = function(pos)
  robbery.plyData = ESX.GetPlayerData()
  if robbery.plyData.job.name == Config.PoliceJob then
    Citizen.CreateThread(function(...)
      ESX.ShowNotification("Somebody is trying to break into a house! [~r~H~s~]")
      local startTime = GetGameTimer()
      while (GetGameTimer() - startTime) < 10 * 1000 do
        if IsControlJustPressed(0, 104) then
          SetNewWaypoint(pos.x,pos.y)
          break
        end
        Wait(0)
      end
    end)
  end
end

robbery.spawnDog = function(loc)
  local forward = GetEntityForwardVector(GetPlayerPed(-1))
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local nPos = pos + (forward * 10)
  local found,z = GetGroundZFor_3dCoord(nPos.x,nPos.y,nPos.z)

  local hash = GetHashKey("a_c_rottweiler")
  RequestModel(hash)
  while not HasModelLoaded(hash) do RequestModel(hash); Wait(10); end

  local relHash = GetHashKey("HATES_PLAYER")
  local plyHash = GetHashKey("PLAYER")
  local copHash = GetHashKey("COP")

  local dog = CreatePed(28, hash, nPos.x,nPos.y,(found and z or nPos.z), 0.0, true,false)

  SetPedRelationshipGroupHash(dog,relHash)
  SetPedRelationshipGroupDefaultHash(dog,relHash)

  SetRelationshipBetweenGroups(5, relHash, plyHash)
  SetRelationshipBetweenGroups(5, plyHash, relHash)
  SetRelationshipBetweenGroups(2, copHash, relHash)
  SetRelationshipBetweenGroups(2, relHash, copHash)

  TaskCombatPed(dog,GetPlayerPed(-1),0,16)

  Citizen.CreateThread(function()
    Wait(30000)
    SetEntityAsNoLongerNeeded(dog)
  end)
end

robbery.spawnPed = function(pos)
  local hash = GetHashKey("csb_jackhowitzer")
  RequestModel(hash)
  while not HasModelLoaded(hash) do RequestModel(hash); Wait(10); end

  local ped = CreatePed(4, hash, pos.x,pos.y,pos.z, 273.0, false,false)
  robbery.inHouse.ped = ped
  FreezeEntityPosition(ped,true)

  SetEntityInvincible(ped,true)

  local dict = 'mp_bedmid'
  RequestAnimDict(dict)
  while not HasAnimDictLoaded(dict) do Citizen.Wait(0); end

  SetBlockingOfNonTemporaryEvents(ped, true)
  TaskSetBlockingOfNonTemporaryEvents(ped, true)

  TaskPlayAnim(ped, dict, 'f_sleep_r_loop_bighouse', 8.0, 8.0, -1, 2, false,false,false)
end

robbery.setCops = function(count)
  robbery.cops = count
end

robbery.setJob = function(job)
  if not robbery.plyData then return; end
  if robbery.plyData.job and robbery.plyData.job.name == Config.PoliceJob then
    if job and job.name ~= Config.PoliceJob then
      TriggerServerEvent('robbery:removeCop')
    end
  else
    if job and job.name == Config.PoliceJob then
      TriggerServerEvent('robbery:addCop')
    end
  end
  robbery.plyData.job = job
end

utils.event(true,robbery.setJob,'esx:setJob')
utils.event(true,robbery.setCops,'robbery:setCops')
utils.event(true,robbery.delPed,'robbery:delPed')
utils.event(true,robbery.pedAttacked,'robbery:delPed')
utils.event(true,robbery.pedAttacked,'robbery:pedAttacked')
utils.event(true,robbery.spawnDog,'robbery:spawnDog')
utils.event(true,robbery.alertPolice,'robbery:alertPolice')
utils.event(false,robbery.lockpickResult,'robbery:lockpickResult')

utils.thread(robbery.awake)