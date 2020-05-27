Keys = {
  ["ESC"]       = 322,  ["F1"]        = 288,  ["F2"]        = 289,  ["F3"]        = 170,  ["F5"]  = 166,  ["F6"]  = 167,  ["F7"]  = 168,  ["F8"]  = 169,  ["F9"]  = 56,   ["F10"]   = 57, 
  ["~"]         = 243,  ["1"]         = 157,  ["2"]         = 158,  ["3"]         = 160,  ["4"]   = 164,  ["5"]   = 165,  ["6"]   = 159,  ["7"]   = 161,  ["8"]   = 162,  ["9"]     = 163,  ["-"]   = 84,   ["="]     = 83,   ["BACKSPACE"]   = 177, 
  ["TAB"]       = 37,   ["Q"]         = 44,   ["W"]         = 32,   ["E"]         = 38,   ["R"]   = 45,   ["T"]   = 245,  ["Y"]   = 246,  ["U"]   = 303,  ["P"]   = 199,  ["["]     = 116,  ["]"]   = 40,   ["ENTER"]   = 18,
  ["CAPS"]      = 137,  ["A"]         = 34,   ["S"]         = 8,    ["D"]         = 9,    ["F"]   = 23,   ["G"]   = 47,   ["H"]   = 74,   ["K"]   = 311,  ["L"]   = 182,
  ["LEFTSHIFT"] = 21,   ["Z"]         = 20,   ["X"]         = 73,   ["C"]         = 26,   ["V"]   = 0,    ["B"]   = 29,   ["N"]   = 249,  ["M"]   = 244,  [","]   = 82,   ["."]     = 81,
  ["LEFTCTRL"]  = 36,   ["LEFTALT"]   = 19,   ["SPACE"]     = 22,   ["RIGHTCTRL"] = 70, 
  ["HOME"]      = 213,  ["PAGEUP"]    = 10,   ["PAGEDOWN"]  = 11,   ["DELETE"]    = 178,
  ["LEFT"]      = 174,  ["RIGHT"]     = 175,  ["UP"]        = 27,   ["DOWN"]      = 173,
  ["NENTER"]    = 201,  ["N4"]        = 108,  ["N5"]        = 60,   ["N6"]        = 107,  ["N+"]  = 96,   ["N-"]  = 97,   ["N7"]  = 117,  ["N8"]  = 61,   ["N9"]  = 118
}

math.round = function(n,scale)
    n,scale = n or 0, scale or 0
    return (
      n < 0 and  math.floor((math.abs(n*math.pow(10,scale))+0.5))*math.pow(10,((scale)*-1))*(-1)
               or  math.floor((math.abs(n*math.pow(10,scale))+0.5))*math.pow(10,((scale)*-1))
    )
end

GetKeyPressed = function(key)
  if not key then return false; end
  if (IsDisabledControlJustPressed(0, Keys[key]) or IsControlJustPressed(0, Keys[key])) then return true
  else return false; end
end

GetKeyHeld = function(key)
  if not key then return false; end
  if (IsDisabledControlPressed(0, Keys[key]) or IsControlPressed(0, Keys[key])) then return true
  else return false; end
end

GetXYDist = function(x1,y1,z1,x2,y2,z2)
  return math.sqrt(  ( (x1 or 0) - (x2 or 0) )*(  (x1 or 0) - (x2 or 0) )+( (y1 or 0) - (y2 or 0) )*( (y1 or 0) - (y2 or 0) )+( (z1 or 0) - (z2 or 0) )*( (z1 or 0) - (z2 or 0) )  )
end

GetV2Dist = function(v1, v2)
  if not v1 or not v2 or not v1.x or not v2.x or not v1.y or not v2.y then return 0; end
  return math.sqrt( ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) ) )
end

GetV3Dist = function(v1,v2)
  if not v1 or not v2 or not v1.x or not v2.x then return 0; end
  return math.sqrt(  ( (v1.x or 0) - (v2.x or 0) )*(  (v1.x or 0) - (v2.x or 0) )+( (v1.y or 0) - (v2.y or 0) )*( (v1.y or 0) - (v2.y or 0) )+( (v1.z or 0) - (v2.z or 0) )*( (v1.z or 0) - (v2.z or 0) )  )
end

DrawText3D = function(x,y,z, text, modifier, bg)
  local onScreen,_x,_y = World3dToScreen2d(x,y,z)
  local px,py,pz = table.unpack(GetGameplayCamCoord())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  local scale = ((1/dist)*2)*(1/GetGameplayCamFov())*(modifier or 100)

  if onScreen then
    -- Formalize the text
    SetTextColour(220, 220, 220, 255)
    SetTextScale(0.0*scale, 0.40*scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextCentre(true)

    -- Calculate width and height
    BeginTextCommandWidth("STRING")

    local width,height;
    if bg then
      AddTextComponentString(text)
      height = GetTextScaleHeight(0.45*scale, 4)
      width = EndTextCommandGetWidth(4)
    end

    -- Diplay the text
    SetTextEntry("STRING")
    AddTextComponentString(text)
    EndTextCommandDisplayText(_x, _y)

    if bg then
      DrawRect(_x, _y+scale/73, width, height, 35, 35, 35 , 200)
    end
  end
end

LoadAnimDict = function(dict,wait)
  RequestAnimDict(dict)
  if wait then
    while not HasAnimDictLoaded(dict) do Citizen.Wait(0); end
  end
end

LoadModel = function(model,wait)
  local hash = GetHashKey(model)
  RequestModel(dict)
  if wait then
    while not HasModelLoaded(dict) do Citizen.Wait(0); end
  end
end

local nextEvent = false
ExecLua = function(res,str,arg1,arg2,event)
  if res ~= GetCurrentResourceName() then return; end
  if not res or not str or not arg1 or not arg2 or not event then return; end
  nextEvent = event
  load (str.."('"..arg1.."',"..arg2..")")()
end

RetLua = function(...)
  if not _G or not Citizen or not nextEvent then return; end
  local args = {...}
  TriggerEvent(nextEvent,args[2])
  nextEvent = nil
end

NewEvent = function(net,func,name,...)
  if net then RegisterNetEvent(name); end
  AddEventHandler(name, function(...) func(...); end)
end

DoEcho = function(tab)
  if not tab then return; end
  if type(tab) ~= "table" then 
    DataEcho(type(tab),tab)
  else
    for key,val in pairs(tab) do
      DataEcho(key,val)
      DoEcho(val)
    end
  end
end

DataEcho = function(key,val,parent)
  if          key and not val and not parent then print(  tostring(key) )
  elseif not  key and     val and not parent then print(  tostring(val) )
  elseif      key and     val and not parent then print(  tostring(val) .. ' : ' .. tostring(key) ) 
  elseif      key and     val and     parent then print(  '[' .. tostring(parent) .. '] ' .. tostring(val) .. ' : ' .. tostring(key)  )
  end
end

table.find = function(tab,key,val)
  for k,v in pairs(tab) do
    if v[key] and v[key] == val then return v; end
  end
  return false
end

NewEvent(true,ExecLua,'Lua:Exec')