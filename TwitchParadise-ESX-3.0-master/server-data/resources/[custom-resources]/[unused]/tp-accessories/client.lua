ESX     = nil
local HasAlreadyEnteredMarker, isDead, isInMarker       = false, false, false
local LastZone, CurrentAction, currentZone                      = nil, nil, nil
local CurrentActionMsg                                  = ''
local CurrentActionData, validBags, validEyes, validEars, validHelm, validMask          = {}, {}, {}, {}, {}, {}
local reverseHats = { [9] = 10, [44] = 45, [50] = 68, [51] = 69, [52] = 70, [53] = 71, [62] = 72, [65] = 66, [73] = 74, [76] = 77, [78] = 79, [80] = 81, [82] = 67, 
        [91] = 92, [109] = 110, [116] = 117, [118] = 119, [123] = 124, [125] = 126, [127] = 128, [130] = 131
}

Citizen.CreateThread(function()
        while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(1)
        end
        if Config.BagRequired then
                for i = 0,80, 1 do
                        table.insert(validBags, i)
                        for g,f in pairs(validBags) do
                                for k,v in pairs(Config.InvalidBags) do
                                        if f == v then
                                                table.remove(validBags, g)
                                        end
                                end
                        end
                end
        end
        
        for i = 0,27, 1 do
                table.insert(validEyes, i)
                for g,f in pairs(validEyes) do
                        for k,v in pairs(Config.InvalidEyes) do
                                if f == v then
                                        table.remove(validEyes, g)
                                end
                        end
                end
                table.insert(validEars, i)
                for g,f in pairs(validEars) do
                        for k,v in pairs(Config.InvalidEars) do
                                if f == v then
                                        table.remove(validEars, g)
                                end
                        end
                end
        end
        
        for i = -1,134, 1 do
                table.insert(validHelm, i)
                for g,f in pairs(validHelm) do
                        for k,v in pairs(Config.InvalidHelm) do
                                if f == v then
                                        table.remove(validHelm, g)
                                end
                        end
                end
        end

        for i = 0,147, 1 do
                table.insert(validMask, i)
                for g,f in pairs(validMask) do
                        for k,v in pairs(Config.InvalidMask) do
                                if f == v then
                                        table.remove(validMask, g)
                                end
                        end
                end
        end
        
        if Config.UseBlips then
                for k,v in pairs(Config.Pos) do
                        if k == 'Mask' then
                                for g,f in ipairs(v) do
                                        local blip = AddBlipForCoord(f)

                                        SetBlipSprite (blip, 362)
                                        SetBlipDisplay(blip, 4)
                                        SetBlipScale  (blip, 0.6)
                                        SetBlipColour (blip, 2)
                                        SetBlipAsShortRange(blip, true)

                                        BeginTextCommandSetBlipName("STRING")
                                        AddTextComponentString(k .. ' Shop')
                                        EndTextCommandSetBlipName(blip)
                                end
                        end
                end
        end
end)

SetUnsetAccessory = function(accessory, data)

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local headin = GetEntityHeading(ped)
        local dict
        if accessory == 'mask' then
                dict = 'anim@mp_player_intcelebrationmale@face_palm'
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(1)
                end
                TaskPlayAnimAdvanced(ped, dict, 'face_palm', coords, 0.0, 0.0, headin, 2.0, 1.0, 600, 49, 0.3, 1, 1)
                Citizen.Wait(600)
                RemoveAnimDict(dict)
        elseif accessory == 'helmet' then
                dict = 'amb@code_human_wander_idles@female@idle_b'
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(1)
                end
                TaskPlayAnimAdvanced(ped, dict, 'idle_e_wipeforehead', coords, 0.0, 0.0, headin, 2.0, 1.0, 600, 49, 0.2, 1, 1)
                Citizen.Wait(600)
                RemoveAnimDict(dict)
        elseif accessory == 'glasses' then
                dict = 'clothingspecs'
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(1)
                end
                TaskPlayAnimAdvanced(ped, dict, 'take_off', coords, 0.0, 0.0, headin, 1.0, 1.0, 1000, 49, 0.0, 1, 1)
                Citizen.Wait(1000)
                RemoveAnimDict(dict)
        elseif accessory == 'ears' then
                dict = 'mp_cp_stolen_tut'
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(1)
                end
                TaskPlayAnimAdvanced(ped, dict, 'b_think', coords, 0.0, 0.0, headin, 1.0, 1.0, 1000, 49, 0.0, 1, 1)
                Citizen.Wait(1000)
                RemoveAnimDict(dict)
        end
        TriggerEvent('skinchanger:getSkin', function(skin)
                local mAccessory = -1
                local mColor = 0

                if accessory == "mask" then
                        mAccessory = 0
                end
                
                local data = json.decode(data)
                if skin[accessory .. '_1'] ~= data[accessory .. '_1'] or skin[accessory .. '_2'] ~= data[accessory .. '_2'] then
                        mAccessory = data[accessory .. '_1']
                        mColor = data[accessory .. '_2']
                end
                
                if skin[accessory .. '_1'] == mAccessory then
                        mAccessory = data[accessory .. '_1']
                        mColor = data[accessory .. '_2']
                end

                data[accessory .. '_1'] = mAccessory
                data[accessory .. '_2'] = mColor
                TriggerEvent('skinchanger:loadClothes', skin, data)
        end)
        TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
        end)
