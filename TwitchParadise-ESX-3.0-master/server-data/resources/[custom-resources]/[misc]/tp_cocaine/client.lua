RegisterNetEvent('instance:onEnter')
RegisterNetEvent('instance:onLeave')
RegisterNetEvent('instance:onClose')
RegisterNetEvent('SVRP_GrowWeed:SyncPlant')
RegisterNetEvent('SVRP_GrowWeed:UseSeed')
RegisterNetEvent('SVRP_GrowWeed:UseItem')
RegisterNetEvent('SVRP_GrowWeed:UseBag')
RegisterNetEvent('SVRP_GrowWeed:UseRollingPapers')

local SVD = SVRP_GrowWeed

function SVD:Start()
  self.Plants = {}
  self.timer = GetGameTimer()
  ESX.TriggerServerCallback('SVRP_GrowWeed:GetLoginData', function(plants)  
    self.Plants = plants or {}
    for k = 1,#self.Plants,1 do
      local v = self.Plants[k]
      if v and not v.Instance then
        local hk      = Utils.GetHashKey(self.Objects[v.Stage])
        local load    = Utils.LoadModel(hk,true) 
        local zOffset = self:GetPlantZ(v) 
        v.Object = CreateObject(hk, v.Position.x, v.Position.y, v.Position.z + zOffset, false, false, false)   
        SetEntityAsMissionEntity(v.Object,true)
        FreezeEntityPosition(v.Object,true)
      end
    end
    self.iR = true
  end)
  while not self.iR do Citizen.Wait(0); end
  if self.dS and self.cS then
    Citizen.CreateThread(function(...) self:PerSecThread(...); end)
    Citizen.CreateThread(function(...) self:FiveSecThread(...); end)
    Citizen.CreateThread(function(...) self:PerFrameThread(...); end)
  end
end

function SVD:GetLoginData()
end

function SVD:PerSecThread()
  while true do
    Wait(1000)
    self:GrowthHandlerFast()
  end
end

function SVD:FiveSecThread()
  local tick = 0
  while true do
    Wait(5000)
    tick = tick + 1
    self:GrowthHandlerSlow()
    self:TextHandler()
    if tick % 4 == 0 then self:SyncCheck(); end
  end
end

function SVD:PerFrameThread()
  if not self then return; end
  while true do
    Citizen.Wait(0)
    self:InputHandler()
    self:DrawCurText() 
  end
end

function SVD:InputHandler()
  if not self.Plants then return; end
  if not #self.Plants then return; end
  if self.CanHarvest or self.PolText then 
    if Utils:GetKeyPressed("E") and (GetGameTimer() - self.timer) > 200 and not self.CurInteracting then
      Citizen.CreateThread(function()
        self.CurInteracting = true
        local plyPed = GetPlayerPed(-1)
        TaskTurnPedToFaceEntity(plyPed, self.Plants[self.CurKey].Object, -1)
        Citizen.Wait(1000)

        TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, true)
        exports["t0sic_loadingbar"]:StartDelayedFunction('Harvesting', 20000, function()
        
        TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_BUM_BIN", 0, false)
        Wait(1000)
        ClearPedTasksImmediately(plyPed)

        local syncData = (self.CanHarvest or self.PolText)
        self.timer = GetGameTimer()

        SetEntityAsMissionEntity(syncData.Object,false)
        FreezeEntityPosition(syncData.Object,false)
        DeleteObject(syncData.Object)

        

        self:Sync(self.Plants[self.CurKey],true)
        self.Plants[self.CurKey] = false
        self.CanHarvest = false
        self.PolText = false
        self:TextHandler()
        self.CurInteracting = false
      end)
    end)
  end
  end
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Positions = {
  ['CokeLeaves'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1940.106, ['y'] = 1940.094, ['z'] = 163.763 },
  ['CokeLeaves2'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1948.758, ['y'] = 1945.036, ['z'] = 162.603 },
  ['CokeLeaves3'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1927.462, ['y'] = 1932.725, ['z'] = 164.942 },
  ['CokeLeaves4'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1916.7648925781, ['y'] = 1926.7862548828, ['z'] = 164.4241027832 },
  ['CokeLeaves5'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1902.0977783203, ['y'] = 1918.50390625, ['z'] = 163.96849060059 },
  ['CokeLeaves6'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1909.5794677734, ['y'] = 1912.4779052734, ['z'] = 167.58512878418 },
  ['CokeLeaves7'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1921.5606689453, ['y'] = 1918.9794921875, ['z'] = 168.29797363281 },
  ['CokeLeaves8'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1940.7810058594, ['y'] = 1929.8790283203, ['z'] = 168.30296325684 },
  ['CokeLeaves9'] = { ['hint'] = '[E] To Pick Leaves', ['x'] = -1959.3262939453, ['y'] = 1940.5483398438, ['z'] = 166.8694152832 },
  ['CokeDry'] = { ['dry'] = '[E] To Dry Produce', ['x'] = 1975.476, ['y'] = 3818.499, ['z'] = 33.436 },
  ['CokeDry2'] = { ['dry'] = '[E] To Dry Produce', ['x'] = 1976.765, ['y'] = 3819.353, ['z'] = 33.450 },
  ['CokePack'] = { ['pack'] = '[E] To Bag Cocaine', ['x'] = 1101.774, ['y'] = -3193.774, ['z'] = -38.993 },
  ['CokePack2'] = { ['pack'] = '[E] To Bag Cocaine', ['x'] = 1099.634, ['y'] = -3194.604, ['z'] = -38.993 },
  ['basit'] = { ['bash'] = '[E] To Bash Coca Powder', ['x'] = 1100.387, ['y'] = -3198.725, ['z'] = -38.993 },
  ['c4'] = { ['make'] = '[E] To craft C4', ['x'] = 1268.590, ['y'] = -1710.270, ['z'] = 54.771 },
  ['SuphricAcid'] = { ['create'] = '[E] To Make Sulphuric Acid', ['x'] = 1389.317, ['y'] = 3604.726, ['z'] = 38.941 }

  --add more locations 6982422,-1710.2700195313,54.77144241333
}

