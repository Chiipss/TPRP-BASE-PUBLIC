-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

RegisterNetEvent('MF_PacificStandard:RefreshBank')
RegisterNetEvent('MF_PacificStandard:OpenDoor')
RegisterNetEvent('MF_SafeCracker:EndMinigame')
RegisterNetEvent('MF_LockPicking:MinigameComplete')
RegisterNetEvent('MF_PacificStandard:NotifyCops')
RegisterNetEvent('MF_PacificStandard:SetCops')

local MFP = MF_PacificStandard

MFP.PoliceOnline = 0
function MFP:Start(...)
    self.PlayerData = ESX.GetPlayerData()
    self.SoundID    = GetSoundId() 
    self.DoorCount  = 0
    if not RequestAmbientAudioBank(self.AudioBank, false) then RequestAmbientAudioBank(self.AudioBankName, false); end
    ESX.TriggerServerCallback('MF_PacificStandard:GetStartData', function(cS,bankData,cops) 
        self.BankData = bankData
        self.PoliceOnline = cops
        for k,v in pairs(self.BankData.DoorLocs) do 
            if v then 
                self.DoorCount = math.min(self.DoorCount + 1,7)
            end
        end
        if cS then self.cS = cS; self.dS = cS; self:Update(); end
    end)
end

function MFP:SpawnSafe()
  self.SafeObject = true
  local newPos = vector3(264.19,207.45,109.59)
  TriggerEvent('MF_SafeCracker:SpawnSafe', false, newPos, 247.0, function(safeObj) self.SafeObject = safeObj; end)
end

function MFP:SpawnCash()
    local pos = vector3(264.24,213.72,101.52)
    local hk = GetHashKey('bkr_prop_bkr_cashpile_04')
    while not HasModelLoaded(hk) do RequestModel(hk); Citizen.Wait(0) end
    self.CashObject = CreateObject(hk, pos.x, pos.y, pos.z, false, false, false)
    SetEntityHeading(self.CashObject, 290.0)
    FreezeEntityPosition(self.CashObject,true)
    SetModelAsNoLongerNeeded(hk)
end

function MFP:Update()
    local tick = 0
    local timer = GetGameTimer()
    local lastKey = GetGameTimer()
    while true do
        Citizen.Wait(0)     
        tick = tick + 1
        local plyPed = GetPlayerPed(-1)
        local plyPos = GetEntityCoords(plyPed)
        local dist = Utils:GetVecDist(plyPos, self.BankLocation)

        if dist < self.LoadDist then
            if not self.BankData or (not self.BankData.DoorLocs or self.DoorCount <= 0) then
                ESX.TriggerServerCallback('MF_PacificStandard:GetBankData', function(bankData) self.BankData = bankData; end)
            end

            if self.BankData and self.BankData.DoorLocs then
                if not self.ZoneLoaded then
                    if not self.CashObject then self:SpawnCash(); end
                    if not self.SafeObject then self:SpawnSafe(); end
                    local allObjs = ESX.Game.GetObjects()
                    local didLock = 0
                    for k,v in pairs(allObjs) do
                        local objPos = GetEntityCoords(v)
                        local closest,closestDist
                        for key,val in pairs(self.BankData.DoorLocs) do
                            local dist = Utils:GetVecDist(objPos,key)
                            if not closestDist or dist < closestDist then
                                closest = k
                                closestDist = dist
                            end
                        end

                        if closestDist < 5.0 then
                            local hKey = GetEntityModel(v)
                            local rKey = hKey % 0x100000000
                            local found = false
                            for key,val in pairs(self.BankData.DoorModels) do
                                if hKey == val or rKey == val then
                                    found = true
                                    locked = self.BankData.DoorLocs[key]
                                end
                            end

                            if found and locked then
                                FreezeEntityPosition(v,true)
                                didLock = didLock + 1
                            else
                            end                          
                        end
                    end  

                    if self.DoorCount >= 0 and didLock >= self.DoorCount then 
                        print("MF_PacificStandard : Locked All Doors")
                        self.ZoneLoaded = true
                    else
                        Citizen.Wait(0)
                    end
                end
            end

            local closestKey,closestVal,closestDis,closestText
            for k,v in pairs(self.Actions) do
                local dist = Utils:GetVecDist(v,plyPos)
                if not closestDis or dist < closestDis then
                    closestKey = k
                    closestVal = v
                    closestDis = dist
                    closestText = self.ActionText[k]
                end
            end


            if self.BankData and closestDis and closestDis < self.InteractDist and not self.DoingAction and self.PoliceOnline and self.PoliceOnline >= self.MinPoliceCount then
                if self.BankData.DoorLocs[closestVal] or self.BankData.LootLocs[closestVal] then
                    Utils:DrawText3D(closestVal.x,closestVal.y,closestVal.z, closestText)

                    if Utils:GetKeyPressed("E") and (GetGameTimer() - lastKey) > 150 then
                        lastKey = GetGameTimer()
                        if not self.DoingAction then
                            self.DoingAction = closestVal
                            self:DoAction(closestKey)
                        end
                    end                  
                end
            end
        else
            if self.ZoneLoaded then 
                self.ZoneLoaded = false 
                if self.SafeObject then
                    for k,v in pairs(self.SafeObject) do DeleteObject(v); end
                    self.SafeObject = false
                end
            end
        end
    end