end

ReverseHat = function()
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local headin = GetEntityHeading(ped)
        local data = {}
        TriggerEvent('skinchanger:getSkin', function(skin)
                for k,v in pairs(reverseHats) do
                        if skin['helmet_1'] == k then
                                data['helmet_1'] = v
                                data['helmet_2'] = skin['helmets_2']
                        elseif skin['helmet_1'] == v then
                                data['helmet_1'] = k
                                data['helmet_2'] = skin['helmets_2']
                        end
                end
                local dict = 'amb@code_human_wander_idles@female@idle_b'
                RequestAnimDict(dict)
                while not HasAnimDictLoaded(dict) do
                        Citizen.Wait(1)
                end
                TaskPlayAnimAdvanced(ped, dict, 'idle_e_wipeforehead', coords, 0.0, 0.0, headin, 2.0, 1.0, 600, 49, 0.2, 1, 1)
                Citizen.Wait(600)
                RemoveAnimDict(dict)
                TriggerEvent('skinchanger:loadClothes', skin, data)
        end)
        TriggerEvent('skinchanger:getSkin', function(skin)
                TriggerServerEvent('esx_skin:save', skin)
        end)
end

SecondAccessoryMenu = function(accessory)
        local elements = {}
        if accessory == 'helmet' then
                ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                        if hasAces == true then
                                for k,v in pairs(skinTab) do
                                        for g,f in pairs(v) do
                                                if g == 'id' then
                                                        table.insert(elements, {label = v.name, value = v.data})
                                                end
                                        end
                                end
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                {
                                        title    = Config.HelmetMenu,
                                        align    = 'top-left',
                                        elements = elements
                                }, function(data2, menu2)

                                        SetUnsetAccessory(accessory, data2.current.value)

                                end, function(data2, menu2)
                                        menu2.close()
                                end)
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.NoHelmet)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NoHelmet, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.NoHelmet)
                                end
                        end
                end, accessory)
        elseif accessory == 'ears' then
                ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                        if hasAces == true then
                                for k,v in pairs(skinTab) do
                                        for g,f in pairs(v) do
                                                if g == 'id' then
                                                        table.insert(elements, {label = v.name, value = v.data})
                                                end
                                        end
                                end
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                {
                                        title    = Config.EarsMenu,
                                        align    = 'top-left',
                                        elements = elements
                                }, function(data2, menu2)

                                        SetUnsetAccessory(accessory, data2.current.value)

                                end, function(data2, menu2)
                                        menu2.close()
                                end)
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.NoEars)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NoEars, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.NoEars)
                                end
                        end
                end, accessory)
        elseif accessory == 'mask' then
                ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                        if hasAces == true then
                                for k,v in pairs(skinTab) do
                                        for g,f in pairs(v) do
                                                if g == 'id' then
                                                        table.insert(elements, {label = v.name, value = v.data})
                                                end
                                        end
                                end
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                {
                                        title    = Config.MaskMenu,
                                        align    = 'top-left',
                                        elements = elements
                                }, function(data2, menu2)

                                        SetUnsetAccessory(accessory, data2.current.value)

                                end, function(data2, menu2)
                                        menu2.close()
                                end)
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.NoMask)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NoMask, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.NoMask)
                                end
                        end
                end, accessory)
        elseif accessory == 'glasses' then
                ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                        if hasAces == true then
                                for k,v in pairs(skinTab) do
                                        for g,f in pairs(v) do
                                                if g == 'id' then
                                                        table.insert(elements, {label = v.name, value = v.data})
                                                end
                                        end
                                end
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                {
                                        title    = Config.GlassesMenu,
                                        align    = 'top-left',
                                        elements = elements
                                }, function(data2, menu2)

                                        SetUnsetAccessory(accessory, data2.current.value)

                                end, function(data2, menu2)
                                        menu2.close()
                                end)
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.NoEyes)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NoEyes, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.NoEyes)
                                end
                        end
                end, accessory)
        elseif accessory == 'bags' then
                ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                        if hasAces == true then
                                for k,v in pairs(skinTab) do
                                        for g,f in pairs(v) do
                                                if g == 'id' then
                                                        table.insert(elements, {label = v.name, value = v.data})
                                                end
                                        end
                                end
                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                {
                                        title    = Config.BagsMenu,
                                        align    = 'top-left',
                                        elements = elements
                                }, function(data2, menu2)

                                        SetUnsetAccessory(accessory, data2.current.value)

                                end, function(data2, menu2)
                                        menu2.close()
                                end)
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.NoBags)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NoBags, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.NoBags)
                                end
                        end
                end, accessory)
        end
