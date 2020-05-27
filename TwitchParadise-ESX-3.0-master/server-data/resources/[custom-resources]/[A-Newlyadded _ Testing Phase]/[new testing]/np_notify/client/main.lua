RegisterNetEvent('np_notify:client:SendAlert')
AddEventHandler('np_notify:client:SendAlert', function(data)
	SendAlert(data.type, data.text, data.code, data.location, data.length, data.style)
end)

function SendAlert(type, text, code, location, length, style)
	SendNUIMessage({
		type = type,
		text = text,
		code = code,
		location = location,
		length = length,
		style = style,
		info = data
	})
end 