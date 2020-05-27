local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

ESX = nil
PlayerData = {}
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer

    local shouldSave = false
    ESX.TriggerServerCallback("suku:FetchBurglaryData", function(list)
        if list == nil then
            shouldSave = true
        else
            BurglaryLocations = list
            shouldSave = false
        end
    end)

    Citizen.Wait(500)

    if shouldSave then
        SaveToDatabase()
    end
end)

function SaveToDatabase()
    TriggerServerEvent("suku:WriteBurglariesToDB", BurglaryLocations)
end

BurglaryLocations = {
    { isActive = false, x = 412.6, y = -1856.03, z = 27.32, h = 312.21, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81}, --LS
    
    { isActive = false, x = 250.77, y = -1934.86, z = 24.7, h = 47.91, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},
    
    { isActive = false, x = 72.34, y = -1938.98, z = 21.37, h = 309.84, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},
    
    { isActive = false, x = -224.55, y = -1666.25, z = 36.64, h = 268.29, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},
    
    { isActive = false, x = -216.55, y = -1648.85, z = 34.46, h = 178.71, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},
    
    { isActive = false, x = -64.21, y = -1449.42, z = 32.52, h = 189.08, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},
    
    { isActive = false, x = 16.61, y = -1443.84, z = 30.95, h = 152.44, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81}, 
    
    { isActive = false, x = 1435.69, y = 3667.22, z = 34.36, h = 289.06, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81}, --Sandy
    
    { isActive = false, x = 1759.92, y = 3821.97, z = 34.77, h = 27.78, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},
    
    { isActive = false, x = -15.16, y = 6557.55, z = 33.24, h = 315.38, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81}, --Paleto
    
    { isActive = false, x = -157.26, y = 6409.36, z = 31.92, h = 44.9, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},
    
    { isActive = false, x = -356.76, y = 6207.24, z = 31.84, h = 225.23, ItemLocations = { {x = 342.23, y = -1003.29, z = -99.0, robbed = false, quality = "low"}, 
    {x = 349.89, y = -1007.39, z = -99.2, robbed = false, quality = "low"}, {x = 341.48, y = -996.1, z = -98.63, robbed = false, quality = "low"}, {x = 338.16, y = -996.57, z = -99.2, robbed = false, quality = "low"},
    {x = 343.84, y = -1003.29, z = -99.2, robbed = false, quality = "low"}, {x = 352.56, y = -998.76, z = -98.64, robbed = false, quality = "low"}, {x = 349.18, y = -994.86, z = -99.2, robbed = false, quality = "low"}, {x = 347.23, y = -994.13, z = -99.2, robbed = false, quality = "low"},
    {x = 345.36, y = -997.05, z = -99.2, robbed = false, quality = "low"}, {x = 346.08, y = -1001.74, z = -99.2, robbed = false, quality = "low"} }, isOnCooldown = false, cooldown = 94, toX = 346.52, toY = -1013.19, toZ = -99.2, toH = 357.81},    

    { isActive = false, x = 201.33, y = 2442.05, z = 60.46, h = 265.2, ItemLocations = { {x = -903.0, y = -372.01, z = 113.11, robbed = false, quality = "med"},
    {x = -902.94, y = -363.36, z = 113.07, robbed = false, quality = "med"}, {x = -897.94, y = -364.94, z = 113.07, robbed = false, quality = "med"}, {x = -900.28, y = -368.47, z = 113.07, robbed = false, quality = "med"}, {x = -904.89, y = -377.16, z = 113.47, robbed = false, quality = "med"}, 
    {x = -919.05, y = -386.55, z = 113.67, robbed = false, quality = "med"}, {x = -928.52, y = -382.51, z = 113.67, robbed = false, quality = "med"}, {x = -930.81, y = -378.13, z = 113.67, robbed = false, quality = "med"}, {x = -926.49, y = -377.82, z = 113.67, robbed = false, quality = "med"},
    {x = -913.48, y = -376.49, z = 113.47, robbed = false, quality = "med"} }, isOnCooldown = false, cooldown = 94, toX = -919.41, toY = -368.52, toZ = 114.28, toH = 111.23},
    
    { isActive = false, x = -3193.57, y = 1208.93, z = 9.43, h = 353.54, ItemLocations = { {x = -903.0, y = -372.01, z = 113.11, robbed = false, quality = "med"},
    {x = -902.94, y = -363.36, z = 113.07, robbed = false, quality = "med"}, {x = -897.94, y = -364.94, z = 113.07, robbed = false, quality = "med"}, {x = -900.28, y = -368.47, z = 113.07, robbed = false, quality = "med"}, {x = -904.89, y = -377.16, z = 113.47, robbed = false, quality = "med"}, 
    {x = -919.05, y = -386.55, z = 113.67, robbed = false, quality = "med"}, {x = -928.52, y = -382.51, z = 113.67, robbed = false, quality = "med"}, {x = -930.81, y = -378.13, z = 113.67, robbed = false, quality = "med"}, {x = -926.49, y = -377.82, z = 113.67, robbed = false, quality = "med"},
    {x = -913.48, y = -376.49, z = 113.47, robbed = false, quality = "med"} }, isOnCooldown = false, cooldown = 94, toX = -919.41, toY = -368.52, toZ = 114.28, toH = 111.23},

    { isActive = false, x = -2977.37, y = 609.27, z = 20.25, h = 101.36, ItemLocations = { {x = -903.0, y = -372.01, z = 113.11, robbed = false, quality = "med"},
    {x = -902.94, y = -363.36, z = 113.07, robbed = false, quality = "med"}, {x = -897.94, y = -364.94, z = 113.07, robbed = false, quality = "med"}, {x = -900.28, y = -368.47, z = 113.07, robbed = false, quality = "med"}, {x = -904.89, y = -377.16, z = 113.47, robbed = false, quality = "med"}, 
    {x = -919.05, y = -386.55, z = 113.67, robbed = false, quality = "med"}, {x = -928.52, y = -382.51, z = 113.67, robbed = false, quality = "med"}, {x = -930.81, y = -378.13, z = 113.67, robbed = false, quality = "med"}, {x = -926.49, y = -377.82, z = 113.67, robbed = false, quality = "med"},
    {x = -913.48, y = -376.49, z = 113.47, robbed = false, quality = "med"} }, isOnCooldown = false, cooldown = 94, toX = -919.41, toY = -368.52, toZ = 114.28, toH = 111.23},

    { isActive = false, x = -1642.7, y = -412.09, z = 42.08, h = 235.59, ItemLocations = { {x = -903.0, y = -372.01, z = 113.11, robbed = false, quality = "med"},
    {x = -902.94, y = -363.36, z = 113.07, robbed = false, quality = "med"}, {x = -897.94, y = -364.94, z = 113.07, robbed = false, quality = "med"}, {x = -900.28, y = -368.47, z = 113.07, robbed = false, quality = "med"}, {x = -904.89, y = -377.16, z = 113.47, robbed = false, quality = "med"}, 
    {x = -919.05, y = -386.55, z = 113.67, robbed = false, quality = "med"}, {x = -928.52, y = -382.51, z = 113.67, robbed = false, quality = "med"}, {x = -930.81, y = -378.13, z = 113.67, robbed = false, quality = "med"}, {x = -926.49, y = -377.82, z = 113.67, robbed = false, quality = "med"},
    {x = -913.48, y = -376.49, z = 113.47, robbed = false, quality = "med"} }, isOnCooldown = false, cooldown = 94, toX = -919.41, toY = -368.52, toZ = 114.28, toH = 111.23},

    { isActive = false, x = -1103.65, y = -1013.86, z = 2.15, h = 27.75, ItemLocations = { {x = -903.0, y = -372.01, z = 113.11, robbed = false, quality = "med"},
    {x = -902.94, y = -363.36, z = 113.07, robbed = false, quality = "med"}, {x = -897.94, y = -364.94, z = 113.07, robbed = false, quality = "med"}, {x = -900.28, y = -368.47, z = 113.07, robbed = false, quality = "med"}, {x = -904.89, y = -377.16, z = 113.47, robbed = false, quality = "med"}, 
    {x = -919.05, y = -386.55, z = 113.67, robbed = false, quality = "med"}, {x = -928.52, y = -382.51, z = 113.67, robbed = false, quality = "med"}, {x = -930.81, y = -378.13, z = 113.67, robbed = false, quality = "med"}, {x = -926.49, y = -377.82, z = 113.67, robbed = false, quality = "med"},
    {x = -913.48, y = -376.49, z = 113.47, robbed = false, quality = "med"} }, isOnCooldown = false, cooldown = 94, toX = -919.41, toY = -368.52, toZ = 114.28, toH = 111.23},

    { isActive = false, x = -943.15, y = -1075.56, z = 2.75, h = 211.17, ItemLocations = { {x = -903.0, y = -372.01, z = 113.11, robbed = false, quality = "med"},
    {x = -902.94, y = -363.36, z = 113.07, robbed = false, quality = "med"}, {x = -897.94, y = -364.94, z = 113.07, robbed = false, quality = "med"}, {x = -900.28, y = -368.47, z = 113.07, robbed = false, quality = "med"}, {x = -904.89, y = -377.16, z = 113.47, robbed = false, quality = "med"}, 
    {x = -919.05, y = -386.55, z = 113.67, robbed = false, quality = "med"}, {x = -928.52, y = -382.51, z = 113.67, robbed = false, quality = "med"}, {x = -930.81, y = -378.13, z = 113.67, robbed = false, quality = "med"}, {x = -926.49, y = -377.82, z = 113.67, robbed = false, quality = "med"},
    {x = -913.48, y = -376.49, z = 113.47, robbed = false, quality = "med"} }, isOnCooldown = false, cooldown = 94, toX = -919.41, toY = -368.52, toZ = 114.28, toH = 111.23},    
    
    { isActive = false, x = -1970.21, y = 246.11, z = 97.81, h = 287.86, ItemLocations = { {x = -789.05, y = 320.79, z = 217.04, robbed = false, quality = "high"}, {x = -789.89, y = 322.83, z = 217.04, robbed = false, quality = "high"}, {x = -798.87, y = 327.71, z = 217.04, robbed = false},
    {x = -794.9, y = 325.71, z = 217.04, robbed = false, quality = "high"}, {x = -792.71, y = 329.09, z = 217.04, robbed = false, quality = "high"}, {x = -792.7, y = 332.08, z = 217.04, robbed = false, quality = "high"}, {x = -781.99, y = 330.65, z = 217.04, robbed = false, quality = "high"},
    {x = -781.42, y = 338.43, z = 216.84, robbed = false, quality = "high"}, {x = -793.41, y = 342.01, z = 216.84, robbed = false, quality = "high"}, {x = -800.2, y = 338.35, z = 220.44, robbed = false, quality = "high"},{x = -796.27, y = 327.6, z = 220.44, robbed = false, quality = "high"},
    {x = -799.15, y = 329.89, z = 220.44, robbed = false, quality = "high"}, {x = -805.56, y = 332.4, z = 220.44, robbed = false, quality = "high"} }, isOnCooldown = false, cooldown = 94, toX = -781.65, toY = 317.94, toZ = 217.64, toH = 359.26 },

    { isActive = false, x = -1938.13, y = 551.38, z = 114.83, h = 66.25, ItemLocations = { {x = -789.05, y = 320.79, z = 217.04, robbed = false, quality = "high"}, {x = -789.89, y = 322.83, z = 217.04, robbed = false, quality = "high"}, {x = -798.87, y = 327.71, z = 217.04, robbed = false},
    {x = -794.9, y = 325.71, z = 217.04, robbed = false, quality = "high"}, {x = -792.71, y = 329.09, z = 217.04, robbed = false, quality = "high"}, {x = -792.7, y = 332.08, z = 217.04, robbed = false, quality = "high"}, {x = -781.99, y = 330.65, z = 217.04, robbed = false, quality = "high"},
    {x = -781.42, y = 338.43, z = 216.84, robbed = false, quality = "high"}, {x = -793.41, y = 342.01, z = 216.84, robbed = false, quality = "high"}, {x = -800.2, y = 338.35, z = 220.44, robbed = false, quality = "high"},{x = -796.27, y = 327.6, z = 220.44, robbed = false, quality = "high"},
    {x = -799.15, y = 329.89, z = 220.44, robbed = false, quality = "high"}, {x = -805.56, y = 332.4, z = 220.44, robbed = false, quality = "high"} }, isOnCooldown = false, cooldown = 94, toX = -781.65, toY = 317.94, toZ = 217.64, toH = 359.26 },

    { isActive = false, x = -1405.12, y = 561.59, z = 125.41, h = 176.69, ItemLocations = { {x = -789.05, y = 320.79, z = 217.04, robbed = false, quality = "high"}, {x = -789.89, y = 322.83, z = 217.04, robbed = false, quality = "high"}, {x = -798.87, y = 327.71, z = 217.04, robbed = false},
    {x = -794.9, y = 325.71, z = 217.04, robbed = false, quality = "high"}, {x = -792.71, y = 329.09, z = 217.04, robbed = false, quality = "high"}, {x = -792.7, y = 332.08, z = 217.04, robbed = false, quality = "high"}, {x = -781.99, y = 330.65, z = 217.04, robbed = false, quality = "high"},
    {x = -781.42, y = 338.43, z = 216.84, robbed = false, quality = "high"}, {x = -793.41, y = 342.01, z = 216.84, robbed = false, quality = "high"}, {x = -800.2, y = 338.35, z = 220.44, robbed = false, quality = "high"},{x = -796.27, y = 327.6, z = 220.44, robbed = false, quality = "high"},
    {x = -799.15, y = 329.89, z = 220.44, robbed = false, quality = "high"}, {x = -805.56, y = 332.4, z = 220.44, robbed = false, quality = "high"} }, isOnCooldown = false, cooldown = 94, toX = -781.65, toY = 317.94, toZ = 217.64, toH = 359.26 },

    { isActive = false, x = -896.28, y = -4.85, z = 43.8, h = 303.89, ItemLocations = { {x = -789.05, y = 320.79, z = 217.04, robbed = false, quality = "high"}, {x = -789.89, y = 322.83, z = 217.04, robbed = false, quality = "high"}, {x = -798.87, y = 327.71, z = 217.04, robbed = false},
    {x = -794.9, y = 325.71, z = 217.04, robbed = false, quality = "high"}, {x = -792.71, y = 329.09, z = 217.04, robbed = false, quality = "high"}, {x = -792.7, y = 332.08, z = 217.04, robbed = false, quality = "high"}, {x = -781.99, y = 330.65, z = 217.04, robbed = false, quality = "high"},
    {x = -781.42, y = 338.43, z = 216.84, robbed = false, quality = "high"}, {x = -793.41, y = 342.01, z = 216.84, robbed = false, quality = "high"}, {x = -800.2, y = 338.35, z = 220.44, robbed = false, quality = "high"},{x = -796.27, y = 327.6, z = 220.44, robbed = false, quality = "high"},
    {x = -799.15, y = 329.89, z = 220.44, robbed = false, quality = "high"}, {x = -805.56, y = 332.4, z = 220.44, robbed = false, quality = "high"} }, isOnCooldown = false, cooldown = 94, toX = -781.65, toY = 317.94, toZ = 217.64, toH = 359.26 }
}