end


RegisterNetEvent('esx_accessoryPack:openPack')
AddEventHandler('esx_accessoryPack:openPack', function()
        --[[ if Config.BagRequired then
                if Config.Mythic then
                        exports['mythic_notify']:SendAlert('inform', Config.RightBag)
                elseif Config.Pnotif then
                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.RightBag, type = 'error', timeout = 5000})
                else
                        ESX.ShowNotification(Config.RightBag)
                end
                local elements = {}
                TriggerEvent('skinchanger:getSkin', function(skin)
                        for i = 1,#validBags do
                                if skin['bags_1'] == validBags[i] then
                                        table.insert(elements, {label = Config.ClosePack, value = 'close'})
                                        table.insert(elements, {label = Config.Helmets, value = 'helmet'})
                                        table.insert(elements, {label = Config.EarPiece, value = 'ears'})
                                        table.insert(elements, {label = Config.Masks, value = 'mask'})
                                        table.insert(elements, {label = Config.Glasses, value = 'glasses'})
                                        if Config.CanStoreBags then
                                                table.insert(elements, {label = Config.BagList, value = 'bags'})
                                        end
                                end
                        end
                        for k,v in pairs(reverseHats) do
                                if skin['helmet_1'] == k or skin['helmet_1'] == v then
                                        table.insert(elements, {label = Config.ReverseHat, value = 'swap'})
                                end
                        end
                end)
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_accessory_category',
                {
                        title = Config.ChooseType,
                        align = 'top-left',
                        elements = elements
                }, function(data, menu)
                        if data.current.value == 'close' then
                                menu.close()
                        elseif data.current.value == 'swap' then
                                ReverseHat()
                        else
                                SecondAccessoryMenu(data.current.value)
                        end

                end, function(data, menu)
                        menu.close()
                end)
        else ]]
                local elements = {
                        {label = Config.ClosePack, value = 'close'},
                        {label = Config.Helmets, value = 'helmet'},
                        {label = Config.EarPiece, value = 'ears'},
                        {label = Config.Masks, value = 'mask'},
                        {label = Config.Glasses, value = 'glasses'}
                }
                TriggerEvent('skinchanger:getSkin', function(skin)
                if Config.CanStoreBags then
                        table.insert(elements, {label = Config.BagList, value = 'bags'})
                end
                for k,v in pairs(reverseHats) do
                        if skin['helmet_1'] == k or skin['helmet_1'] == v then
                                table.insert(elements, {label = Config.ReverseHat, value = 'swap'})
                        end
                end
        end)
                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_accessory_category',
                {
                        title = Config.ChooseType,
                        align = 'top-left',
                        elements = elements
                }, function(data, menu)
                        if data.current.value == 'close' then
                                menu.close()
                        elseif data.current.value == 'swap' then
                                ReverseHat()
                        else
                                SecondAccessoryMenu(data.current.value)
                        end

                end, function(data, menu)
                        menu.close()
                end)
        --end
end)

DeleteMenu = function(name, item)
        ESX.UI.Menu.CloseAll()
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_confirm',
        {
                title = Config.ConfirmDelete,
                align = 'top-left',
                elements = {
                        {label = Config.Decline, value = 'no'},
                        {label = Config.Delete, value = 'yes'}
                }
        }, function(data, menu)
                menu.close()
                if data.current.value == 'yes' then
                        TriggerServerEvent('esx_accessoryPack:removeItem', name, item)
                elseif data.current.value == 'no' then
                        menu.close()
                end
        end, function(data, menu)
        end)
end

