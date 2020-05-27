SVRP_GrowWeed = {}

esx = nil

local SVD = SVRP_GrowWeed
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

SVD.FoodDrainSpeed      = 0.0000
SVD.WaterDrainSpeed     = 0.0000
SVD.QualityDrainSpeed   = 0.0100

SVD.GrowthGainSpeed     = 0.0060
SVD.QualityGainSpeed    = 0.0050

SVD.SyncDist = 50.0
SVD.InteractDist = 2.5
SVD.PoliceJobLabel = "LSPD"
SVD.WeedPerBag = 1
SVD.JointsPerBag = 10 
SVD.BagsPerPapers = 1

SVD.PlantTemplate = {
   ["Gender"] = "Female",
  ["Quality"] = 0.1,
   ["Growth"] = 0.1,
    ["Water"] = 20.0,
     ["Food"] = 20.0,
    ["Stage"] = 1,
}

SVD.ItemTemplate = {
     ["Type"] = "Water",
     ["Quality"] = 0.1,
}

SVD.Objects = {
  [1] = "prop_barrel_02a",
  [2] = "prop_barrel_02a",
  [3] = "prop_barrel_02a",
  [4] = "prop_barrel_02a",
  [5] = "prop_barrel_02a",
  [6] = "prop_barrel_02a",
  [7] = "prop_barrel_02a",
}

--5.706