Citizen.CreateThread(function()
	while true do
    local sleep = 1000		
    local plyCoords = GetEntityCoords(PlayerPedId())

		for index, value in pairs(Positions) do
			if value.make ~= nil then
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)
				if distance < 7.0 then
					sleep = 5
					DrawM(value.make, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
					if distance < 0.7 then
            if IsControlJustReleased(0, 38) then
              
              TriggerEvent("tp:makeC4")
  
            end
          end
				end
			end			
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
    local sleep = 1000		
    local plyCoords = GetEntityCoords(PlayerPedId())

		for index, value in pairs(Positions) do
			if value.hint ~= nil then
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)
				if distance < 7.0 then
					sleep = 5
					DrawM(value.hint, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
					if distance < 0.7 then
            if IsControlJustReleased(0, 38) then
              
              TriggerEvent("tp:startPicking")
  
            end
          end
				end
			end			
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
    local sleep = 1000		
    local plyCoords = GetEntityCoords(PlayerPedId())

		for index, value in pairs(Positions) do
			if value.dry ~= nil then
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)
				if distance < 4.0 then
					sleep = 5
					DrawM(value.dry, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
					if distance < 0.4 then
            if IsControlJustReleased(0, 38) then
              
              TriggerEvent("tp:startDrying")
  
            end
          end
				end
			end			
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
    local sleep = 1000		
    local plyCoords = GetEntityCoords(PlayerPedId())

		for index, value in pairs(Positions) do
			if value.pack ~= nil then
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)
				if distance < 1.5 then
					sleep = 5
					DrawM(value.pack, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
					if distance < 0.4 then
            if IsControlJustReleased(0, 38) then
              
              TriggerEvent("tp:startPacking")
  
            end
          end
				end
			end			
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
    local sleep = 1000		
    local plyCoords = GetEntityCoords(PlayerPedId())

		for index, value in pairs(Positions) do
			if value.create ~= nil then
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)
				if distance < 1.5 then
					sleep = 5
					DrawM(value.create, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
					if distance < 0.4 then
            if IsControlJustReleased(0, 38) then
              
              TriggerEvent("tp:createAcid")
  
            end
          end
				end
			end			
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while true do
    local sleep = 1000		
    local plyCoords = GetEntityCoords(PlayerPedId())

		for index, value in pairs(Positions) do
			if value.bash ~= nil then
				local distance = GetDistanceBetweenCoords(plyCoords, value.x, value.y, value.z, true)
				if distance < 1.5 then
					sleep = 5
					DrawM(value.bash, 27, value.x, value.y, value.z - 0.945, 255, 255, 255, 1.5, 15)
					if distance < 0.4 then
            if IsControlJustReleased(0, 38) then
              
              TriggerEvent("tp:bashCoca")
  
            end
          end
				end
			end			
		end
		Citizen.Wait(sleep)
	end
end)