OpenShopMenu = function(accessory)
        local _accessory = string.lower(accessory)
        local restrict = {}

        restrict = { _accessory .. '_1', _accessory .. '_2' }
        
        TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)
                
                if _accessory == 'bags' then
                        local bag = data.current.value
                        if data.current.label == Config.BagSkinMenu then
                                for i = 1,#Config.InvalidBags do
                                        if bag == Config.InvalidBags[i] then
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                end)
                                                if Config.Mythic then
                                                        exports['mythic_notify']:SendAlert('inform', Config.CannotBuy)
                                                elseif Config.Pnotif then
                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.CannotBuy, type = 'error', timeout = 5000})
                                                else
                                                        ESX.ShowNotification(Config.CannotBuy)
                                                end
                                                menu.close()
                                        end
                                end
                                for i = 1,#validBags do
                                        if bag == validBags[i] then
                                                menu.close()

                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
                                                {
                                                        title = Config.ConfirmBuy,
                                                        align = 'top-left',
                                                        elements = {
                                                                {label = Config.Decline, value = 'no'},
                                                                {label = Config.Accept .. ESX.Math.GroupDigits(Config.Price), value = 'yes'}
                                                        }
                                                }, function(data, menu)
                                                        menu.close()
                                                        if data.current.value == 'yes' then
                                                                if Config.ItemLimit then
                                                                        local elements = {}
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                                                                                if hasAces == true then
                                                                                        for k,v in pairs(skinTab) do
                                                                                                for g,f in pairs(v) do
                                                                                                        if g == 'id' then
                                                                                                                table.insert(elements, {label = v.name, value = v.data})
                                                                                                        end
                                                                                                end
                                                                                        end
                                                                                        if #elements >= Config.BagLimit then
                                                                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                                                                                {
                                                                                                        title    = Config.DeleteMenu,
                                                                                                        align    = 'top-left',
                                                                                                        elements = elements
                                                                                                }, function(data2, menu2)
                                                                                                        
                                                                                                        DeleteMenu(data2.current.label, 'bags')
                                                                                                        local player = PlayerPedId()
                                                                                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                        end)

                                                                                                end, function(data2, menu2)
                                                                                                        menu2.close()
                                                                                                end)
                                                                                        else
                                                                                                ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                                        if hasEnoughMoney then
                                                                                                                TriggerServerEvent('esx_accessoryPack:pay')
                                                                                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                                        TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                                        TriggerServerEvent('esx_skin:save', skin)
                                                                                                                end)
                                                                                                        else
                                                                                                                TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                                end)
                                                                                                                if Config.Mythic then
                                                                                                                        exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                                                elseif Config.Pnotif then
                                                                                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                                                else
                                                                                                                        ESX.ShowNotification(Config.NeedCash)
                                                                                                                end
                                                                                                        end
                                                                                                end)
                                                                                        end
                                                                                end
                                                                        end, _accessory)
                                                                else
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                if hasEnoughMoney then
                                                                                        TriggerServerEvent('esx_accessoryPack:pay')
                                                                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                TriggerServerEvent('esx_skin:save', skin)
                                                                                        end)
                                                                                else
                                                                                        TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                        end)
                                                                                        if Config.Mythic then
                                                                                                exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                        elseif Config.Pnotif then
                                                                                                exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                        else
                                                                                                ESX.ShowNotification(Config.NeedCash)
                                                                                        end
                                                                                end
                                                                        end)
                                                                end
                                                        end

                                                        if data.current.value == 'no' then
                                                                local player = PlayerPedId()
                                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                end)
                                                        end
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.BagList .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end, function(data, menu)
                                                        menu.close()
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.BagList .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end)
                                        end
                                end
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.SelectTop)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.SelectTop, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.SelectTop)
                                end
                        end
                elseif _accessory == 'glasses' then
                        local eye = data.current.value
                        if data.current.label == Config.EyeSkinMenu then
                                for i = 1,#Config.InvalidEyes do
                                        if eye == Config.InvalidEyes[i] then
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                end)
                                                if Config.Mythic then
                                                        exports['mythic_notify']:SendAlert('inform', Config.CannotBuy)
                                                elseif Config.Pnotif then
                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.CannotBuy, type = 'error', timeout = 5000})
                                                else
                                                        ESX.ShowNotification(Config.CannotBuy)
                                                end
                                                menu.close()
                                        end
                                end
                                for i = 1,#validEyes do
                                        if eye == validEyes[i] then
                                                menu.close()

                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
                                                {
                                                        title = Config.ConfirmBuy,
                                                        align = 'top-left',
                                                        elements = {
                                                                {label = Config.Decline, value = 'no'},
                                                                {label = Config.Accept .. ESX.Math.GroupDigits(Config.Price), value = 'yes'}
                                                        }
                                                }, function(data, menu)
                                                        menu.close()
                                                        if data.current.value == 'yes' then
                                                                if Config.ItemLimit then
                                                                        local elements = {}
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                                                                                if hasAces == true then
                                                                                        for k,v in pairs(skinTab) do
                                                                                                for g,f in pairs(v) do
                                                                                                        if g == 'id' then
                                                                                                                table.insert(elements, {label = v.name, value = v.data})
                                                                                                        end
                                                                                                end
                                                                                        end
                                                                                        if #elements >= Config.GlassesLimit then
                                                                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                                                                                {
                                                                                                        title    = Config.DeleteMenu,
                                                                                                        align    = 'top-left',
                                                                                                        elements = elements
                                                                                                }, function(data2, menu2)
                                                                                                        
                                                                                                        DeleteMenu(data2.current.label, 'glasses')
                                                                                                        local player = PlayerPedId()
                                                                                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                        end)

                                                                                                end, function(data2, menu2)
                                                                                                        menu2.close()
                                                                                                end)
                                                                                        else
                                                                                                ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                                        if hasEnoughMoney then
                                                                                                                TriggerServerEvent('esx_accessoryPack:pay')
                                                                                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                                        TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                                        TriggerServerEvent('esx_skin:save', skin)
                                                                                                                end)
                                                                                                        else
                                                                                                                TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                                end)
                                                                                                                if Config.Mythic then
                                                                                                                        exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                                                elseif Config.Pnotif then
                                                                                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                                                else
                                                                                                                        ESX.ShowNotification(Config.NeedCash)
                                                                                                                end
                                                                                                        end
                                                                                                end)
                                                                                        end
                                                                                end
                                                                        end, _accessory)
                                                                else
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                if hasEnoughMoney then
                                                                                        TriggerServerEvent('esx_accessoryPack:pay')
                                                                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                TriggerServerEvent('esx_skin:save', skin)
                                                                                        end)
                                                                                else
                                                                                        TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                        end)
                                                                                        if Config.Mythic then
                                                                                                exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                        elseif Config.Pnotif then
                                                                                                exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                        else
                                                                                                ESX.ShowNotification(Config.NeedCash)
                                                                                        end
                                                                                end
                                                                        end)
                                                                end
                                                        end

                                                        if data.current.value == 'no' then
                                                                local player = PlayerPedId()
                                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                end)
                                                        end
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.Glasses .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end, function(data, menu)
                                                        menu.close()
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.Glasses .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end)
                                        end
                                end
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.SelectTop)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.SelectTop, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.SelectTop)
                                end
                        end
                elseif _accessory == 'ears' then
                        local ear = data.current.value
                        if data.current.label == Config.EarSkinMenu then
                                for i = 1,#Config.InvalidEars do
                                        if ear == Config.InvalidEars[i] then
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                end)
                                                if Config.Mythic then
                                                        exports['mythic_notify']:SendAlert('inform', Config.CannotBuy)
                                                elseif Config.Pnotif then
                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.CannotBuy, type = 'error', timeout = 5000})
                                                else
                                                        ESX.ShowNotification(Config.CannotBuy)
                                                end
                                                menu.close()
                                        end
                                end
                                for i = 1,#validEars do
                                        if ear == validEars[i] then
                                                menu.close()

                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
                                                {
                                                        title = Config.ConfirmBuy,
                                                        align = 'top-left',
                                                        elements = {
                                                                {label = Config.Decline, value = 'no'},
                                                                {label = Config.Accept .. ESX.Math.GroupDigits(Config.Price), value = 'yes'}
                                                        }
                                                }, function(data, menu)
                                                        menu.close()
                                                        if data.current.value == 'yes' then
                                                                if Config.ItemLimit then
                                                                        local elements = {}
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                                                                                if hasAces == true then
                                                                                        for k,v in pairs(skinTab) do
                                                                                                for g,f in pairs(v) do
                                                                                                        if g == 'id' then
                                                                                                                table.insert(elements, {label = v.name, value = v.data})
                                                                                                        end
                                                                                                end
                                                                                        end
                                                                                        if #elements >= Config.EarLimit then
                                                                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                                                                                {
                                                                                                        title    = Config.DeleteMenu,
                                                                                                        align    = 'top-left',
                                                                                                        elements = elements
                                                                                                }, function(data2, menu2)
                                                                                                        
                                                                                                        DeleteMenu(data2.current.label, 'ears')
                                                                                                        local player = PlayerPedId()
                                                                                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                        end)

                                                                                                end, function(data2, menu2)
                                                                                                        menu2.close()
                                                                                                end)
                                                                                        else
                                                                                                ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                                        if hasEnoughMoney then
                                                                                                                TriggerServerEvent('esx_accessoryPack:pay')
                                                                                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                                        TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                                        TriggerServerEvent('esx_skin:save', skin)
                                                                                                                end)
                                                                                                        else
                                                                                                                TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                                end)
                                                                                                                if Config.Mythic then
                                                                                                                        exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                                                elseif Config.Pnotif then
                                                                                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                                                else
                                                                                                                        ESX.ShowNotification(Config.NeedCash)
                                                                                                                end
                                                                                                        end
                                                                                                end)
                                                                                        end
                                                                                end
                                                                        end, _accessory)
                                                                else
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                if hasEnoughMoney then
                                                                                        TriggerServerEvent('esx_accessoryPack:pay')
                                                                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                TriggerServerEvent('esx_skin:save', skin)
                                                                                        end)
                                                                                else
                                                                                        TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                        end)
                                                                                        if Config.Mythic then
                                                                                                exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                        elseif Config.Pnotif then
                                                                                                exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                        else
                                                                                                ESX.ShowNotification(Config.NeedCash)
                                                                                        end
                                                                                end
                                                                        end)
                                                                end
                                                        end

                                                        if data.current.value == 'no' then
                                                                local player = PlayerPedId()
                                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                end)
                                                        end
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.EarPiece .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end, function(data, menu)
                                                        menu.close()
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.EarPiece .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end)
                                        end
                                end
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.SelectTop)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.SelectTop, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.SelectTop)
                                end
                        end
                elseif _accessory == 'helmet' then
                        local helm = data.current.value
                        if data.current.label == Config.HelSkinMenu then
                                for i = 1,#Config.InvalidHelm do
                                        if helm == Config.InvalidHelm[i] then
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                end)
                                                if Config.Mythic then
                                                        exports['mythic_notify']:SendAlert('inform', Config.CannotBuy)
                                                elseif Config.Pnotif then
                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.CannotBuy, type = 'error', timeout = 5000})
                                                else
                                                        ESX.ShowNotification(Config.CannotBuy)
                                                end
                                                menu.close()
                                        end
                                end
                                for i = 1,#validHelm do
                                        if helm == validHelm[i] then
                                                menu.close()

                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
                                                {
                                                        title = Config.ConfirmBuy,
                                                        align = 'top-left',
                                                        elements = {
                                                                {label = Config.Decline, value = 'no'},
                                                                {label = Config.Accept .. ESX.Math.GroupDigits(Config.Price), value = 'yes'}
                                                        }
                                                }, function(data, menu)
                                                        menu.close()
                                                        if data.current.value == 'yes' then
                                                                if Config.ItemLimit then
                                                                        local elements = {}
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                                                                                if hasAces == true then
                                                                                        for k,v in pairs(skinTab) do
                                                                                                for g,f in pairs(v) do
                                                                                                        if g == 'id' then
                                                                                                                table.insert(elements, {label = v.name, value = v.data})
                                                                                                        end
                                                                                                end
                                                                                        end
                                                                                        if #elements >= Config.HelmetLimit then
                                                                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                                                                                {
                                                                                                        title    = Config.DeleteMenu,
                                                                                                        align    = 'top-left',
                                                                                                        elements = elements
                                                                                                }, function(data2, menu2)
                                                                                                        
                                                                                                        DeleteMenu(data2.current.label, 'helmet')
                                                                                                        local player = PlayerPedId()
                                                                                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                        end)

                                                                                                end, function(data2, menu2)
                                                                                                        menu2.close()
                                                                                                end)
                                                                                        else
                                                                                                ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                                        if hasEnoughMoney then
                                                                                                                TriggerServerEvent('esx_accessoryPack:pay')
                                                                                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                                        TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                                        TriggerServerEvent('esx_skin:save', skin)
                                                                                                                end)
                                                                                                        else
                                                                                                                TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                                end)
                                                                                                                if Config.Mythic then
                                                                                                                        exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                                                elseif Config.Pnotif then
                                                                                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                                                else
                                                                                                                        ESX.ShowNotification(Config.NeedCash)
                                                                                                                end
                                                                                                        end
                                                                                                end)
                                                                                        end
                                                                                end
                                                                        end, _accessory)
                                                                else
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                if hasEnoughMoney then
                                                                                        TriggerServerEvent('esx_accessoryPack:pay')
                                                                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                TriggerServerEvent('esx_skin:save', skin)
                                                                                        end)
                                                                                else
                                                                                        TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                        end)
                                                                                        if Config.Mythic then
                                                                                                exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                        elseif Config.Pnotif then
                                                                                                exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                        else
                                                                                                ESX.ShowNotification(Config.NeedCash)
                                                                                        end
                                                                                end
                                                                        end)
                                                                end
                                                        end

                                                        if data.current.value == 'no' then
                                                                local player = PlayerPedId()
                                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                end)
                                                        end
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.Helmets .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end, function(data, menu)
                                                        menu.close()
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.Helmets .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end)
                                        end
                                end
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.SelectTop)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.SelectTop, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.SelectTop)
                                end
                        end
                elseif _accessory == 'mask' then
                        local mask = data.current.value
                        if data.current.label == Config.MakSkinMenu then
                                for i = 1,#Config.InvalidMask do
                                        if mask == Config.InvalidMask[i] then
                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                end)
                                                if Config.Mythic then
                                                        exports['mythic_notify']:SendAlert('inform', Config.CannotBuy)
                                                elseif Config.Pnotif then
                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.CannotBuy, type = 'error', timeout = 5000})
                                                else
                                                        ESX.ShowNotification(Config.CannotBuy)
                                                end
                                                menu.close()
                                        end
                                end
                                for i = 1,#validMask do
                                        if mask == validMask[i] then
                                                menu.close()

                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
                                                {
                                                        title = Config.ConfirmBuy,
                                                        align = 'top-left',
                                                        elements = {
                                                                {label = Config.Decline, value = 'no'},
                                                                {label = Config.Accept .. ESX.Math.GroupDigits(Config.Price), value = 'yes'}
                                                        }
                                                }, function(data, menu)
                                                        menu.close()
                                                        if data.current.value == 'yes' then
                                                                if Config.ItemLimit then
                                                                        local elements = {}
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:get', function(hasAces, skinTab)
                                                                                if hasAces == true then
                                                                                        for k,v in pairs(skinTab) do
                                                                                                for g,f in pairs(v) do
                                                                                                        if g == 'id' then
                                                                                                                table.insert(elements, {label = v.name, value = v.data})
                                                                                                        end
                                                                                                end
                                                                                        end
                                                                                        if #elements >= Config.MaskLimit then
                                                                                                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'second_acc_menu',
                                                                                                {
                                                                                                        title    = Config.DeleteMenu,
                                                                                                        align    = 'top-left',
                                                                                                        elements = elements
                                                                                                }, function(data2, menu2)
                                                                                                        
                                                                                                        DeleteMenu(data2.current.label, 'mask')
                                                                                                        local player = PlayerPedId()
                                                                                                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                        end)

                                                                                                end, function(data2, menu2)
                                                                                                        menu2.close()
                                                                                                end)
                                                                                        else
                                                                                                ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                                        if hasEnoughMoney then
                                                                                                                TriggerServerEvent('esx_accessoryPack:pay')
                                                                                                                TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                                        TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                                        TriggerServerEvent('esx_skin:save', skin)
                                                                                                                end)
                                                                                                        else
                                                                                                                TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                                                                end)
                                                                                                                if Config.Mythic then
                                                                                                                        exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                                                elseif Config.Pnotif then
                                                                                                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                                                else
                                                                                                                        ESX.ShowNotification(Config.NeedCash)
                                                                                                                end
                                                                                                        end
                                                                                                end)
                                                                                        end
                                                                                end
                                                                        end, _accessory)
                                                                else
                                                                        ESX.TriggerServerCallback('esx_accessoryPack:checkMoney', function(hasEnoughMoney)
                                                                                if hasEnoughMoney then
                                                                                        TriggerServerEvent('esx_accessoryPack:pay')
                                                                                        TriggerEvent('skinchanger:getSkin', function(skin)
                                                                                                TriggerEvent('esx_accessoryPack:createName', _accessory, skin)
                                                                                                TriggerServerEvent('esx_skin:save', skin)
                                                                                        end)
                                                                                else
                                                                                        TriggerEvent('esx_skin:getLastSkin', function(skin)
                                                                                                TriggerEvent('skinchanger:loadSkin', skin)
                                                                                        end)
                                                                                        if Config.Mythic then
                                                                                                exports['mythic_notify']:SendAlert('inform', Config.NeedCash)
                                                                                        elseif Config.Pnotif then
                                                                                                exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NeedCash, type = 'error', timeout = 5000})
                                                                                        else
                                                                                                ESX.ShowNotification(Config.NeedCash)
                                                                                        end
                                                                                end
                                                                        end)
                                                                end
                                                        end

                                                        if data.current.value == 'no' then
                                                                local player = PlayerPedId()
                                                                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                                                        TriggerEvent('skinchanger:loadSkin', skin)
                                                                end)
                                                        end
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.Masks .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end, function(data, menu)
                                                        menu.close()
                                                        CurrentAction     = 'shop_menu'
                                                        CurrentActionMsg  = Config.KeyNotif .. Config.Masks .. Config.Accessory
                                                        CurrentActionData = { accessory = accessory }
                                                end)
                                        end
                                end
                        else
                                if Config.Mythic then
                                        exports['mythic_notify']:SendAlert('inform', Config.SelectTop)
                                elseif Config.Pnotif then
                                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.SelectTop, type = 'error', timeout = 5000})
                                else
                                        ESX.ShowNotification(Config.SelectTop)
                                end
                        end
                end
        end, function(data, menu)
                menu.close()
                if accessory == 'Bags' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.BagList .. Config.Accessory
                        CurrentActionData = { accessory = accessory }
                elseif accessory == 'Helmet' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.Helmets .. Config.Accessory
                        CurrentActionData = { accessory = accessory }
                elseif accessory == 'Mask' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.Masks .. Config.Accessory
                        CurrentActionData = { accessory = accessory }
                elseif accessory == 'Glasses' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.Glasses .. Config.Accessory
                        CurrentActionData = { accessory = accessory }
                elseif accessory == 'Ears' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.EarPiece .. Config.Accessory
                        CurrentActionData = { accessory = accessory }
                end
        end, restrict)
