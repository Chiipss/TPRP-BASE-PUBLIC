RegisterNetEvent('SVRP_GrowWeed:SyncPlant')
RegisterNetEvent('SVRP_GrowWeed:RemovePlant')

local SVD = SVRP_GrowWeed

function SVD:Awake(...)
  while not ESX do 
    Citizen.Wait(0); 
  end

  self:DSP(true);
  self.dS = true
  self:Start()
end

function SVD:DoLogin(src)  
  self:DSP(true);
end

function SVD:DSP(val) self.cS = val; end
function SVD:Start(...)
  self:Update();
end

function SVD:Update(...)
end

function SVD:SyncPlant(plant,delete)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local identifier = xPlayer.getIdentifier()
  plant["Owner"] = identifier
  if delete then 
    if xPlayer.job.label ~= self.PoliceJobLabel then
      self:RewardPlayer(source, plant)
    end
  end
  self:PlantCheck(identifier,plant,delete) 
  TriggerClientEvent('SVRP_GrowWeed:SyncPlant',-1,plant,delete)
end

function SVD:RewardPlayer(source,plant)
  local xPlayer = ESX.GetPlayerFromId(source)
    while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
      xPlayer.addInventoryItem('coca-paste', 2)
      xPlayer.addInventoryItem('barrel', 1)
end

function SVD:PlantCheck(identifier, plant, delete)
  if not plant or not identifier then return; end
  local data = MySQL.Sync.fetchAll('SELECT * FROM dopeplants WHERE plantid=@plantid',{['@plantid'] = plant.PlantID})
  if not delete then
    if not data or not data[1] then  
      MySQL.Async.execute('INSERT INTO dopeplants (owner, plantid, plant) VALUES (@owner, @id, @plant)',{['@owner'] = identifier,['@id'] = plant.PlantID, ['@plant'] = json.encode(plant)})
    else
      MySQL.Sync.execute('UPDATE dopeplants SET plant=@plant WHERE plantid=@plantid',{['@plant'] = json.encode(plant),['@plantid'] = plant.PlantID})
    end
  else
    if data and data[1] then
      MySQL.Async.execute('DELETE FROM dopeplants WHERE plantid=@plantid', {['@plantid'] = plant.PlantID})
    end
  end
end

