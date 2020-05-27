local script_name = "scotty-crafting"

print("Loading " .. script_name)

ESX = nil

item_data = nil
craft_name = nil
craft_percent = -1

menu_active = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	ESX.TriggerServerCallback('scotty:craftGetItems', function(data)
		SendNUIMessage({
			type = 'load-item',
			data = data
		})
		
		item_data = data
		
		SendNUIMessage({
			type = 'load-craft',
			data = Config["category"],
			config = {
				craft_cost = Config["craft_cost"],
			}
		})
	end)
end)

local delay = 0
function OpenCraftMenu()
	if delay > GetGameTimer() then return end
	delay = GetGameTimer() + 1000
	SendNUIMessage({
		type = 'show',
		data = Config["category"]
	})
	SetNuiFocus(true,true)
	menu_active = true
end

function CloseCraftMenu()
	SendNUIMessage({
		type = 'close',
	})
	SetNuiFocus(false,false)
	menu_active = false
end

RegisterNUICallback("Escape", function(data, cb)
	SetNuiFocus(false,false)
	menu_active = false
end)

RegisterNUICallback("Craft", function(data, cb)
	CraftItem(data.cate_id, data.item_id, data.amount)
end)

function table.Count(tbl)
	local count = 0
	for k,v in pairs(tbl) do
		count = count + 1
	end
	return count
end

function CraftItem(cate_id, item_id, amount)
	amount = amount or 1
	
	if Config["category"][cate_id] == nil
	or Config["category"][cate_id]["list"] == nil
	or Config["category"][cate_id]["list"][item_id] == nil
	or IsEntityDead(PlayerPedId()) then
		return
	end

	local cate = Config["category"][cate_id]
	local data = Config["category"][cate_id]["list"][item_id]
	local item = item_data[data.item]
	
	if string.find(string.lower(data.item), "weapon_") then
		item = {
			label = string.lower(data.item)
		}
	end
	
	local inv = ESX.GetPlayerData().inventory
	local list = data.blueprint
	
	local pos = GetEntityCoords(PlayerPedId())
	
	if list == nil then
		return
	end
	
	craft_name = item.label or "Unknown"
	
	local money = ESX.GetPlayerData().money
	
	if data.cost ~= nil and data.cost > 0
	or Config["craft_cost"] ~= nil and Config["craft_cost"] > 0 then
		local cost = data.cost or Config["craft_cost"]
		if type(cost) ~= "number" then
			SendNUIMessage({
				type = 'dialog',
				title = "Error setting file",
				message = "Contact the system administrator to fix the problem."
			})
			return
		end
		
		if money < cost then
			SendNUIMessage({
				type = 'dialog',
				title = Config["translate"]["no_money"],
				message = string.format(Config["translate"]["no_money2"], string.Comma(cost))
			})
			return
		end
	end
	
	if data.equipment then
		local num = table.Count(data.equipment)
		for k,v in pairs(inv) do
			if data.equipment[v.name] and v.count <= 0 then
				SendNUIMessage({
					type = 'dialog',
					title = Config["translate"]["no_equipment"],
					message = Config["translate"]["no_equipment2"]
				})
				return
			end
		end
	end

	local to_remove = 0
	for k,v in pairs(list) do
		to_remove = to_remove + (v * amount)
	end
	for k,v in pairs(inv) do
		if list[v.name] and v.count > 0 then
			local d = list[v.name]
			if d <= v.count then
				to_remove = to_remove - v.count
			end
		end
	end
	
	if to_remove <= 0 then
		local tab = GetNearestTable()
		
		if tab == nil then
			return
		end
		
		CloseCraftMenu()
		
		local time = data.craft_duration or Config["craft_duration"] or 5
		
		if amount > 1 and Config["craft_duration_multiply"] then
			time = time * amount
		end
		
		if Config["craft_duration_max"] and time > Config["craft_duration_max"] then
			time = Config["craft_duration_max"]
		end
		
		local duration = time * 1000
		local heading = GetHeadingFromVector_2d(tab.position.x - pos.x, tab.position.y - pos.y)
		SetEntityHeading(PlayerPedId(), heading)
		
		craft_percent = 0
		
		local dict = "anim@amb@business@coc@coc_unpack_cut_left@"
		local anim = "cut_cough_coccutter"
		local flag = 30
		
		if data.animation or cate.animation then
			local a = data.animation or cate.animation
			dict = a.dict
			anim = a.anim
			
			if a.flag then
				flag = a.flag
			end
		end
		
		Citizen.CreateThread(function()
			Citizen.Wait(100)
			PlayAnim(dict, anim, duration + 100, flag or 30)
			FreezeEntityPosition(PlayerPedId(), true)
			
			local start = GetGameTimer()
			local time = start + duration
			while (time > GetGameTimer() and not IsEntityDead(PlayerPedId())) do
				local sec = (GetGameTimer() - start)
				craft_percent = math.Round((sec / duration) * 100, 2)
				if craft_percent >= 100 then
					craft_percent = 100
				end
				Citizen.Wait(100)
			end
			
			FreezeEntityPosition(PlayerPedId(), false)
			
			if not IsEntityDead(PlayerPedId()) then
				craft_percent = 100
				
				TriggerServerEvent('scotty:craftItem', cate_id, item_id, amount)
				
				Citizen.Wait(500)
				craft_percent = -1
			else
				craft_percent = -1
			end
		end)
	else
		SendNUIMessage({
			type = 'dialog',
			title = Config["translate"]["not_enough"],
			message = Config["translate"]["not_enough2"]
		})
	end