RegisterNetEvent('tp:makeC4')
AddEventHandler('tp:makeC4', function()
  local playerPed		= GetPlayerPed(-1)
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
        CurrentAction = 'c4'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Crafting C4', 15000, function() 

				if CurrentAction ~= nil then				
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('tp_items:get')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
    end)
end)

RegisterNetEvent('tp:startPicking')
AddEventHandler('tp:startPicking', function()
  local playerPed		= GetPlayerPed(-1)
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
        CurrentAction = 'picking'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Picking leaves', 15000, function()

				if CurrentAction ~= nil then				
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('tp_leaf:get')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
    end)
end)

RegisterNetEvent('tp:startDrying')
AddEventHandler('tp:startDrying', function()
  local playerPed		= GetPlayerPed(-1)
      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
        CurrentAction = 'drying'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Drying Produce', 30000, function()

				if CurrentAction ~= nil then				
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('tp_dry:get')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
    end)
end)

RegisterNetEvent('tp:startPacking')
AddEventHandler('tp:startPacking', function()
  local playerPed		= GetPlayerPed(-1)
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
        CurrentAction = 'pack'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Weighing and bagging cocaine', 30000, function()

				if CurrentAction ~= nil then				
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('tp_pack:get')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
    end)
end)

RegisterNetEvent('tp:createAcid')
AddEventHandler('tp:createAcid', function()
  local playerPed		= GetPlayerPed(-1)
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
        CurrentAction = 'create'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Combining meterials', 30000, function()

				if CurrentAction ~= nil then				
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('tp_create:get')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
    end)
end)

RegisterNetEvent('tp:bashCoca')
AddEventHandler('tp:bashCoca', function()
  local playerPed		= GetPlayerPed(-1)
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_PARKING_METER", 0, true)
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
        CurrentAction = 'bash'

				exports["t0sic_loadingbar"]:StartDelayedFunction('Bashing Cocaine', 50000, function()

				if CurrentAction ~= nil then				
					ClearPedTasksImmediately(playerPed)
					TriggerServerEvent('tp_bash:get')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
    end)
end)


function DrawM(hint, type, x, y, z)
	Draw3DText(x, y, z + 1.2, hint)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
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

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


function SVD:DrawCurText()
  if not self.CurText then return; end
  local closest = self.CurText.closest
  local plyPos = GetEntityCoords(GetPlayerPed(-1))
  if Utils.GetXYDist(plyPos.x,plyPos.y,plyPos.z,closest.Position.x,closest.Position.y,closest.Position.z) > self.InteractDist then self.CurText = false; self:TextHandler() return; end
  local strA = self.CurText.strA
  local strB = self.CurText.strB
  Draw3DText(closest.Position.x,closest.Position.y,closest.Position.z, strA)
  --Draw3DText(closest.Position.x,closest.Position.y,closest.Position.z - 0.1, strB)
  if not self.PolText then return; end
  local closestPol = self.PolText.closest
  local strC = self.PolText.strA
  Draw3DText(closestPol.Position.x,closestPol.Position.y,closestPol.Position.z - 0.15, strC)
end

function SVD:TextHandler()
  if not self.Plants then self.CanHarvest = false; self.CurText = false; self.PolText = false; self.CurKey = false; return; end
  if not #self.Plants then self.CanHarvest = false; self.CurText = false; self.PolText = false; self.CurKey = false; return; end
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local closest,closestDist,closestKey
  for k = 1,#self.Plants,1 do
    local v = self.Plants[k]
    if v then
      if (self.Instance and v.Instance and v.Instance == self.Instance) or (not self.Instance and not v.Instance) then
        local dist = Utils:GetVecDist(plyPos,v.Position)
        if not closest or dist < closestDist then
          closestDist = dist
          closest = v
          closestKey = k
        end
      end
    end
  end

  if not closest then self.CanHarvest = false; self.CurText = false; self.PolText = false; self.CurKey = false; return; end
  if closestDist > self.InteractDist then self.CanHarvest = false; self.CurText = false; self.PolText = false; self.CurKey = false; return; end

  local strA
  if closest.Gender == "Male" then
    strA = "Cocaine | "
  else
    strA = "[ Female Strain ] "
  end

  local colGrowth = self:GetValColour(closest.Growth)
  strA = strA .. colGrowth .. math.ceil(closest.Growth) .. "~s~% Cured " -- 
  local plyData = ESX.GetPlayerData()
  if closest.Growth >= 99.99 then 
    local plyId = plyData.identifier
    if closest.Owner == plyId  then
      strA = strA .. "| Press [~g~E~s~] To Collect Paste" 
      self.CanHarvest = closest
    else
      self.CanHarvest = false
    end
  end
  local colQual = self:GetValColour(closest.Quality)
  strA = strA    

  local colFert = self:GetValColour(closest.Food)
  local strB = colFert 
  local colWater = self:GetValColour(closest.Water)
  strB = strB 

  self.CurText = { closest = closest, strA = strA, strB = strB }
  if (plyData.job and plyData.job.label and plyData.job.label == self.PoliceJobLabel) then
    self.PolText = { closest = closest, strA = "Press [~r~E~s~] To Destroy" }
  end
  self.CurKey = closestKey
