local pickuppos = {["x"] = 0.0, ["y"] = 0.0, ["z"] = 0.0}
local pickupspawned = false
local pickups = {}
local k = 1
local pickupmodel = GetHashKey("p_michael_backpack_s")
local ped = GetPlayerPed(-1)
local pickupSecondaryInventory = {
    type = "pickup",
    owner = ""
}

pickup = 0
function createPickup(x, y, z)
    pickupspawned = true
    pickuppos = {["x"] = x, ["y"] = y, ["z"] = z}
    RequestModel(pickupmodel)
    while not HasModelLoaded(pickupmodel) do
        Citizen.Wait(100)
    end
    pickup = CreateObject(pickupmodel, x, y + 0.5, z, true, false, false)
    PlaceObjectOnGroundProperly(pickup)
    FreezeEntityPosition(pickup, true)
end

--[[  Test pickup function
RegisterCommand('createp', function(args, raw)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    createPickup(coords.x,coords.y,coords.z)
    

end)
--]]
RegisterCommand(
    "deletep",
    function(args, raw)
        DeleteObject(pickup)
        if pickups ~= nil then
            TriggerServerEvent("pickupItem", pickups[1].item, pickups[1].qty)
            pickupspawned = false
            pickups = {}
        else
            print("yea")
        end
    end
)

RegisterNetEvent("registerItem") -- Step 2
AddEventHandler("registerItem", function(item, count)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        createPickup(coords.x, coords.y, coords.z)
        pickups[k] = {
            uid = k,
            item = item.id,
            qty = count,
            ["x"] = coords.x,
            ["y"] = coords.y,
            ["z"] = coords.z
        }
        TriggerServerEvent("inv:createPickup", pickups[k], k)
        print("Created pickup")
        print(json.encode(pickups[k]))
        k = k + 1
    end
)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        for i = 1, #pickups do
                local pickupcheck =GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), pickups[i]["x"], pickups[i]["y"], pickups[i]["z"], true)
                if pickupcheck <= 3 then
                    Draw3DText(pickups[i]["x"], pickups[i]["y"], pickups[i]["z"] + 0.1, "[Press ~p~E~w~ to search the bag]", 255, 255, 255, 255, 4, 0.45, true, true, true, true, 0, 0, 0, 0, 55)
                    if IsControlJustPressed(1, 38) then
                        local itempick = "pickup - " .. pickups[i].uid
                        pickupSecondaryInventory.owner = itempick
                        openInventory(pickupSecondaryInventory)
                        local ox, oy, oz = table.unpack(GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, -2.0))
                        itempickup = GetClosestObjectOfType(ox, oy, oz, 1.5, pickupmodel, true, false, false)
                        print(itempickup)
                        print(ox, oy, oz)
                        DeleteObject(itempickup)
                    end
                end
            end
        end
    end
)

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
