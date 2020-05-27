-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFT = MF_Trackables
local TSC = ESX.TriggerServerCallback
local TSE = TriggerServerEvent
local CT = Citizen.CreateThread

function MFT:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    self.PlayerData = ESX.GetPlayerData()
    TSC('MF_Trackables:GetStartData', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function MFT:Start()
  if self.dS and self.cS then self:Update(); end
end

MFT.Messages              = {}
MFT.CurMsg                = 0
MFT.MessageCount          = 0
MFT.LastMessage           = false
MFT.LastMessageReceived   = false
MFT.LastMessageNumber     = false
MFT.UiOpen                = false


function MFT:Update(...)
  local resX,resY = GetActiveScreenResolution()
  local xMod,yMod = self.SizeX,self.SizeY
  local xPos,yPos = self.PosX,self.PosY

  local titleOffsetX,titleOffsetY   =  0.00,-0.08
  local countOffsetX,countOffsetY   = -0.08,-0.08
  local jobOffsetX,jobOffsetY       =  0.08,-0.08
  local msgOffsetX,msgOffsetY       =  0.00,-0.04
  local timeOffsetX,timeOffsetY     = -0.07, 0.04
  local senderOffsetX,senderOffsetY =  0.07, 0.04
  local ctrlOffsetX,ctrlOffsetY     =  0.00, 0.07

  local titleTemplate   = Utils.DrawTextTemplate()
  titleTemplate.x       = xPos + titleOffsetX
  titleTemplate.y       = yPos + titleOffsetY
  titleTemplate.text    = "~w~Recent Calls"
  titleTemplate.colour1 = 180
  titleTemplate.colour2 = 000
  titleTemplate.colour3 = 000

  local countTemplate   = Utils.DrawTextTemplate()
  countTemplate.x       = xPos + countOffsetX
  countTemplate.y       = yPos + countOffsetY
  countTemplate.text    = '~y~'..self.CurMsg .. " / " .. self.MessageCount
  countTemplate.colour1 = 200
  countTemplate.colour2 = 200
  countTemplate.colour3 = 000

  local jobTemplate     = Utils.DrawTextTemplate()
  jobTemplate.x         = xPos + jobOffsetX
  jobTemplate.y         = yPos + jobOffsetY
  jobTemplate.text      = '' -- (self.Messages[self.CurMsg] and '~y~Units : '..self.Messages[self.CurMsg].responders) or '~r~Units : 0'
  jobTemplate.colour1   = 200
  jobTemplate.colour2   = 200
  jobTemplate.colour3   = 000

  local msgTemplate     = Utils.DrawTextTemplate()
  msgTemplate.x         = xPos + msgOffsetX
  msgTemplate.y         = yPos + msgOffsetY
  msgTemplate.text      = (self.Messages[self.CurMsg] and self.Messages[self.CurMsg].text) or ''
  msgTemplate.colour1   = 180
  msgTemplate.colour2   = 180
  msgTemplate.colour3   = 180

  local year,month,day,hour,min,sec = GetLocalTime()
  self.LastMessageReceived = hour..":"..min.." - "..day.."/"..month.."/"..year

  local timeTemplate    = Utils.DrawTextTemplate()
  timeTemplate.x         = xPos + timeOffsetX
  timeTemplate.y         = yPos + timeOffsetY
  timeTemplate.text      = (self.Messages[self.CurMsg] and '~y~'..self.Messages[self.CurMsg].time) or ''
  timeTemplate.colour1   = 180
  timeTemplate.colour2   = 000
  timeTemplate.colour3   = 000
  timeTemplate.scale1    = 0.3
  timeTemplate.scale2    = 0.3

  local senderTemplate   = Utils.DrawTextTemplate()
  senderTemplate.x         = xPos + senderOffsetX
  senderTemplate.y         = yPos + senderOffsetY
  senderTemplate.text      = (self.Messages[self.CurMsg] and '~y~'..self.Messages[self.CurMsg].sender) or ''
  senderTemplate.colour1   = 180
  senderTemplate.colour2   = 000
  senderTemplate.colour3   = 000
  senderTemplate.scale1    = 0.3
  senderTemplate.scale2    = 0.3

  local controlsTemplate   = Utils.DrawTextTemplate()
  controlsTemplate.x       = xPos + ctrlOffsetX
  controlsTemplate.y       = yPos + ctrlOffsetY
  controlsTemplate.text    = '' -- (self.Messages[self.CurMsg] and '~r~Press [~y~G~r~] to respond. Press [~y~H~r~] to delete.') or ''
  controlsTemplate.colour1 = 000
  controlsTemplate.colour2 = 000
  controlsTemplate.colour3 = 000
  controlsTemplate.scale1  = 0.3
  controlsTemplate.scale2  = 0.3

  local maxLength = 20
  if string.len(msgTemplate.text) > maxLength then
    local start = string.find(msgTemplate.text," ",maxLength)
    local lineA = string.sub(msgTemplate.text,1,start)..'\n'..string.sub(msgTemplate.text,start+1)
    msgTemplate.text = lineA
  end

  local lastKeyTimer = GetGameTimer()

  local modAlpha = 0

  self.UiOpen = false
  while self.dS and self.cS do
    Citizen.Wait(0)
    if IsControlJustReleased(0, Keys['F3']) and (self.PlayerData.job.name == "police" or self.PlayerData.job.name == "ambulance" or self.PlayerData.job.name == "taxi" or self.PlayerData.job.name == "mechanic") then 
      self.UiOpen = not self.UiOpen; 
    end

    if self.UiOpen then
      if IsControlJustPressed(0, Keys["RIGHT"]) then 
        self.CurMsg = math.min(self.CurMsg + 1,self.MessageCount)
      elseif IsControlJustPressed(0, Keys["LEFT"]) then 
        self.CurMsg = math.max(self.CurMsg - 1, 0)
      end

      if IsControlJustPressed(0, Keys["H"]) and self.Messages[self.CurMsg] and (GetGameTimer() - lastKeyTimer) > 150 then
        for k=self.CurMsg,self.MessageCount-1,1 do
          self.Messages[k] = self.Messages[k+1] 
        end
        self.Messages[self.MessageCount] = nil
        self.MessageCount = self.MessageCount - 1
        if self.CurMsg > self.MessageCount then self.CurMsg = self.MessageCount; end
        lastKeyTimer = GetGameTimer()
      end

      if IsControlJustPressed(0, Keys["L"]) and self.Messages[self.CurMsg] then 
        SetNewWaypoint(self.Messages[self.CurMsg].loc.x,self.Messages[self.CurMsg].loc.y)
        modAlpha = 255
        if not self.Messages[self.CurMsg].responded and self.Messages[self.CurMsg].estadokey == 1 then
          self.Messages[self.CurMsg].responded = true
          self.Messages[self.CurMsg].estadokey = 2
          TSE('MF_Trackables:Respond',self.CurMsg)
          if self.Messages[self.CurMsg].txt then
            exports['mythic_notify']:DoLongHudText('inform', 'You confirmed your assistance to a citizen!')
            TSE('betrayed_phone:confirmaAsistencia',self.Messages[self.CurMsg].playerid,self.Messages[self.CurMsg].job)
          end
        end
        if self.Messages[self.CurMsg].estadokey ~= 2 then
          self.Messages[self.CurMsg].estadokey = 1
        end
      end

      countTemplate.text    = '~y~'..self.CurMsg .. " / " .. self.MessageCount
      jobTemplate.text      = (self.Messages[self.CurMsg] and '~y~Units : '..self.Messages[self.CurMsg].responders) or '' -- '~y~Units : 0'
      msgTemplate.text      = (self.Messages[self.CurMsg] and self.Messages[self.CurMsg].text) or ''
      timeTemplate.text     = (self.Messages[self.CurMsg] and self.Messages[self.CurMsg].time.." GMT 0") or ''
      senderTemplate.text   = ''
      if self.Messages[self.CurMsg] then
        if self.Messages[self.CurMsg].estadokey == 0 then
          controlsTemplate.text = (self.Messages[self.CurMsg] and '~r~Press [~y~L~r~] see location. Press [~y~H~r~] delete.') or ''
        elseif self.Messages[self.CurMsg].estadokey == 1 then
          controlsTemplate.text = (self.Messages[self.CurMsg] and '~r~Press [~y~L~r~] confirm assistance. Press [~y~H~r~] delete.') or ''
        elseif self.Messages[self.CurMsg].estadokey == 2 then
          controlsTemplate.text = (self.Messages[self.CurMsg] and '~r~Press [~y~L~r~] see location. Press [~y~H~r~] delete.') or ''
        end
      else
        controlsTemplate.text = (self.Messages[self.CurMsg] and '~r~Press [~y~L~r~] see location. Press [~y~H~r~] delete.') or ''
      end

      if not lastMsg or msgTemplate.text ~= lastMsg then
        if string.len(msgTemplate.text) > maxLength then
          local start = string.find(msgTemplate.text," ",maxLength)
          if start then
            local lineA = string.sub(msgTemplate.text,1,start)..'\n'..string.sub(msgTemplate.text,start+1)
            msgTemplate.text = lineA
          end
        end
        lastMsg = msgTemplate.text
      end

      if modAlpha > 0 then modAlpha = math.max(0,modAlpha - 5); end

      DrawRect(xPos,yPos, xMod,yMod, 5,5,5,200)
      DrawRect(xPos,yPos, xMod,yMod, 35,5,5,modAlpha)
      Utils.DrawText(titleTemplate)
      Utils.DrawText(countTemplate)
      Utils.DrawText(jobTemplate)
      Utils.DrawText(msgTemplate)
      Utils.DrawText(timeTemplate)
      Utils.DrawText(senderTemplate)
      Utils.DrawText(controlsTemplate)
    end
  end
end

function MFT.SetJob(source,job)
  local self = MFT
  self.PlayerData.job = job
  --TriggerServerEvent('MF_Trackables:Notify',"You have just changed your job to : testing.",GetEntityCoords(GetPlayerPed(-1)),"police")
end

function MFT.AddMessage(source,msg,pos,job,mensaje,id)
  if not source then return; end
  if not job then job = pos; pos = msg; msg = source; end

  local self = MFT
  if not self.PlayerData then return; end
  if not self.PlayerData.job or self.PlayerData.job.name ~= job then return; end
  local year,month,day,hour,min,sec = GetLocalTime()
  local curTime = '~y~'..hour..":"..min.." - "..day.."/"..month.."/"..year

  self.MessageCount = self.MessageCount + 1
  self.LastMessage = self.MessageCount
  self.Messages[self.LastMessage] = {
    text = msg or '',
    time = curTime,
    pos = '~y~'..math.round(pos.x,1.0)..' / '..math.round(pos.y,1.0)..' / '..math.round(pos.z,1.0),
    loc = pos,
    responders = 0,
    txt = mensaje,
    playerid = id,
    job = job,
    estadokey = 0,
  }
  exports['mythic_notify']:DoLongHudText('inform', msg)
  TriggerEvent('InteractSound_CL:PlayOnOne','copradio',0.5)
end

function MFT.Responding(source,id)
  local self = MFT
  for k,v in pairs(self.Messages) do
    if id == k then v.responders = v.responders + 1; end
  end
end

NewEvent(true,MFT.SetJob,'esx:setJob')
NewEvent(true,MFT.AddMessage,'MF_Trackables:DoNotify')
NewEvent(true,MFT.Responding,'MF_Trackables:Responding')

CT(function(...) MFT:Awake(...); end)