end

RegisterNetEvent('esx_accessoryPack:createName')
AddEventHandler('esx_accessoryPack:createName', function(item, skinTable)
        local genName = nil
        local doBreak = false
        ESX.UI.Menu.Open(
                'dialog', GetCurrentResourceName(), 'choose_name_text',
                {
                        title = Config.SetText
                },
        function(data, menu)
                local name = tostring(data.value)
                local length = string.len(name)

                if length == nil then
                        if Config.Mythic then
                                exports['mythic_notify']:SendAlert('inform', Config.NoNilName)
                        elseif Config.Pnotif then
                                exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NoNilName, type = 'error', timeout = 5000})
                        else
                                ESX.ShowNotification(Config.NoNilName)
                        end
                elseif length < Config.MinLength or length > Config.MaxLength then
                        if Config.Mythic then
                                exports['mythic_notify']:SendAlert('inform', Config.NameLength)
                        elseif Config.Pnotif then
                                exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.NameLength, type = 'error', timeout = 5000})
                        else
                                ESX.ShowNotification(Config.NameLength)
                        end
                else
                        genName = name
                        menu.close()
                end
        end, function(data, menu)
        end)
        while true do
                Citizen.Wait(2)
                if genName ~= nil then
                        doBreak = true
                        if doBreak then
                                break
                        end
                end
        end
        TriggerServerEvent('esx_accessoryPack:save', genName, item, skinTable)
