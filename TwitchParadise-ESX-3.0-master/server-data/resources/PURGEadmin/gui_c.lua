-- [[Variables.]]
local menuKey = 212

local noclipHotkey = 344 -- [[HOME]]
local noclipActive = false
local currentSpeed = 1

local screenshotHotkey = 314 -- [[NUMPAD +]]

local SlapAmount = {}
for i=1,20 do
	table.insert(SlapAmount,i)
end

-- [[Used to enable/disable controls when in noclip.]]
function noclipControls(bool)
	local controls = {
		20,
		30,
		31,
		32,
		33,
		34,
		35,
		44,
		85,
		266,
		267,
		268,
		269
	}
	for k, v in pairs(controls) do 
		if bool then
			DisableControlAction(1, v, false)
		else
			EnableControlAction(1, v, true)
		end
	end
end

-- [[Used for the text notification when enabling/disabling no-clip.]]
function getNoClipState()
	if noclipActive then 
		return "~g~Enabled"
	else
		return "~r~Disabled"
	end
end

-- [[Used to setup player for no-clip by disabling certain things such as collison, etc.]]
function setupNoClip()
	if noclipActive then
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetEntityCollision(ped, false, false)
	else
		FreezeEntityPosition(ped, false)
		SetEntityInvincible(ped, false)
		SetEntityCollision(ped, true, true)
	end
end