end

function GetNearestTable()
	local pos = GetEntityCoords(PlayerPedId())
	for k,v in ipairs(Config["craft_table"]) do
		if v.position ~= nil then
			local dist = GetDistanceBetweenCoords(v.position["x"], v.position["y"], v.position["z"], pos.x, pos.y, pos.z, true)
			if dist <= (v.max_distance or 2.0) then
				return v
			end
		end
	end
end

if Config["debug"] then
	RegisterCommand("sc_bench", function()
		local ped = PlayerPedId()
		
		local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 2.0, 0.0)
		local heading = GetEntityHeading(ped)
		
		Citizen.CreateThread(function()
			local bench = GetHashKey("gr_prop_gr_bench_04b")
			RequestModel(bench)

			while not HasModelLoaded(bench) do
				Citizen.Wait(1)
			end
			
			local ent = CreateObject(bench, pos.x, pos.y, pos.z, false, false, true)
			
			SetEntityHeading(ent, heading or 0)
			FreezeEntityPosition(ent, true)
			SetEntityInvincible(ent, true)
			
			PlaceObjectOnGroundProperly(ent)
			
			SetModelAsNoLongerNeeded(bench)
			
			pos = GetEntityCoords(ent)
			heading = GetEntityHeading(ent)
			
			local text = string.format("{ x = %.2f, y = %.2f, z = %.2f, h = %.2f }", pos.x, pos.y, pos.z, heading)
			
			SendNUIMessage({
				type = "copy-clipboard",
				text = text
			})
			
			print(text)
			print("Copied to clipboard!")
		
			Citizen.Wait(5000)
			DeleteObject(ent)
		end)
	end, true)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId())
		
		if not IsEntityDead(PlayerPedId()) then
			for k,v in ipairs(Config["craft_table"]) do
				if v.position ~= nil then
					if v.ent == nil then
						if ESX then
							v.ent = true
							
							if v.map_blip then
								v.blip = AddBlipForCoord(v.position.x, v.position.y, v.position.z)
								SetBlipSprite(v.blip, 643)
								SetBlipDisplay(v.blip, 2)
								SetBlipScale(v.blip, v.blip_scale or 0.5)
								SetBlipColour(v.blip, v.blip_coler or 35)
								SetBlipAsShortRange(v.blip, true)
								BeginTextCommandSetBlipName("STRING")
								AddTextComponentString(v.blip_name or "Crafting Table")
								EndTextCommandSetBlipName(v.blip)
							end
							
							Citizen.CreateThread(function()
								local bench = GetHashKey("gr_prop_gr_bench_04b")
								RequestModel(bench)
		
								while not HasModelLoaded(bench) do
									Citizen.Wait(1)
								end
								
								local ent = CreateObject(bench, v.position.x, v.position.y, v.position.z, false, false, true)
								
								SetEntityHeading(ent, v.position.h or 0)
								FreezeEntityPosition(ent, true)
								SetEntityInvincible(ent, true)
								
								SetModelAsNoLongerNeeded(bench)
								
								Config["craft_table"][k].ent = ent
							end)
						end
					end
					
					local dist = GetDistanceBetweenCoords(v.position["x"], v.position["y"], v.position["z"], pos.x, pos.y, pos.z, true)
					
					if v.ent and type(v.ent) == "number" and craft_percent ~= -1 then
						draw.Simple3DText(v.position["x"], v.position["y"], v.position["z"] + 1.4, "CRAFTING", 1.0)
						draw.Simple3DText(v.position["x"], v.position["y"], v.position["z"] + 1.25, craft_percent.."%", 0.7)
					end
					
					if dist <= (v.max_distance or 2.0) and craft_percent == -1 and not menu_active then
						SetTextComponentFormat('STRING')
						AddTextComponentString("press ~INPUT_CONTEXT~ to access crafting menu")
						DisplayHelpTextFromStringLabel(0, 0, 1, -1)

						if IsControlPressed(0, 38) then
							OpenCraftMenu()
						end
					end
				end
			end
		elseif menu_active then
			CloseCraftMenu()
		end
	end
end)

draw = draw or {}
function draw.Simple3DText(x, y, z, text, sc)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local p = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
	local scale = (1 / distance) * 2
	local fov = (1 / GetGameplayCamFov()) * 100
	scale = scale * fov
	if sc then scale = scale * sc end
	if onScreen then
		SetTextScale(0.0 * scale, 0.35 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

function PlayAnim(anim, param, duration, flag)
	Citizen.CreateThread(function()
		RequestAnimDict(anim)
		
		local time = GetGameTimer() + 1000
		while not (HasAnimDictLoaded(anim) and time > GetGameTimer()) do
			Citizen.Wait(0)
		end
		
		ClearPedTasks(PlayerPedId())
		TaskPlayAnim(PlayerPedId(), anim, param or "Loop", 8.0, 8.0, duration, flag or 63, 0, 0, 0, 0)
	end)
end

function math.Round( num, idp )
	local mult = 10 ^ ( idp or 0 )
	return math.floor( num * mult + 0.5 ) / mult
end

function string.Comma( number )
	if tonumber( number ) then
		number = string.format( "%f", number )
		number = string.match( number, "^(.-)%.?0*$" ) -- Remove trailing zeros
	end

	local k

	while true do
		number, k = string.gsub( number, "^(-?%d+)(%d%d%d)", "%1,%2" )
		if ( k == 0 ) then break end
	end

	return number
end
