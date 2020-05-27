resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'


client_scripts {
  '@tprp_base/locale.lua',
  'locales/en.lua',
  'client/chicken_c.lua',
  'client/cow_c.lua',
  'client/pig_c.lua',
  'client/pizza_c.lua',
  'client/fruitpicking_c.lua',
  'client/forklift_c.lua',
  'client/fishing_c.lua',
  --'client/hunting_c.lua',
  'config.lua'
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@tprp_base/locale.lua',
  'locales/en.lua',
  'server/chicken_s.lua',
  'server/cow_s.lua',
  'server/pig_s.lua',
  'server/pizza_s.lua',
  --'server/hunting_s.lua',
  'server/fruitpicking_s.lua',
  'server/forklift_s.lua',
  'server/fishing_s.lua',
  'config.lua'
}

dependencies {
	'tprp_base'
}

files {
	'data/vehicles.meta',
	'data/carvariations.meta',
	'data/carcols.meta',
	'data/handling.meta',
}

data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'

