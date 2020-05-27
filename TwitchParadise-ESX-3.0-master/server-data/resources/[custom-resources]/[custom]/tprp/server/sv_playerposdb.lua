RegisterServerEvent("projectEZ:savelastpos")
AddEventHandler("projectEZ:savelastpos", function(LastPosX , LastPosY , LastPosZ , LastPosH)
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.getIdentifier()
		local LastPos = "{" .. LastPosX .. ", " .. LastPosY .. ",  " .. LastPosZ .. ", " .. LastPosH .. "}"
		local executed_query = MySQL.Sync.execute("UPDATE users SET lastpos=@lastpos WHERE identifier=@username", {['@username'] = player, ['@lastpos'] = LastPos})
	end)
end)



RegisterServerEvent("projectEZ:SpawnPlayer")
AddEventHandler("projectEZ:SpawnPlayer", function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
		local player = user.getIdentifier()
		local result = MySQL.Sync.fetchAll("SELECT lastpos FROM users WHERE identifier=@username", {['@username'] = player})
		-- local result = MySQL.Sync.fetchAll('SELECT identifier, lastpos FROM users')
		if (result) then
			for k,v in ipairs(result) do
				if v.lastpos ~= "" then
					local ToSpawnPos = json.decode(v.lastpos)
					TriggerClientEvent("projectEZ:spawnlaspos", source, ToSpawnPos[1], ToSpawnPos[2], ToSpawnPos[3])
				end
			end
		end
	end)
end)