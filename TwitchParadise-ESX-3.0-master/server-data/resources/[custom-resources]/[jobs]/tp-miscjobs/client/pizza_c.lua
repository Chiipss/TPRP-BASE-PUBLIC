------------
-- CONFIG --
------------




---------
-- ESX --
---------

ESX = nil
local PlayerData = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)
-------------
-- ZMIENNE --
-------------

local PodczasSluzby = false
local Zatrudniony = true
local BlipCelu = nil
local BlipZakonczenia = nil
local BlipAnulowania = nil
local PozycjaCelu = nil
local MaPaczke = false
local ObokVana = false
local OstatniCel = 0
local LiczbaDostaw = 0
local Rozwieziono = false
local xxx = nil
local yyy = nil
local zzz = nil
local Blipy = {}
local JuzBlip = false
local DostarczaPaczke = false
local posiadaVana = false

------------------------
-- PODSTAWOWE FUNKCJE --
------------------------

--Tworzenie blipa pracy
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not JuzBlip then
            Blipy['praca'] = AddBlipForCoord(Config.Strefy.Praca.x, Config.Strefy.Praca.y, Config.Strefy.Praca.z)
            SetBlipSprite(Blipy['praca'], 488)
            SetBlipDisplay(Blipy['praca'], 4)
            SetBlipScale(Blipy['praca'], 0.7)
            SetBlipColour(Blipy['praca'], 42)
            SetBlipAsShortRange(Blipy['praca'], true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Paradise Pizzas')
            EndTextCommandSetBlipName(Blipy['praca'])
						JuzBlip = true
        end
    end
end)

-- Spawn Samochodu
function WyciagnijPojazd()
    if ESX.Game.IsSpawnPointClear(Config.Strefy.Spawn.Pos, 7) then
        if posiadaVana == true then
            exports['mythic_notify']:SendAlert('inform', 'You got a car already! Cancel the mission to get a new one!', 10000)
         --   TriggerEvent('pNotify:SendNotification', {text = 'You got a car already! Cancel the mission to get a new one!', timeout = 20000})
        elseif posiadaVana == false then
            ESX.Game.SpawnVehicle('foodcar4', Config.Strefy.Spawn.Pos, Config.Strefy.Spawn.Heading, function(vehicle)
                platenum = math.random(100, 999)
                SetVehicleNumberPlateText(vehicle, "PIZZA"..platenum)
                SetVehicleCustomPrimaryColour(vehicle, 255, 245, 171)
                SetVehicleCustomSecondaryColour(vehicle, 255, 245, 171)
                SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
                plaquevehicule = "PIZZA"..platenum
                local vehicle = GetVehiclePedIsIn(PlayerPedId())
                local plate = GetVehicleNumberPlateText(vehicle)
	            TriggerServerEvent('garage:addKeys', plate)
            end)
            PodczasSluzby = true
            LosujCel()
            DodajBlipaAnulowania()
            posiadaVana = true
        end
    else
        exports['mythic_notify']:SendAlert('inform', 'Parking slot is taken by an other vehicle!', 10000)
      --  TriggerEvent("pNotify:SendNotification", {text = 'Parking slot is taken by an other vehicle!'})
    end
end

-- Garaz
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Zatrudniony then
            local Gracz = GetPlayerPed(-1)
            local Pozycja = GetEntityCoords(Gracz)
            local Dystans = GetDistanceBetweenCoords(Pozycja, Config.Strefy.Praca.x, Config.Strefy.Praca.y, Config.Strefy.Praca.z, true)
            if Dystans <= 10.0 then
                local PozycjaGarazu = {
                    ["x"] = Config.Strefy.Praca.x,
                    ["y"] = Config.Strefy.Praca.y,
                    ["z"] = Config.Strefy.Praca.z + 1
                }
                ESX.Game.Utils.DrawText3D(PozycjaGarazu, "Press [~g~E~s~] to start work", 0.55, 1.5, "~b~PIZZA BOY", 0.7)
                if Dystans <= 3.0 then
                    if IsControlJustReleased(0, 38) then
                        WyciagnijPojazd()
                    end
                end
            end
        end
    end
end)

-----------------------
-- WYSZUKIWANIE CELU --
-----------------------

