RegisterCommand('help', function(source, args, rawCommand) 
	TriggerClientEvent('rgz_help:start', source)
end, false)