-- [[Uses the servers response to gauge what you can and can't do.]]
function GetPermLevel(int)
	if perm > int then
		return true
	else
		return false
	end 
end

-- [[The servers reponse to carrying your permissions.]]
RegisterNetEvent("PURGEadmin:adminresponse")
AddEventHandler('PURGEadmin:adminresponse', function(responseperm)
	perm = responseperm
end)

_menuPool = NativeUI.CreatePool()

Citizen.CreateThread(function()
	TriggerServerEvent("PURGEadmin:amiadmin")
	TriggerServerEvent("PURGEadmin:requestBanlist")

	while perm == nil do
		Wait(100)
	end

	if not HasStreamedTextureDictLoaded("commonmenu") then
		while not HasStreamedTextureDictLoaded("commonmenu") do
			RequestStreamedTextureDict("commonmenu", true)
			print("[PURGE-BR] Downloading Admin Assets!") -- [[Needed for the custom banners used within the menu.]]
			Citizen.Wait(100)
		end
	end

	if GetPermLevel(0) then

		menuOrientation = 1250

		menuWidth = 150

		mainMenu = NativeUI.CreateMenu("Administration", "~r~Purge hammer ready!", menuOrientation, 0)
		_menuPool:Add(mainMenu)
		
		mainMenu:SetMenuWidthOffset(menuWidth)	
		_menuPool:ControlDisablingEnabled(true)
		_menuPool:MouseControlsEnabled(true)
			
		while true do
			if _menuPool then
				_menuPool:ProcessMenus()
			end
			
			if IsControlJustReleased(1, menuKey) then
				if mainMenu:Visible() then
					mainMenu:Visible(false)
					_menuPool:Remove()
					collectgarbage()
				else
					GenerateMenu()
					mainMenu:Visible(true)
				end
			end
			
			if IsControlJustPressed(1, noclipHotkey) and GetPermLevel(5) then
				noclipActive = not noclipActive
				GenerateMenu()
				setupNoClip(noclipActive)
				ShowNotification("No-clip: "..getNoClipState())
			end

			if IsPedInAnyVehicle(PlayerPedId(), true) then
				ped = GetVehiclePedIsIn(PlayerPedId(), false)
			else
				ped = PlayerPedId()
			end

			if IsControlJustPressed(1, screenshotHotkey) then
				local coooooords = GetEntityCoords(ped)

				TriggerServerEvent("PURGEadmin:SaveCoords", coooooords)
			end

			Citizen.Wait(1)
		end
	else
		return
	end
end)

function GenerateMenu() -- [[Create the menu.]]
	_menuPool = NativeUI.CreatePool()

	collectgarbage()

	menuOrientation = 1250

	menuWidth = 150
	
	mainMenu = NativeUI.CreateMenu("Administration", "~r~Purge hammer ready!", menuOrientation, 0)
	_menuPool:Add(mainMenu)
	
	mainMenu:SetMenuWidthOffset(menuWidth)	
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
	
	playermanagement = _menuPool:AddSubMenu(mainMenu, "Player Management","",true)

	mainMenu:SetMenuWidthOffset(menuWidth)	
	playermanagement:SetMenuWidthOffset(menuWidth)	

	players = {}
	local localplayers = {}
	for _, activeplayer in ipairs(GetActivePlayers()) do
		table.insert(localplayers, GetPlayerServerId(activeplayer))
	end
	
	table.sort(localplayers)

	for i,thePlayer in ipairs(localplayers) do
		table.insert(players,GetPlayerFromServerId(thePlayer))
	end

	local banLength = {
		{label = "1 Day", time = 86400},
		{label = "3 Days", time = 259200},
		{label = "1 Week", time = 518400},
		{label = "2 Weeks", time = 1123200},
		{label = "1 Month", time = 2678400},
		{label = "1 Year", time = 31536000},
		{label = "Permanent", time = 10444636800},
	}

	local bt = {}
	for i,a in ipairs(banLength) do
		table.insert(bt, a.label)
	end

	for i,thePlayer in ipairs(players) do
		thisPlayer = _menuPool:AddSubMenu(playermanagement,"["..GetPlayerServerId(thePlayer).."] "..GetPlayerName(thePlayer),"",true)
		thisPlayer:SetMenuWidthOffset(menuWidth)

		local thisKickMenu = _menuPool:AddSubMenu(thisPlayer,"Kick Player","",true, false, "commonmenu", "interaction_bgd_3")
		thisKickMenu:SetMenuWidthOffset(menuWidth)

		local sl = {"Mic Spam", "Hate Speech", "Custom"}
		KickReason = "Mic Spam"
		local thisItem = NativeUI.CreateListItem("Kick Reason", sl, 1,"Choose the reason to kick, select custom for a custom reason!")
		thisKickMenu:AddItem(thisItem)
		thisKickMenu.OnListChange = function(sender, item, index)
			if item == thisItem then
				i = item:IndexToItem(index)
				if i ~= "Custom" then
					KickReason = i
				end
			end
		end
		
		thisKickMenu.OnListSelect = function(sender, item, index)
			if item == thisItem then
				i = item:IndexToItem(index)
				if i == "Custom" then
					AddTextEntry("FMMC_KEY_TIP8", "Kick reason [128 CHAR MAX]")
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
					
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait(10)
					end
					
					local result = GetOnscreenKeyboardResult()
					
					if result and result ~= "" then
						KickReason = result
					else
						KickReason = "None"
					end
				end
			end
		end
		
		local thisItem = NativeUI.CreateItem("Confirm Kick","~r~~h~NOTE:~h~~w~ Pressing Confirm will kick "..GetPlayerName(thePlayer).." with the specified settings.")
		thisKickMenu:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			if KickReason == "" or KickReason == "None" then
				ShowNotification("~r~ERROR ~w~: That is not a valid kick reason!")
				_menuPool:CloseAllMenus()
				Citizen.Wait(800)
				GenerateMenu()
				playermanagement:Visible(true)
			else
				TriggerServerEvent("PURGEadmin:kickPlayer", GetPlayerServerId(thePlayer), KickReason)
				KickReason = ""
				_menuPool:CloseAllMenus()
				Citizen.Wait(800)
				GenerateMenu()
				playermanagement:Visible(true)
			end
		end	
		
		if GetPermLevel(3) then
			local thisBanMenu = _menuPool:AddSubMenu(thisPlayer,"Ban Player","",true, false, "commonmenu", "interaction_bgd_3")
			thisBanMenu:SetMenuWidthOffset(menuWidth)

			local sl = {"Mic Spam", "Hate Speech", "Custom"}
			BanReason = "Mic Spam"
			local thisItem = NativeUI.CreateListItem("Ban Reason", sl, 1,"Choose the reason to ban, select custom for a custom reason!")
			thisBanMenu:AddItem(thisItem)

			thisBanMenu.OnListChange = function(sender, item, index)
				if item == thisItem then
					i = item:IndexToItem(index)
					if i ~= "Custom" then
						BanReason = i
					end
				end
			end
			
			thisBanMenu.OnListSelect = function(sender, item, index)
				if item == thisItem then
					i = item:IndexToItem(index)
					if i == "Custom" then
						AddTextEntry("FMMC_KEY_TIP8", "Ban reason [128 CHAR MAX]")
						DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
						
						while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
							Citizen.Wait(10)
						end
						
						local result = GetOnscreenKeyboardResult()
						
						if result and result ~= "" then
							BanReason = result
						else
							BanReason = "None"
						end
					end
				end
			end
			
			local thisItem = NativeUI.CreateListItem("Ban Length",bt, 1,"Until when should the "..GetPlayerName(thePlayer).." be banned?" )
			thisBanMenu:AddItem(thisItem)
			local BanTime = 1
			thisItem.OnListChanged = function(sender,item,index)
				BanTime = index
			end
		
			local thisItem = NativeUI.CreateItem("Confirm Ban","~r~~h~NOTE:~h~~w~ Pressing Confirm will ban "..GetPlayerName(thePlayer).." with the specified settings.")
			thisBanMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				if BanReason == "" or BanReason == "None" then
					BanReason = "No Reason Specified"
					_menuPool:CloseAllMenus()
					Citizen.Wait(800)
					GenerateMenu()
					playermanagement:Visible(true)
				else
					TriggerServerEvent("PURGEadmin:banPlayer", GetPlayerServerId( thePlayer ), BanReason, banLength[BanTime].time, GetPlayerName( thePlayer ))
					BanTime = 1
					BanReason = ""
					_menuPool:CloseAllMenus()
					Citizen.Wait(800)
					GenerateMenu()
					playermanagement:Visible(true)
				end
			end	
		else 
			local thisItem = NativeUI.CreateLockedItem("Ban Player","")
			thisPlayer:AddItem(thisItem)
		end
		
		local thisItem = NativeUI.CreateItem("Screenshot Player's Game","Take a screenshot of "..GetPlayerName(thePlayer).."'s game. Can be found on ~b~discord ~r~#~w~server-logs! (~r~Broken~w~)")
		thisPlayer:AddItem(thisItem)
		thisItem:SetRightBadge(4)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			TriggerServerEvent("PURGEadmin:screenshotPlayer", GetPlayerServerId(thePlayer))
		end

		if GetPermLevel(1) then			
			local thisItem = NativeUI.CreateItem("Mute Player","Enable/disable "..GetPlayerName(thePlayer).." from using the text chat.")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				TriggerServerEvent("PURGEadmin:mutePlayer", GetPlayerServerId(thePlayer), GetPlayerName(thePlayer))
			end
		else 
			local thisItem = NativeUI.CreateLockedItem("Mute Player","")
			thisPlayer:AddItem(thisItem)
		end

		local thisItem = NativeUI.CreateItem("Spectate Player", "View "..GetPlayerName(thePlayer).."'s perspective.")
		thisPlayer:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			TriggerServerEvent("PURGEadmin:requestSpectate", thePlayer)
		end
		
		if GetPermLevel(1) then
			local thisItem = NativeUI.CreateItem("Teleport to Player","Teleport to "..GetPlayerName(thePlayer).."'s position.")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(thePlayer),true))
				local heading = GetEntityHeading(GetPlayerPed(thePlayer))
				SetEntityCoords(PlayerPedId(), x, y, z, 0, 0, heading, false)
			end
		else 
			local thisItem = NativeUI.CreateLockedItem("Teleport to Player","")
			thisPlayer:AddItem(thisItem)
		end
		
		if GetPermLevel(2) then
			local thisItem = NativeUI.CreateItem("Teleport Player to Me","Teleport "..GetPlayerName(thePlayer).." to your position.")
			thisPlayer:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId()))
				local heading = GetEntityHeading(PlayerPedId())
				TriggerServerEvent("PURGEadmin:TeleportPlayerToCoords", GetPlayerServerId(thePlayer), px, py, pz, heading)
			end
		else 
			local thisItem = NativeUI.CreateLockedItem("Teleport Player to me","")
			thisPlayer:AddItem(thisItem)
		end
		
		if GetPermLevel(4) then
			local thisItem = NativeUI.CreateSliderItem("Slap Player", SlapAmount, 20, false, false)
			thisPlayer:AddItem(thisItem)
			thisItem.OnSliderSelected = function(index)
				TriggerServerEvent("PURGEadmin:SlapPlayer", GetPlayerServerId(thePlayer), index*10)
			end
		else 
			local thisItem = NativeUI.CreateLockedItem("Slap Player","")
			thisPlayer:AddItem(thisItem)
		end

		if GetPermLevel(2) then
			local sl = {"On", "Off"}
			local thisItem = NativeUI.CreateListItem("Set Player Frozen", sl, 1, "Freeze "..GetPlayerName(thePlayer).." in their current position.")
			thisPlayer:AddItem(thisItem)
			thisPlayer.OnListSelect = function(sender, item, index)
				if item == thisItem then
					i = item:IndexToItem(index)
					if i == "On" then
						TriggerServerEvent("PURGEadmin:FreezePlayer", GetPlayerServerId(thePlayer), true)
					else
						TriggerServerEvent("PURGEadmin:FreezePlayer", GetPlayerServerId(thePlayer), false)
					end
				end
			end
		else 
			local thisItem = NativeUI.CreateLockedItem("Freeze Player", "")
			thisPlayer:AddItem(thisItem)
		end

		if GetPermLevel(4) then

			local thisPermMenu = _menuPool:AddSubMenu(thisPlayer,"Update Permission","",true, false, "commonmenu", "interaction_bgd_4")
			thisPermMenu:SetMenuWidthOffset(menuWidth)

			local staffSl = {}

			if GetPermLevel(5) then
				staffSl = {"Trial-Moderator", "Moderator", "Senior Moderator", "Admin", "Head Admin", "Owner"} -- [[Owner can give all ranks.]]
			else
				staffSl = {"Trial-Moderator", "Moderator", "Senior Moderator", "Admin"} -- [[Head Admin can give up to Admin rank.]]
			end

			permission = 1
			permissionName = ""
			local thisItem = NativeUI.CreateListItem("Update Permission", staffSl, 1, "Update "..GetPlayerName(thePlayer).."'s current permission.")
			thisPermMenu:AddItem(thisItem)
			thisPermMenu.OnListChange = function(sender, item, index)
				if item == thisItem then
					permission = index
					permissionName = item:IndexToItem(index)
				end
			end

			local thisItem = NativeUI.CreateItem("Give Permission","")
			thisPermMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem) 
				TriggerServerEvent("PURGEadmin:UpdateAdmin", GetPlayerServerId(thePlayer), permission, permissionName)
				permission = 1
				permissionName = ""
			end
		else 
			local thisItem = NativeUI.CreateLockedItem("Update Permission","")
			thisPlayer:AddItem(thisItem)
		end

		local thisItem = NativeUI.CreateItem("Staff Notification", "Send a ~r~staff ~w~notificaiton to "..GetPlayerName(thePlayer)..".")
		thisPlayer:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			AddTextEntry("FMMC_KEY_TIP8", "Message [90 CHAR MAX]")
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 90)
			
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				Citizen.Wait(10)
			end
			
			local result = GetOnscreenKeyboardResult()
			
			if result and result ~= "" then
				TriggerServerEvent("PURGEadmin:StaffNotification", GetPlayerServerId(thePlayer), result)
			else
				ShowNotification("~r~ERROR ~w~: Invalid Message!")
			end
			result = ""
		end
	end
	
	if GetPermLevel(5) then
		local thisItem = NativeUI.CreateItem("Teleport Players to Me", "~r~~h~NOTE:~h~~w~ This will teleport ~y~~h~all~h~ ~w~~s~players to you.")
		playermanagement:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			local px, py, pz = table.unpack(GetEntityCoords(PlayerPedId(), true))
			local heading = GetEntityHeading(PlayerPedId())
			TriggerServerEvent("PURGEadmin:TeleportPlayerToCoords", -1, px, py, pz, heading)
		end
	else
		local thisItem = NativeUI.CreateLockedItem("All Players","")
		playermanagement:AddItem(thisItem)
	end

	if GetPermLevel(3) then
		servermanagement = _menuPool:AddSubMenu(mainMenu, "Server Management","",true)
		servermanagement:SetMenuWidthOffset(menuWidth)	

		if GetPermLevel(5) then
			local devMenu = _menuPool:AddSubMenu(servermanagement,"Server Dev","",true, false, "commonmenu", "interaction_bgd_2")
			devMenu:SetMenuWidthOffset(menuWidth)

			local noclipMenu = _menuPool:AddSubMenu(devMenu,"No-clip","",true, false, "commonmenu", "interaction_bgd_2")
			noclipMenu:SetMenuWidthOffset(menuWidth)

			local thisItem = NativeUI.CreateItem("No-Clip Speed", "Click to input a speed! ~h~(~r~Integer value only!~w~)")
			noclipMenu:AddItem(thisItem)
			thisItem:RightLabel(currentSpeed)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				AddTextEntry("FMMC_KEY_TIP8", "No-clip Speed [10 CHAR MAX]")
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 10)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(10)
				end
				
				local result = GetOnscreenKeyboardResult()

				if result == "" or result == nil then 
					ShowNotification("~r~ERROR ~w~: Invalid Speed!")
				elseif string.find(result,"[%D]") then
					ShowNotification("~r~ERROR ~w~: Invalid Speed! Integer value only.")
				elseif tonumber(result) > 100 then
					ShowNotification("~r~ERROR ~w~: Invalid Speed! Above 100.")
				else
					currentSpeed = result
					thisItem:RightLabel(currentSpeed)
				end
			end

			noclipItem = NativeUI.CreateItem("No-Clip", "Click to engage no-clip...you cheat!")
			noclipMenu:AddItem(noclipItem)
			noclipItem:SetRightBadge(0)
			noclipItem.Activated = function(ParentMenu,SelectedItem)
				noclipActive = not noclipActive
				if noclipActive then
					noclipItem:SetRightBadge(22)
					setupNoClip(true)
				else
					noclipItem:SetRightBadge(0)
					setupNoClip(false)
				end
			end
			
			local thisItem = NativeUI.CreateItem("Spawn Veh By Name", "Spawn a vehicle by its model name!")
			devMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				local ped = PlayerPedId()
				local coooooords = GetEntityCoords(ped)

				AddTextEntry("FMMC_KEY_TIP8", "Model")
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(10)
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result then
					if IsModelAVehicle(result) then
						if IsPedInAnyVehicle(ped) then
							DeleteEntity(GetVehiclePedIsIn(ped, false))
						end
						resulthash = GetHashKey(result)
						if not HasModelLoaded() then
							RequestModel(resulthash)
							while not HasModelLoaded(resulthash) do
								Citizen.Wait(10)
							end
						end
						local veh = CreateVehicle(resulthash, coooooords.x, coooooords.y, coooooords.z, GetEntityHeading(ped), true, false)
						SetPedIntoVehicle(ped, veh, -1)
					else
						ShowNotification("~r~ERROR ~w~: Invalid vehicle!")
					end
				end
			end

			local thisItem = NativeUI.CreateItem("Get coooooords", "Get your current co-ordinates.")
			devMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				local coooooords = GetEntityCoords(PlayerPedId())

				TriggerServerEvent("PURGEadmin:SaveCoords", coooooords)
			end

			local thisItem = NativeUI.CreateItem("Set Game Type", "Set the Game Type as listed on the Serverlist.")
			devMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				AddTextEntry("FMMC_KEY_TIP8", "Game Type")
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(10)
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result then
					TriggerServerEvent("PURGEadmin:SetGameType", result)
				end
			end
			
			local thisItem = NativeUI.CreateItem("Set Map Name", "Set the Map Name as listed on the Serverlist.")
			devMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				AddTextEntry("FMMC_KEY_TIP8", "Map name")
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(10)
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result then
					TriggerServerEvent("PURGEadmin:SetMapName", result)
				end
			end
			
			local thisItem = NativeUI.CreateItem("Start Resource by Name", "Start a resource installed on the server.")
			devMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				AddTextEntry("FMMC_KEY_TIP8", "Resource name")
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(10)
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result then
					TriggerServerEvent("PURGEadmin:StartResource", result)
				end
			end
			
			local thisItem = NativeUI.CreateItem("Stop Resource by Name", "Stop a resource installed on the server.")
			devMenu:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				AddTextEntry("FMMC_KEY_TIP8", "Resource name")
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32 + 1)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(10)
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result then
					if result ~= GetCurrentResourceName() then
						TriggerServerEvent("PURGEadmin:StopResource", result)
					else
						TriggerEvent("chat:addMessage", { args = { "[^8SERVER^7]", "Don't do that, seriously!" } })
					end
				end
			end
		end 

		if GetPermLevel(4) then
			local thisItem = NativeUI.CreateItem("~y~Announcement", "")
			servermanagement:AddItem(thisItem)
			thisItem.Activated = function(ParentMenu,SelectedItem)
				AddTextEntry("FMMC_KEY_TIP8", "Announcement [32 Char Max]")
				DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 32)
				
				while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
					Citizen.Wait(1)
				end
				
				local result = GetOnscreenKeyboardResult()
				
				if result and result ~= "" then
					TriggerServerEvent("PURGEadmin:ServerAnnouncement", result)
				else
					ShowNotification("~r~ERROR ~w~: Invalid announcement!")
				end
				result = ""
			end

			unbanPlayer = _menuPool:AddSubMenu(servermanagement, "Un-Ban Player", "Click to un-ban player!", true, false, "commonmenu", "interaction_bgd_3")
			unbanPlayer:SetMenuWidthOffset(menuWidth)
			
			local reason = ""
			local identifier = ""
			for i,theBanned in ipairs(banlist) do
				local theName = banlist[i].name
				local theReason = banlist[i].reason
				local theLicense = banlist[i].license

				local theUnbanPlayer = _menuPool:AddSubMenu(unbanPlayer, theName, "Reason: ~r~"..theReason.."\n~w~License: ~r~"..string.gsub(theLicense, "license:", ""), true, false, "commonmenu", "interaction_bgd_3")
				theUnbanPlayer:SetMenuWidthOffset(menuWidth)

				local thisItem = NativeUI.CreateItem("Yes", "~r~~h~Are you sure you wan't to unban this player?")
				theUnbanPlayer:AddItem(thisItem)
				thisItem.Activated = function(ParentMenu,SelectedItem)
					TriggerServerEvent("PURGEadmin:unbanPlayer", banlist[i], theName)
					TriggerServerEvent("PURGEadmin:requestBanlist")
					_menuPool:CloseAllMenus()
					Citizen.Wait(800)
					GenerateMenu()
					mainMenu:Visible(true)
				end

				local thisItem = NativeUI.CreateItem("No", "~g~~h~Go back to safety?")
				theUnbanPlayer:AddItem(thisItem)
				thisItem.Activated = function(ParentMenu,SelectedItem)
					_menuPool:CloseAllMenus()
					Citizen.Wait(800)
					GenerateMenu()
					unbanPlayer:Visible(true)
				end
			end
		else
			local thisItem = NativeUI.CreateLockedItem("Unban Player","")
			servermanagement:AddItem(thisItem)
		end	

		addbanPlayer = _menuPool:AddSubMenu(servermanagement, "Add-Ban", "Ban those who got away!", true, false, "commonmenu", "interaction_bgd_3")
		addbanPlayer:SetMenuWidthOffset(menuWidth)
		
		local thisItem = NativeUI.CreateItem("Name", "Add name to player.")
		addbanName = "Unknown"
		thisItem:RightLabel(addbanName)
		addbanPlayer:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			AddTextEntry("FMMC_KEY_TIP8", "Name [32 Char Max]")
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "Uknown", "", "", "", 32)
			
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				Citizen.Wait(1)
			end
			
			local result = GetOnscreenKeyboardResult()
			
			if result and result ~= "" then
				addbanName = result
			else
				addbanName = "Unknown"
			end
			thisItem:RightLabel(addbanName)
			result = ""
		end

		local sl = {"Mic Spam", "Hate Speech", "Custom"}
		addbanReason = "Mic Spam"
		local thisItem = NativeUI.CreateListItem("Ban Reason", sl, 1,"Choose the reason to ban, select custom for a custom reason!")
		addbanPlayer:AddItem(thisItem)

		addbanPlayer.OnListChange = function(sender, item, index)
			if item == thisItem then
				i = item:IndexToItem(index)
				if i ~= "Custom" then
					addbanReason = i
				else
					addbanReason = "None specified."
				end
			end
		end
		
		addbanPlayer.OnListSelect = function(sender, item, index)
			if item == thisItem then
				i = item:IndexToItem(index)
				if i == "Custom" then
					AddTextEntry("FMMC_KEY_TIP8", "Ban reason [128 CHAR MAX]")
					DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 128)
					
					while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
						Citizen.Wait(10)
					end
					
					local result = GetOnscreenKeyboardResult()
					
					if result and result ~= "" then
						addbanReason = result
					else
						ShowNotification("~r~ERROR ~w~: Invalid reason!")
					end
				end
			end
		end

		local thisItem = NativeUI.CreateItem("License", "Add license identifier for ban.")
		addbanLicense = ""
		addbanPlayer:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			AddTextEntry("FMMC_KEY_TIP8", "Licnese [48 Char]")
			DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "license:", "", "", "", 48)
			
			while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
				Citizen.Wait(1)
			end
			
			local result = GetOnscreenKeyboardResult()
			
			if result and result ~= "" and #result == 48 then
				addbanLicense = result
			else
				ShowNotification("~r~ERROR ~w~: Invalid License!")
			end
			result = ""
		end

		local thisItem = NativeUI.CreateListItem("Ban Length",bt, 1,"Until when should the this player be banned?" )
		addbanPlayer:AddItem(thisItem)
		local addbanTime = 1
		thisItem.OnListChanged = function(sender,item,index)
			addbanTime = index
		end

		local thisItem = NativeUI.CreateItem("Confirm Ban","~r~~h~NOTE:~h~~w~ Pressing Confirm will ban this player with the specified settings.")
		addbanPlayer:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			if #addbanLicense ~= 48 then
				ShowNotification("~r~ERROR ~w~: Invalid license, the ban will not be added.")
			else
				TriggerServerEvent("PURGEadmin:addBan", addbanName, addbanReason, addbanLicense, banLength[addbanTime].time)
				addbanTime = 1
				addbanReason = ""
				addbanLicense = ""
				addbanName = ""
				_menuPool:CloseAllMenus()
				Citizen.Wait(800)
				GenerateMenu()
				addbanPlayer:Visible(true)
			end
		end	
	end

	settingsMenu = _menuPool:AddSubMenu(mainMenu, "Menu Settings","",true)
	settingsMenu:SetMenuWidthOffset(menuWidth)	

	local keybindMenu = _menuPool:AddSubMenu(settingsMenu,"Keybinds","Edit menu based keybinds!",true)
	keybindMenu:SetMenuWidthOffset(menuWidth)

	local menuKeyTable = {
		{label = "F1", key = 288},
		{label = "F5", key = 166},
		{label = "F6", key = 167},
		{label = "F7", key = 168},
		{label = "F9", key = 56},
		{label = "F10", key = 57},
	}

	local mt = {}
	for k, v in ipairs(menuKeyTable) do
		table.insert(mt, v.label)
	end

	local thisItem = NativeUI.CreateListItem("Menu Key", mt, 1,"Change your menu opening key.")
	keybindMenu:AddItem(thisItem)
	keybindMenu.OnListSelect = function(sender, item, index)
		if item == thisItem then
			menuKey = menuKeyTable[index].key
		end
	end

	if GetPermLevel(4) then
		local thisItem = NativeUI.CreateItem("Refresh Banlist", "This Refreshes the Banlist in the 'Unban Player' Menu.\nRequires Reopening.")
		settingsMenu:AddItem(thisItem)
		thisItem.Activated = function(ParentMenu,SelectedItem)
			TriggerServerEvent("PURGEadmin:requestBanlist")
			_menuPool:CloseAllMenus()
			Citizen.Wait(1000)
			GenerateMenu()
			playermanagement:Visible(true)
		end
	else
		local thisItem = NativeUI.CreateLockedItem("Refresh Banlist","")
		settingsMenu:AddItem(thisItem)
	end
	
	_menuPool:RefreshIndex()