end

function MFP:DoAction(act)
    local doWait = false
    if act == "Hack" then
        TriggerEvent("mhacking:show")
        TriggerEvent("mhacking:start",2,13,self.HackingCb)
        FreezeEntityPosition(GetPlayerPed(-1),true)
    elseif act == "LockpickA" or act == "LockpickB" or act == "LockpickC" then
        doWait = true
        ESX.TriggerServerCallback('MF_PacificStandard:GetLockpickCount', function(count)
            if count and count > 0 then
                TriggerEvent('MF_LockPicking:StartMinigame')
            else
                ESX.ShowNotification("You don't have any lockpicks.")
                self.DoingAction = false
            end
            doWait = false
        end)
    elseif act == "Identify" then
        self:HandleVaultDoor(self.DoingAction)
    elseif act == "Safe" then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent('MF_SafeCracker:StartMinigame', self.SafeRewards)
    elseif act == "LootA" or act == "LootB" or act == "LootC" or act == "LootD" or act == "LootE" or act == "LootF" or act == "LootG" or act == "LootH" then
        doWait = true
        ESX.TriggerServerCallback('MF_PacificStandard:GetOxyCount', function(count)
            if count and count > 0 then
                self:HandleLooting(act)
            else
                ESX.ShowNotification("You need a plasma torch to cut this open.")
                self.DoingAction = false
            end
            doWait = false
        end)
    elseif act == "LootCash" then
        self:HandleLootCash()
    end

    if doWait then while doWait do Citizen.Wait(0); end; end

    if self.DoingAction then
        TriggerServerEvent('MF_PacificStandard:NotifyPolice')
    end
end

function MFP:HandleLootCash()
    local plySkin
    TriggerEvent('skinchanger:getSkin', function(skin) plySkin = skin; end)
    --if (plySkin["bags_1"] ~= 0 or plySkin["bags_2"] ~= 0) then
    ESX.TriggerServerCallback('MF_PacificStandard:TryLootCash',function(canLoot)
        if canLoot then  
            TaskTurnPedToFaceCoord(plyPed, self.DoingAction.x, self.DoingAction.y, self.DoingAction.z, -1)
            Wait(1500)
            local plyPed = GetPlayerPed(-1)

            exports['progressBars']:startUI(15 * 1000, "Looting Cash")
            ESX.Streaming.RequestAnimDict('mp_take_money_mg', function(...)
                TaskPlayAnim( plyPed, "mp_take_money_mg", "stand_cash_in_bag_loop", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )     
            end)
            Wait(15 * 1000)
            ClearPedTasksImmediately(plyPed)
            Wait(1000)
        else
            ESX.ShowNotification("Somebody else is already looting this.")
        end
        self.DoingAction = false
    end)
end

function MFP:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    self:Start()
end

