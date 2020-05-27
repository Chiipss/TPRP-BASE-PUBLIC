local storageSecondaryInventory = {
    type = 'storage',
    owner = 'XYZ123'
}

Citizen.CreateThread(function()
    for k,v in pairs(Config.storageLockers) do
        local lockerBlip = AddBlipForCoord(v.coords)

        SetBlipSprite(lockerBlip, 255)
        SetBlipDisplay(lockerBlip, 4)
        SetBlipScale(lockerBlip, 0.9)
        SetBlipColour(lockerBlip, 46)
        SetBlipAsShortRange(lockerBlip, true)


        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(lockerBlip)
    end
end)

Citizen.CreateThread(function()
    while not ESXLoaded do
        Citizen.Wait(10)
    end
    for k, v in pairs(Config.storageLockers) do
        local marker = {
            name = k,
            type = v.markerType or 1,
            coords = v.coords,
            colour = v.markerColour or { r = 55, b = 255, g = 55 },
            size = v.size or vector3(1.0, 1.0, 1.0),
            businessname = v.businessname,
            action = function()
                lockerMenu(v.doorname, v.businessname, v.price)
            end,
            shouldDraw = function()
                return ESX.PlayerData.job.name == v.job or v.job == 'all'
            end,
            msg = v.msg or 'Press ~INPUT_CONTEXT~ to open Stash',
        }
        TriggerEvent('disc-base:registerMarker', marker)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local player = GetPlayerPed(-1)
        local coords = GetEntityCoords(player)
        for k, v in pairs(Config.storageLockers) do
            if GetDistanceBetweenCoords(coords, v.coords, true) < 3.0 then
                ESX.Game.Utils.DrawText3D(vector3(v.coords), "[~g~E~w~] Open Storage Locker", 0.6)
            end
        end
    end
end)

function lockerMenu(lockerName, businessName, price)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local menuelements = {}

    ESX.TriggerServerCallback('tp:storage:checkLocker', function(cb)
        if cb == 'true' then
            table.insert(menuelements, {
                ["label"] = "<span style='color:green'>Open your locker</span>", 
                ["action"] = "open"
            })
        elseif cb == 'false' then
            table.insert(menuelements, {
                ["label"] = "You don't own a locker - Rent a locker", 
                ["action"] = "rent"
            })
        elseif cb == 'unpaid' then
            table.insert(menuelements, {
                ["label"] = "<span style='color:red'>Payment Overdue - Pay your rent</span>", 
                ["action"] = "pay"
            })
        else
            print("LOCKER ERROR: Something went wrong")
        end

        if ESX.PlayerData.job.name == "police" then -- possible grade check
            table.insert(menuelements, {
                ["label"] = "Raid a locker - <span style='color:red'>Authorisaton Required</span>", 
                ["action"] = "raid"
            })
        end
    
        if ESX.PlayerData.job.name == "lawyer" and ESX.PlayerData.job.grade >= 2 then -- add grade check
            table.insert(menuelements, {
                ["label"] = "DoJ Authorisation - <span style='color:red'>Manage Codes<span>", 
                ["action"] = "lawyer"
            })
        end
    
        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_locker_menu", {
            ["title"] = businessName .. " - $" .. price .. " per week!",
            ["align"] = "right",
            ["elements"] = menuelements
        }, function(menuData, menuHandle)
            local currentAction = menuData["current"]["action"]
            
            if currentAction == "rent" then
                newLocker(lockerName, businessName, price)
                menuHandle.close()
            elseif currentAction == "open" then
                openLocker(lockerName)
                menuHandle.close()
            elseif currentAction == "pay" then
                payLockerFee(lockerName, businessName, price)
                menuHandle.close()
            elseif currentAction == "raid" then
                raidLocker(lockerName)
                menuHandle.close()
            elseif currentAction == "lawyer" then
                lawyerLockerMenu()
                menuHandle.close()
            end
    
        end, function(menuData, menuHandle)
            menuHandle.close()
        end, function(menuData, menuHandle)
            local currentAction = menuData["current"]["action"]
        end)

    end, lockerName)

end

function openLocker(lockerName)
    local playerPed = PlayerPedId()
        ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)
        storageSecondaryInventory.owner = identifier
        storageSecondaryInventory.type = lockerName
        openInventory(storageSecondaryInventory) 
    end, GetPlayerServerId(NetworkGetEntityOwner(playerPed)))
end

function newLocker(lockerName, businessName, price)

    local menuelements2 = {}

    table.insert(menuelements2, {
        ["label"] = "<span style='color:green'>Yes</span>", 
        ["action"] = "yes"
    })
    table.insert(menuelements2, {
        ["label"] = "<span style='color:red'>No</span>", 
        ["action"] = "no"
    })

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_locker_menu2", {
        ["title"] = "Are you sure? - $" .. price .. " per week!",
        ["align"] = "right",
        ["elements"] = menuelements2
    }, function(menuData3, menuHandle3)
        local currentAction = menuData3["current"]["action"]
        
        if currentAction == "yes" then
            local playerPed = PlayerPedId()
            menuHandle3.close()
            ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)
                TriggerServerEvent('tp:storage:newLocker', identifier, lockerName)
            end, GetPlayerServerId(NetworkGetEntityOwner(playerPed)))
            menuHandle3.close()
        elseif currentAction == "no" then
            menuHandle3.close()
        end
    end, function(menuData3, menuHandle3)
        menuHandle3.close()
    end, function(menuData3, menuHandle3)
        local currentAction = menuData3["current"]["action"]
    end)
