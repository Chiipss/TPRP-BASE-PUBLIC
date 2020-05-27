Config = {}

Config.Locale = 'en'

Config.EnablePrice = true
Config.Price = 500

Config.FixCarDamage = false -- Should this repair the cars body aswell? (DO NOT SET THIS TO TRUE IF Config.RealisticVehicleFailure IS TRUE!!!!!)

Config.RealisticVehicleFailure = false -- Set to true if you are using RealisticCarFailure
Config.SetEngineHealthOnRepair = 700.0 -- Change this to your required value as your damage system may differ to mine (Lower = doesnt repair as much)
Config.SetVehiclePetrolTankHealthOnRepair = 700.0 -- Change this to your required value as your damage system may differ to mine (Lower = doesnt repair as much)


-- Add more loactions here

Config.Locations = {
	vector3(-212.447, -1325.749, 29.840) 
}