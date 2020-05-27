local TOGGLE_KEY = 318

local pets = {
	["Cat"]  		= 1462895032,
	["Husky"] 		= 1318032802,
	["Pug"] 		= 1832265812,
	["Poodle"] 		= 1125994524,
	["Rottweiler"] 	= -1788665315,
	["Retriever"] 	= 882848737,
	["Shepherd"] 	= 1126154828,
	["Westy"] 		= -1384627013,
    ["Boar"] = 3462393972,
    ["Chickenhawk"] = 2864127842,
    --["Chimp"] = 2825402133,
    ["Chop"] = 351016938,
    --["Cormorant"] = 1457690978,
    ["Cow"] = 4244282910,
    ["Coyote"] = 1682622302,
    --["Crow"] = 402729631,
    ["Deer"] = 3630914197,
    --["Fish"] = 802685111,
    ["Hen"] = 1794449327,
    ["MtLion"] = 307287994,
    ["Pig"] = 2971380566,
    --["Pigeon"] = 111281960,
    ["Rat"] = 3283429734,
    --["Rhesus"] = 3268439891,
    --["Seagull"] = 3549666813,
    --["SharkTiger"] = 113504370,
}

local my_pet ={
	handle = nil,
	hash = pets["Husky"],
	name = "Rename Me",
	showName = true,
}

--+++++++
-- MENU +
--+++++++
Citizen.CreateThread(function()
	CreateWarMenu('PET_MENU', 'PET MENU', 'PET MENU')--, {0, 0}, 1.0, {0,0,255,255})
	CreateWarSubMenu('PET_SPAWN', 'PET_MENU', 'PET LIST', tablelength(pets).." PETS AVAILABLE", {0.7, 0.1}, 1.0, {75,175,50,255})
	while true do Wait(0)
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 0.5, 0))
		if IsControlJustReleased(0, TOGGLE_KEY) then -- U
			WarMenu.OpenMenu('PET_MENU')
		end
		if WarMenu.IsMenuOpened('PET_MENU') then
			if WarMenu.MenuButton('Spawn Pet', 'PET_SPAWN') then
			elseif WarMenu.Button('Rename Pet', my_pet.name) then
				local name = Input(my_pet.name)
				if name ~= nil or name ~= '' then
					my_pet.name = name
				else
					my_pet.name = '~r~INVALID NAME'
				end
			elseif WarMenu.Button('Toggle Name') then
				my_pet.showName = not my_pet.showName
			elseif WarMenu.Button('Teleport into Vehicle') then
				if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
					local car = GetVehiclePedIsUsing(GetPlayerPed(-1))
					if my_pet.handle ~= nil then
						local has_control = false
						RequestNetworkControl(function(cb)
							has_control = cb
						end)
						if has_control then
							if not IsPedInAnyVehicle(my_pet.handle, true) then
								for i = 1, GetVehicleMaxNumberOfPassengers(car) do
									if IsVehicleSeatFree(car, i) then
										TaskWarpPedIntoVehicle(my_pet.handle, car, i)
									end
								end
							end
						end
					end
				end
			elseif WarMenu.Button('Teleport to Player') then
				if DoesEntityExist(my_pet.handle) then
					local has_control = false
					RequestNetworkControl(function(cb)
						has_control = cb
					end)
					if has_control then
						SetEntityCoordsNoOffset(my_pet.handle, x, y, z)
					end
				end
			elseif WarMenu.Button('~r~Delete Pet') then
				DeletePed(my_pet.handle)
			end
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('PET_SPAWN') then
			for key,value in pairs(pets) do
				if WarMenu.Button(key) then
					if my_pet.handle == nil then
						my_pet.handle = CreateAPed(tonumber(value),{x = x, y = y, z = z, rot = 0})
					else
						Notify("~r~Delete your pet!")
					end
				end
			end
			WarMenu.Display()
		end
		if my_pet.handle ~= nil and my_pet.showName then
        	aPos = GetEntityCoords(my_pet.handle)
        	DrawText3d(aPos.x, aPos.y, aPos.z + 0.7, 0.5, 0, "~g~[PERSONAL PET]", 255, 255, 255, false)
        	DrawText3d(aPos.x, aPos.y, aPos.z + 0.6, 0.5, 0, my_pet.name, 255, 255, 255, false)
		end
	end
end)

