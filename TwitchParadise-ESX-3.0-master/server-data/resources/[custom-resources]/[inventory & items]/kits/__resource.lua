resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'kits'
version '1.0.0'

client_scripts {
	'client/advrepairkit_c.lua',
	'client/dentpuller_c.lua',
	'client/repairkit_c.lua',
	'client/tyrekit_c.lua',
	'client/clamp_c.lua',
	'client/clampkey_c.lua',
	'client/scubba_c.lua',
	'config.lua'
}

server_scripts {
	'server/advrepairkit_s.lua',
	'server/dentpuller_s.lua',
	'server/repairkit_s.lua',
	'server/tyrekit_s.lua',
	'server/clamp_s.lua',
	'server/clampkey_s.lua',
	'server/scubba_s.lua',
	'config.lua'
}