local isLockPicking = false
local isSearching = false
local currentRobbed = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = GetPlayerPed(-1)
        if DoesEntityExist(player) then
            local coords = GetEntityCoords(player)
            for i = 1, #BurglaryLocations, 1 do
                if not BurglaryLocations[i].isActive and not isLockPicking and not BurglaryLocations[i].isOnCooldown then
                    if IsPlayerInDoorZone() then
                        if GetDistanceBetweenCoords(coords, BurglaryLocations[i].x, BurglaryLocations[i].y, BurglaryLocations[i].z, true) < 1.5 then
                            if IsControlJustReleased(0, Keys["E"]) then
                                ESX.TriggerServerCallback("suku:DoesPlayerHaveItem", function(item)
                                    if item then
                                        AttemptPicklock(BurglaryLocations[i])
                                    else
                                        exports['mythic_notify']:DoHudText('inform', 'You need a lockpick!')
                                    end
                                end, "lockpick")
                                Citizen.Wait(2000)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function IsPlayerInDoorZone()
    local player = GetPlayerPed(-1)
    for i = 1, #BurglaryLocations, 1 do
        local coords = GetEntityCoords(player, true)
        if GetDistanceBetweenCoords(coords, BurglaryLocations[i].x, BurglaryLocations[i].y, BurglaryLocations[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function AttemptPicklock(location)
    isLockPicking = true
    SetEntityHeading(GetPlayerPed(-1), location.h - 180)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    TweekTaskTimer(10000, "Attempting Lockpick")
    randomSeed = math.random(1, 7)
    Citizen.Wait(10000)
    if randomSeed == 3 or randomSeed == 4 or randomSeed == 5 or randomSeed == 6 then
        exports['mythic_notify']:DoHudText('error', 'You have failed the attempt!')
        TriggerServerEvent("suku:BreakPicklock", 1)
        TriggerServerEvent('suku:StartBurglaryBlip', true, location)
        FreezeEntityPosition(GetPlayerPed(-1), false)
        isLockPicking = false
    else
        location.isActive = true
        TriggerServerEvent("suku:UpdateBurglariesToDB", BurglaryLocations)
        exports['mythic_notify']:DoHudText('success', 'Your attempt was successful!')
        local chance = math.random(1, 5)
        if chance == 5 then
            TriggerServerEvent("suku:BreakPicklock", 1)
        end

        local ClosestEntity = GetClosestPed(location.x, location.y, location.z, 20, 1, 0, 0, 0, 1)
        if DoesEntityExist(ClosestEntity) then
            print(" There is an entity")
            TriggerServerEvent('suku:StartBurglaryBlip', true, location)
        end
        FreezeEntityPosition(GetPlayerPed(-1), false)
        TeleportPlayerToInterior(location)
        isLockPicking = false
        ClearPedTasks(GetPlayerPed(-1))
    end
    isLockPicking = false
end

function SetLocationAsActive(location)
    for i = 1, #BurglaryLocations, 1 do
        if BurglaryLocations[i].isActive then
            BurglaryLocations[i].isActive = false
            BurglaryLocations[i].isOnCooldown = true
        end
    end
    location.isActive = true
    TriggerServerEvent("suku:UpdateBurglariesToDB", BurglaryLocations)
end

function TeleportPlayerToInterior(location)
    local player = GetPlayerPed(-1)
    SetEntityCoords(player, location.toX, location.toY, location.toZ - 1.0, 1, 0, 0, 1)
    SetEntityHeading(player, location.toH)
end

function IsPlayerInActiveExitZone()
    for i = 1, #BurglaryLocations, 1 do
        if BurglaryLocations[i].isActive then
            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(player)
            if GetDistanceBetweenCoords(coords, BurglaryLocations[i].toX, BurglaryLocations[i].toY, BurglaryLocations[i].toZ, true) < 1.5 then
                return true
            end
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = GetPlayerPed(-1)
        if DoesEntityExist(player) then
            local coords = GetEntityCoords(player)
            if IsPlayerInActiveExitZone() then
                for i = 1, #BurglaryLocations, 1 do
                    if BurglaryLocations[i].isActive then
                        ESX.Game.Utils.DrawText3D(vector3(BurglaryLocations[i].toX, BurglaryLocations[i].toY, BurglaryLocations[i].toZ), "Press ~r~E~s~ to leave", 0.6)
                        if GetDistanceBetweenCoords(coords, BurglaryLocations[i].toX, BurglaryLocations[i].toY, BurglaryLocations[i].toZ, true) < 1.5 then
                            if IsControlJustReleased(0, Keys["E"]) then
                                TeleportPlayerToOutside(BurglaryLocations[i])
                                Citizen.Wait(2000)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function TeleportPlayerToOutside(location)
    local player = GetPlayerPed(-1)
    for i = 1, #BurglaryLocations, 1 do
        if BurglaryLocations[i].isActive then
            SetEntityCoords(player, BurglaryLocations[i].x, BurglaryLocations[i].y, BurglaryLocations[i].z - 1.0, 1, 0, 0, 1)
            SetEntityHeading(player, BurglaryLocations[i].h)

            BurglaryLocations[i].isOnCooldown = true
            BurglaryLocations[i].isActive = false
        end
    end
    TriggerServerEvent("suku:UpdateBurglariesToDB", BurglaryLocations)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = GetPlayerPed(-1)
        if DoesEntityExist(player) then
            local coords = GetEntityCoords(player)
            for i = 1, #BurglaryLocations, 1 do
                if BurglaryLocations[i].isActive then
                    for j = 1, #BurglaryLocations[i].ItemLocations, 1 do
                        if GetDistanceBetweenCoords(coords, BurglaryLocations[i].ItemLocations[j].x, BurglaryLocations[i].ItemLocations[j].y, BurglaryLocations[i].ItemLocations[j].z, true) < 1.5 then
                            if not BurglaryLocations[i].ItemLocations[j].robbed then
                                ESX.Game.Utils.DrawText3D(vector3(BurglaryLocations[i].ItemLocations[j].x, BurglaryLocations[i].ItemLocations[j].y, BurglaryLocations[i].ItemLocations[j].z), "Press ~r~E~s~ to search", 0.6)
                            end

                            if IsControlJustReleased(0, Keys["E"]) and not BurglaryLocations[i].ItemLocations[j].robbed then
                                SearchLocation(BurglaryLocations[i].ItemLocations[j])
                                Citizen.Wait(2000)
                            end
                        end
                    end
                end
            end
        end
    end
end)

function SearchLocation(location)
    isSearching = true
    FreezeEntityPosition(GetPlayerPed(-1), true)
    TweekTaskTimer(5000, "Searching")
    Citizen.Wait(5000)
    location.robbed = true
    isSearching = false
    TriggerServerEvent("suku:UpdateBurglariesToDB", BurglaryLocations)
    TriggerServerEvent("suku:RewardPlayerSearchHouseSpot", location.quality)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    ClearPedTasks(GetPlayerPed(-1))
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isLockPicking then
            DisableInput()
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end

            if not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 3) then
                TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 8.0, 8.0, 14000, 50, 0, false, false, false)
            end
        end

        if isSearching then
            DisableInput()
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end

            if not IsEntityPlayingAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 3) then
                TaskPlayAnim(PlayerPedId(), "mp_arresting", "a_uncuff", 8.0, 8.0, 5000, 50, 0, false, false, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for i = 1, #BurglaryLocations, 1 do
            if BurglaryLocations[i].isActive then
                for j = 1, #BurglaryLocations[i].ItemLocations, 1 do
                    if BurglaryLocations[i].ItemLocations[j].robbed then
                        table.insert(currentRobbed, BurglaryLocations[i].ItemLocations[j])
                        break
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for i = 1, #BurglaryLocations, 1 do
            if BurglaryLocations[i].isOnCooldown and BurglaryLocations[i].cooldown > 0 then
                BurglaryLocations[i].cooldown = BurglaryLocations[i].cooldown - 1

                if BurglaryLocations[i].cooldown <= 0 and BurglaryLocations[i].isOnCooldown then
                    BurglaryLocations[i].isOnCooldown = false
                    BurglaryLocations[i].cooldown = 94
                end
                TriggerServerEvent("suku:UpdateBurglariesToDB", BurglaryLocations)
                Citizen.Wait(60 * 1000)
            end
        end
    end
end)

