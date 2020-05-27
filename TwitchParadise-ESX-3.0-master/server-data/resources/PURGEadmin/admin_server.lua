-- Muted Players Table
MutedPlayers = {} 

-- Bad Boy Table
banlist = {}

Loghook = "https://discordapp.com/api/webhooks/612737119344918551/mo0FhwUgr9BRCOTziUl-AvZOYKIyZUsNlfJIRQdxx4bdeJz4MyiLrswsHkDV-4pUa0kb"

Citizen.CreateThread(function()

	RegisterServerEvent("PURGEadmin:amiadmin")
	AddEventHandler("PURGEadmin:amiadmin", function()

		local src = source
		local content = LoadResourceFile("PURGEadmin", "admins.json")
		local adminlist = json.decode(content)
		if not adminlist then
			print("-------------------^8!FATAL ERROR!^7------------------\n")
			print("PURGEadmin: Failed to load Admin List!\n")
			print("PURGEadmin: Admin permission retrieval failed!!\n")
			print("-------------------^8!FATAL ERROR!^7------------------\n")
		end

		local playerLicense = getId(src, "license")

		for i, theAdmin in pairs(adminlist) do
			if theAdmin.license == playerLicense then
				TriggerClientEvent("PURGEadmin:adminresponse", src, theAdmin.permission)
				return
			end
		end

		TriggerClientEvent("PURGEadmin:adminresponse", src, 0)
	end)
	
	RegisterServerEvent("PURGEadmin:kickPlayer")
	AddEventHandler("PURGEadmin:kickPlayer", function(playerId,reason)
		local src = source
		if playerId ~= nil then
			if not DoesPlayerHavePermission(playerId, 6) then -- [[Owners cannot be kicked or banned.]]
				Log("⛔ ``"..getName(playerId).."`` has been kicked!\n⛔ Kicked by : ``"..getName(src).."``\n⛔ Reason: ``"..reason.."``", true)
				DropPlayer(playerId, "⛔ You have been kicked from PURGE [BR]. \n ⛔ Reason: " .. reason .." \n ⛔ Kicked By: " ..getName(src))
			else
				TriggerClientEvent("PURGEadmin:ClientStaffNotification", src, "Good Try!")
			end
		end
	end)
	
	RegisterServerEvent("PURGEadmin:requestSpectate")
	AddEventHandler("PURGEadmin:requestSpectate", function(playerId)
		local src = source
		TriggerClientEvent("PURGEadmin:requestSpectate", src, playerId)
	end)
	
	RegisterServerEvent("PURGEadmin:SetGameType")
	AddEventHandler("PURGEadmin:SetGameType", function(text)
		SetGameType(text)
	end)
	
	RegisterServerEvent("PURGEadmin:SetMapName")
	AddEventHandler("PURGEadmin:SetMapName", function(text)
		SetMapName(text)
	end)
	
	RegisterServerEvent("PURGEadmin:StartResource")
	AddEventHandler("PURGEadmin:StartResource", function(text)
		StartResource(text)
	end)
	
	RegisterServerEvent("PURGEadmin:StopResource")
	AddEventHandler("PURGEadmin:StopResource", function(text)
		StopResource(text)
	end)
	
	
	RegisterServerEvent("PURGEadmin:banPlayer")
	AddEventHandler("PURGEadmin:banPlayer", function(playerId, reason, expires, username)
		local src = source
		if playerId ~= nil then
			if not DoesPlayerHavePermission(playerId, 6) then
				local playerName = getName(playerId)
				local playerLicense = getId(playerId, "license")
				local playerExpire2 = getDate(expires)
			
				local ban = {name = playerName, license = playerLicense, reason = reason, expire = os.time()+expires, expire2 = playerExpire2, onScene = "true" }
				updateBlacklist(ban)

				Log("⛔ ``"..playerName.."`` has been banned!\n⛔ Banned By: ``"..getName(src).."``\n⛔ Reason: ``"..reason.."``\n⛔ License: ``"..playerLicense.."``\n⛔ Ban Expires: ``"..playerExpire2.."``", true)
				DropPlayer(playerId, "⛔ You have been banned! \n⛔ Reason: " .. reason .." \n⛔ Banned By: " ..getName(src).. " \n⛔ Ban Expires: "..playerExpire2)
			else
				TriggerClientEvent("PURGEadmin:ClientStaffNotification", src, "Good Try!")
			end
		end
	end)

	RegisterServerEvent("PURGEadmin:addBan")
	AddEventHandler("PURGEadmin:addBan", function(playerName, banReason , playerLicense, expires)
		local src = source
		local playerExpire2 = getDate(expires)
		
		local ban = {name = playerName, license = playerLicense, reason = banReason, expire = os.time()+expires, expire2 = playerExpire2, onScene = "false" }
		updateBlacklist(ban)

		Log("⛔ A ban has just been added!\n⛔ Added By: ``"..getName(src).."``\n⛔ Name: ``"..playerName.."``\n⛔ Reason: ``"..banReason.."``\n⛔ License: ``"..playerLicense.."``\n⛔ Ban Expires: ``"..playerExpire2.."``", true)
	end)
	
	RegisterServerEvent("PURGEadmin:requestBanlist")
	AddEventHandler("PURGEadmin:requestBanlist", function()
		local src = source
		TriggerClientEvent("PURGEadmin:fillBanlist", src, blacklist)
	end)
	
	
	RegisterServerEvent("PURGEadmin:TeleportPlayerToCoords")
	AddEventHandler("PURGEadmin:TeleportPlayerToCoords", function(clients, px, py, pz, heading)
		TriggerClientEvent("PURGEadmin:TeleportRequest", clients, px, py, pz, heading)
	end)
	
	RegisterServerEvent("PURGEadmin:SlapPlayer")
	AddEventHandler("PURGEadmin:SlapPlayer", function(playerId,slapAmount)
		local src = source
		Log("⛔ ``"..getName(playerId).."`` has been slapped!".."\n⛔ Slapped By: ``"..getName(src).."``\n⛔ HP: ``"..slapAmount.."``", true)
		TriggerClientEvent("PURGEadmin:SlapPlayer", playerId, slapAmount)
	end)
	
	RegisterServerEvent("PURGEadmin:FreezePlayer")
	AddEventHandler("PURGEadmin:FreezePlayer", function(playerId,toggle)
		local src = source
		if toggle then
			Log("⛔ ``"..getName(playerId).."`` has been frozen!\n⛔ Frozen By: ``"..getName(src).."``", true)
		else
			Log("⛔ ``"..getName(playerId).."`` has been un-frozen!\n⛔ Un-Frozen By: ``"..getName(src).."``", true)
		end
		TriggerClientEvent("PURGEadmin:FreezePlayer", playerId, toggle)
	end)
	
	RegisterServerEvent("PURGEadmin:unbanPlayer")
	AddEventHandler("PURGEadmin:unbanPlayer", function(playerInfo, playerName)
		local src = source
		updateBlacklist(playerInfo, true)
		Log("⛔ ``"..playerName.."`` has been un-banned!\n⛔ Un-Banned By: ``"..getName(src).."``\n⛔ License: ``"..string.gsub(playerInfo.license, "license:", "").."``", true)
	end)

	RegisterServerEvent("PURGEadmin:mutePlayer")
	AddEventHandler("PURGEadmin:mutePlayer", function(playerId, playerName)
		local src = source
		if not MutedPlayers[playerId] then 
			MutedPlayers[playerId] = true
			TriggerClientEvent("chat:addMessage", src, { args = { "[^3Administration^7]", playerName.." has been muted!" } })
			Log("⛔ ``"..playerName.."`` has been muted!\n⛔ Muted By: ``"..getName(src).."``", true)
		else 
			MutedPlayers[playerId] = false
			TriggerClientEvent("chat:addMessage", src, { args = { "[^3Administration^7]", playerName.." has been un-muted!" } })
			Log("⛔ ``"..playerName.."`` has been un-muted!\n⛔ Un-Muted By: ``"..getName(src).."``", true)
		end
	end)

	RegisterServerEvent("PURGEadmin:UpdateAdmin")
	AddEventHandler("PURGEadmin:UpdateAdmin", function(playerId, permissionLevel, permissionName)
		local src = source

		local playerLicense = getId(playerId, "license")
		local playerName = getName(playerId)

		print("Player License == "..playerLicense)

		updateAdminList({name = playerName, license = playerLicense, permission = permissionLevel }, playerId)

		Log("⛔ Permission update for ``"..playerName.."``\n⛔ Updated By: ``"..getName(src).."``\n⛔ Permission: ``"..permissionName.." ["..permissionLevel.."]``", true)
	end)
	
	RegisterServerEvent("PURGEadmin:ServerAnnouncement")
	AddEventHandler("PURGEadmin:ServerAnnouncement", function(announcement)
		local src = source
		TriggerClientEvent("PURGEadmin:ClientAnnouncement", -1, announcement)
		Log("⛔ A server announcement has been made!\n⛔ Made By: ``"..getName(src).."``\n⛔ Announcement Message: ``"..announcement.."``", true)
	end)

	RegisterServerEvent("PURGEadmin:StaffNotification")
	AddEventHandler("PURGEadmin:StaffNotification", function(playerId, payload)
		local src = source
		TriggerClientEvent("PURGEadmin:ClientStaffNotification", playerId, payload)
		Log("⛔ ``"..getName(playerId).."`` has received a staff notification!\n⛔ Sent By: ``"..getName(src).."``\n⛔ Saying: ``"..payload.."``", true)
	end)

	RegisterServerEvent("PURGEadmin:screenshotPlayer")
	AddEventHandler("PURGEadmin:screenshotPlayer", function(playerId)
		local src = source
		TriggerClientEvent("PURGEadmin:screenshotClient", playerId, src)
	end)

	RegisterServerEvent("PURGEadmin:screenshotTodiscord")
	AddEventHandler("PURGEadmin:screenshotTodiscord", function(taker, success, size, payload)
		local src = source 
		if not success then
			TriggerClientEvent("PURGEadmin:ClientStaffNotification", taker, "There was an error uploading the screenshot to the web!")
			return
		elseif size == 12065 then
			TriggerClientEvent("PURGEadmin:ClientStaffNotification", taker, "The player did not have FiveM in focus, screenshot failed!")
			return
		else
			local scembed = {
				{
					["author"] = {
						["name"] = "A screenshot has been taken!",
					},
					["color"] = 3026483,
					["description"] = "----------------------------------",
					["footer"] = {
						["text"] = "PilotSpy | "..getDate()
					},
					["image"] = {
						["url"] = payload
					},
					["fields"] = {
						{
							["name"] = "Taken By:",
							["value"] = getName(taker)
						},
						{
							["name"] = "Taken Of:",
							["value"] = getName(src).."\n----------------------------------"
						}
					}
				}
			} 
			PerformHttpRequest(Loghook, function(err, text, headers) end, "POST", json.encode({embeds = scembed}), { ["Content-Type"] = "application/json" })
		end
	end)

	RegisterServerEvent("PURGEadmin:SaveCoords")
	AddEventHandler("PURGEadmin:SaveCoords", function(coords)
		Log(coords, false)
	end)

	AddEventHandler("playerConnecting", function(playerName, setKickReason)
		local src = source
		local numIds = GetPlayerIdentifiers(src)
		for bi,blacklisted in ipairs(blacklist) do
			for i,theId in ipairs(numIds) do
				if blacklisted.license == theId then
					setKickReason("⛔ You are banned from PURGE [BR] \n ⛔ Reason: " .. blacklist[bi].reason .." \n ⛔ Ban Expires: " ..blacklist[bi].expire2)
					CancelEvent()
					return
				end
			end
		end
	end)

	AddEventHandler("chatMessage", function(source, author, message)
		local src = source
		local msg = message
		if MutedPlayers[src] then
			CancelEvent()
			TriggerClientEvent("chat:addMessage", src, { args = { "[^8SERVER^7]", "You are muted!" } })
		end
	end)

	function DoesPlayerHavePermission(user, permission)

		local content = LoadResourceFile("PURGEadmin", "admins.json")
		local checkadminslist = json.decode(content)
		if not checkadminslist then
			print("-------------------^8!FATAL ERROR!^7------------------\n")
			print("PURGEadmin: Failed to load Admin List!\n")
			print("PURGEadmin: Unable to check player permission!\n")
			print("-------------------^8!FATAL ERROR!^7------------------\n")
			return
		end

		local playerLicense = getId(user, "license")

		for i,theAdmin in ipairs(checkadminslist) do
			if theAdmin.license == playerLicense then
				if theAdmin.permission == permission then
					return true
				end
			end
		end

		return false
	end

	blacklist = {} -- [[Global banlist table to sync with admins on the client side.]]
	
	function updateBlacklist(data, remove)



		local content = LoadResourceFile("PURGEadmin", "banlist.json")
		blacklist = json.decode(content)
		if not blacklist then
			print("-------------------^8!FATAL ERROR!^7------------------\n")
			print("PURGEadmin: Failed to load Banlist!\n")
			print("PURGEadmin: Please check this error soon, Bans *will not* work!\n")
			print("-------------------^8!FATAL ERROR!^7------------------\n")
			return
		end
		
		if data and not remove then
			table.insert(blacklist, data)
		elseif not data then
			for i,theBan in ipairs(blacklist) do
				if theBan.expire < os.time() then
					table.remove(blacklist,i)
				elseif theBan.expire == 1924300800 then
					blacklist[i].expire = 10444633200
				end
			end
		elseif data and remove then
			for i,theBan in ipairs(blacklist) do
				if theBan.license == data.license then
					table.remove(blacklist,i)
				end
			end
		end
		SaveResourceFile("PURGEadmin", "banlist.json", json.encode(blacklist, {indent = true}), -1)
	end

	function updateAdminList(data, user)

		local content = LoadResourceFile("PURGEadmin", "admins.json")
		local adminlist = json.decode(content)
		if not adminlist then
			print("-------------------^8!FATAL ERROR!^7------------------\n")
			print("PURGEadmin: Failed to load Admin List!\n")
			print("PURGEadmin: Admin update failed!\n")
			print("-------------------^8!FATAL ERROR!^7------------------\n")
			return
		end

		for i,theAdmin in ipairs(adminlist) do
			if theAdmin.license == data.license then
				theAdmin.permission = data.permission
				TriggerClientEvent("PURGEadmin:adminresponse", user, permission)
				SaveResourceFile("PURGEadmin", "admins.json", json.encode(adminlist, {indent = true}), -1) -- [[In-effecient fix but it works for now.]]
				return
			end
		end

		table.insert(adminlist, data)
		TriggerClientEvent("PURGEadmin:adminresponse", user, data.permission)
		SaveResourceFile("PURGEadmin", "admins.json", json.encode(adminlist, {indent = true}), -1)
	end
	
	function IsIdentifierBanned(license) -- [[Not used atm, maybe later at some point.]]
		local identifierfound = false
		for i, theBan in ipairs(blacklist) do
			if license == theBan.license then
				identifierfound = true
			end
		end
		return identifierfound
	end

	---------------------------------- USEFUL

	function getName(player)
		if (player == 0 or player == "") then
			return "Console"
		elseif GetPlayerName(player) then
			return GetPlayerName(player)
		else
			return "Unknown - " .. player
		end
	end
	
	function Log(message, logging)
		if logging then
			PerformHttpRequest(Loghook, function(err, text, headers) end, "POST", json.encode({content = message}), { ["Content-Type"] = "application/json" })
			OldLogFile = io.open("resources/"..GetCurrentResourceName().."/dump/log.txt", "r")
			LogFileString = OldLogFile:read("*a")
			ServerLogFileString = LogFileString
			OldLogFile:close()


			LogFile = io.open("resources/"..GetCurrentResourceName().."/dump/log.txt", "w")
			LogFile:write(ServerLogFileString.."\n["..getDate().."] "..message)
			LogFile:close()
		else
			OldCoordFile = io.open("resources/"..GetCurrentResourceName().."/dump/coords.txt", "r")
			OldCoordFileString = OldCoordFile:read("*a")
			ServerCoordFileString = OldCoordFileString
			OldCoordFile:close()


			CoordFile = io.open("resources/"..GetCurrentResourceName().."/dump/coords.txt", "w")
			CoordFile:write(ServerCoordFileString.."\n{ x = "..math.round(message.x, 3)..", y = "..math.round(message.y, 3)..", z = "..math.round(message.z, 3).." },")
			CoordFile:close()
		end
	end
	
	function getId(user)
		local numIds = GetPlayerIdentifiers(user)

		for i, theId in ipairs(numIds) do 
			if string.find(theId, "license:") then
				return theId
			end
		end
	end

	function getDate(int) -- [[Used for UI date keeping.]]
		if int then
			return os.date('%d/%m/%Y %H:%M:%S GMT', (os.time()+int))
		else
			return os.date('%d/%m/%Y %H:%M:%S GMT', os.time())
		end
	end

	function loopUpdateBlacklist()
		updateBlacklist()
		SetTimeout(100000, loopUpdateBlacklist)
	end

	function math.round(num, numDecimalPlaces)
		return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
	end
	
	loopUpdateBlacklist()
end)

