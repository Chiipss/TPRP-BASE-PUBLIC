-- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA!
-- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA!
-- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA! -- JUST EDIT THE CONFIG.LUA!

-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!
-- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE! -- DO NOT EDIT THESE!

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

-- Error Check
if DiscordWebhookSystemInfos == nil and DiscordWebhookKillinglogs == nil and DiscordWebhookChat == nil then
	local Content = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
	Content = load(Content)
	Content()
end
if DiscordWebhookSystemInfos == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "System Infos" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "System Infos" webhook non-existing!\n\n')
		end
	end)
end
if DiscordWebhookKillinglogs == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Killing Log" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookKillinglogs, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Killing Log" webhook non-existing!\n\n')
		end
	end)
end
if DiscordWebhookChat == 'WEBHOOK_LINK_HERE' then
	print('\n\nERROR\n' .. GetCurrentResourceName() .. ': Please add your "Chat" webhook\n\n')
else
	PerformHttpRequest(DiscordWebhookChat, function(Error, Content, Head)
		if Content == '{"code": 50027, "message": "Invalid Webhook Token"}' then
			print('\n\nERROR\n' .. GetCurrentResourceName() .. ': "Chat" webhook non-existing!\n\n')
		end
	end)
end
	
-- System Infos
PerformHttpRequest(DiscordWebhookSystemInfos, function(Error, Content, Head) end, 'POST', json.encode({username = SystemName, content = '**_TPRP_ server webhook** ***started***'}), { ['Content-Type'] = 'application/json' })

AddEventHandler('playerConnecting', function()
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```css\n' .. GetPlayerName(source) .. ' connecting\n```', SystemAvatar, false)
	
	local printString = ""
	identifiers = GetPlayerIdentifiers(source)
	for _, id in ipairs(identifiers) do
		-- CHECK FOR STEAM RUNNING
		if string.match(id, "steam:") then
			steamId = id
			--steamId = string.gsub(id, "steam:", " steam:")
			printString = (printString .. steamId)
			--print("Found steam id: "..steamId)
		end
		-- CHECK FOR DISCORD RUNNING
		if string.match(id, "discord:") then
			discordId = id
			discordId = string.gsub(id, "discord:", " discord:")
			printString = (printString .. discordId)
			--print("Found discord id: "..discordId)
		end
		-- CHECK FOR FIVEM LICENCE
		if string.match(id, "licence:") then
			licenceId = id
			licenceId = string.gsub(id, "licence:", " licence:")
			printString = (printString .. licenceId)
			--print("Found licence id: "..licenceId)
		end
		-- CHECK FOR IP
		if string.match(id, "ip:") then
			ipId = id
			ipId = string.gsub(id, "ip:", " IP:")
			printString = (printString .. ipId)
			--print("Found IP: "..ipId)
		end
	end
	
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```css\n' .. GetPlayerName(source) .. ": IDs - ".. printString .. '\n```', SystemAvatar, false)
end)

AddEventHandler('playerDropped', function(Reason)
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```fix\n' .. GetPlayerName(source) .. ' left (' .. Reason .. ')\n```', SystemAvatar, false)
end)

-- On Character Load
AddEventHandler('esx:playerLoaded', function(source)
	Citizen.Wait(100)
	local playerData = ESX.GetPlayerFromId(source)
	local firstname
	local lastname
    if playerData ~= nil then
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
            ['@identifier'] = playerData.identifier
        })
        firstname = result[1].firstname
		lastname  = result[1].lastname
		if firstname == "" or firstname == nil or not firstname then
			TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```css\n' .. GetPlayerName(source) .. ': New character, waiting for info.\n```', SystemAvatar, false)
			Citizen.Wait(10000)
			newPlayer(source)
			else
			TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```css\n' .. GetPlayerName(source) .. ': ID [' .. source .. '] - ' .. firstname .. ' '.. lastname .. ' was loaded.\n```', SystemAvatar, false)
		end
	end
end)

