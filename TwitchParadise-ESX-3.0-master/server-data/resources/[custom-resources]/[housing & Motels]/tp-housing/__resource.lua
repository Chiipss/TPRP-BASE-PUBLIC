resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	'utils.lua',
	'config.lua',
	'client/main.lua',
	'client/shells.lua',
}

server_scripts {
  	'@mysql-async/lib/MySQL.lua',
	'utils.lua',
	'houses.lua',
	'config.lua',
	'server/main.lua',
	'server/playerhousing.net.dll',
}
 
files {
	'stream/playerhouse_hotel/playerhouse_hotel.ytyp',
	'stream/playerhouse_hotel/playerhouse_hotel.ytyp',
	'stream/playerhouse_tier3/playerhouse_tier3.ytyp',
}

data_file 'DLC_ITYP_REQUEST' 'stream/v_int_20.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_hotel/playerhouse_hotel.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier1/playerhouse_tier1.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/playerhouse_tier3/playerhouse_tier3.ytyp'



exports {
	'imClosesToCloset',
	'DespawnInterior',
	'CreateMotel',
	'CreateTier1House',
	'CreateTier2House',
	'CreateTier3House',

	'CreateTier1HouseFurnished',
}