end

function SVD:GetValColour(v)
  if not v then return "[ ~s~"; end
  if v>=95.0 then return "~p~"
  elseif v>=80.0 then return ""
  elseif v>=60.0 then return ""
  elseif v>=40.0 then return ""
  elseif v>=20.0 then return ""
  elseif v>=0.0 then return "~r~"
  else return "[ ~s~"
  end
end

function SVD:GetQualColour(v)
  if not v then return "~s~"; end
  if v>=5.0 then return "~b~"
  elseif v>=4.0 then return "~g~"
  elseif v>=3.0 then return "~y~"
  elseif v>=2.0 then return "~o~"
  elseif v>=1.0 then return "~y~"
  elseif v>=0.0 then return "~r~"
  else return "~s~"
  end
end

function SVD:GrowthHandlerSlow()
  if not self.Plants then return; end
  if not #self.Plants then return; end
  local plyData = ESX.GetPlayerData()
  local plyId = plyData.identifier
  for k = 1,#self.Plants,1 do
    local v = self.Plants[k]
    if v and v.Owner and v.Owner == plyId then
      self:GrowPlantSlow(v,k)
    end
  end
end

function SVD:GrowPlantSlow(plant,key)
  if not self.Plants then return; end
  if not self.Plants[key] then return; end
  if self.Plants[key] ~= plant then return; end

  local divider = 95.0 / #self.Objects
  local targetStage = math.max(1,math.floor(plant.Growth / divider))

  if plant.Stage ~= math.min(targetStage,7) then
    plant.Stage = targetStage
    SetEntityAsMissionEntity(plant.Object,false)
    FreezeEntityPosition(plant.Object,false)

    local hk      = Utils.GetHashKey(self.Objects[plant.Stage])
    local load    = Utils.LoadModel(hk,true) 
    local zOffset = self:GetPlantZ(plant) 
    DeleteObject(plant.Object)
    plant.Object = CreateObject(hk, plant.Position.x, plant.Position.y, plant.Position.z + zOffset, false, false, false)   
    SetEntityAsMissionEntity(plant.Object,true)
    FreezeEntityPosition(plant.Object,true)

    self:Sync(plant,false)
  end
end

function SVD:GrowthHandlerFast()
  if not self.Plants then return; end
  if not #self.Plants then return; end
  local plyData = ESX.GetPlayerData()
  local plyId = plyData.identifier
  for k = 1,#self.Plants,1 do
    local v = self.Plants[k]
    if v and v.Owner and v.Owner == plyId then
      self:GrowPlantFast(v,k)
    end
  end
end

function SVD:GrowPlantFast(plant,key)
  if not self.Plants then return; end
  if not self.Plants[key] then return; end
  if self.Plants[key] ~= plant then return; end

  plant.Food = math.max(0.0,plant.Food - self.FoodDrainSpeed)
  plant.Water = math.max(0.0,plant.Water - self.WaterDrainSpeed)

  if plant.Food > 80.0 and plant.Water > 80.0 then
    plant.Quality = math.min(100.0,plant.Quality + (self.QualityGainSpeed * 2))
    plant.Growth = math.min(100.0,plant.Growth + (self.GrowthGainSpeed * 2))
  elseif plant.Food > 50 and plant.Water > 50 then
    plant.Quality = math.min(100.0,plant.Quality + (self.QualityGainSpeed / 2))
    plant.Growth = math.min(100.0,plant.Growth + self.GrowthGainSpeed)  
  elseif plant.Food > 0.5 and plant.Water > 0.5 then
    plant.Growth = math.min(100.0,plant.Growth + (self.GrowthGainSpeed / 2))
  end

  if (plant.Food+20.0) < plant.Quality or (plant.Water+20.0) < plant.Quality then
    plant.Quality = math.max(0.0,plant.Quality - self.QualityDrainSpeed)
  end
