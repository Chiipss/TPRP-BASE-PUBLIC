OpenFinanceMenu = function()

    ESX.TriggerServerCallback("tp-financemenu:getFinancedVehicles", function(fetchedVehicles)
        local menuElements = {}

        for key, vehicleData in ipairs(fetchedVehicles) do
            local vehicleProps = vehicleData["props"]

            local readAbleTime = vehicleData["financetimer"] / 60
           
            if vehicleData["financetimer"] <= 0 then
                table.insert(menuElements, {
                    ["label"] = "<span style='font-weight:bold;color:red;'>Overdue</span> " .. GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps["model"])) .. " [" .. vehicleData["plate"] .. "] | $" .. vehicleData["finance"],
                    ["vehicle"] = vehicleData
                })
            else
                table.insert(menuElements, {
                    ["label"] = "<span style='font-weight:bold;color:green;'>Not Due</span> " .. GetLabelText(GetDisplayNameFromVehicleModel(vehicleProps["model"])) .. " [" .. vehicleData["plate"] .. "] | $" .. vehicleData["finance"] .. " | " .. round(readAbleTime) .. " hours until payment due.",
                    ["vehicle"] = vehicleData
                })
            end

        end

        if #menuElements == 0 then
            table.insert(menuElements, {
                ["label"] = "You have no outstanding finance."
            })
        elseif #menuElements > 0 then
            -- DO SOME SHITE
        end

        ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_finance_menu", {
            ["title"] = "Finance Menu",
            ["align"] = Config.AlignMenu,
            ["elements"] = menuElements
        }, function(menuData, menuHandle)
            local currentVehicle = menuData["current"]["vehicle"]

            if currentVehicle then
                menuHandle.close()
                --print(currentVehicle["finance"])
                PayFinance(currentVehicle["props"], currentVehicle["finance"])
            end
        end, function(menuData, menuHandle)
            menuHandle.close()
        end, function(menuData, menuHandle)
            local currentVehicle = menuData["current"]["vehicle"]
            -- Called when switching menu entries up and down
        end)
    end)
end

PayFinance = function(vehicleProps, currentFinance, amountToPay)

    local modelName = GetDisplayNameFromVehicleModel(vehicleProps["model"])
    local minimumPayment = nil

    -- Get Minimum Payment Ammount
    ESX.TriggerServerCallback('tp-financemenu:getMinimumPayment', function(callbackstring)
        minimumPayment = callbackstring.value1
        exactmin = callbackstring.value2
    end, vehicleProps["plate"])

    Citizen.Wait(500)

    menuOpen = false

    if exactmin == true then
        inputField = "Amount to repay - Exactly $" .. tostring(minimumPayment).. " "
    else
        inputField = "Amount to repay - Atleast $" .. tostring(minimumPayment).. " "
    end
  
    ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Finance Repayment', {title = inputField}, 
        function(data2, menu2)
            local quantity = tonumber(data2.value)
            if minimumPayment == nil then
                menu2.close()
            end
            if quantity == nil then
                exports['mythic_notify']:SendAlert('error', 'Invalid amount', 15000)
                menu2.close()
            elseif quantity < minimumPayment and not exactmin then
                exports['mythic_notify']:SendAlert('error', 'You must pay atleast $' .. minimumPayment, 15000)
            elseif exactmin and quantity ~= minimumPayment then
                exports['mythic_notify']:SendAlert('error', 'You must pay exactly $' .. minimumPayment, 15000)
            else
                menu2.close()
                ESX.TriggerServerCallback('JAM_VehicleFinance:RepayLoan', function(valid)
                    if valid then 
                        exports['mythic_notify']:SendAlert('success', 'You have paid $'.. quantity ..' towards this vehicles loan.', 30000)
                        --ESX.ShowNotification("You have payed $~g~"..quantity.." ~s~towards this vehicles loan.")
                        TriggerServerEvent('JAM_VehicleFinance:RemoveFromRepoList', vehicleProps["plate"])
                        return 
                    else 
                        exports['mythic_notify']:SendAlert('error', "You don't have enough money.", 15000)
                        --ESX.ShowNotification("You don't have enough money.")
                        return
                    end
                end, vehicleProps["plate"], quantity)
                menu2.close()
            end
        end,
        function(data2,menu2)
            menu2.close()
            ESX.UI.Menu.CloseAll()
        end)
    
end

function round(num)
    under = math.floor(num)
    upper = math.floor(num) + 1
    underV = -(under - num)
    upperV = upper - num
    if (upperV > underV) then
        return under
    else
        return upper
    end
end