Config = {}

--MORE STRINGS BELOW YOU ABSOLUTELY MUST SET THESE TO YOUR ESX SKIN MENU LABEL --
--( i.e. French will put 'Sac' in place of 'Bag', Spanish will use 'Orejas' instead of 'Ears' ) --
-- THIS ABSOLUTELY MUST MATCH YOUR SKIN MENU LABELS TO ALLOW YOU TO PURCHASE ITEMS --

Config.BagSkinMenu = 'Bag'
Config.EarSkinMenu = 'Ear accessories'
Config.EyeSkinMenu = 'Glasses 1'
Config.HelSkinMenu = 'Helmet 1'
Config.MakSkinMenu = 'Mask 1'

-- LOCALE STRINGS AT BOTTOM OF PAGE --

Config.Price = 100
Config.OpenKey = 344 -- 'F11'
Config.Mythic = true -- choose if you wish to use mythicnotify
Config.Pnotif = false -- choose if you wish to use pnotify

Config.MinLength = 1 -- choose min length for accessory names
Config.MaxLength = 16 -- choose max length for accessory names

Config.UseBlips = true
Config.UseMarkers	= true
Config.DrawDistance = 10.0
Config.Size   = {x = 1.0, y = 1.0, z = 1.0}
Config.Color  = {r = 255, g = 255, b = 255}
Config.Type   = 27

Config.InvalidBags = { -- choose which bag skins cannot be used as a backpack
	0, 8
}
Config.InvalidEyes = { -- choose which glasses cannot be purchased
	0, 6, 11, 14, 27
}
Config.InvalidEars = { -- choose which ear pieces cannot be purchased
	0
}
Config.InvalidHelm = { -- choose which helmets/hats cannot be purchased
	-1, 8, 11, 18, 57, 121, 129
}

Config.InvalidMask = { -- choose which masks cannot be purchased
	0, 120
}

Config.BagRequired = true -- adjust to make players need a bag skin to access backpack or not
Config.CanStoreBags = true -- adjust to allow players to store more backpacks inside their backpack
Config.ItemLimit = false -- adjust to limit how many accessories players can carry NOT RECOMMENDED TO SWITCH TO TRUE IF USED AS FALSE AT ALL
--( DOABLE BUT WILL MAKE PLAYERS DELETE ENTRIES UP TO THE AMOUNT ALLOWED, IS ANNOYING IF THEY HAVE ALOT OF ENTRIES :SHRUG: )
Config.BagLimit = 5
Config.EarLimit = 20
Config.MaskLimit = 10
Config.HelmetLimit = 4
Config.GlassesLimit = 10

Config.CommsOnly = false -- adjust to remove/add key presses

