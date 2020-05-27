Config = {}

Config.Locale = 'en'

-- Set the time (in minutes) during the player is outlaw
Config.Timer = 1

-- Set if show alert when player use gun
Config.GunshotAlert = true

-- Set if show when player do carjacking
Config.CarJackingAlert = true

-- Set if show when player fight in melee
Config.MeleeAlert = false

-- In seconds
Config.BlipGunTime = 40

-- Blip radius, in float value!
Config.BlipGunRadius = 100.00

-- In seconds
Config.BlipMeleeTime = 7

-- Blip radius, in float value!
Config.BlipMeleeRadius = 100.00

-- In seconds
Config.BlipJackingTime = 40

-- Blip radius, in float value!
Config.BlipJackingRadius = 100.00

-- Show notification when cops steal too?
Config.ShowCopsMisbehave = false

-- Jobs in this table are considered as cops
Config.WhitelistedCops = {
	'police'
}