local blipRobbery = nil

RegisterNetEvent('suku:SetBurglaryBlip')
AddEventHandler('suku:SetBurglaryBlip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 1)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('suku:killblip')
AddEventHandler('suku:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('suku:ManageBlip')
AddEventHandler('suku:ManageBlip', function(BlipState)
    local state = BlipState
    local BlipTime = 20

    Citizen.CreateThread(function()
        while state do
            Citizen.Wait(1000)
            if BlipTime > 0 then
                BlipTime = BlipTime - 1
            end

            if BlipTime <= 0 then
                TriggerEvent('suku:killblip')
                BlipTime = 20
                state = false
            end
        end
    end)
end)

function TweekTaskTimer(time, message)
    exports['progressBars']:startUI(time, message)
end

RegisterNetEvent("suku:NotifyBurgPlayer")
AddEventHandler("suku:NotifyBurgPlayer", function(type, message)
    exports['mythic_notify']:DoHudText(type, message)
end)

function DisableInput()
    DisableControlAction(0, 24, true) -- Attack
	DisableControlAction(0, 257, true) -- Attack 2
	DisableControlAction(0, 25, true) -- Aim
	DisableControlAction(0, 263, true) -- Melee Attack 1
	DisableControlAction(0, 32, true) -- W
	DisableControlAction(0, 34, true) -- A
	DisableControlAction(0, 31, true) -- S
	DisableControlAction(0, 30, true) -- D

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