Config.Pos = {

	Locker = {
		
		vector3(-1195.49, -1577.67,	3.61),
			
	},
	
	Bags = {
		
		vector3(424.12, -809.66, 28.49),
		vector3(1200.03, 2708.98, 37.22),
		vector3(-818.87, -1073.30, 10.33),
		vector3(76.83, -1389.71, 28.38),
		vector3(-1098.26, 2711.47, 18.11),
		vector3(1693.01, 4819.30, 41.06),
		vector3(1.51, 6511.06, 30.88),
		
	},
	
	Ears = {
		
		vector3(75.77, -1392.94, 28.38),
		vector3(-709.426, -153.829, 36.535),
		vector3(-163.093, -302.038, 38.853),
		vector3(425.44, -806.02, 28.50),
		vector3(-822.24, -1073.92, 10.33),
		vector3(-1451.300, -238.254, 48.929),
		vector3(4.69, 6512.74, 30.88),
		vector3(125.00, -224.55, 53.56),
		vector3(1693.57, 4822.83, 41.06),
		vector3(614.76, 2763.75, 41.09),
		vector3(1196.64, 2709.79, 37.22),
		vector3(-1192.13, -767.79, 16.32),
		vector3(-3171.28, 1043.08, 19.86),
		vector3(-1101.23, 2710.19, 18.11),
		vector3(-1271.85, -1420.68, 3.34),
		vector3(-1256.10, -1443.23, 3.35),
		
	},
	
	Mask = {
		
		vector3(-1336.98, -1279.13, 3.86),
		vector3(-1172.32, -1572.09, 3.66),
		
	},
	
	Helmet = {
		
		vector3(73.45, -1399.99, 28.38),
		vector3(427.52, -799.34, 28.50),
		vector3(-829.39, -1075.38, 10.33),
		vector3(11.45, 6515.92, 30.88),
		vector3(122.37, -222.03, 53.56),
		vector3(1694.90, 4830.01, 41.06),
		vector3(618.09, 2762.58, 41.08),
		vector3(1189.64, 2712.13, 37.22),
		vector3(-1191.26, -771.33, 16.33),
		vector3(-3173.88, 1045.74, 19.86),
		vector3(-1107.91, 2707.40, 18.12),
		vector3(-1125.27, -1643.53, 3.36),
		
	},
	
	Glasses = {
	
		vector3(81.69, -1400.18, 28.38),
		vector3(-713.102, -160.116, 36.535),
		vector3(-156.171, -300.547, 38.853),
		vector3(419.29, -798.96, 28.50),
		vector3(-825.61, -1082.70, 10.33),
		vector3(-1458.052, -236.783, 48.918),
		vector3(5.89, 6521.96, 30.88),
		vector3(127.58, -220.80,	53.56),
		vector3(1686.76, 4829.06, 41.07),
		vector3(613.73, 2759.24, 41.08),
		vector3(1189.61, 2703.95, 37.23),
		vector3(-1196.41, -769.49, 16.32),
		vector3(-3168.43, 1046.75, 19.86),
		vector3(-1102.68, 2701.04, 18.11),
		vector3(-1121.51, -1647.48, 3.66),
		vector3(-1249.45, -1455.10, 3.32),
	
	}

}

--STRINGS--
Config.ItemPurchased = 'You have completed your purchase for $'
Config.GlassesMenu 	= 'Choose Eye Wear'
Config.HelmetMenu   = 'Choose Helmet/Hat'
Config.EarsMenu		= 'Choose Ear Piece'
Config.MaskMenu		= 'Choose Mask'
Config.BagsMenu		= 'Choose Bag'
Config.DeleteMenu	= 'Choose Item To Remove'
Config.NoHelmet		= 'You do NOT have any Helmets/Hats in your Pack'
Config.NoEars		= 'You do NOT have any Ear Pieces in your Pack'
Config.NoMask		= 'You do NOT have any Masks in your Pack'
Config.NoEyes		= 'You do NOT have any Glasses in your Pack'
Config.NoBags		= 'You do NOT have any Bags in your Pack'
Config.RightBag		= 'Make sure you have the proper BAG'
Config.ChooseType 	= 'Choose Accessory Type'
Config.ClosePack	= 'Zip Up Pack'
Config.Helmets		= 'Helmet'
Config.EarPiece		= 'Ears'
Config.Masks		= 'Mask'
Config.Glasses 		= 'Glasses'
Config.BagList		= 'Bags'
Config.CannotBuy	= 'Unfortunately this Item can not be bought here'
Config.ConfirmBuy	= 'Confirm Purchase'
Config.ConfirmDelete= 'Confirm Delete'
Config.Decline		= 'Decline'
Config.Accept		= 'Purchase for $'
Config.Delete		= 'Confirm Item Remove'
Config.NeedCash		= 'You do NOT have enough Cash'
Config.KeyNotif		= 'Press E to buy '
Config.Accessory	= ' accessory'
Config.LockerNotif	= 'Press E to open Locker'
Config.SetText		= 'Set Name Text'
Config.NoNilName	= 'The Name can not be NIL!'
Config.NameLength	= 'The Key Name must be between 1 and 12 characters!'
Config.AtCounter	= 'You must be at a Shop or Locker to get a BAG'
Config.SelectTop	= 'You must choose the actual accessory piece, not the texture'
Config.ReverseHat	= 'Flip Helmet/Reverse Hat'