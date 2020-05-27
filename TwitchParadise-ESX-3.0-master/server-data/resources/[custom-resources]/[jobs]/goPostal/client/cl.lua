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

local PlayerData              = {}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	
	CreateBlip()	
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
    CreateBlip()	
	Citizen.Wait(5000)
end)

--------------------------------------

local currentJob = {}
local restockObject = {}
local restockObjectLocation = {}
local onJob = false 
local goPostalVehicle = nil
local currentJobPay = 0
local PackageObject = nil
local currentPackages = 0
local locations = {
	["Grapeseed"] = {
		['Max'] = 22,
		[1] = {2563.99, 4692.7, 35.02},
		[2] = {1967.33, 4640.92, 41.88},
		[3] = {2030.39, 4980.46, 42.1},
		[4] = {1717.86, 4676.93, 43.66},
		[5] = {1689.25, 4818.3, 43.06},
		[6] = {2505.48, 4095.73, 39.2}, 
		[7] = {2570.87, 4282.84, 43.0},
		[8] = {2721.19, 4285.98, 48.6},
		[9] = {2727.59, 4145.46, 45.69},
		[10] = {3322.6, 5166.06, 19.92},
		[11] = {2216.42, 5612.49, 55.69}, 
		[12] = {2434.51, 4976.82, 47.07},
		[13] = {2300.36, 4871.94, 42.06},
		[14] = {1962.36, 5184.98, 47.98},
		[15] = {1698.97, 4921.18, 42.56},
		[16] = {1655.87, 4874.38, 42.04}, 
		[17] = {2159.72, 4789.8, 41.67},
		[18] = {2121.77, 4784.71, 41.97},
		[19] = {2639.04, 4246.56, 44.77},
		[20] = {2455.85, 4058.3, 38.06},
		[21] = {3680.06, 4497.93, 25.11}, 
		[22] = {3807.8, 4478.6, 6.37},
	},

	["Sandy Shores"] = {
		['Max'] = 33,
		[1] = {1986.69824, 3815.02490, 33.32370},
		[2] = {1446.34997, 3649.69384, 35.48260},
		[3] = {228.27, 3165.8, 43.61},
		[4] = {170.36, 3113.28, 43.51},
		[5] = {179.76, 3033.1, 43.98},
		[6] = {1990.57141, 3057.46801, 48.06378}, 
		[7] = {2201.01, 3318.25, 46.77},
		[8] = {2368.38, 3155.96, 48.61},
		[9] = {1881.07,3888.5,34.25},
		[10] = {1889.76,3810.71,33.75},
		[11] = {1638.8,3734.17,34.41}, 
		[12] = {2630.27,3262.88,56.25},
		[13] = {2622.43,3275.56,56.3},
		[14] = {2633.7,3287.4,56.45},
		[15] = {2389.48, 3341.64, 47.72}, 
		[16] = {2393.01, 3320.62, 48.24},
		[17] = {2163.38, 3374.63, 46.07},
		[18] = {1959.95, 3741.99, 33.24},
		[19] = {1931.55, 3727.6, 33.84},
		[20] = {1850.68, 3690.03, 35.5}, 
		[21] = {1707.92, 3585.29, 36.57},
		[22] = {1756.33, 3659.54, 35.39},
		[23] = {1825.41, 3718.35, 34.42},
		[24] = {1899.13, 3764.68, 33.79},
		[25] = {1923.37, 3797.43, 33.44}, 
		[26] = {1914.69, 3813.37, 33.44},
		[27] = {1913.61, 3868.06, 33.37},
		[28] = {1942.34, 3885.42, 33.67},
		[29] = {1728.66, 3851.46, 34.78},
		[30] = {903.67, 3560.82, 33.81},
		[31] = {910.93, 3644.29, 32.68},
		[32] = {1393.15,3673.4, 34.79},
		[33] = {1435.18, 3682.92, 34.84},
	},

	["Paleto Bay"] = {
		['Max'] = 29,
		[1] = {-291.14, 6199.27, 32.49},
		[2] = {-96.43, 6324.47, 32.08},
		[3] = {-390.28, 6300.23, 30.75},
		[4] = {-360.8, 6320.98, 30.76},
		[5] = {-303.41, 6329.00, 32.99},
		[6] = {-215.5, 6431.99, 32.49}, 
		[7] = {-46.21,6595.62,31.55},
		[8] = {0.46, 6546.92, 32.37},
		[9] = {-1.09, 6512.9, 33.04},
		[10] = {99.35, 6618.56, 33.47},
		[11] = {-774.31, 5597.84, 34.61}, 
		[12] = {-696.1, 5802.36, 17.83},
		[13] = {-448.77, 6009.95, 32.22},
		[14] = {-326.55,6083.95,31.96},
		[15] = {-341.66, 6212.46,32.59},
		[16] = {-247.15,6331.02,32.93}, 
		[17] = {-394.74,6272.52,30.94},
		[18] = {35.18,6662.39,32.19},
		[19] = {-130.66,6551.98,29.87},
		[20] = {-106.06,6469.6,32.63},
		[21] = {-94.5, 6408.86, 32.14}, 
		[22] = {-25.2,6472.25,31.98},
		[23] = {-105.28,6528.96,30.17},
		[24] = {150.41,6647.58,32.11},
		[25] = {161.68,6636.1,32.17},
		[26] = {-9.37,6653.93,31.98},
		[27] = {-40.15,6637.23,31.09},
		[28] = {-5.97,6623.07,32.32},
		[29] = {-113.22, 6538.18, 30.6},
	}
}