function MFP:HandleLooting(act)
    ESX.TriggerServerCallback('MF_PacificStandard:GetCutterCount', function(count)
        if count then
            ESX.TriggerServerCallback('MF_PacificStandard:TryLoot',function(canLoot) 
                if canLoot then
                    local plyPed = GetPlayerPed(-1)

                    TaskTurnPedToFaceCoord(plyPed, self.DoingAction.x, self.DoingAction.y, self.DoingAction.z, -1)
                    Wait(2000)

                    FreezeEntityPosition(plyPed,true)
                    exports['progressBars']:startUI(self.InteractTimer * 1000, "Cutting")
                    TaskStartScenarioInPlace(plyPed, "WORLD_HUMAN_WELDING", 0, true)
                    Wait(self.InteractTimer * 1000)

                    ClearPedTasksImmediately(plyPed)
                    FreezeEntityPosition(plyPed,false)
                    TriggerServerEvent('MF_PacificStandard:RewardPlayer', act)
                else
                    ESX.ShowNotification("Somebody else is already looting this.")
                end
                self.DoingAction = false
            end,self.DoingAction)
        else
            self.DoingAction = false
            ESX.ShowNotification("You don't have any plasma cutters.")
        end
    end)
end

function MFP:HandleVaultDoor(closest)
  ESX.TriggerServerCallback('MF_PacificStandard:GetIDCount', function(count)
    if count and count > 0 then
      local plyPed = GetPlayerPed(-1)
      TaskTurnPedToFaceCoord(plyPed, closest.x, closest.y, closest.z, -1)
      Wait(2000)

      FreezeEntityPosition(plyPed,true)
      exports['progressBars']:startUI(self.InteractTimer * 1000, "Requesting Access")
      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_ATM", 0, true)
      Wait(self.InteractTimer * 1000)

      TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_ATM", 0, false)
      Wait(1500)

      ClearPedTasksImmediately(plyPed)
      FreezeEntityPosition(plyPed,false)
      TriggerServerEvent('tp_doorlock:updateState', 1, false)
      Wait(100)
      TriggerServerEvent('MF_PacificStandard:OpenDoor', self.DoingAction)
    else
      ESX.ShowNotification("You havn't got a bank ID card.")
    end
    self.DoingAction = false
  end)
end

function MFP.HackingCb(success)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerEvent('mhacking:hide')
    if success then
        TriggerServerEvent('MF_PacificStandard:OpenDoor', MFP.DoingAction)
    end
    MFP.DoingAction = false;
end

function MFP:OpenDoor(doorloc,doorhash)
    if self.ZoneLoaded then
        Citizen.CreateThread(function(...) 
            local allObjs = ESX.Game.GetObjects()

            local closestObj,closestDist
            for k,v in pairs(allObjs) do
                local hKey = GetEntityModel(v)
                local rKey = hKey % 0x100000000
                if hKey == doorhash or rKey == doorhash then
                    local dist = Utils:GetVecDist(doorloc, GetEntityCoords(v))
                    if not closestDist or dist < closestDist then
                        closestObj = v
                        closestDist = dist
                    end
                end
            end

            if closestDist and closestDist < self.LoadDist then
                local tick = 0
                local modifier = 0.3
                if doorhash == 961976194 then modifier = -0.3; end
                while tick < 350 do
                    Citizen.Wait(5)
                    tick = tick + 1
                    local entHeading = GetEntityHeading(closestObj)
                    SetEntityHeading(closestObj, entHeading + modifier)
                end
            end
        end)
    end        
end

function MFP:FinishLockpick(result)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    if result then
        TriggerServerEvent('MF_PacificStandard:OpenDoor', self.DoingAction)
    end
    self.DoingAction = false;
end

function MFP:NotifyCops()
  if self.PlayerData.job.name == self.PoliceJobName then
    TriggerServerEvent("tp:addChatPolice", "[10-90] Someone is attempting to break into Pacific Bank vaults, Please prioritize this call.")


    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
    Citizen.Wait(250)
    PlaySoundFrontend(-1, "Mission_Pass_Notify", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 0)
    Citizen.CreateThread(function(...)
      local blipA = AddBlipForRadius(246.78, 218.70, 106.30, 100.0)
      SetBlipHighDetail(blipA, true)
      SetBlipColour(blipA, 1)
      SetBlipAlpha (blipA, 128)

      local blipB = AddBlipForCoord(246.78, 218.70, 106.30)
      SetBlipSprite               (blipB, 458)
      SetBlipDisplay              (blipB, 4)
      SetBlipScale                (blipB, 1.0)
      SetBlipColour               (blipB, 1)
      SetBlipAsShortRange         (blipB, true)
      SetBlipHighDetail           (blipB, true)
      BeginTextCommandSetBlipName ("STRING")
      AddTextComponentString      ("Robbery In Progress")
      EndTextCommandSetBlipName   (blipB)

      local timer = GetGameTimer()
      while GetGameTimer() - timer < 60000 do
        Citizen.Wait(0)
      end

      RemoveBlip(blipA)
      RemoveBlip(blipB)
    end)
  end