function newPlayer(source)
	Citizen.Wait(100)
	local playerData = ESX.GetPlayerFromId(source)
	local firstname
	local lastname
    if playerData ~= nil then
		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
            ['@identifier'] = playerData.identifier
        })
        firstname = result[1].firstname
		lastname  = result[1].lastname
		if firstname == "" or firstname == nil or not firstname then
			Citizen.Wait(10000)
			newPlayer(source)
		else
			TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookSystemInfos, SystemName, '```css\n' .. GetPlayerName(source) .. ': ID [' .. source .. '] - ' .. firstname .. ' '.. lastname .. ' was created.\n```', SystemAvatar, false)
		end
	end
end

RegisterConsoleListener(function(channel, message)
    if string.find(message, "SCRIPT ERROR") then
        if string.find(message, "motels.HomeInv") then
            -- Nowt
        else
            TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookScriptError, SystemName, '```diff\n- ' .. message .. '```', SystemAvatar, false)
        end
    end
end)

-- Killing Log
RegisterServerEvent('tp-dbot:playerDied')
AddEventHandler('tp-dbot:playerDied', function(Message, Weapon)
	local date = os.date('*t')
	
	if date.day < 10 then date.day = '0' .. tostring(date.day) end
	if date.month < 10 then date.month = '0' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '0' .. tostring(date.hour) end
	if date.min < 10 then date.min = '0' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '0' .. tostring(date.sec) end
	if Weapon then
		Message = Message .. ' [' .. Weapon .. ']'
	end
	TriggerEvent('DiscordBot:ToDiscord', DiscordWebhookKillinglogs, SystemName, Message .. ' `' .. date.day .. '.' .. date.month .. '.' .. date.year .. ' - ' .. date.hour .. ':' .. date.min .. ':' .. date.sec .. '`', SystemAvatar, false)
end)

-- Chat
AddEventHandler('chatMessage', function(Source, Name, Message)
	local Webhook = DiscordWebhookChat; TTS = false

	--Removing Color Codes (^0, ^1, ^2 etc.) from the name and the message
	for i = 0, 9 do
		Message = Message:gsub('%^' .. i, '')
		Name = Name:gsub('%^' .. i, '')
	end
	
	--Splitting the message in multiple strings
	MessageSplitted = stringsplit(Message, ' ')
	
	--Checking if the message contains a blacklisted command
	if not IsCommand(MessageSplitted, 'Blacklisted') then
		--Checking if the message contains a command which has his own webhook
		if IsCommand(MessageSplitted, 'HavingOwnWebhook') then
			Webhook = GetOwnWebhook(MessageSplitted)
		end
		
		--Checking if the message contains a special command
		if IsCommand(MessageSplitted, 'Special') then
			MessageSplitted = ReplaceSpecialCommand(MessageSplitted)
		end
		
		---Checking if the message contains a command which belongs into a tts channel
		if IsCommand(MessageSplitted, 'TTS') then
			TTS = true
		end
		
		--Combining the message to one string again
		Message = ''
		
		for Key, Value in ipairs(MessageSplitted) do
			Message = Message .. Value .. ' '
		end
		
		--Adding the username if needed
		Message = Message:gsub('USERNAME_NEEDED_HERE', GetPlayerName(Source))
		
		--Adding the userid if needed
		Message = Message:gsub('USERID_NEEDED_HERE', Source)
		
		-- Shortens the Name, if needed
		if Name:len() > 23 then
			Name = Name:sub(1, 23)
		end

		--Getting the steam avatar if available
		local AvatarURL = UserAvatar
		if GetIDFromSource('steam', Source) then
			PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
				local SteamProfileSplitted = stringsplit(Content, '\n')
				for i, Line in ipairs(SteamProfileSplitted) do
					if Line:find('<avatarFull>') then
						AvatarURL = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
						TriggerEvent('DiscordBot:ToDiscord', Webhook, Name .. ' [ID: ' .. Source .. ']', Message, AvatarURL, false, Source, TTS) --Sending the message to discord
						break
					end
				end
			end)
		else
			--Using the default avatar if no steam avatar is available
			TriggerEvent('DiscordBot:ToDiscord', Webhook, Name .. ' [ID: ' .. Source .. ']', Message, AvatarURL, false, Source, TTS) --Sending the message to discord
		end
	end
