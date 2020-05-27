ESX = nil

TriggerEvent("esx:getSharedObject", function(library) 
	ESX = library 
end)

RegisterServerEvent('esx_skin:save')
AddEventHandler('esx_skin:save', function()
    local src = source
    TriggerClientEvent('betrayed_skins:guardarSkin',src)
end)

ESX.RegisterServerCallback('esx_skin:getPlayerSkin', function(source, cb)
  local xPlayer = ESX.GetPlayerFromId(source)
  local jobSkin = {
  skin_male   = xPlayer.job.skin_male,
  skin_female = xPlayer.job.skin_female}
  cb(nil, jobSkin)
end)


ESX.RegisterServerCallback('betrayed_skins:getSex', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["identifier"] = xPlayer.identifier}, function(result)
        cb(result[1].sex)
    end)
  end)

local function checkExistenceClothes(steamid, cb)
    MySQL.Async.fetchAll("SELECT steamid FROM character_current WHERE steamid = @steamid LIMIT 1;", {["steamid"] = steamid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

local function checkExistenceFace(steamid, cb)
    MySQL.Async.fetchAll("SELECT steamid FROM character_face WHERE steamid = @steamid LIMIT 1;", {["steamid"] = steamid}, function(result)
        local exists = result and result[1] and true or false
        cb(exists)
    end)
end

RegisterServerEvent("betrayed_skins:insert_character_current")
AddEventHandler("betrayed_skins:insert_character_current",function(data)
    if not data then return end
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier
    if not characterId then return end
    checkExistenceClothes(characterId, function(exists)
        local values = {
            ["steamid"] = characterId,
            ["model"] = json.encode(data.model),
            ["drawables"] = json.encode(data.drawables),
            ["props"] = json.encode(data.props),
            ["drawtextures"] = json.encode(data.drawtextures),
            ["proptextures"] = json.encode(data.proptextures),
        }

        if not exists then
            local cols = "steamid, model, drawables, props, drawtextures, proptextures"
            local vals = "@steamid, @model, @drawables, @props, @drawtextures, @proptextures"

            MySQL.Async.execute("INSERT INTO character_current ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "model = @model,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
        MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE steamid = @steamid", values)
    end)
end)

RegisterServerEvent("betrayed_skins:insert_character_face")
AddEventHandler("betrayed_skins:insert_character_face",function(data)
    if not data then return end
    local src = source

    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    checkExistenceFace(characterId, function(exists)
        if data.headBlend == "null" or data.headBlend == nil then
            data.headBlend = '[]'
        else
            data.headBlend = json.encode(data.headBlend)
        end
        local values = {
            ["steamid"] = characterId,
            ["hairColor"] = json.encode(data.hairColor),
            ["headBlend"] = data.headBlend,
            ["headOverlay"] = json.encode(data.headOverlay),
            ["headStructure"] = json.encode(data.headStructure),
        }

        if not exists then
            local cols = "steamid, hairColor, headBlend, headOverlay, headStructure"
            local vals = "@steamid, @hairColor, @headBlend, @headOverlay, @headStructure"

            MySQL.Async.execute("INSERT INTO character_face ("..cols..") VALUES ("..vals..")", values, function()
            end)
            return
        end

        local set = "hairColor = @hairColor,headBlend = @headBlend, headOverlay = @headOverlay,headStructure = @headStructure"
        MySQL.Async.execute("UPDATE character_face SET "..set.." WHERE steamid = @steamid", values )
    end)
end)

RegisterServerEvent("betrayed_skins:get_character_face")
AddEventHandler("betrayed_skins:get_character_face",function(pSrc)
    local src = (not pSrc and source or pSrc)
    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT cc.model, cf.hairColor, cf.headBlend, cf.headOverlay, cf.headStructure FROM character_face cf INNER JOIN character_current cc on cc.steamid = cf.steamid WHERE cf.steamid = @steamid", {['steamid'] = characterId}, function(result)
        if (result ~= nil and result[1] ~= nil) then
            local temp_data = {
                hairColor = json.decode(result[1].hairColor),
                headBlend = json.decode(result[1].headBlend),
                headOverlay = json.decode(result[1].headOverlay),
                headStructure = json.decode(result[1].headStructure),
            }
            local model = tonumber(result[1].model)
            if model == 1885233650 or model == -1667301416 then
                TriggerClientEvent("betrayed_skins:setpedfeatures", src, temp_data)
            end
        else
            TriggerClientEvent("betrayed_skins:setpedfeatures", src, false)
        end
	end)
end)

RegisterServerEvent("betrayed_skins:get_character_current")
AddEventHandler("betrayed_skins:get_character_current",function(pSrc)
    local src = (not pSrc and source or pSrc)
    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT * FROM character_current WHERE steamid = @steamid", {['steamid'] = characterId}, function(result)
        local temp_data = {
            model = result[1].model,
            drawables = json.decode(result[1].drawables),
            props = json.decode(result[1].props),
            drawtextures = json.decode(result[1].drawtextures),
            proptextures = json.decode(result[1].proptextures),
        }
        TriggerClientEvent("betrayed_skins:setclothes", src, temp_data,0)
	end)
end)

RegisterServerEvent("betrayed_skins:retrieve_tats")
AddEventHandler("betrayed_skins:retrieve_tats", function(pSrc)
    local src = (not pSrc and source or pSrc)
	local user = ESX.GetPlayerFromId(src)
	MySQL.Async.fetchAll("SELECT * FROM playersTattoos WHERE identifier = @identifier", {['identifier'] = user.identifier}, function(result)
        if(#result == 1) then
			TriggerClientEvent("betrayed_skins:settattoos", src, json.decode(result[1].tattoos))
		else
			local tattooValue = "{}"
			MySQL.Async.execute("INSERT INTO playersTattoos (identifier, tattoos) VALUES (@identifier, @tattoo)", {['identifier'] = user.identifier, ['tattoo'] = tattooValue})
			TriggerClientEvent("betrayed_skins:settattoos", src, {})
		end
	end)
end)

RegisterServerEvent("betrayed_skins:set_tats")
AddEventHandler("betrayed_skins:set_tats", function(tattoosList)
	local src = source
	local user = ESX.GetPlayerFromId(src)
	MySQL.Async.execute("UPDATE playersTattoos SET tattoos = @tattoos WHERE identifier = @identifier", {['tattoos'] = json.encode(tattoosList), ['identifier'] = user.identifier})
end)


RegisterServerEvent("betrayed_skins:get_outfit")
AddEventHandler("betrayed_skins:get_outfit",function(slot)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT * FROM character_outfits WHERE steamid = @steamid and slot = @slot", {
        ['steamid'] = characterId,
        ['slot'] = slot
    }, function(result)
        if result and result[1] then
            if result[1].model == nil then
                TriggerClientEvent("DoLongHudText", src, "Can not use.",2)
                return
            end

            local data = {
                model = result[1].model,
                drawables = json.decode(result[1].drawables),
                props = json.decode(result[1].props),
                drawtextures = json.decode(result[1].drawtextures),
                proptextures = json.decode(result[1].proptextures),
                hairColor = json.decode(result[1].hairColor)
            }

            TriggerClientEvent("betrayed_skins:setclothes", src, data,0)

            local values = {
                ["steamid"] = characterId,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
            }

            local set = "model = @model, drawables = @drawables, props = @props,drawtextures = @drawtextures,proptextures = @proptextures"
            MySQL.Async.execute("UPDATE character_current SET "..set.." WHERE steamid = @steamid",values)
        else
            TriggerClientEvent("DoLongHudText", src, "No outfit on slot " .. slot,2)
            return
        end
	end)
end)

