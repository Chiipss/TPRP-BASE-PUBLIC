----------------------------------
-------------FUNCIONES------------
----------------------------------

X.ClickW = function(v)
  if v then
    if v.health > 0 then
       if X.Clicks >= Config.ClicksToCutNeeded then 
          X.Clicks = 0
          v.health = v.health - 1
          TriggerServerEvent('tm1_stores:giveWood',v.data)
          TriggerServerEvent('tm1_stores:getDataWood',Config.Woods)
        else
          X.Clicks = X.Clicks + 1 
        end
    end
  end
end

X.CraftW = function(item)
  X.IsProcessing = true
  Citizen.CreateThread(function()
    X.startAnim("mini@repair", "fixing_a_ped")
    exports["t0sic_loadingbar"]:StartDelayedFunction('Packaging wood', 10000, function()
    --Wait(10000)
    ClearPedTasks(PlayerPedId())
    X.IsProcessing = false
    TriggerServerEvent('tm1_stores:craftWood',item)
  end)
end)
end

X.CanPickW = function(coords)
  for i,v in pairs(Config.Woods) do
    if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,v.x,v.y,v.z) < 75 then
      if v.health >= v.max / 2 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~g~"..v.health.."/"..v.max)
      elseif v.health >= v.max / 4 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~b~"..v.health.."/"..v.max)
      elseif v.health < v.max / 4 and v.health ~= 0 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~y~"..v.health.."/"..v.max)
      elseif v.health <= 0 then
        X.DrawText3D({x = v.x, y = v.y, z = v.z}, Local.treeOf.."~b~"..Local[v.data].."~w~ : ~r~ "..v.health.."/"..v.max)  
      end
    end
    if GetCurrentPedWeapon(GetPlayerPed(-1),"WEAPON_HATCHET",true) then
      if IsControlJustReleased(1,  24) then
        if GetDistanceBetweenCoords(coords.x,coords.y,coords.z,v.x,v.y,v.z) < 2.5 and v.health > 0 then
          if v then
            X.ClickW(v)
          end
        end
      end
    end
  end
end

X.OpenProcesser = function()
  local elements = {
    {label = Local.process..Local.pine,value = "pine"}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'processer',
    {
      title  = Local.woodProcesser,
      align    = 'bottom-right',
      elements = elements
    },
    function(data, menu)  
      if data.current.value and X.IsProcessing == false then
        X.CraftW(data.current.value)
      end
      menu.close()
    end,
    function(data, menu)
      menu.close()
    end
  )
end