end


Citizen.CreateThread(function() -- [[No-clip]]
	while true do

		Citizen.Wait(1)

		noclipControls(noclipActive)

		if noclipActive then
            yoff = 0.0
			zoff = 0.0
			
			if IsDisabledControlPressed(0, 32) then
                yoff = 0.5
			end
			
            if IsDisabledControlPressed(0, 33) then
                yoff = -0.5
			end
			
            if IsDisabledControlPressed(0, 34) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())+3.0)
			end
			
            if IsDisabledControlPressed(0, 35) then
                SetEntityHeading(PlayerPedId(), GetEntityHeading(PlayerPedId())-3.0)
			end
			
            if IsDisabledControlPressed(0, 44) then
                zoff = 0.21
			end
			
            if IsDisabledControlPressed(0, 20) then
                zoff = -0.21
			end
			
            local newPos = GetOffsetFromEntityInWorldCoords(ped, 0.0, yoff * (currentSpeed + 0.3), zoff * (currentSpeed + 0.3))
            local heading = GetEntityHeading(ped)
            SetEntityVelocity(ped, 0.0, 0.0, 0.0)
            SetEntityRotation(ped, 0.0, 0.0, 0.0, 0, false)
            SetEntityHeading(ped, heading)
            SetEntityCollision(ped, false, false)
            SetEntityCoordsNoOffset(ped, newPos.x, newPos.y, newPos.z, noclipActive, noclipActive, noclipActive)
		end

		if announcestring then
			scaleform = initializeScaleform("mp_big_message_freemode")
			DrawScaleformMovie(scaleform, 0.5, 0.2, 0.5, 0.5, 255, 255, 255, 255, 0)
		end
	end
end)