RegisterServerEvent("betrayed_skins:set_outfit")
AddEventHandler("betrayed_skins:set_outfit",function(slot, name, data)
    if not slot then return end
    local src = source

    local user = ESX.GetPlayerFromId(src)
    local characterId = user.identifier

    if not characterId then return end

    MySQL.Async.fetchAll("SELECT slot FROM character_outfits WHERE steamid = @steamid and slot = @slot", {
        ['steamid'] = characterId,
        ['slot'] = slot
    }, function(result)
        if result and result[1] then
            local values = {
                ["steamid"] = characterId,
                ["slot"] = slot,
                ["name"] = name,
                ["model"] = json.encode(data.model),
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor),
            }

            local set = "model = @model,name = @name,drawables = @drawables,props = @props,drawtextures = @drawtextures,proptextures = @proptextures,hairColor = @hairColor"
            MySQL.Async.execute("UPDATE character_outfits SET "..set.." WHERE steamid = @steamid and slot = @slot",values)
        else
            local cols = "steamid, model, name, slot, drawables, props, drawtextures, proptextures, hairColor"
            local vals = "@steamid, @model, @name, @slot, @drawables, @props, @drawtextures, @proptextures, @hairColor"

            local values = {
                ["steamid"] = characterId,
                ["name"] = name,
                ["slot"] = slot,
                ["model"] = data.model,
                ["drawables"] = json.encode(data.drawables),
                ["props"] = json.encode(data.props),
                ["drawtextures"] = json.encode(data.drawtextures),
                ["proptextures"] = json.encode(data.proptextures),
                ["hairColor"] = json.encode(data.hairColor)
            }

            MySQL.Async.execute("INSERT INTO character_outfits ("..cols..") VALUES ("..vals..")", values, function()
                TriggerClientEvent("DoLongHudText", src, name .. " stored in slot " .. slot,1)
            end)
        end
	end)
