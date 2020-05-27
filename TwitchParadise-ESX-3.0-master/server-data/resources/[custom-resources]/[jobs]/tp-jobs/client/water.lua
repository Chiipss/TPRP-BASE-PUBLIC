local animationsToBeCleared = {'WORLD_HUMAN_CONST_DRILL', 'WORLD_HUMAN_HAMMERING', 'WORLD_HUMAN_GARDENER_LEAF_BLOWER'}

X.Draw3DTextWater = function(v)
  X.DrawText3D({x = v.x, y = v.y, z = v.z}, "~w~["..Local.dirtyWater.."~w~]")
  X.DrawText3D({x = v.x, y = v.y, z = v.z - 0.1}, "~w~["..Local.salinity.."~w~] : "..v.salinity.."%")
  X.DrawText3D({x = v.x, y = v.y, z = v.z - 0.2}, "~w~["..Local.chemists.."~w~] : "..v.chemists.."%")
  X.DrawText3D({x = v.x, y = v.y, z = v.z - 0.3}, "~w~["..Local.pollution.."~w~] : "..v.pollution.."%")
end

X.DoAction = function(v)
  Citizen.CreateThread(function()
    if type(v.anim) == 'string' then
      X.startScenario(v.anim)
      TriggerServerEvent('tm1_stores:doSomething', v)
      Citizen.Wait(v.animSeconds * 1000)
      X.ClearPed(v.anim)
      ClearPedTasks(PlayerPedId())
      X.IsDoingSomething = false
    elseif type(v.anim) == 'array' or type(v.anim) == 'table' then
      X.startAnim(v.anim.lib, v.anim.anim)
      TriggerServerEvent('tm1_stores:doSomething', v)
      Citizen.Wait(v.animSeconds * 1000)
      ClearPedTasks(PlayerPedId())
      X.IsDoingSomething = false
    elseif v.anin == nil then
      TriggerServerEvent('tm1_stores:doSomething', v)
      X.IsDoingSomething = false
    end
  end)
end

X.ClearPed = function(anim)
  for k,v in pairs(animationsToBeCleared) do
    if v == anim then
      ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local model = nil
    
        if skin.sex == 0 then
          model = GetHashKey("mp_m_freemode_01")
        else
          model = GetHashKey("mp_f_freemode_01")
        end
    
        RequestModel(model)
        while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(1)
        end
    
        SetPlayerModel(PlayerId(), model)
        SetModelAsNoLongerNeeded(model)
    
        TriggerEvent('skinchanger:loadSkin', skin)
        TriggerEvent('esx:restoreLoadout')
      end)
    end
  end 
end

X.GetWater = function(point)
  Citizen.CreateThread(function()
    X.startScenario("CODE_HUMAN_MEDIC_KNEEL")
    Citizen.Wait(5* 1000)
    ClearPedTasks(PlayerPedId())
    TriggerServerEvent('tm1_stores:addWaterBottle', point)
    X.IsPlanting = false
  end)
end

X.OpenBottleMenu = function()
  local elements = Config.BottleShop
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'bottle_shop', {
    title    = Local.bottleShop,
    align    = 'bottom-right',
    elements = elements
  }, function(data, menu)
    if data.current.value then
      TriggerServerEvent('tm1_stores:buyItem', data.current.value, data.current.price)
    end
  end,
  function(data, menu)
    menu.close()
  end
  )
end

X.OpenProcesserMenu = function()
  local elements = {
    {label = Local.confirm_yes, value = "yes"},
    {label = Local.confirm_no, value = "no"}
  }
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'water_processer', {
    title    = Local.washBottles,
    align    = 'bottom-right',
    elements = elements
  }, function(data, menu)
    if data.current.value == "yes" then
      TriggerServerEvent('tm1_stores:washBottles')
    else
      menu.close()
    end
  end,
  function(data, menu)
    menu.close()
  end
  )
end

X.OpenSaltMenu = function()
  local elements = {
    {label = Local.confirm_yes, value = "yes"},
    {label = Local.confirm_no, value = "no"}
  }
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'water_processer', {
    title    = Local.washSaltBottles,
    align    = 'bottom-right',
    elements = elements
  }, function(data, menu)
    if data.current.value == "yes" then
      TriggerServerEvent('tm1_stores:washSaltBottles')
    else
      menu.close()
    end
  end,
  function(data, menu)
    menu.close()
  end
  )
end

X.OpenPackageMenu = function()
  local elements = Config.PackageShop
  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'package_processer', {
    title    = Local.washSaltBottles,
    align    = 'bottom-right',
    elements = elements
  }, function(data, menu)
    if data.current.from then
      TriggerServerEvent('tm1_stores:package', data.current.from, data.current.to)
    else
      menu.close()
    end
  end,
  function(data, menu)
    menu.close()
  end
  )
end