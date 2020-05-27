robbery = {}
Config = {  
  __VERSION = "1.02",

  -- Lock houses/reset loot tables
  ResetAfterMinutes = 15,

  -- Distance to perform action/draw marker
  ActDist   =  1.0,
  DrawDist  = 10.0,

  -- How long to loot
  InteractTimer = 5.0,

  -- Police stuff
  PoliceJob     = "police",
  AlertTimeout  = 10,
  MinCopsOnline = 4,

  -- Use dog?
  UseDog      = true,

  -- Account reward type
  -- NOTE: Uses xPlayer.addAccountMoney(Config.RewardAccount,amount)
  -- Make sure you're setting a valid account name. 
  RewardAccount = "black_money",

  -- Blip Stuff
  ShowBlip    = true,
  BlipCol     = 85,
  BlipAlpha   = 0.5,
  BlipSprite  = 154,
  BlipScale   = 0.5,
  BlipDisplay = 3,
  BlipText    = "House Robbery",
  BlipShort   = true,

  -- Lockpicking stuff
  LockpickItemName = "lockpick",
  NeedLockpick     = true,
  TakeLockpick     = true,
  MinigameForEntry = true,
  TimeForLockpick  = 5,
  UsingProgressBar = true,
  UseDraw3D        = true,

  Entrys = {
    vector4(329.38,-1845.92,27.74, 043.0),
    vector4(338.70,-1829.54,28.33, 132.0),
    vector4(320.25,-1854.07,27.51,-132.7),
    vector4(348.64,-1820.98,28.89, 139.5),
    vector4(333.08,-1740.87,29.73,-036.7),
    vector4(320.66,-1759.78,29.63,-052.5),
    vector4(304.46,-1775.43,29.10, 045.9),
    vector4(300.25,-1783.67,28.43,-039.6),
    vector4(288.67,-1792.55,28.08, 141.1),
  },
}

robbery.lootOffsets = { 
  ['entertainment unit'] = vector3(-8.29,16.00,0.79), 
  ['drawers'] = vector3(-7.21,9.16,0.79), 
  ['bookshelf'] = vector3(-1.2,16.99,1.2), 
  ['chest'] = vector3(5.4,13.71,0.79), 
  ['wardrobe'] = vector3(4.5,18.91,0.79), 
  ['bedside table'] = vector3(2.73,17.63,0.79), 
  ['bathroom cabinet'] = vector3(0.83,18.41,0.79), 
} 

robbery.lootTable = {
  ['entertainment unit'] = {
    weapons = {
      weapon_smg = {
        chance = 25,
        ammo   = 150,
      },
      weapon_pistol = {
        chance = 50,
        ammo   = 150,
      },
    },
    money = 150,
    item = {
      ipad = {
        max = 2,
        chance = 50,
      },
    },
  },
  ['drawers'] = {
    weapons = {},
    money = 0,
    item = {},
  },
  ['bookshelf'] = {
    weapons = {},
    money = 150,
    item = {
      ipad = {
        max = 1,
        chance = 25,
      },
      book = {
        max = 5,
        chance = 85,
      },
    },
  },
  ['chest'] = {
    weapons = {},
    money = 150,
    item = {
      book = {
        max = 5,
        chance = 85,
      },
      ipad = {
        max = 1,
        chance = 80,
      },
    },
  },
  ['wardrobe'] = {
    weapons = {},
    money = 150,
    item = {
      book = {
        max = 3,
        chance = 50,
      },
    },
  },
  ['bedside table'] = {
    weapons = {},
    money = 150,
    item = {
      rolex = {
        max = 1,
        chance = 80,
      },
      book = {
        max = 5,
        chance = 85,
      },
    },
  },
  ['bathroom cabinet'] = {
    weapons = {},
    money = 150,
    item = {
      book = {
        max = 5,
        chance = 85,
      },
      rolex = {
        max = 1,
        chance = 30,
      },
    },
  },
}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
Citizen.CreateThread(function(...) while not ESX do TriggerEvent('esx:getSharedObject',function(obj) ESX = obj; end); Citizen.Wait(0); end; end)

mLibs = exports["meta_libs"]