end)


RegisterServerEvent("betrayed_skins:remove_outfit")
AddEventHandler("betrayed_skins:remove_outfit",function(slot)

    local src = source
    local user = ESX.GetPlayerFromId(src)
    local steamid = user.identifier
    local slot = slot

    if not steamid then return end

    MySQL.Async.execute( "DELETE FROM character_outfits WHERE steamid = @steamid AND slot = @slot", { ['steamid'] = steamid,  ["slot"] = slot } )
    TriggerClientEvent("DoLongHudText", src,"Removed slot " .. slot .. ".",1)
end)

RegisterServerEvent("betrayed_skins:list_outfits")
AddEventHandler("betrayed_skins:list_outfits",function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local steamid = user.identifier
    local slot = slot
    local name = name

    if not steamid then return end

    MySQL.Async.fetchAll("SELECT slot, name FROM character_outfits WHERE steamid = @steamid", {['steamid'] = steamid}, function(skincheck)
    	TriggerClientEvent("betrayed_skins:listOutfits",src, skincheck)
	end)
end)


RegisterServerEvent("clothing:checkIfNew")
AddEventHandler("clothing:checkIfNew", function()
    local src = source
    local user = ESX.GetPlayerFromId(src)
    local steamid = user.identifier

    MySQL.Async.fetchAll("SELECT * FROM character_current WHERE steamid = @steamid LIMIT 1", {
        ['steamid'] = steamid
    }, function(result)
        local isService = false;
        if user.job.name == "police" or user.job.name == "ambulance" then isService = true end

        if result[1] == nil then
            MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {["identifier"] = steamid}, function(result)
                if result[1].skin then
                    TriggerClientEvent('betrayed_skins:setclothes',src,{},json.decode(result[1].skin))
                else
                    TriggerClientEvent('betrayed_skins:setclothes',src,{},nil)
                end
                return
            end)
        else
            TriggerEvent("betrayed_skins:get_character_current", src)
        end
        TriggerClientEvent("betrayed_skins:inService",src,isService)
    end)
end)

RegisterServerEvent("clothing:checkMoney")
AddEventHandler("clothing:checkMoney", function(menu,askingPrice)
    local src = source
    local target = ESX.GetPlayerFromId(src)

    if not askingPrice
    then
        askingPrice = 0
    end

    if (tonumber(target.getMoney()) >= askingPrice) then
        target.removeMoney(askingPrice)
        TriggerClientEvent("DoShortHudText",src, "You Paid $"..askingPrice,8)
        TriggerClientEvent("betrayed_skins:hasEnough",src,menu)
    else
        TriggerClientEvent("DoShortHudText",src, "You need $"..askingPrice.." + Tax.",2)
    end
end)