end

function MFP.SetJob(source,job)
  local self = MFP
  local lastData = self.PlayerData
  if lastData.job.name == self.PoliceJobName then
    TriggerServerEvent('MF_PacificStandard:CopLeft')
  elseif lastData.job.name ~= self.PoliceJobName and job.name == self.PoliceJobName then
    TriggerServerEvent('MF_PacificStandard:CopEnter')
  end
  self.PlayerData = ESX.GetPlayerData()
end

RegisterNetEvent("tp:thermiteTrigger")
AddEventHandler("tp:thermiteTrigger",function(z)
    thermite()
end)

RegisterNetEvent("tp:notifypacific")
AddEventHandler("tp:notifypacific", function()
    local aa=PlayerPedId()
    local ab=GetEntityCoords(aa)
    if GetDistanceBetweenCoords(ab,vector3(256.80,219.73,106.29),true)<=2.5 then
        exports['mythic_notify']:SendAlert('error', 'Something doesnt feel right <br/> Maybe try again later.', 15000)
    end
end)

function thermite()
    Citizen.CreateThread(function()
        local a6=nil
        local a7=nil
        local a8=nil
        local a9=nil
        local aa=PlayerPedId()
        local ab=GetEntityCoords(aa)
        if GetDistanceBetweenCoords(ab,vector3(256.80,219.73,106.29),true)<=2.5 then
            a6=vector3(256.80,219.73,106.29)a7=340.78
            a8=4072696575
            a9=78.82
--[[         elseif GetDistanceBetweenCoords(ab,vector3(261.24,221.94,106.08),true)<=2.5 then
            a6=vector3(261.24,221.94,106.08)a7=253.27
            a8=746855201
            a9=27.48 ]]
        elseif GetDistanceBetweenCoords(ab,vector3(253.52,221.20,101.48),true)<=2.5 then
            a6=vector3(253.52,221.20,101.48)a7=162.70
            a8=1655182495
            a9=5.0
        --[[ elseif GetDistanceBetweenCoords(ab,vector3(261.19,216.24,101.0),true)<=2.5 then
            a6=vector3(261.19,216.24,101.0)a7=251.65
            a8=2786611474
            a9=90.0 ]]
        end

        if a6~=nil then
            ESX.ShowNotification("~r~~h~Planting")
            SetEntityCoords(aa,a6)
            SetEntityHeading(aa,a7)
            RequestAnimDict("anim@heists@ornate_bank@thermal_charge")
            RequestModel("hei_prop_heist_thermite")
            while not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge")or not HasModelLoaded("hei_prop_heist_thermite")do
                Wait(50)
            end
            local thermite=CreateObject(GetHashKey("hei_prop_heist_thermite"),GetEntityCoords(aa),true,true,true)
            AttachEntityToEntity(thermite,aa,GetPedBoneIndex(GetPlayerPed(-1),28422),0,0,0,0,0,175.0,true,true,false,true,1,true)
            TaskPlayAnim(aa,"anim@heists@ornate_bank@thermal_charge","thermal_charge",0.8,0.0,-1,0,0,0,0,0)blockKeys=true
            Citizen.Wait(5000)
            DetachEntity(thermite)
            FreezeEntityPosition(thermite,true)
            blockKeys=false
            TriggerServerEvent('tp:thermiteRemove',NetworkGetNetworkIdFromEntity(thermite),a8)
            Citizen.Wait(6000)
            ClearPedTasksImmediately(aa)
            Citizen.Wait(2000)
            local p=GetClosestObjectOfType(a6,5.0,a8,false)x,y,z=table.unpack(a6)
            TriggerServerEvent('tp:thermiteSomething',x,y,z,a8,a9)a6=nil
            a9=nil
            thermite=nil
            a8=nil
            x,y,z=nil
            a9=nil
        end
    end)
end

local A=0
RegisterNetEvent("tp:thermiteEffect")
AddEventHandler("tp:thermiteEffect",function(B,C)
    A=C
    terkidan(B)
end)

