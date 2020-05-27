resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'License Shop'

version '1.0.0'

server_scripts {
	'@tprp_base/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@tprp_base/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}
