ESX = nil
seeded = false
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
while not ESX do
    Citizen.Wait(0)
end

Citizen.CreateThread(function()
    while not seeded do
        math.randomseed(os.time())
        print("Unique Plates Seeded - " .. os.time())
        seeded = true
    end
end)

RegisterCommand("newplate", function(source, args, raw)
    local src = source
    local plate = UniquePlateCheck()
    TriggerClientEvent('tp-printplate', src, plate)
end, false)


ESX.RegisterServerCallback('tp-generateplate', function(source, cb)
    local newPlate = UniquePlateCheck()
    print(newPlate)
	cb(newPlate)
end)

function GenerateUniquePlate()
    local upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local numbers = "0123456789"
    local characterSet = numbers .. upperCase
    local keyLength = 8
    local output = ""
    for	i = 1, keyLength do
        local rand = math.random(#characterSet)
        output = output .. string.sub(characterSet, rand, rand)
    end
    print(output)
    return output
end

function UniquePlateCheck()
    local plate = GenerateUniquePlate()

    local result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate", {['@plate'] = plate})
    if result[1] then    -- Bad condition (Duplicate)
        print("Failure - Duplicate Plate!")
        Citizen.Wait(50)
        UniquePlateCheck()
    else
        print("Success - No duplicate plate found")
        return plate  -- Good Condition (No duplicate)
	end
end