function terkidan(a4)
    Citizen.CreateThread(function()
        local a5=NetworkGetEntityFromNetworkId(a4)
        RequestNamedPtfxAsset("scr_ornate_heist")
        while not HasNamedPtfxAssetLoaded("scr_ornate_heist")do 
            Citizen.Wait(100)
        end
        UseParticleFxAssetNextCall("scr_ornate_heist")
        StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_burn",a5,0,1.0,0,0,0,0,1.0,false,false,false)
        StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_sparks",a5,0,1.0,0,0,0,0,1.0,false,false,false)
        StartParticleFxLoopedOnEntity("scr_heist_ornate_thermal_glow",a5,0,1.0,0,0,0,0,1.0,false,false,false)
        StartParticleFxLoopedOnEntity("sp_fbi_fire_trail_smoke",a5,0,1.0,0,0,0,0,1.0,false,false,false) 
        Citizen.Wait(7000)
        DeleteEntity(a5)
    end)
end


local dd = true

RegisterNetEvent('tp:thermiteDoorTrigger')
AddEventHandler('tp:thermiteDoorTrigger',function(D,E,F,G,H)
    local I={D,E,F}
    local J=nil
    if G==961976194 then
        doorname='v_ilev_bk_vaultdoor'J=H
        princoordsg=I
        prinrotationg=J
        prinDoortypeg=doorname
        a=true
    end

    if G==4072696575 then
        doorname='hei_v_ilev_bk_gate_pris'J=H
        princoords1=I
        prinrotation1=J
        prinDoortype1=doorname
        b=true
    end
    if G==746855201 then
        doorname='hei_v_ilev_bk_gate2_pris'J=H
        princoords2=I
        prinrotation2=J
        prinDoortype2=doorname
        c=true
    end
    if G==1655182495 then
        doorname='v_ilev_bk_safegate'J=H
        princoords3=I
        prinrotation3=J
        prinDoortype3=doorname
        d=true
    end
    if G==2786611474 then
        doorname='hei_v_ilev_bk_safegate_pris'J=H
        princoords4=I
        prinrotation4=J
        prinDoortype4=doorname
        e=true
    end
    Citizen.CreateThread(function()
        while true do
            if a then
                local K,L=ESX.Game.GetClosestObject(prinDoortypeg,princoordsg)
                SetEntityHeading(K,prinrotationg)
                --print("OPENING DOOR 1")
            end
            if b then
                local M,L=ESX.Game.GetClosestObject(prinDoortype1,princoords1)
                SetEntityHeading(M,prinrotation1)
                --print("OPENING DOOR 2")
            end
            if c then
                local N,L=ESX.Game.GetClosestObject(prinDoortype2,princoords2)
                SetEntityHeading(N,prinrotation2)
                --print("OPENING DOOR 3")
            end
            if d then
                local O,L=ESX.Game.GetClosestObject(prinDoortype4,prinDoortype4)
                SetEntityHeading(O,prinrotation3)
                Citizen.Wait(500)
                break
                --print("OPENING DOOR 4")
                --print(dd)
            end
            --[[ if e then
                local P,L=ESX.Game.GetClosestObject(prinDoortype4,princoords4)
                SetEntityHeading(P,prinrotation4)
                --print("OPENING DOOR 5")
                Citizen.Wait(100)
                break
            end ]]
            Wait(2000)
        end
    end)
end)



RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job) MFP.SetJob(source,job); end)

AddEventHandler('MF_PacificStandard:RefreshBank', function(bankData) MFP.BankData = bankData; end)
AddEventHandler('MF_PacificStandard:OpenDoor', function(doorloc,doorhash) MFP:OpenDoor(doorloc,doorhash); end)
AddEventHandler('MF_PacificStandard:NotifyCops', function() MFP:NotifyCops(); end)
AddEventHandler('MF_PacificStandard:SetCops', function(val) MFP.PoliceOnline = val; end)
AddEventHandler('MF_SafeCracker:EndMinigame', function(won) MFP:FinishLockpick(won); end)
AddEventHandler('MF_LockPicking:MinigameComplete', function(result) MFP:FinishLockpick(result); end)
AddEventHandler('MF_LockPicking:MinigameComplete', function(result) MFP:FinishLockpick(result); end)

Citizen.CreateThread(function(...) MFP:Awake(...); end)