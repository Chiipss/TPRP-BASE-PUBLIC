local holstered = true

local weapons = {
    "WEAPON_PISTOL",
    "WEAPON_SNSPISTOL",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_PISTOL50",
    "WEAPON_REVOLVER",
    "WEAPON_PISTOL_MK2",
    "WEAPON_COMBATPISTOL",
    "WEAPON_HEAVYPISTOL",
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(200)
        local ped = PlayerPedId()
        if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) then
            RequestAnimDict( "reaction@intimidation@1h" )
            if CheckWeapon(ped) then
                if holstered then
                    TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 49, 0, 0, 0, 0 )
                    Citizen.Wait(1700)
                    ClearPedTasks(ped)
                    holstered = false
                end
                --SetPedComponentVariation(ped, 0, 0, 0, 0)
            elseif not CheckWeapon(ped) then
                if not holstered then
                    TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
                    Citizen.Wait(1500)
                    ClearPedTasks(ped)
                    holstered = true
                end
                --SetPedComponentVariation(ped, 0, 0, 0, 0)
            end
        end
    end
end)



Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
        if IsEntityPlayingAnim(PlayerPedId(), "reaction@intimidation@1h", "intro", 3) or IsEntityPlayingAnim(PlayerPedId(), "reaction@intimidation@1h", "outro", 3)  then
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true) 
            DisableControlAction(0, 69, true)
            DisableControlAction(0, 92, true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 122, true)
            DisableControlAction(0, 135, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 144, true)
            DisableControlAction(0, 176, true)
            DisableControlAction(0, 223, true)
            DisableControlAction(0, 229, true)
            DisableControlAction(0, 237, true)
            DisableControlAction(0, 257, true)
            DisableControlAction(0, 329, true)
            DisableControlAction(0, 346, true)  
        end        
    end
end)

function CheckWeapon(ped)
    for i = 1, #weapons do
        if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
            return true
        end
    end
    return false
end


