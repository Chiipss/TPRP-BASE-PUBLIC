OnCmd = {}

-- Registers a command. If a command function returns true, the event is not cancelled and other resources
-- have the chance to do something with it.
function OnCmd:register( cmd, func )
	if self[cmd] ~= nil then
		return false
	end

	self[cmd] = func
	return true
end

function OnCmd:call( cmd, source, args )
	if self[cmd] == nil then
		for k,v in pairs(self) do
			if string.lower( k ) == string.lower( cmd ) then
				cmd = k
				break
			end
		end

		if self[cmd] == nil then
			return false
		end
	end

	return not self[cmd]( source, args )
end

function OnCmd:feedback( source, name, colour, message )
	if source ~= -1 then
		if name ~= "" then
			TriggerClientEvent( "chatMessage", source, name, colour, message )
		else
			TriggerClientEvent( "MSQNotify", source, message )
		end
	else
		print( tostring( name ) .. ": " .. message )
	end
end

AddEventHandler( "chatMessage", function( source, name, message )
    if string.len( message ) > 1 then
        local msg = stringsplit(message)

        if string.len(msg[1]) > 1 and string.sub(msg[1], 1, 1) == "/" then
            local args = {}

            for p in string.gmatch( message, "%S+" ) do
                table.insert( args, p )
            end

            local cmd = string.sub( table.remove( args, 1 ), 2 )

            print(string.format("Command '%s' entered..", cmd))

            -- BUG: OnCmd:call( cmd, source, args ) gives "no coercion operator is defined" error on 'source' parameter
            if OnCmd.call( OnCmd, cmd, source, args ) then
    --[[ prints in chat box instead of console // aspire
				 print( string.format( "Command '%s' found, called by '%s'.", cmd, name ) )
	--]]
                CancelEvent()
            end
        end
    end
end)

AddEventHandler( "rconCommand", function( cmd, args )
	cmd = cmd:lower()

	if OnCmd:call( cmd, -1, args ) == true then
		print( string.format( "Command '%s' found, called by 'RCON'.", cmd ) )
		CancelEvent()
	end
end)

function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