function LosujCel()
    local LosowyPunkt = math.random(1, 21)
    if LiczbaDostaw == 4 then
        exports['mythic_notify']:SendAlert('success', 'You delivered all Pizzas! Go back to Pizza This!', 10000)
       -- TriggerEvent('pNotify:SendNotification', {text = 'You delivered all Pizzas! Go back to Pizza This!'})
        UsunBlipaAnulowania()
        SetBlipRoute(BlipCelu, false)
        DodajBlipaZakonczenia()
        Rozwieziono = true
				xxx = nil
				yyy = nil
				zzz = nil
    else
      local pizza = 4 - LiczbaDostaw
      if pizza == 1 then
        exports['mythic_notify']:SendAlert('inform', 'You have got one pizza left to deliver!', 10000)
      --  TriggerEvent('pNotify:SendNotification', {text = 'You have got one pizza left.'})
      else
        if pizza == 4 then
          pizza = 'four'
        elseif pizza == 3 then
          pizza = 'three'
        elseif pizza == 2 then
          pizza = 'two'
        end
        exports['mythic_notify']:SendAlert('inform', 'You have got '..pizza..' pizzas left.', 10000)
   --     TriggerEvent('pNotify:SendNotification', {text = 'You have got '..pizza..' pizzas left.'})
      end
        if OstatniCel == LosowyPunkt then
            LosujCel()
        else
            if LosowyPunkt == 1 then
								xxx =3.45
								yyy =36.74
								zzz =71.53
                OstatniCel = 1
            elseif LosowyPunkt == 2 then
								xxx =-273.58
								yyy =28.33
								zzz =54.75
                OstatniCel = 2
            elseif LosowyPunkt == 3 then
								xxx =-345.05
								yyy =18.23
								zzz =47.85
                OstatniCel = 3
            elseif LosowyPunkt == 4 then
								xxx =-549.89
								yyy =37.7
								zzz =43.6
                OstatniCel = 4
            elseif LosowyPunkt == 5 then
								xxx =-842.22
								yyy =-25.07
								zzz =40.39
                OstatniCel = 5
            elseif LosowyPunkt == 6 then
								xxx =-902.37
								yyy =191.56
								zzz =69.44
                OstatniCel = 6
            elseif LosowyPunkt == 7 then
								xxx =-1116.81
								yyy =304.54
								zzz =66.52
                OstatniCel = 7
            elseif LosowyPunkt == 8 then
								xxx =-637.01
								yyy =180.39
								zzz =61.75
                OstatniCel = 8
            elseif LosowyPunkt == 9 then
								xxx =-1905.66
								yyy =252.95
								zzz =86.45
                OstatniCel = 9
            elseif LosowyPunkt == 10 then
								xxx =-1961.23
								yyy =212.01
								zzz =86.8
                OstatniCel = 10
            elseif LosowyPunkt == 11 then
								xxx =-1447.51
								yyy =-537.6
								zzz =34.74
                OstatniCel = 11
            elseif LosowyPunkt == 12 then
								xxx =126.678
								yyy =-1929.798
								zzz =21.382
                OstatniCel = 12
            elseif LosowyPunkt == 13 then
								xxx =-5.0513
								yyy =-1872.062
								zzz =24.151
                OstatniCel = 13
            elseif LosowyPunkt == 14 then
								xxx =-80.589
								yyy =-1608.237
								zzz =31.480
                OstatniCel = 14
            elseif LosowyPunkt == 15 then
								xxx =-27.885
								yyy =-1103.904
								zzz =26.422
                OstatniCel = 15
            elseif LosowyPunkt == 16 then
								xxx =344.731
								yyy =-205.027
								zzz =58.019
                OstatniCel = 16
            elseif LosowyPunkt == 17 then
								xxx =340.956
								yyy =-214.876
								zzz =58.019
                OstatniCel = 17
            elseif LosowyPunkt == 18 then
								xxx =337.132
								yyy =-224.712
								zzz =58.019
                OstatniCel = 18
            elseif LosowyPunkt == 19 then
								xxx =331.373
								yyy =-225.865
								zzz =58.019
                OstatniCel = 19
            elseif LosowyPunkt == 20 then
								xxx =337.158
								yyy =-224.729
								zzz =54.221
                OstatniCel = 20
            elseif LosowyPunkt == 21 then
								xxx =-386.907
								yyy =504.108
								zzz =120.412
                OstatniCel = 21
            end
            DodajBlipaDoCelu(PozycjaCelu)
            exports['mythic_notify']:SendAlert('inform', 'Deliver pizza to the client!', 10000)
		 --   TriggerEvent('pNotify:SendNotification', {text = 'Deliver pizza to the client!'})
        end
    end
end

----------------------
-- TWORZENIE BLIPÓW --
----------------------