end

function SVD:SyncCheck()
  if not self.Plants then return; end
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)
  local closestPos = GetEntityCoords(plyPed)

  local plys = ESX.Game.GetPlayers()
  local closestPly,closestDist
  for k = 1,#plys,1 do
    local ped = GetPlayerPed(plys[k])
    if ped ~= plyPed then
      local dist = Utils:GetVecDist(plyPos,GetEntityCoords(ped))
      if not closestPly or dist < closestPly then
        closestDist = dist
        closestPly = ped
      end
    end
  end
  local plyData = ESX.GetPlayerData()
  --if closestDist and closestDist < self.SyncDist then
    for k = 1,#self.Plants,1 do
      local v = self.Plants[k]
      if v and v.Owner == plyData.identifier then 
        self:Sync(v) 
        local str = "SyncPlant-Send-"..k
      end
    end
  --end
end

function SVD:EnterInstance(instance)
  self.Instance = instance.data.owner
  print("Enter Instance : SVD")
  if not self.Plants then return; end
  if not #self.Plants then return; end
  for k = 1,#self.Plants,1 do
    local v = self.Plants[k]
    if v and v.Instance then
      if v.Instance == self.Instance then
        SVD:SpawnInstance(v,k)
      end
    end
  end
end

function SVD:LeaveInstance(instance)
  print("Leave Instance : SVD")
  if not self.Plants then return; end
  if not #self.Plants then return; end
  self.Instance = false
  for k = 1,#self.Plants,1 do
    local v = self.Plants[k]
    if v and v.Instance then
      local plyData = ESX.GetPlayerData()
      FreezeEntityPosition(self.Plants[k].Object,false)
      SetEntityAsMissionEntity(self.Plants[k].Object,false)
      DeleteObject(self.Plants[k].Object)
      if v.Owner ~= plyData.identifier then
        self.Plants[k] = false
      end
    end
  end
end

function SVD:SpawnInstance(plant,k)
  if not self.Instance then return; end
  if plant.Instance ~= self.Instance then return; end
  self.Plants = self.Plants or {}
  if self.Plants[k] then
    local hk   = Utils.GetHashKey(self.Objects[plant.Stage])
    local load = Utils.LoadModel(hk,true) 
    local zOffset = self:GetPlantZ(self.Plants[k]) 
    self.Plants[k].Object = CreateObject(hk, plant.Position.x, plant.Position.y, plant.Position.z + zOffset, false, false, false)            
    FreezeEntityPosition(self.Plants[k].Object,true)
    SetEntityAsMissionEntity(self.Plants[k].Object,true)
  else 
    self.Plants[k] = plant
    local hk   = Utils.GetHashKey(self.Objects[plant.Stage])
    local load = Utils.LoadModel(hk,true)  
    local zOffset = self:GetPlantZ(self.Plants[k])
    self.Plants[k].Object = CreateObject(hk, plant.Position.x, plant.Position.y, plant.Position.z + zOffset, false, false, false)            
    FreezeEntityPosition(self.Plants[k].Object,true)
    SetEntityAsMissionEntity(self.Plants[k].Object,true)
  end
end

function SVD:SpawnWorld(plant,k)
  if self.Instance or (not plant or plant.Instance) then return; end
  self.Plants = self.Plants or {}
  if self.Plants[k] then
    local hk   = Utils.GetHashKey(self.Objects[plant.Stage])
    local load = Utils.LoadModel(hk,true)  
    local zOffset = self:GetPlantZ(self.Plants[k])
    self.Plants[k].Object = CreateObject(hk, plant.Position.x, plant.Position.y, plant.Position.z + zOffset, false, false, false)            
    FreezeEntityPosition(self.Plants[k].Object,true)
    SetEntityAsMissionEntity(self.Plants[k].Object,true)
  else 
    self.Plants[k] = plant
    local hk   = Utils.GetHashKey(self.Objects[plant.Stage])
    local load = Utils.LoadModel(hk,true)  
    local zOffset = self:GetPlantZ(self.Plants[k])
    self.Plants[k].Object = CreateObject(hk, plant.Position.x, plant.Position.y, plant.Position.z + zOffset, false, false, false)            
    FreezeEntityPosition(self.Plants[k].Object,true)
    SetEntityAsMissionEntity(self.Plants[k].Object,true)
  end
end