end)

--Event to actually send Messages to Discord
RegisterServerEvent('DiscordBot:ToDiscord')
AddEventHandler('DiscordBot:ToDiscord', function(WebHook, Name, Message, Image, External, Source, TTS)
	if Message == nil or Message == '' then
		return nil
	end
	if TTS == nil or TTS == '' then
		TTS = false
	end
	if External then
		if WebHook:lower() == 'chat' then
			WebHook = DiscordWebhookChat
		elseif WebHook:lower() == 'system' then
			WebHook = DiscordWebhookSystemInfos
		elseif WebHook:lower() == 'kill' then
			WebHook = DiscordWebhookKillinglogs
		elseif not Webhook:find('discordapp.com/api/webhooks') then
			print('ToDiscord event called without a specified webhook!')
			return nil
		end
		
		if Image:lower() == 'steam' then
			Image = UserAvatar
			if GetIDFromSource('steam', Source) then
				PerformHttpRequest('http://steamcommunity.com/profiles/' .. tonumber(GetIDFromSource('steam', Source), 16) .. '/?xml=1', function(Error, Content, Head)
					local SteamProfileSplitted = stringsplit(Content, '\n')
					for i, Line in ipairs(SteamProfileSplitted) do
						if Line:find('<avatarFull>') then
							Image = Line:gsub('	<avatarFull><!%[CDATA%[', ''):gsub(']]></avatarFull>', '')
							return PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
						end
					end
				end)
			end
		elseif Image:lower() == 'user' then
			Image = UserAvatar
		else
			Image = SystemAvatar
		end
	end
	PerformHttpRequest(WebHook, function(Error, Content, Head) end, 'POST', json.encode({username = Name, content = Message, avatar_url = Image, tts = TTS}), {['Content-Type'] = 'application/json'})
end)

-- Functions
function IsCommand(String, Type)
	if Type == 'Blacklisted' then
		for i, BlacklistedCommand in ipairs(BlacklistedCommands) do
			if String[1]:lower() == BlacklistedCommand:lower() then
				return true
			end
		end
	elseif Type == 'Special' then
		for i, SpecialCommand in ipairs(SpecialCommands) do
			if String[1]:lower() == SpecialCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'HavingOwnWebhook' then
		for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
			if String[1]:lower() == OwnWebhookCommand[1]:lower() then
				return true
			end
		end
	elseif Type == 'TTS' then
		for i, TTSCommand in ipairs(TTSCommands) do
			if String[1]:lower() == TTSCommand:lower() then
				return true
			end
		end
	end
	return false
end

function ReplaceSpecialCommand(String)
	for i, SpecialCommand in ipairs(SpecialCommands) do
		if String[1]:lower() == SpecialCommand[1]:lower() then
			String[1] = SpecialCommand[2]
		end
	end
	return String
end

function GetOwnWebhook(String)
	for i, OwnWebhookCommand in ipairs(OwnWebhookCommands) do
		if String[1]:lower() == OwnWebhookCommand[1]:lower() then
			if OwnWebhookCommand[2] == 'WEBHOOK_LINK_HERE' then
				print('Please enter a webhook link for the command: ' .. String[1])
				return DiscordWebhookChat
			else
				return OwnWebhookCommand[2]
			end
		end
	end
end

function stringsplit(input, seperator)
	if seperator == nil then
		seperator = '%s'
	end
	
	local t={} ; i=1
	
	for str in string.gmatch(input, '([^'..seperator..']+)') do
		t[i] = str
		i = i + 1
	end
	
	return t
end

function GetIDFromSource(Type, ID) --(Thanks To WolfKnight [forum.FiveM.net])
    local IDs = GetPlayerIdentifiers(ID)
    for k, CurrentID in pairs(IDs) do
        local ID = stringsplit(CurrentID, ':')
        if (ID[1]:lower() == string.lower(Type)) then
            return ID[2]:lower()
        end
    end
    return nil
end