--+++++++++++++++++++++++++++++
-- F O L L O W      O W N E R +
--+++++++++++++++++++++++++++++
Citizen.CreateThread(function()
	while true do Wait(100)
		if my_pet.handle ~= nil then
			local has_control = false
			RequestNetworkControl(function(cb)
				has_control = cb
			end)
			if has_control then
				--TaskFollowToOffsetOfEntity(my_pet.handle, GetPlayerPed(PlayerId()), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
				--SetPedKeepTask(my_pet.handle, true)
				local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -0.5, 0))
				local a,b,c = table.unpack(GetEntityCoords(my_pet.handle))
				local dist = Vdist(x, y, z, a, b, c)
				if dist > 2.5 then
					TaskGoToCoordAnyMeans(my_pet.handle, x, y, z, 10.0, 0, 0, 0, 0)
					while dist > 2.5 do Wait(0)
						if my_pet.handle == nil then break end
						a,b,c = table.unpack(GetEntityCoords(my_pet.handle))
						dist = Vdist(x, y, z, a, b, c)
					end
				end
			end
		end
	end
end)

--++++++++++++
-- F U N C S +
--++++++++++++
function Notify(text)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(text)
	DrawNotification(true, false)
end
function Input(help)
	local var = ''
	DisplayOnscreenKeyboard(6, "FMMC_KEY_TIP8", "", help, "", "", "", 60)
	while UpdateOnscreenKeyboard() == 0 do
		DisableAllControlActions(0)
		Citizen.Wait(0)
	end
	if GetOnscreenKeyboardResult() then
		var = GetOnscreenKeyboardResult()
	end
	return var
end
function DeletePed(handle)
	local has_control = false
	RequestNetworkControl(function(cb)
		has_control = cb
	end)
	
	if has_control then
		SetEntityAsMissionEntity(handle, true, true)
		DeleteEntity(handle)
		my_pet.handle = nil
	end
end
function CreateAPed(hash, pos)
	local handle = nil
	
	RequestModel(hash)
	
	while not HasModelLoaded(hash) do
		Citizen.Wait(1)
	end

	handle = CreatePed(PED_TYPE_ANIMAL, hash, pos.x, pos.y, pos.z, GetEntityHeading(GetPlayerPed(PlayerId())), true, true)
	SetBlockingOfNonTemporaryEvents(handle, true)
	SetEntityInvincible(handle, true)
	SetPedFleeAttributes(handle, 0, 0)
	
	-- NetworkRegisterEntityAsNetworked(handle)
	-- while not NetworkGetEntityIsNetworked(handle) do
		-- NetworkRegisterEntityAsNetworked(handle)
		-- Citizen.Wait(1)
	-- end
	
	SetModelAsNoLongerNeeded(hash)
	
	return handle
end
function RequestNetworkControl(callback)
    local netId = NetworkGetNetworkIdFromEntity(my_pet.handle)
    local timer = 0
    NetworkRequestControlOfNetworkId(netId)
    while not NetworkHasControlOfNetworkId(netId) do
        Citizen.Wait(1)
        NetworkRequestControlOfNetworkId(netId)
        timer = timer + 1
        if timer == 5000 then
            Citizen.Trace("Control failed")
            callback(false)
            break
        end
    end
    callback(true)
end
function CreateWarMenu(id, title, subtitle)--, pos, width, rgba)
	--local x,y = table.unpack(pos)
	--local r,g,b,a = table.unpack(rgba)
	WarMenu.CreateMenu(id, title)
	WarMenu.SetSubTitle(id, subtitle)
	--WarMenu.SetMenuX(id, x)
	--WarMenu.SetMenuY(id, y)
	--WarMenu.SetMenuWidth(id, width)
	--WarMenu.SetTitleBackgroundColor(id, r, g, b, a)
	--WarMenu.SetTitleColor(id, 255, 255, 255, a)
end
function CreateWarSubMenu(id, base, title, subtitle)
	WarMenu.CreateSubMenu(id, base, title)
	WarMenu.SetSubTitle(id, subtitle)
end
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end
function DrawText3d(x,y,z, size, font, text, r, g, b, outline)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
	
	if onScreen then
		SetTextScale(size*scale, size*scale)
		SetTextFont(font)
		SetTextProportional(1)
		SetTextColour(r, g, b, 255)
		if not outline then
			SetTextDropshadow(0, 0, 0, 0, 55)
			SetTextEdge(2, 0, 0, 0, 150)
			SetTextDropShadow()
			SetTextOutline()
		end
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		SetDrawOrigin(x,y,z, 0)
		DrawText(0.0, 0.0)
		ClearDrawOrigin()
	end
end