local restockLocations = {
 [1] = {-436.062, 6135.071, 31.478},
 [2] = {-435.247, 6134.340, 31.478},
 [3] = {-434.869, 6133.323, 31.478},
 [4] = {-444.338, 6138.739, 31.478},
 [5] = {-445.607, 6139.875, 31.478},
 [6] = {-427.392, 6134.616, 31.478},
 [7] = {-426.332, 6133.624, 31.478},
 [8] = {-424.201, 6132.655, 31.478}
}

local vehicleSpawnLocations = {
 {x = -400.5178, y = 6163.97607, z = 31.387895, h = 354.08728},
 {x = -403.4285, y = 6165.96875, z = 31.426778, h = 352.25277},
 {x = -406.0371, y = 6168.61914, z = 31.394813, h = 353.80203},
 {x = -408.9385, y = 6171.53271, z = 31.380252, h = 353.44647},
 {x = -411.9129, y = 6174.58349, z = 31.379669, h = 353.77667}
}



function CreateBlip()
    if PlayerData.job ~= nil and PlayerData.job.name == 'gopostal' then

		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(-400.5178, 6163.97607, 31.387895)
			SetBlipSprite(BlipCloakRoom, 541)
			SetBlipColour(BlipCloakRoom, 46)
			SetBlipScale(BlipCloakRoom, 0.6)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('GoPostal Duty')
			EndTextCommandSetBlipName(BlipCloakRoom)
	  end	
	else

        if BlipCloakRoom ~= nil then
            RemoveBlip(BlipCloakRoom)
            BlipCloakRoom = nil
        end
	end
 end


Citizen.CreateThread(function()
 while true do
  Citizen.Wait(5)
  if PlayerData.job ~= nil and PlayerData.job.name == 'gopostal' then
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -402.732, 6172.939, 31.532, true) < 15) then
	DrawMarker(23, -402.732, 6172.939, 31.532-0.9, 0, 0, 0, 0.0, 0, 0, 3.0, 3.0, 0.5001, 255, 255, 255, 255, 0, 0, 0, 0)
   	if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -402.732, 6172.939, 31.532, true) < 1.5) then
   	 if DoesEntityExist(goPostalVehicle) then DrawText3d(-402.732, 6172.939, 31.532+1.2, "~w~Press ~r~[E]~w~ to end work", 200) else DrawText3d(-402.732, 6172.939, 31.532+1.2, "~w~Press ~r~[E]~w~ for start work.", 200) end	
   	 if IsControlJustPressed(0, 38) then 
   	  if DoesEntityExist(goPostalVehicle) then 
   	   onJob = false
	   DeleteVehicle(goPostalVehicle)
	   RemoveJobBlip()

	   local plate = GetVehicleNumberPlateText(goPostalVehicle)
	   TriggerServerEvent('garage:addKeys', plate)
   	  else
   	   local freespot, v = getParkingPosition(vehicleSpawnLocations)
		if freespot then SpawnGoPostal(v.x, v.y, v.z, v.h) end
		exports['mythic_notify']:SendAlert('inform', 'Go Round The Back of The Warehouse To Fill Your Truck', 10000)
		--TriggerEvent("pNotify:SendNotification", {text= "<font color='yellow'>Go Round The Back of The Warehouse To Fill Your Truck"})  
      end
     end
	end
   end
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -441.282, 6142.714, 31.478, true) < 40) and IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("boxville4")) and DoesEntityExist(goPostalVehicle) then
   	DrawMarker(23, -441.282, 6142.714, 31.478-0.95, 0, 0, 0, 0.0, 0, 0, 3.0, 3.0, 0.5001, 255, 255, 255, 255, 0, 0, 0, 0)
	if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -441.282, 6142.714, 31.478, true) < 4) then
	 if not onJob then 
	  DrawText3d(-441.282, 6142.714, 31.478+1.2, "~w~Press ~r~[E]~w~ to restock your van", 200)
	  
	  
	  
	  
	  if IsControlJustPressed(0, 38) then
	   restockVan()
	  end
     end
    end
   end
   if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), currentJob[1], currentJob[2], currentJob[3], true) < 20) and onJob then
   	DrawMarker(1, currentJob[1], currentJob[2], currentJob[3], 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 112, 100,210, true, true, 0,0)
	if(GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), currentJob[1], currentJob[2], currentJob[3], true) < 1.5) then
	 drawTxt('~w~Press ~r~[E]~w~ to Deliver The Package')
	 if IsControlJustPressed(0, 38) then
	  DeleteObject(PackageObject)
	  ClearPedTasks(GetPlayerPed(-1))
	  PackageObject = nil 
	  TriggerServerEvent('gopostal:cash', currentJobPay)
	  
	  newShift()
	 end
    end
   end
   if onJob and not IsPedInAnyVehicle(GetPlayerPed(-1)) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), currentJob[1], currentJob[2], currentJob[3], true) < 20 then 
    local bootPos = GetEntityCoords(goPostalVehicle)
    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bootPos.x, bootPos.y, bootPos.z, true) < 2.5 and PackageObject == nil then 
     drawTxt('~w~Press ~r~[E]~w~ To Take Package')
	 
     if IsControlJustPressed(0, 38) then
	  LoadModel("prop_cs_cardbox_01")
	  local pos = GetEntityCoords(GetPlayerPed(-1), false)
	  PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), pos.x, pos.y, pos.z, true, true, true)
      AttachEntityToEntity(PackageObject, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
      LoadAnim("anim@heists@box_carry@")
      TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
     end
    end 
   end
  end
 end
end)


