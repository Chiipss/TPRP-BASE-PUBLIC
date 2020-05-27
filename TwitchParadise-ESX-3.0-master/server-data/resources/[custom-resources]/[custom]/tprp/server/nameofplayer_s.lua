RegisterServerEvent('cp:spawnplayer')
AddEventHandler('cp:spawnplayer', function()
	local source = source
	TriggerEvent('es:getPlayerFromId', source, function(user)
	local player = user.identifier
	local executed_query = MySQL.Async.execute("UPDATE users SET `Nom` = @name WHERE identifier = @username",
							{['@name'] = GetPlayerName(source), ['@username'] = player})
	end)
 end)