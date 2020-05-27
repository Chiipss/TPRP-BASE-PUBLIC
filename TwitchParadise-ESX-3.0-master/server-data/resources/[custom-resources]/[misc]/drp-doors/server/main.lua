ESX				= nil
local DoorInfo	= {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('tprp-doorlock:updateState')
AddEventHandler('tprp-doorlock:updateState', function(doorID, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(doorID) ~= 'number' then
		print(('tprp-doorlock: %s didn\'t send a number!'):format(xPlayer.identifier))
		return
	end

	if not IsAuthorized(xPlayer.job.name, Config.DoorList[doorID]) then
		print(('tprp-doorlock: %s attempted to open a locked door!'):format(xPlayer.identifier))
		return
	end

	-- make each door a table, and clean it when toggled
	DoorInfo[doorID] = {}

	-- assign information
	DoorInfo[doorID].state = state
	DoorInfo[doorID].doorID = doorID

	TriggerClientEvent('tprp-doorlock:setState', -1, doorID, state)
end)

ESX.RegisterServerCallback('tprp-doorlock:getDoorInfo', function(source, cb)
	cb(DoorInfo, #DoorInfo)
end)

function IsAuthorized(jobName, doorID)
	for i=1, #doorID.authorizedJobs, 1 do
		if doorID.authorizedJobs[i] == jobName then
			return true
		end
	end

	return false
end