function restockVan()
 local restockPackages = 8
 local restockVan = true
 local carryingPackage = {status = false, id = nil}
 for id,v in pairs(restockLocations) do 
  restockObject[id] = CreateObject(GetHashKey("prop_cs_cardbox_01"), v[1],v[2],v[3]-0.95, true, true, true)
  restockObjectLocation[id] = v 
  PlaceObjectOnGroundProperly(restockObject[id])
 end
 while restockVan do 
  Wait(1)
  for id,v in pairs(restockObjectLocation) do 
   DrawMarker(2, v[1],v[2],v[3], 0,0,0,0,0,0,0.5,0.5,0.5,255,255,0,165,0,0,0,0)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), v[1],v[2],v[3], true) < 1.0 then
    drawTxt('~w~Press ~r~[E]~w~ To Take Package')
    if IsControlJustPressed(0, 38) then 
     AttachEntityToEntity(restockObject[id], PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
     LoadAnim("anim@heists@box_carry@")
     TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
     carryingPackage.status = true
     carryingPackage.id = id
    end
   end
  end
  if carryingPackage.status then 
   local bootPos = GetEntityCoords(goPostalVehicle)
   if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), bootPos.x, bootPos.y, bootPos.z, true) < 2.6 then 
    drawTxt('~w~Press ~r~[E]~w~ To Put Package Into Van')
    if IsControlJustPressed(0, 38) then 
     DeleteObject(restockObject[carryingPackage.id])
     ClearPedTasks(GetPlayerPed(-1))
     carryingPackage.status = false
     restockObjectLocation[carryingPackage.id] = {}
     restockObject[carryingPackage.id] = nil
     restockPackages = restockPackages-1
     if restockPackages == 0 then 
      restockVan = false
      newShift()
	  onJob = true
	  exports['mythic_notify']:SendAlert('inform', 'Van Restocked, Begin Delivering Your Packages', 10000)
      --exports.pNotify:SendNotification({text = "Van Restocked, Begin Delivering Your Packages"})
     end
    end
   end
  end
 end
end

function newShift()
 local id = math.random(1,3)
 if id == 1 then 
	local jobLocation = locations['Grapeseed'][math.random(1, locations['Grapeseed']['Max'])] 
	SetJobBlip(jobLocation[1],jobLocation[2],jobLocation[3])
	currentJob = jobLocation
 elseif id == 2 then 
	local jobLocation = locations['Sandy Shores'][math.random(1, locations['Sandy Shores']['Max'])]
	SetJobBlip(jobLocation[1],jobLocation[2],jobLocation[3])
	currentJob = jobLocation
 elseif id == 3 then 
	local jobLocation = locations['Paleto Bay'][math.random(1, locations['Paleto Bay']['Max'])]
	SetJobBlip(jobLocation[1],jobLocation[2],jobLocation[3])
	currentJob = jobLocation
 end

currentJobPay = CalculateTravelDistanceBetweenPoints(GetEntityCoords(GetPlayerPed(-1)), currentJob[1],currentJob[2],currentJob[3])/2/4
	if currentJobPay > 100 then
		currentJobPay = round((currentJobPay / 2), 0)
		if currentJobPay > 450 then
			currentJobPay = 450
		end
		return
	elseif currentJobPay > 60 then
		currentJobPay = math.random(70,100)
		return
	end
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function SpawnGoPostal(x,y,z,h)
 local vehicleHash = GetHashKey('boxville4')
 RequestModel(vehicleHash)
 while not HasModelLoaded(vehicleHash) do
  Citizen.Wait(0)
 end

 goPostalVehicle = CreateVehicle(vehicleHash, x, y, z, h, true, false)
 local id = NetworkGetNetworkIdFromEntity(goPostalVehicle)
 SetNetworkIdCanMigrate(id, true)
 SetNetworkIdExistsOnAllMachines(id, true)
 SetVehicleDirtLevel(goPostalVehicle, 0)
 SetVehicleHasBeenOwnedByPlayer(goPostalVehicle, true)
 SetEntityAsMissionEntity(goPostalVehicle, true, true)
 SetVehicleEngineOn(goPostalVehicle, true)
end