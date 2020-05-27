local blips = {
	  {name="Delivery Jobs", id=85, x = -321.32, y = -1022.568, z = 30.09, color = 25 },
    {name="Pink Cage Motel", id=475, x = 326.29, y = -212.31, z = 55.08, color = 41 },
    {name="Bilingsgate Motel", id=475, x = 565.20, y = -1761.26, z = 29.17, color = 53 },
    {name="The Rancho Motel", id=475, x = 361.95, y = -1798.7, z = 29.1, color = 6 },
    {name="Von Crastenburg Motel", id=475, x = 435.98, y = 215.37, z = 103.17, color = 7 },
    {name="Dream View Motel", id=475, x = -104.86, y = 6315.9, z = 31.58, color = 78 },
    {name="Crown Jewels Motel", id=475, x = -1317.17, y = -939.03, z = 9.73, color = 60 },
    {name="Bayview Lodge Motel", id=475, x = -695.99, y = 5802.4, z = 17.33, color = 69 },
    {name="Eastern Motel", id=475, x = 317.33, y = 2623.21, z = 44.46, color = 17 },
    {name="Juice Warehouse", id=409, x = -249.61, y = 6063.83, z = 31.50, color = 53 },
    {name="Sell fruit", id=605, x = 1264.247, y = 3545.389, z = 35.167, color = 69 },
    {name="Sell juice", id=605, x = 2739.931, y = 4403.824, z = 48.50, color = 17 },
    {name="Job Vehicles", id=524, x = 407.815, y = 6496.035, z = 27.87, color = 30 },
    --{name="Huntin store", id=442, x = 969.163, y = -2107.903, z = 31.475, color = 1 },
    --{name="Hunting", id=442, x = -769.237, y = 5595.621, z = 33.485, color = 2 },
    {name="City hall", id=419, x = -544.58, y = -204.590, z = 27.19},
    {name="Forklift Warehouse", id=569, x = 152.382, y = -3101.465, z = 5.896, color = 56},
    {name="Forklift Warehouse", id=569, x = 152.953, y = -3211.840, z = 6.109, color = 56},
    {name="Pig Farm", id=126, x = 2190.445, y = 4981.941, z = 41.517, color = 23},
    {name="Pig Slaughter House", id=273, x = 998.135, y = -2144.108, z = 29.529, color = 23},
    {name="Pig Dealer", id=478, x = 1194.148, y = 2722.781, z = 38.623, color = 23},
    {name="Chicken Farm", id=126, x = 2388.725, y = 5044.985, z = 46.304, color = 46},
    {name="Chicken Slaughter House", id=273, x = -96.007, y = 6206.92, z = 31.02, color = 46},
    {name="Chicken Dealer", id=478, x = -1177.17, y = -890.68, z = 13.79, color = 46},
    {name="Burger Shot", id=536, x = -1194.111, y = -891.712, z = 13.995, color = 21},
    {name="Hospital", id=61, x = 337.19284057617, y = -583.3, z = 42.4, color = 2},

    {name="MRPD", id=60, x = 425.1, y = -979.5, z = 30.7, color = 77}, 
    {name="SSPD", id=60, x = 1855.578, y = 3683.289, z = 34.268, color = 77},
    {name="PBPD", id=60, x = -445.789, y = 6014.299, z = 31.716, color = 77},
    {name="MRPD HELI", id=43, x = 449.263, y = -980.244, z = 43.687, color = 77},
    {name="FlyWheels Garage", id=446, x = 1773.051, y = 3333.058, z = 41.370, color = 75},

    --{name="Cinema", id=362, x = 336.868, y = 177.476, z = 103.110, color = 71},
    {name="Police Impound", id=473, x = 409.12, y = -1624.18, z = 28.4, color = 29},
    --[[ {name="Vehicle Impound", id=473, x = 483.6, y = -1312.07, z = 28.23, color = 47}, ]]

    --[[ {name="Garage A", id=50, x = 232.2, y = -792.48, z = 29.61, color = 67},
    {name="Garage B", id=50, x = -742.92, y = -2473.92, z = 13.45, color = 67},
    {name="Garage C", id=50, x = 288.39, y = -339.62, z = 43.94, color = 67},
    {name="Garage D", id=50, x = 1419.45, y = 3619.47, z = 33.92, color = 67},
    {name="Garage E", id=50, x = 127.48, y = 6608.51, z = 30.87, color = 67},
    {name="Garage F", id=50, x = -2358.76, y = 4086.07, z = 31.57, color = 67},
    {name="Garage G", id=50, x = -54.80, y = -1836.24, z = 26.57, color = 67}, ]]
    
  }

  local biggerBlips = {  
      {name="Apples", id=1, x = 354.81, y = 6516.67, z = 28.52, color = 2 },
      {name="Oranges", id=1, x = 247.94, y = 6513.16, z = 29.50, color = 47 },
      {name="Cows", id=141, x = 2438.240, y = 4765.890, z = 35.00, color = 16},
      {name="Milk Vat", id=402, x = 2502.120, y = 4801.250, z = 43.740, color = 16},
      {name="Boilingbroke Penitentiary", id=188, x = 1845.6022949219, y = 2585.8029785156, z = 45.672061920166, color = 49},
    } 


 

Citizen.CreateThread(function()

    for _, item in pairs(blips) do
      item.blip = AddBlipForCoord(item.x, item.y, item.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipScale(item.blip,0.6)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING") 
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
      SetBlipColour(item.blip, item.color)
    end
end)

Citizen.CreateThread(function()

  for _, item in pairs(biggerBlips) do
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.id)
    SetBlipScale(item.blip,0.8)
    SetBlipAsShortRange(item.blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
    SetBlipColour(item.blip, item.color)
  end
end)