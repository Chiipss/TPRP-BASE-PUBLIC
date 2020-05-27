---------------------------------------
-- Ace Perm Whitelist, Made by FAXES --
---------------------------------------
-- Config
nonWL = "You are not whitelisted on this server, please contact TPRP via the official channel." -- Displayed when a player is not allowed into the server

-- Main Code
AddEventHandler('onResourceStart', function()
	Citizen.Wait(150)
    --SetGameType(gametypemsg) We probably don't want to set the game type.
end)

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local s = source
    deferrals.defer()
    Citizen.Wait(100)
    deferrals.update("Checking Permissions")
    Wait(1000)
    local allowed = false
    if IsPlayerAceAllowed(s, "fax-whitelist") then
        Citizen.Wait(100)
        deferrals.done()
        allowed = true
    else
        Citizen.Wait(100)
        deferrals.done(nonWL)
    end
end)