function SVD:SyncHandler(plant,delete)
  if not plant and not delete then return; end
  local plyPed = GetPlayerPed(-1)
  local plyPos = GetEntityCoords(plyPed)

  if delete then
    if self.Plants then
      if #self.Plants then
        for k = 1,#self.Plants,1 do
          local v = self.Plants[k]
          if v and v.Position then
            if (math.floor(v.Position.x) == math.floor(plant.Position.x)) and (math.floor(v.Position.y) == math.floor(plant.Position.y)) then
              DeleteObject(self.Plants[k].Object)
              self.Plants[k] = false
              return
            end
          end
        end
      end
    end
  else
    local plyData = ESX.GetPlayerData()
    local dist = Utils:GetVecDist(plyPos,plant.Position)
    if dist < self.SyncDist then
      if self.Plants and #self.Plants and #self.Plants > 0 then
        local didSpawn = false
        for k = 1,#self.Plants,1 do
          if self.Plants[k] then
            local v = self.Plants[k]   
            if v then     
              if v.Position.x == plant.Position.x and v.Position.y == plant.Position.y then
                if ((v.Instance and self.Instance and self.Instance == v.Instance) or (not self.Instance and not v.Instance)) and plant.Owner ~= plyData.identifier then
                  local zOffset = self:GetPlantZ(plant)
                  FreezeEntityPosition(self.Plants[k].Object,false)
                  SetEntityAsMissionEntity(self.Plants[k].Object,false)
                  DeleteObject(self.Plants[k].Object)
                  local hk   = Utils.GetHashKey(self.Objects[plant.Stage])
                  local load = Utils.LoadModel(hk,true)  
                  self.Plants[k] = plant
                  self.Plants[k].Object = CreateObject(hk, plant.Position.x, plant.Position.y, plant.Position.z + zOffset, false, false, false)      
                  FreezeEntityPosition(self.Plants[k].Object,true)
                  SetEntityAsMissionEntity(self.Plants[k].Object,true)
                  didSpawn = true
                else 
                  didSpawn = true
                end
              end
            end
          end
        end
        if not didSpawn then 
          if self.Instance then
            self:SpawnInstance(plant,#self.Plants+1)
          else
            self:SpawnWorld(plant,#self.Plants+1)
          end
        end
      else
        if self.Instance then
          if plant.Owner == self.Instance then
            self:SpawnInstance(plant,1)
          end
        else
          self:SpawnWorld(plant,1)
        end
      end
    end
  end
end

function SVD:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    ESX.TriggerServerCallback('SVRP_GrowWeed:GetStartData', function(retVal) self.dS = true; self.cS = retVal; end)
    while not self.dS do Citizen.Wait(0); end
    self:Start()
end

function SVD:GetPlantZ(plant)
  if plant.Stage <= 3 then return -1.0
  else return -3.5
  end
end

function SVD:UseItem(item)
  if not self.Plants then return; end
  if not #self.Plants then return; end
  local ped = GetPlayerPed(-1)
  local closest,closestDist
  for k = 1,#self.Plants,1 do
    local v = self.Plants[k]
    if v then
      local dist = Utils:GetVecDist(v.Position,GetEntityCoords(ped))
      if not closestDist or dist < closestDist then
        closestDist = dist
        closest = v
      end
    end
  end
  if not closest or not closestDist then return; end
  if closestDist < self.InteractDist then 
    if item.Type == "Water" then
      closest.Water = closest.Water + (item.Quality * 100)
    elseif item.Type == "Food" then
      closest.Food = closest.Food + (item.Quality * 100)
    end
    closest.Quality = closest.Quality + item.Quality
  end

  self:Sync(closest)
  self:TextHandler()
end

D = {}

D.startScenario = function(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

function SVD:UseSeed(seed)
  if not seed then return; end
  print("USE")
  self.Plants       = self.Plants or {}
  local ply         = GetPlayerPed(-1)
  local plyPos      = GetEntityCoords(ply)
  local k           = math.max(1,#self.Plants+1)
  local hk          = Utils.GetHashKey(self.Objects[1])
  local dmin,dmax   = GetModelDimensions(hk)
  local pos         = GetOffsetFromEntityInWorldCoords(ply,0,dmax.y*5,0)
  local npos        = {x=pos.x,y=pos.y,z=plyPos.z}
  local load        = Utils.LoadModel(hk,true)  
  local go          = CreateObject(hk,npos.x,npos.y,npos.z - 1.0,false,false,false)  
  local frozen      = FreezeEntityPosition(go,true)
  local mission     = SetEntityAsMissionEntity(go,true)
  local plyData     = ESX.GetPlayerData()

  D.startScenario("CODE_HUMAN_MEDIC_KNEEL")
	exports["t0sic_loadingbar"]:StartDelayedFunction('Mixing ingredients', 25000, function()
  ClearPedTasks(PlayerPedId())
  
  self.Plants[k]             = seed
  self.Plants[k]["Object"]   = go
  self.Plants[k]["Position"] = npos
  self.Plants[k]["Instance"] = (self.Instance or false)
  self.Plants[k]["Owner"]    = (plyData.identifier)
  self:Sync(self.Plants[k])
  
  

  Utils.ReleaseModel(hk)
  self:TextHandler()
end)
end

function SVD:Sync(plant,delete)
  TriggerServerEvent('SVRP_GrowWeed:SyncPlant',plant,delete)
end

function SVD:UseBag(canUse)
  Citizen.CreateThread(function(...)
    local plyPed = GetPlayerPed(-1)
    if canUse then TaskStartScenarioInPlace(plyPed, "PROP_HUMAN_PARKING_METER", 0, true); end
    Wait(5000)
    ClearPedTasksImmediately(plyPed)
  end)
end

---------------------
--#################--
--##   3D TEXT   ##--
--#################--
---------------------
local color = { r = 220, g = 220, b = 220, alpha = 255 } -- Color of the text 
local font = 4 -- Font of the text
local time = 7000 -- Duration of the display of the text : 1000ms = 1sec
local background = { enable = true, color = { r = 35, g = 35, b = 35, alpha = 200 }, }
local chatMessage = true
local dropShadow = true
local nbrDisplaying = 1

function Draw3DText(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
SetTextScale(0.33, 0.33)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
	  SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0,0,0,65)

    BeginTextCommandWidth("STRING")
    AddTextComponentString(text)
    local width = EndTextCommandGetWidth(font)

    --if background.enable then DrawRect(_x, _y+scale/73, width, height, background.color.r, background.color.g, background.color.b , background.color.alpha); end

end

function Drugs1()
	StartScreenEffect("DrugsMichaelAliensFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsMichaelAliensFightOut", 3.0, 0)
	StopScreenEffect("DrugsMichaelAliensFightIn")
	StopScreenEffect("DrugsMichaelAliensFight")
	StopScreenEffect("DrugsMichaelAliensFightOut")

end

function Drugs2()
	StartScreenEffect("DrugsTrevorClownsFightIn", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
	Citizen.Wait(8000)
	StartScreenEffect("DrugsTrevorClownsFightOut", 3.0, 0)
	StopScreenEffect("DrugsTrevorClownsFight")
	StopScreenEffect("DrugsTrevorClownsFightIn")
	StopScreenEffect("DrugsTrevorClownsFightOut")
end

function RevertToStressMultiplier()

	local factor = (stresslevel / 2) / 10000
	local factor = 1.0 - factor


	if factor > 0.1 then

		SetSwimMultiplierForPlayer(PlayerId(), factor)
		SetRunSprintMultiplierForPlayer(PlayerId(), factor)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
	end

end


imdead = 0


RegisterNetEvent('sniffFake:onUse')
AddEventHandler('sniffFake:onUse', function(arg1,arg2,arg3)
    dstamina = 0
    stresslevel = 0

    Citizen.Wait(1000)

    exports['mythic_notify']:SendAlert('inform', 'You sniffed the full bag! Get ready for a trip...', 7000)
    local death = math.random(1,99)
      if death <= 5 then
        exports['mythic_notify']:SendAlert('error', 'You should call a doctor, You dont feel so good.....', 5000)
        Citizen.Wait(10000)
        exports['mythic_notify']:SendAlert('error', 'You felt your heart skip a beat....', 5000)
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'heartrate', 1.0)
        Citizen.Wait(8000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        Citizen.Wait(8000)
        RequestAnimSet("MOVE_M@DRUNK@VERYDRUNK")
        ResetPedMovementClipset(GetPlayerPed(-1))
        SetPedMovementClipset(GetPlayerPed(-1),"MOVE_M@DRUNK@VERYDRUNK", 0.8)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        StartScreenEffect("DrugsTrevorClownsFight", 3.0, 0)
        Citizen.Wait(8000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        Citizen.Wait(8000) 
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        Citizen.Wait(8000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        DoScreenFadeOut(500)
        Citizen.Wait(500)
        DoScreenFadeIn(500)
        exports['mythic_notify']:SendAlert('error', 'YOU NEED MEDICAL ATTENTION', 5000)
        Citizen.Wait(6000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        Citizen.Wait(15000)
        exports['mythic_notify']:SendAlert('error', 'CARDIAC ARREST....', 5000)
        SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
        Citizen.Wait(500)
        SetEntityHealth(GetPlayerPed(-1), 0)
        ResetPedMovementClipset(GetPlayerPed(-1))
        StopScreenEffect("DrugsTrevorClownsFight")
      else


      if math.random(100) > 50 then
          Drugs1()
      else
          Drugs2()
      end

      SetPedArmour( GetPlayerPed(-1), 100 )

      if stresslevel > 500 then
          SetRunSprintMultiplierForPlayer(PlayerId(), 1.08)
          dstamina = 200
      else
          SetRunSprintMultiplierForPlayer(PlayerId(), 1.1)
          dstamina = 200
      end

      while dstamina > 0 do

          Citizen.Wait(1000)
          RestorePlayerStamina(PlayerId(), 1.0)
          dstamina = dstamina - 1

          if IsPedRagdoll(GetPlayerPed(-1)) then
              SetPedToRagdoll(GetPlayerPed(-1), math.random(5), math.random(5), 3, 0, 0, 0)
          end

          if math.random(500) < 3 then
              if math.random(100) > 50 then
                  Drugs1()
              else
                  Drugs2()
              end
              Citizen.Wait(math.random(30000))
          end

          if math.random(100) > 75 and IsPedRunning(GetPlayerPed(-1)) then
              SetPedToRagdoll(GetPlayerPed(-1), math.random(1000), math.random(1000), 3, 0, 0, 0)
          end

      end

      dstamina = 0

      if IsPedRunning(GetPlayerPed(-1)) then
          SetPedToRagdoll(GetPlayerPed(-1),1000,1000, 3, 0, 0, 0)
      end

      SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
      RevertToStressMultiplier()
    end
end)


RegisterNetEvent('sniffcoke:onUse')
AddEventHandler('sniffcoke:onUse', function(arg1,arg2,arg3)
    dstamina = 0
    stresslevel = 0
    Citizen.Wait(1000)
    exports['mythic_notify']:SendAlert('inform', 'You sniffed the full bag! Get ready for a trip...', 7000)

	if math.random(100) > 50 then
		Drugs1()
	else
		Drugs2()
	end

    if stresslevel > 500 then
	   	SetRunSprintMultiplierForPlayer(PlayerId(), 1.35)
	    dstamina = 30
	else
	    SetRunSprintMultiplierForPlayer(PlayerId(), 1.45)
	    dstamina = 30
	end

    while dstamina > 0 do

        Citizen.Wait(1000)
        RestorePlayerStamina(PlayerId(), 1.0)
        dstamina = dstamina - 1

        if IsPedRagdoll(GetPlayerPed(-1)) then
            SetPedToRagdoll(GetPlayerPed(-1), math.random(5), math.random(5), 3, 0, 0, 0)
        end

	  	if math.random(500) < 100 then
	  		if math.random(100) > 50 then
	  			Drugs1()
	  		else
	  			Drugs2()
	  		end
		  	Citizen.Wait(math.random(30000))
		end

        if math.random(100) > 75 and IsPedRunning(GetPlayerPed(-1)) then
            SetPedToRagdoll(GetPlayerPed(-1), math.random(1000), math.random(1000), 3, 0, 0, 0)
        end  
    end

    dstamina = 0

    if IsPedRunning(GetPlayerPed(-1)) then
        SetPedToRagdoll(GetPlayerPed(-1),6000,6000, 3, 0, 0, 0)
    end

    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
    RevertToStressMultiplier()
end)

AddEventHandler('instance:onEnter', function(instance) while not SVD.iR do Citizen.Wait(0); end SVD:EnterInstance(instance); end)
AddEventHandler('instance:onLeave', function(instance) if SVD.iR then SVD:LeaveInstance(instance); else SVD.Instance = false; end; end)
AddEventHandler('SVRP_GrowWeed:UseSeed', function(seed) if SVD.iR then SVD:UseSeed(seed); end; end)
AddEventHandler('SVRP_GrowWeed:UseItem', function(item) if SVD.iR then SVD:UseItem(item); end; end)
AddEventHandler('SVRP_GrowWeed:SyncPlant', function(plant,del) if SVD.iR then SVD:SyncHandler(plant,del); end; end)
AddEventHandler('SVRP_GrowWeed:UseBag', function(canUse,msg) SVD:UseBag(canUse,msg); end)

Citizen.CreateThread(function(...) SVD:Awake(...); end)