end

function payLockerFee(lockerName, businessName, price)


    local menuelements2 = {}

    table.insert(menuelements2, {
        ["label"] = "<span style='color:green'>Yes</span>", 
        ["action"] = "yes"
    })
    table.insert(menuelements2, {
        ["label"] = "<span style='color:red'>No</span>", 
        ["action"] = "no"
    })

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_locker_menu2", {
        ["title"] = "Are you sure? - $" .. price .. " per week!",
        ["align"] = "right",
        ["elements"] = menuelements2
    }, function(menuData3, menuHandle3)
        local currentAction = menuData3["current"]["action"]
        
        if currentAction == "yes" then
            local playerPed = PlayerPedId()
            menuHandle3.close()
            ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)
                TriggerServerEvent('tp:storage:payLockerRent', identifier, lockerName)
            end, GetPlayerServerId(NetworkGetEntityOwner(playerPed)))
            menuHandle3.close()
        elseif currentAction == "no" then
            menuHandle3.close()
        end
    end, function(menuData3, menuHandle3)
        menuHandle3.close()
    end, function(menuData3, menuHandle3)
        local currentAction = menuData3["current"]["action"]
    end)
end

function raidLocker(lockerName)
    local playerPed = PlayerPedId()
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Raid Menu', {title = "Enter Lock Owner ID"},
    function(data2, menu2)
        local lockerid = tonumber(data2.value)
        menu2.close()
        ESX.TriggerServerCallback('disc-inventoryhud:getIdentifier', function(identifier)
            ESX.TriggerServerCallback('tp:storage:checkRaidedLocker', function(cb)
                if cb == 'true' then
                    raidAuthorisation(lockerid, identifier, lockerName)
                elseif cb == 'false' then
                    exports['mythic_notify']:SendAlert('error', 'We don\'t have that customer here!', 10000)
                end
            end, identifier, lockerName)
        end, lockerid)
    end,
    function(data2, menu2)
        menu2.close()
        ESX.UI.Menu.CloseAll()
    end)
end

function raidAuthorisation(lockerid, identifier, lockerName)
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Raid Menu', {title = "Enter Authorisation Code"},
    function(data3, menu3)
        local authCode = tostring(data3.value)
        menu3.close()
        ESX.TriggerServerCallback('tp:storage:checkAuthCode', function(cb)
            if cb == 'correct' then
                storageSecondaryInventory.owner = identifier
                storageSecondaryInventory.type = lockerName
                openInventory(storageSecondaryInventory)
                TriggerServerEvent('tp:storage:notifyRaid', lockerid)
            elseif cb == 'expired' then
                exports['mythic_notify']:SendAlert('error', 'The auth code you entered has expired!', 10000)
            elseif cb == 'invalid' then
                exports['mythic_notify']:SendAlert('error', 'The auth code you entered was invalid!', 10000)
            end
        end, authCode)
    end,
    function(data3, menu3)
        menu3.close()
        ESX.UI.Menu.CloseAll()
    end)
end

function lawyerLockerMenu()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local menuelements = {}

    ESX.TriggerServerCallback("tp:storage:getAuthCodes", function(fetchedCodes)
        for k, v in pairs(fetchedCodes) do
            if v["active"] == 'true' then
                table.insert(menuelements, {
                    ["label"] = "<span style='color:green'>Active</span> - Code: " .. v["code"] .. " Used " .. v["used"] .. " times.",
                    ["action"] = "manage",
                    ["code"] = v["code"],
                    ["active"] = v["active"]
                })
            else
                table.insert(menuelements, {
                    ["label"] = "<span style='color:red'>Expired</span> - Code: " .. v["code"] .. " Used " .. v["used"] .. " times.",
                    ["action"] = "manage",
                    ["code"] = v["code"],
                    ["active"] = v["active"]
                })
            end
        end

        table.insert(menuelements, {
            ["label"] = "Generate New Code",
            ["action"] = "newcode"
        })

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_locker_menu", {
            ["title"] = "Storage Authorisation Menu",
            ["align"] = "right",
            ["elements"] = menuelements
        }, function(menuData, menuHandle)
            local currentAction = menuData["current"]["action"]
            
            if currentAction == "close" then
                menuHandle.close()
            elseif currentAction == "manage" then
               menuHandle.close()
               codeOptionsMenu(menuData["current"])
            elseif currentAction == "newcode" then
                TriggerServerEvent('tp:storage:generateAuthCode')
                menuHandle.close()
                lawyerLockerMenu()
            end
    
        end, function(menuData, menuHandle)
            menuHandle.close()
        end, function(menuData, menuHandle)
            local currentAction = menuData["current"]["action"]
        end)

    end)
end

function codeOptionsMenu(menudatacurrent)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local menuelements = {}

    table.insert(menuelements, {
        ["label"] = "Delete Code",
        ["action"] = "delcode"
    })

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_locker_menu", {
        ["title"] = menudatacurrent["code"] .. " - code options",
        ["align"] = "right",
        ["elements"] = menuelements
    }, function(menuData, menuHandle)
        local currentAction = menuData["current"]["action"]
        
        if currentAction == "delcode" then
            TriggerServerEvent('tp:storage:removeAuthCode', menudatacurrent["code"])
            menuHandle.close()
            lawyerLockerMenu()
        end

    end, function(menuData, menuHandle)
        menuHandle.close()
        lawyerLockerMenu()
    end, function(menuData, menuHandle)
        local currentAction = menuData["current"]["action"]
    end)
end