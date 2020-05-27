JAM_Pillbox = {}
local JPB = JAM_Pillbox
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

JPB.HospitalPosition = vector3(306.69,-591.16,43.29)
JPB.LoadZoneDist = 80.0
JPB.DrawTextDist = 4.0
JPB.InteractDist = 2.5
JPB.MaxCapacity = 7
JPB.AutoHealTimer = 30 -- seconds
JPB.HealingTimer = 5 -- seconds
JPB.OnlineEMSTimerMultiplier = 4 -- if ems > MinEMSCount and player in bed, time for auto heal = AutoHealTimer*OnlineEMSTimerMultiplier

JPB.UseHospitalClothing = true
JPB.UsingSkeletalSystem = true
JPB.UsingProgressBars = true
JPB.UsingBasicNeeds = true

JPB.MinEMSCount = 1
JPB.EMSJobLabel = "EMS"

JPB.PushToTalkKey = "N"

JPB.ActionMarkers = {
  [1] = vector3(312.302,-592.939,43.492),
}

JPB.ActionText = {
  [1] = "Press [~r~E~s~] to check yourself in.",
  [2] = "Press [~r~E~s~] to lay down on the bed.",
}

JPB.Actions = {
  [1] = "Check In",
  [2] = "Lay Down",
}

JPB.BedLocations = {
  [1] = vector3(322.616, -587.168, 43.34),
  [2] = vector3(317.670, -585.368, 43.84),
  [3] = vector3(314.465, -584.201, 43.84),
  [4] = vector3(311.057, -582.961, 43.84),
  [5] = vector3(307.717, -581.745, 43.84),
  [6] = vector3(309.353, -577.378, 43.84),
  [7] = vector3(313.929, -579.043, 43.84),
  [8] = vector3(319.412, -581.039, 43.84),
  [9] = vector3(324.262, -582.800, 43.84),



}

JPB.BedRotations = {
  [vector3(322.616, -587.168, 43.34)] = vector3(90.0, 70.0, 0.0),
  [vector3(317.670, -585.368, 43.84)] = vector3(90.0,  70.0, 0.0),
  [vector3(314.465, -584.201, 43.84)] = vector3(90.0,  70.0, 0.0),
  [vector3(311.057, -582.961, 43.84)] = vector3(90.0, 70.0, 0.0),
  [vector3(307.717, -581.745, 43.84)] = vector3(90.0, 70.0, 0.0),
  [vector3(309.353, -577.378, 43.84)] = vector3(90.0, 160.0, 0.0),
  [vector3(313.929, -579.043, 43.84)] = vector3(90.0, 160.0, 0.0),
  [vector3(319.412, -581.039, 43.84)] = vector3(90.0, 160.0, 0.0),
  [vector3(324.262, -582.800, 43.84)] = vector3(90.0, 160.0, 0.0),
}

JPB.GetUpLocations = {
  [vector3(322.616, -587.168, 43.34)] = vector4(323.05810546875,-585.45544433594,43.284023284912,224.31),
  [vector3(317.670, -585.368, 43.84)] = vector4(318.06979370117,-583.85559082031,43.284023284912,154.91),
  [vector3(314.465, -584.201, 43.84)] = vector4(315.17803955078,-582.8515625,43.284023284912,146.98),
  [vector3(311.057, -582.961, 43.84)] = vector4(311.72494506836,-581.55364990234,43.284023284912,084.35),
  [vector3(307.717, -581.745, 43.84)] = vector4(308.40411376953,-580.06011962891,43.284023284912,216.76),
  [vector3(309.353, -577.378, 43.84)] = vector4(309.52365112305,-579.22796630859,43.284023284912,111.87),
  [vector3(313.929, -579.043, 43.84)] = vector4(313.35256958008,-580.55346679688,43.284023284912,217.84),
  [vector3(319.412, -581.039, 43.84)] = vector4(318.78073120117,-582.64044189453,43.284023284912,111.87),
  [vector3(324.262, -582.800, 43.84)] = vector4(323.49261474609,-584.39916992188,43.284023284912,217.84),

  
}

JPB.Outfits = {
  patient_wear = {
    male = {
      ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
      ['torso_1']  = 104, ['torso_2']  = 0,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms']     = 3, ['pants_1']  = 29,
      ['pants_2']  = 0,   ['shoes_1']  = 34,
      ['shoes_2']  = 0,  ['chain_1']  = 0,
      ['chain_2']  = 0
    },
    female = {
      ['tshirt_1'] = 15,   ['tshirt_2'] = 0,
      ['torso_1']  = 141,  ['torso_2']  = 1,
      ['decals_1'] = 0,   ['decals_2'] = 0,
      ['arms']     = 0,  ['pants_1'] = 47,
      ['pants_2']  = 3,  ['shoes_1']  = 35,
      ['shoes_2']  = 0,   ['chain_1']  = 0,
      ['chain_2']  = 0
    }
  }
}