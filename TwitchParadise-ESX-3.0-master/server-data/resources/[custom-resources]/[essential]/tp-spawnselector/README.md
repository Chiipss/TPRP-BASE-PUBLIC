#srp-spawn
**INSTALLATION** 
``` 
1. Download the repository 
2. Place the srp-spawn folder in your [ESX] directory 
3. Type start srp-spawn in your server.cfg  

You will have to figure out by yourself how to use the script 
``` 
In esx_kashacters 
Comment out in client.lua:
`--TriggerEvent('esx_ambulancejob:multicharacter', source)` and add `TriggerEvent("srp-spawn:setNui")`
```
RegisterNetEvent('kashactersC:SpawnCharacter')
AddEventHandler('kashactersC:SpawnCharacter', function(spawn, isnew)
    TriggerServerEvent('es:firstJoinProper')
    TriggerEvent('es:allowedToSpawn')

    SetTimecycleModifier('default')
    local pos = spawn
    SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
    DoScreenFadeIn(500)
    Citizen.Wait(500)
    cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam2, pos.x,pos.y,pos.z+200)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
    Citizen.Wait(900)
    exports.spawnmanager:setAutoSpawn(false)
    --TriggerEvent('esx_ambulancejob:multicharacter', source)
    TriggerEvent("srp-spawn:setNui")
 if isnew then
        TriggerEvent('esx_identity:showRegisterIdentity')
 end

    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x,pos.y,pos.z+200, 300.00,0.00,0.00, 100.00, false, 0)
    PointCamAtCoord(cam, pos.x,pos.y,pos.z+2)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)
    Citizen.Wait(3700)
    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    FreezeEntityPosition(GetPlayerPed(-1), false)
    Citizen.Wait(500)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    IsChoosing = false
    DisplayHud(true)
    DisplayRadar(true)
end)
```
