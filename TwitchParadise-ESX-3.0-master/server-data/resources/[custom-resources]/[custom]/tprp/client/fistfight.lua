local weapons = {
    ['WEAPON_UNARMED'] = 0.2, 
    ['WEAPON_ADVANCEDRIFLE'] = 0.5,
    ['WEAPON_APPISTOL'] = 0.5,
    ['WEAPON_ASSAULTRIFLE'] = 0.5,
    ['WEAPON_ASSAULTSHOTGUN'] = 0.5,
    ['WEAPON_BAT'] = 0.3,
    ['WEAPON_BOTTLE'] = 0.3,
    ['WEAPON_BULLPUPRIFLE'] = 0.5,
    ['WEAPON_BULLPUPSHOTGUN'] = 0.5,
    ['WEAPON_CARBINERIFLE'] = 0.5,
    ['WEAPON_COMBATMG'] = 0.5,
    ['WEAPON_COMBATPDW'] = 0.5,
    ['WEAPON_COMBATPISTOL'] = 0.5,
    ['WEAPON_COMPACTLAUNCHER'] = 0.5,
    ['WEAPON_COMPACTRIFLE'] = 0.5,
    ['WEAPON_CROWBAR'] = 0.3,
    ['WEAPON_DAGGER'] = 0.3,
    ['WEAPON_DBSHOTGUN'] = 0.5,
    ['WEAPON_DIGISCANNER'] = 0.5,
    ['WEAPON_DOUBLEACTION'] = 0.5,
    ['WEAPON_FIREWORK'] = 0.5,
    ['WEAPON_FLASHLIGHT'] = 0.3,
    ['WEAPON_GOLFCLUB'] = 0.3,
    ['WEAPON_GRENADELAUNCHER'] = 0.5,
    ['WEAPON_GUSENBURG'] = 0.5,
    ['WEAPON_HAMMER'] = 0.3,
    ['WEAPON_HATCHET'] = 0.3,
    ['WEAPON_HEAVYPISTOL'] = 0.5,
    ['WEAPON_HEAVYSHOTGUN'] = 0.5,
    ['WEAPON_HEAVYSNIPER'] = 0.5,
    ['WEAPON_HOMINGLAUNCHER'] = 0.5,
    ['WEAPON_KNIFE'] = 0.5,
    ['WEAPON_KNUCKLE'] = 0.4,
    ['WEAPON_MACHETE'] = 0.5,
    ['WEAPON_MACHINEPISTOL'] = 0.5,
    ['WEAPON_MARKSMANPISTOL'] = 0.5,
    ['WEAPON_MARKSMANRIFLE'] = 0.5,
    ['WEAPON_MG'] = 0.5,
    ['WEAPON_MICROSMG'] = 0.5,
    ['WEAPON_MINISMG'] = 0.5,
    ['WEAPON_NIGHTSTICK'] = 0.5,
    ['WEAPON_PETROLCAN'] = 0.5,
    ['WEAPON_PISTOL'] = 0.5,
    ['WEAPON_PISTOL_MK2'] = 0.5,
    ['WEAPON_PISTOL50'] = 0.5,
    ['WEAPON_POOLCUE'] = 0.5,
    ['WEAPON_PUMPSHOTGUN'] = 0.5,
    ['WEAPON_REVOLVER'] = 0.5,
    ['WEAPON_RPG'] = 0.5,
    ['WEAPON_SAWNOFFSHOTGUN'] = 0.5,
    ['WEAPON_SMG'] = 0.5,
    ['WEAPON_SNIPERRIFLE'] = 0.5,
    ['WEAPON_SPECIALCARBINE'] = 0.5,
    ['WEAPON_SWITCHBLADE'] = 0.5,
    ['WEAPON_VINTAGEPISTOL'] = 0.5,
    ['WEAPON_WRENCH'] = 0.5,

}

Citizen.CreateThread(function()
    while true do
        for k, v in pairs(weapons) do
            N_0x4757f00bc6323cfe(GetHashKey(k), v)
        Wait(0)
        end
    end
end)


--[[ 
Citizen.CreateThread(function()
    while true do
    N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.2) -- Change this from 0.01 to whatever, 1.0 being normal damage, 4.0 being 4x damage, 0.01 being a fraction of damage.
    Wait(0)
    end
end)
  ]]
