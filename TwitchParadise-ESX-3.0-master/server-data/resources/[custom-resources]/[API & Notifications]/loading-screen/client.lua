
local Ran = false

AddEventHandler("onClientMapStart", function ()
	if not Ran then
		ShutdownLoadingScreenNui()
		Ran = true
	end
end)