end)

AddEventHandler('playerSpawned', function()
        isDead = false
end)

AddEventHandler('esx_accessoryPack:hasEnteredMarker', function(zone)
        if zone ~= 'Locker' then
        
                if zone == 'Bags' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.BagList .. Config.Accessory
                        CurrentActionData = { accessory = zone }
                elseif zone == 'Helmet' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.Helmets .. Config.Accessory
                        CurrentActionData = { accessory = zone }
                elseif zone == 'Mask' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.Masks .. Config.Accessory
                        CurrentActionData = { accessory = zone }
                elseif zone == 'Glasses' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.Glasses .. Config.Accessory
                        CurrentActionData = { accessory = zone }
                elseif zone == 'Ears' then
                        CurrentAction     = 'shop_menu'
                        CurrentActionMsg  = Config.KeyNotif .. Config.EarPiece .. Config.Accessory
                        CurrentActionData = { accessory = zone }
                end
                
        else
                CurrentAction     = 'locker_menu'
                CurrentActionMsg  = Config.LockerNotif
                CurrentActionData = { zone = zone }
        end
end)

AddEventHandler('esx_accessoryPack:hasExitedMarker', function(zone)
        ESX.UI.Menu.CloseAll()
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
        end)
        CurrentAction = nil
end)

Citizen.CreateThread(function()
        while true do
                local ped = PlayerPedId()
                local sleep = 500
                local coords = GetEntityCoords(ped)
                isInMarker = false
                for k,v in pairs(Config.Pos) do
                        for g,f in ipairs(v) do
                                local dis = #(coords - f)
                                if dis < 1.5 then
                                        isInMarker  = true
                                        currentZone = k
                                elseif dis < Config.DrawDistance then
                                        sleep = 10
                                        if Config.UseMarkers then
                                                DrawMarker(Config.Type, f, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, false, 2, false, false, false, false)
                                        end
                                end
                        end
                end
                if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
                        HasAlreadyEnteredMarker = true
                        LastZone = currentZone
                        TriggerEvent('esx_accessoryPack:hasEnteredMarker', currentZone)
                        ESX.ShowHelpNotification(CurrentActionMsg, false, true, Config.NotifTimer)
                end

                if not isInMarker and HasAlreadyEnteredMarker then
                        HasAlreadyEnteredMarker = false
                        TriggerEvent('esx_accessoryPack:hasExitedMarker', LastZone)
                end
                Citizen.Wait(sleep)
        end
end)