-- Blip celu podrózy
function DodajBlipaDoCelu(PozycjaCelu)
    Blipy['cel'] = AddBlipForCoord(xxx, yyy, zzz)
    SetBlipRoute(Blipy['cel'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Delivery of Pizza This')
	EndTextCommandSetBlipName(Blipy['cel'])
end

-- Blip anulowania pracy
function DodajBlipaAnulowania()
    Blipy['anulowanie'] = AddBlipForCoord(Config.Strefy.Anulowanie.x, Config.Strefy.Anulowanie.y, Config.Strefy.Anulowanie.z)
		SetBlipColour(Blipy['anulowanie'], 59)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Job Cancel')
	EndTextCommandSetBlipName(Blipy['anulowanie'])
end

-- Blip zakonczenia pracy
function DodajBlipaZakonczenia()
    Blipy['zakonczenie'] = AddBlipForCoord(Config.Strefy.Zakonczenie.x, Config.Strefy.Zakonczenie.y, Config.Strefy.Zakonczenie.z)
		SetBlipColour(Blipy['zakonczenie'], 2)
    SetBlipRoute(Blipy['zakonczenie'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Job End')
	EndTextCommandSetBlipName(Blipy['zakonczenie'])
end

---------------------
-- USUWANIE BLIPÓW --
---------------------

function UsunBlipaCelu()
    RemoveBlip(Blipy['cel'])
end

function UsunBlipaAnulowania()
    RemoveBlip(Blipy['anulowanie'])
end

function UsunWszystkieBlipy()
    RemoveBlip(Blipy['cel'])
    RemoveBlip(Blipy['anulowanie'])
    RemoveBlip(Blipy['zakonczenie'])
end

--------------------
-- STREFA DOSTAWY --
--------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Gracz = GetPlayerPed(-1)
        local Pozycja = GetEntityCoords(Gracz)
        local Dystans = GetDistanceBetweenCoords(Pozycja, xxx, yyy, zzz, true)
        if Dystans <= 40.0 and Zatrudniony and (not MaPaczke) then
            local PozycjaDostawy = {
                ["x"] = xxx,
                ["y"] = yyy,
                ["z"] = zzz
            }
            ESX.Game.Utils.DrawText3D(PozycjaDostawy, "Get ~y~Pizza~s~ from ~b~Panto~s~!", 0.6)
            local pojazd = GetClosestVehicle(Pozycja, 6.0, 0, 70)
            if IsVehicleModel(pojazd, GetHashKey('foodcar4')) then
                local pozycjaPojazdu = GetEntityCoords(pojazd)
								local Odleglosc = GetDistanceBetweenCoords(Pozycja, pozycjaPojazdu, true)
                ESX.Game.Utils.DrawText3D(pozycjaPojazdu, "Press [~g~E~s~] to get ~y~Pizza", 1.0, 5.0, "~b~Panto", 1.15)
								if Dystans >= 4 and Odleglosc <= 5 then
                	                ObokVana = true
								end
            end
        elseif Dystans <= 25 and MaPaczke and Zatrudniony then
            local PozycjaDostawy = {
                ["x"] = xxx,
                ["y"] = yyy,
                ["z"] = zzz
            }
            ESX.Game.Utils.DrawText3D(PozycjaDostawy, "Press [~g~E~s~] to deliver ~y~Pizza", 0.55, 1.5, "~b~Delivery", 0.7)
            if Dystans <= 3 then
                if IsControlJustReleased(0, 38) then
                    WezPaczke()
                    DostarczPaczke()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if (not MaPaczke) and ObokVana then
			if IsControlJustReleased(0, 38) then
                WezPaczke()
                ObokVana = false
			end
		end
	end
end)

-------------------
-- DOSTAWA PIZZY --
-------------------

function loadAnimDict(dict)
	while ( not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(0)
	end
end

function WezPaczke()
    local player = GetPlayerPed(-1)
    if not IsPedInAnyVehicle(player, false) then
        local ad = "anim@heists@box_carry@"
        local prop_name = 'prop_pizza_box_01'
        if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
            loadAnimDict( ad )
            if MaPaczke then
                TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 49, 0, 0, 0, 0 )
                DetachEntity(prop, 1, 1)
                DeleteObject(prop)
                Wait(1000)
                ClearPedSecondaryTask(PlayerPedId())
                MaPaczke = false
            else
                local x,y,z = table.unpack(GetEntityCoords(player))
                prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
                AttachEntityToEntity(prop, player, GetPedBoneIndex(player, 60309), 0.2, 0.08, 0.2, -45.0, 290.0, 0.0, true, true, false, true, 1, true)
                TaskPlayAnim( player, ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                MaPaczke = true
            end
        end
    end
end

function DostarczPaczke()
    if not DostarczaPaczke then
        DostarczaPaczke = true
        LiczbaDostaw = LiczbaDostaw + 1
        UsunBlipaCelu()
        SetBlipRoute(BlipCelu, false)
        MaPaczke = false    
        KolejnaDostawa()
        Citizen.Wait(2500)
        DostarczaPaczke = false
    end
end

function KolejnaDostawa()
    TriggerServerEvent('WellDoPizza:Zaplata')
    Citizen.Wait(300)
    LosujCel()
end
------------------
-- KONIEC PRACY --
------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local Gracz = GetPlayerPed(-1)
        local Pozycja = GetEntityCoords(Gracz)
        local DystansOdStrefyZakonczenia = GetDistanceBetweenCoords(Pozycja, Config.Strefy.Zakonczenie.x, Config.Strefy.Zakonczenie.y, Config.Strefy.Zakonczenie.z, true)
        local DystansOdStrefyAnulowania = GetDistanceBetweenCoords(Pozycja, Config.Strefy.Anulowanie.x, Config.Strefy.Anulowanie.y, Config.Strefy.Anulowanie.z, true)
        if PodczasSluzby then
            if Rozwieziono then
                if DystansOdStrefyZakonczenia <= 25 then
                    local Zakonczenie = {
                        ["x"] = Config.Strefy.Zakonczenie.x,
                        ["y"] = Config.Strefy.Zakonczenie.y,
                        ["z"] = Config.Strefy.Zakonczenie.z
                    }
                    ESX.Game.Utils.DrawText3D(Zakonczenie, "Press [~g~E~s~] to ~r~END~s~ the your shift", 1.4, 3.5, "~b~JOB END", 1.55)
                    if DystansOdStrefyZakonczenia <= 7 then
                        if IsControlJustReleased(0, 38) then
                            exports['mythic_notify']:SendAlert('success', 'You ended your shift. Thank you!', 10000)
                           -- TriggerEvent('pNotify:SendNotification', {text = 'You ended your shift. Thank you!'})
                            KoniecPracy()
                        end
                    end
                end
            else
                if DystansOdStrefyAnulowania <= 25 then
                    local Anulowanie = {
                        ["x"] = Config.Strefy.Anulowanie.x,
                        ["y"] = Config.Strefy.Anulowanie.y,
                        ["z"] = Config.Strefy.Anulowanie.z
                    }
                    ESX.Game.Utils.DrawText3D(Anulowanie, "Press [~g~E~s~] to ~r~CANCEL~s~ THE JOB", 1.4, 3.5, "~b~JOB CANCEL", 1.55)
                    if DystansOdStrefyAnulowania <= 7 then
                        if IsControlJustReleased(0, 38) then
                            exports['mythic_notify']:SendAlert('error', 'Job was canceled', 10000)
                          --  TriggerEvent('pNotify:SendNotification', {text = 'Job was canceled!'})
							KoniecPracy()
                        end
                    end
                end
            end
        end
    end
end)

function KoniecPracy()
    UsunWszystkieBlipy()
    local Gracz = GetPlayerPed(-1)
    if IsPedInAnyVehicle(Gracz, false) then
        local Van = GetVehiclePedIsIn(Gracz, false)
        if IsVehicleModel(Van, GetHashKey('foodcar4')) then
            ESX.Game.DeleteVehicle(Van)
            if Rozwieziono == true then
                TriggerServerEvent("WellDoPizza:OddajKaucje", 'zakonczenie')
            end
            PodczasSluzby = false
            BlipCelu = nil
            BlipZakonczenia = nil
            BlipAnulowania = nil
            PozycjaCelu = nil
            MaPaczke = false
            OstatniCel = nil
            LiczbaDostaw = 0
            xxx = nil
            yyy = nil
            zzz = nil
            posiadaVana = false
            Rozwieziono = false
        else
            exports['mythic_notify']:SendAlert('error', "You have to return Pizza This' panto!", 10000)
            exports['mythic_notify']:SendAlert('error', "If you lost your panto, Cancel the job on feet!", 10000)
           --TriggerEvent('pNotify:SendNotification', {text = "You have to return Pizza This' panto!"})
         --TriggerEvent('pNotify:SendNotification', {text = "If you lost your panto, Cancel the job on feet!"})
        end
    else
        PodczasSluzby = false
        BlipCelu = nil
        BlipZakonczenia = nil
        BlipAnulowania = nil
        PozycjaCelu = nil
        MaPaczke = false
        OstatniCel = nil
        LiczbaDostaw = 0
        xxx = nil
        yyy = nil
        zzz = nil
        posiadaVana = false
        Rozwieziono = false
    end
end
