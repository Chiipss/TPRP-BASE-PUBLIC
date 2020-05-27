local rGzHelpGUI               = false

RegisterNetEvent('rgz_help:start')
AddEventHandler('rgz_help:start', function()
	if not rGzHelpGUI then
		SetNuiFocus(true, true)
		SendNUIMessage({type = 'open'})
		rGzHelpGUI = true
	end
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'close'})
	rGzHelpGUI = false
end)
