
--- on server restart, math random to load 3 positions out of the list,
--- information can be got from a random place similar to shady backalley dude



ESX = nil
finished = nil
local insideMarker = false
local activeShops = {}
local saleItems = {}

Citizen.CreateThread(function()
    math.randomseed(GetGameTimer())
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('onResourceStart', function(r)
    if r == GetCurrentResourceName() then
        print('big boobs')
        TriggerServerEvent('tp-pawnshop:requestShops')
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    TriggerServerEvent('tp-pawnshop:requestShops')
end)

RegisterNetEvent('tp-pawnshop:sendShops')
AddEventHandler('tp-pawnshop:sendShops', function(sv_activeShops, sv_saleItems)
    print("received server data")
    print(json.encode(sv_activeShops))
    print(json.encode(sv_saleItems))
    activeShops = sv_activeShops
    saleItems = sv_saleItems
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        for k,v in pairs(activeShops) do
            for i = 1, #activeShops, 1 do
                local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, activeShops[i].x, activeShops[i].y, activeShops[i].z, true)
                if (distance < 1.5) and insideMarker == false then
                    DrawMarker(Config.ShopMarker, activeShops[i].x, activeShops[i].y, activeShops[i].z-0.985, 0.0, 0.0, 0.0, 0.0, 0, 0.0, Config.ShopMarkerScale.x, Config.ShopMarkerScale.y, Config.ShopMarkerScale.z, Config.ShopMarkerColor.r,Config.ShopMarkerColor.g,Config.ShopMarkerColor.b,Config.ShopMarkerColor.a, false, false, 2, false, false, false, false)
                end
                if (distance < 0.5) and insideMarker == false then
                    DrawText3Ds(activeShops[i].x, activeShops[i].y, activeShops[i].z, Config.ShopDraw3DText)
                    if IsControlJustPressed(0, 38) then
                        OpenPawnShop(i)
                        insideMarker = true
                        Citizen.Wait(500)
                    end
                end
            end
        end
    end
end)

function OpenPawnShop(shopNumber)
    print(shopNumber)
    local player = PlayerPedId()
    FreezeEntityPosition(player, true)
    local elements = {}

    for k,v in pairs(saleItems) do
        if v.shop == shopNumber then
            table.insert(elements, {
                label = v.Label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.SellPrice..""),
                itemName = v.itemName,
                SellPrice = v.SellPrice
            })
        end
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tp-pawnshop-menu',
    {
        title = "Sell me stuff",
        align = "bottom-right",
        elements = elements
    },
    function(data, menu)
        if data.current.itemName == data.current.itemName then
            OpenSellDialogMenu(data.current.itemName, data.current.SellPrice)
        end
    end, function(data, menu)
        menu.close()
        insideMarker = false
        FreezeEntityPosition(player, false)
    end,function(data,menu)
    end)
end

function OpenSellDialogMenu(itemName, SellPrice)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'tp-pawnshop-menu-sell', {
		title = "Amount to Sell?"
	}, function(data, menu)
		menu.close()
		amountToSell = tonumber(data.value)
		totalSellPrice = (SellPrice * amountToSell)
        TriggerServerEvent("tp-pawnshop:SellItem",amountToSell,totalSellPrice,itemName)
        print(totalSellPrice)
	end,
	function(data, menu)
		menu.close()
	end)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end