function SVD:GetLoginData(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local data = MySQL.Sync.fetchAll('SELECT * FROM dopeplants WHERE owner=@owner',{['@owner'] = xPlayer.identifier})
  if not data or not data[1] then return false; end
  local aTab = {}
  for k = 1,#data,1 do
    local v = data[k]
    if v and v.plant then
      local data = json.decode(v.plant)
      table.insert(aTab,data)
    end
  end
  return aTab
end

function SVD:ItemTemplate()
  return {
       ["Type"] = "Water",
    ["Quality"] = 0.0,
  }
end

function SVD:PlantTemplate()
  return {
   ["Gender"] = "Female",
  ["Quality"] = 0.0,
   ["Growth"] = 0.0,
    ["Water"] = 20.0,
     ["Food"] = 20.0,
    ["Stage"] = 1,
  ["PlantID"] = math.random(math.random(999999,9999999),math.random(99999999,999999999))
  }
end

ESX.RegisterServerCallback('SVRP_GrowWeed:GetLoginData', function(source,cb) cb(SVD:GetLoginData(source)); end)
ESX.RegisterServerCallback('SVRP_GrowWeed:GetStartData', function(source,cb) while not SVD.dS do Citizen.Wait(0); end; cb(SVD.cS); end)
AddEventHandler('SVRP_GrowWeed:SyncPlant', function(plant,delete) SVD:SyncPlant(plant,delete); end)
AddEventHandler('playerConnected', function(...) SVD:DoLogin(source); end)
Citizen.CreateThread(function(...) SVD:Awake(...); end)

-- Maintenance Items
ESX.RegisterUsableItem('wateringcan', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('wateringcan').count > 0 then 
    --xPlayer.removeInventoryItem('wateringcan', 1)

    local template = SVD:ItemTemplate()
    template.Type = "Water"
    template.Quality = 0.1

    TriggerClientEvent('SVRP_GrowWeed:UseItem',source,template)
  end
end)

ESX.RegisterUsableItem('purifiedwater', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('purifiedwater').count > 0 then 
    xPlayer.removeInventoryItem('purifiedwater', 1)

    local template = SVD:ItemTemplate()
    template.Type = "Water"
    template.Quality = 0.2

    TriggerClientEvent('SVRP_GrowWeed:UseItem',source,template)
  end
end)

ESX.RegisterUsableItem('lowgradefert', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('lowgradefert').count > 0 then 
    xPlayer.removeInventoryItem('lowgradefert', 1)

    local template = SVD:ItemTemplate()
    template.Type = "Food"
    template.Quality = 0.1

    TriggerClientEvent('SVRP_GrowWeed:UseItem',source,template)
  end
end)

ESX.RegisterUsableItem('highgradefert', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('highgradefert').count > 0 then 
    xPlayer.removeInventoryItem('highgradefert', 1)

    local template = SVD:ItemTemplate()
    template.Type = "Food"
    template.Quality = 0.2

    TriggerClientEvent('SVRP_GrowWeed:UseItem',source,template)
  end
end)


ESX.RegisterUsableItem('coca_leaf', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  if xPlayer.getInventoryItem('coca_leaf').count >= 80 and xPlayer.getInventoryItem('barrel').count > 0 and xPlayer.getInventoryItem('sulf-acid').count >= 4 then
    xPlayer.removeInventoryItem('coca_leaf', 80)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('sulf-acid', 4)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('barrel', 1)

    local template = SVD:PlantTemplate()
    template.Gender = "Male"
    template.Quality = 0.2
    template.Quality = math.random(200,500)/10
    template.Food =  math.random(200,400)/10
    template.Water = math.random(200,400)/10

    TriggerClientEvent('SVRP_GrowWeed:UseSeed',source,template)

  else

    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You seem to be missing something.', length = 10000})
    
  end
end)

ESX.RegisterUsableItem('coke_pooch', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.removeInventoryItem('coke_pooch', 1)
	TriggerClientEvent('sniffcoke:onUse', _source)
end)

ESX.RegisterUsableItem('coke', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
  xPlayer.removeInventoryItem('coke', 1)
	TriggerClientEvent('sniffFake:onUse', _source)
end)



---------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("tp_leaf:get")
AddEventHandler("tp_leaf:get", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('coca_leaf').count <= 175 then
		xPlayer.addInventoryItem("coca_leaf", math.random(1,8))
		else
		TriggerClientEvent('esx:showNotification', source, '~r~You cant hold any more coca leaves')
	end		
end)

RegisterServerEvent("tp_dry:get")
AddEventHandler("tp_dry:get", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('heat-gun').count > 0 and xPlayer.getInventoryItem('coca-paste').count >= 2 then
    xPlayer.removeInventoryItem('coca-paste', 2)
    Citizen.Wait(500)
    xPlayer.addInventoryItem('coca-powder', 1)
  elseif xPlayer.getInventoryItem('heat-gun').count > 0 then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough CocaPaste', length = 10000})
	end		
end)

RegisterServerEvent("tp_pack:get")
AddEventHandler("tp_pack:get", function()
  local xPlayer = ESX.GetPlayerFromId(source)
	while not xPlayer do Citizen.Wait(0); ESX.GetPlayerFromId(source); end
  local canUse = false
  if xPlayer.getInventoryItem('coca-powder').count > 0 and xPlayer.getInventoryItem('drugscales').count > 0 and xPlayer.getInventoryItem('dopebag').count >= 28 then
    xPlayer.removeInventoryItem('dopebag', 28)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('coca-powder', 1)
    Citizen.Wait(500)
    xPlayer.addInventoryItem('coke_pooch', 28)
    canUse = true
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'You bagged 28G of cocaine', length = 10000})
  elseif xPlayer.getInventoryItem('coca-powder').count > 0 then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You need scales and baggies to bag it up', length = 10000})
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough cocaine powder to do this.', length = 10000})
  end
  TriggerClientEvent('SVRP_GrowWeed:UseBag', source, canUse)	
end)


RegisterServerEvent("tp_create:get")
AddEventHandler("tp_create:get", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('battery-acid').count > 0 and xPlayer.getInventoryItem('WEAPON_PETROLCAN').count > 0 then
    xPlayer.removeInventoryItem('battery-acid', 1)
    Citizen.Wait(500)
    xPlayer.addInventoryItem('sulf-acid', 1)
  elseif xPlayer.getInventoryItem('battery-acid').count > 0 then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You need a jerry can', length = 10000})
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You seem to missing Battery acid', length = 10000})
  end	
end)


RegisterServerEvent("tp_bash:get")
AddEventHandler("tp_bash:get", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer.getInventoryItem('coca-powder').count > 0 and xPlayer.getInventoryItem('teething-powder').count > 0 and xPlayer.getInventoryItem('dopebag').count >= 28 then
    xPlayer.removeInventoryItem('dopebag', 46)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('teeth-powder', 1)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('coca-powder', 1)
    Citizen.Wait(500)
    xPlayer.addInventoryItem('coke', 46)
  elseif xPlayer.getInventoryItem('coca-powder').count > 0 then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You need baggies!', length = 10000})
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You seem to missing items', length = 10000})
  end	
end)

RegisterServerEvent("tp_items:get")
AddEventHandler("tp_items:get", function()
    local _source = source	
	local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer.getInventoryItem('pAmmo').count >= 3 and xPlayer.getInventoryItem('sulf-acid').count > 0 and xPlayer.getInventoryItem('empty-battery').count >= 1 and xPlayer.getInventoryItem('rolex').count >= 1 then
    xPlayer.removeInventoryItem('pAmmo', 3)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('sulf-acid', 1)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('empty-battery', 1)
    Citizen.Wait(500)
    xPlayer.removeInventoryItem('rolex', 1)
    Citizen.Wait(500)
    xPlayer.addInventoryItem('c4', 1)
  elseif xPlayer.getInventoryItem('pAmmo').count < 3 then
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You need more ammo! And might be missing 3 other items!!', length = 10000})
  else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You seem to missing items', length = 10000})
  end	
end)