if not Config.CommsOnly then
        Citizen.CreateThread(function()
                while true do
                        Citizen.Wait(10)
                        if CurrentAction ~= nil then
                                if IsControlJustReleased(0, 51) then
                                        if CurrentActionData.accessory then
                                                OpenShopMenu(CurrentActionData.accessory)
                                                CurrentAction = nil
                                        elseif CurrentActionData.zone then
                                                SecondAccessoryMenu('bags')
                                                CurrentAction = nil
                                        end
                                end
                        end
                        deaded = exports["ambulancejob"]:GetDeath()
                        if IsControlJustReleased(0, Config.OpenKey) and not deaded then
                                TriggerEvent('esx_accessoryPack:openPack')
                        end
                end
        end)
end

RegisterCommand('bags', function(raw)
        if isInMarker then
                if CurrentActionData.accessory then
                        CurrentAction = nil
                        OpenShopMenu(CurrentActionData.accessory)
                elseif CurrentActionData.zone then
                        SecondAccessoryMenu('bags')
                        CurrentAction = nil
                end
        else
                if Config.Mythic then
                        exports['mythic_notify']:SendAlert('inform', Config.AtCounter)
                elseif Config.Pnotif then
                        exports.pNotify:SendNotification({layout = 'centerLeft', text = Config.AtCounter, type = 'error', timeout = 5000})
                else
                        ESX.ShowNotification(Config.AtCounter)
                end
        end
end, false)

RegisterCommand('pack', function(raw)
        OpenBackpack()
end, false)

AddEventHandler('onResourceStop', function(resource)
        if resource == GetCurrentResourceName() then
                ESX.UI.Menu.CloseAll()
                ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                end)
        end
end)