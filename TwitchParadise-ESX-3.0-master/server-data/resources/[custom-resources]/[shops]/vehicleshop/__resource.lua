resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Vehicle Shop'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@tprp_base/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@tprp_base/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}

dependency 'tprp_base'

export 'GeneratePlate'