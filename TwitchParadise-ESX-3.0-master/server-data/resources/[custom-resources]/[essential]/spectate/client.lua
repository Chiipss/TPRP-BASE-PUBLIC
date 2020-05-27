--------------------------------------------------------------------------------
--                               TWITCH PARADISE                              --
--                                  Spectate                                  --
--------------------------------------------------------------------------------

ESX = nil
local playerdata = nil
local localPlayerData = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end

  while localPlayerData == nil do
    localPlayerData = ESX.GetPlayerData()
  end
end)

-- Spectator mode flag
local spectatorMode = false
local playerToSpec = nil

function isPlayerInSpectatorMode()
  return spectatorMode
end

function getSpectatingPlayer()
  return playerToSpec
end

function setPlayerInSpectatorMode(enable)
  spectatorMode = enable
  if not enable then
    playerToSpec = nil
    spectatePlayer2(nil, 0, false)
  end
end

function spectatePlayer2(player, playerId, enable)
  targetPed = GetPlayerPed(player)

	local playerPed = PlayerPedId() -- yourself (not needed really)
	--enable = true
	--if targetPed == playerPed then enable = false end
	if(enable)then
			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
			NetworkSetInSpectatorMode(true, targetPed)
	else
			local targetx,targety,targetz = table.unpack(GetEntityCoords(targetPed, false))
			NetworkSetInSpectatorMode(false, targetPed)
	end
end


-- Spectator mode
Citizen.CreateThread(function()
  local index = 1
  local playerPed = nil
  local alivePlayers = {}

  while true do
    Wait(0)
    
    -- Spectator mode
    alivePlayers = getPlayers() -- get all players

      -- Player pressed 'F9'
    if IsControlJustReleased(1, 56) and not spectatorMode then -- **add admin check here!!**
        -- If there are players remaining and the current players isn't already in spectator
        if #alivePlayers > 0 and not spectatorMode then
          if playerToSpec == nil then
            index = 1
            -- Get the player to spectate
            playerToSpec = GetPlayerFromServerId(alivePlayers[index])
          end
          -- Triggers the spectator mode
          spectatePlayer2(alivePlayers[index], playerToSpec, true)
          --grabPlayerInfo(tonumber(alivePlayers[index]))
          spectatorMode = true
        else
          -- Disable the spectator mode
          setPlayerInSpectatorMode(false)
          spectatePlayer2(alivePlayers[index], playerToSpec, false)
        end
    else
        -- Player is in spectator and pressed "ARROW RIGHT"
        if spectatorMode and IsControlJustReleased(0, 174) then
          -- Increments the index, if next player does not exists, go back to the first
          index = index + 1
          if alivePlayers[index] == nil then
            index = 1
          end
          playerToSpec = GetPlayerFromServerId(alivePlayers[index])
          spectatePlayer2(alivePlayers[index], playerToSpec, true)
          --grabPlayerInfo(tonumber(alivePlayers[index]))
        end

        -- Player is in spectator and pressed "ARROW LEFT"
        if spectatorMode and IsControlJustReleased(0, 175) then
          -- Decrements the index, if previous player does not exists, go back to the last
          index = index - 1
          if alivePlayers[index] == nil then
            index = #alivePlayers
          end
          playerToSpec = GetPlayerFromServerId(alivePlayers[index])
          spectatePlayer2(alivePlayers[index], playerToSpec, true)
          --grabPlayerInfo(tonumber(alivePlayers[index]))
        end
        -- Stop Spectator Mode
        if spectatorMode and IsControlJustReleased(1,56) then
            spectatePlayer2(nil, 0, false)
            setPlayerInSpectatorMode(false)
        end
    end

      -- Every frame in spectator mode
    if spectatorMode then
        if alivePlayers[index] ~= nil then
            drawTxt("SPECTATOR MODE ON", 2, {255, 255, 255} , 5, 0.45,  0.2)
            --print("Player index: " .. alivePlayers[index])
            --print("Steam Name: " .. steamname)
            -- Draw Player Name
            --drawTxt(steamname, 2, {255, 255, 255} , 0.4, 5,  5)
            --drawTxt(wholename, 2, {255, 255, 255} , 0.4, 2.5,  1.5)
            --drawTxt(job, 2, {255, 255, 255} , 0.4, 3.5,  1.5)
        else
          if #alivePlayers > 0 then
            -- Current spectated player isn't there anymore, but there are still players to spectate
            -- Goes back to the first alive player
            index = 1
            playerToSpec = GetPlayerFromServerId(alivePlayers[index])
            spectatePlayer2(alivePlayers[index], playerToSpec, true)
            -- else, the stopGame event should be triggered
          end
        end
    end
    end
end)


function getPlayers()
    local players = {}

    for _, i in ipairs(GetActivePlayers()) do
        if NetworkIsPlayerActive(i) then
			if GetPlayerName(i) ~= GetPlayerName(PlayerId()) then
				table.insert(players, i)
			end
		end
    end

    return players
end

local firstname
local lastname
local wholename
local steamname
local job

function grabPlayerInfo(target)
  
  print("Grabbing Info")
  ESX.TriggerServerCallback('tp-spectate:getOtherPlayerData', function(data)
		
		if data.firstname then
      firstname = data.firstname
    end
    if data.lastname then
      lastname = data.lastname
      wholename = (data.firstname .. " " .. data.lastname)
    end
    if data.name then
      steamname = data.name
    end

  end	, target)
end

function drawTxt(content, font, colour, scale, x, y)
    SetTextFont(font)
    SetTextScale(scale, 0.30)
    SetTextColour(colour[1],colour[2],colour[3], 255)
    SetTextEntry("STRING")
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextDropShadow()
    SetTextEdge(4, 0, 0, 0, 255)
    SetTextOutline()
    AddTextComponentString(content)
    DrawText(x, y)
end