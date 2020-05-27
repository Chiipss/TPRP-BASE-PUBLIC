resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'TPRP Contract'

version '1.0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@tprp_base/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@tprp_base/locale.lua',
	'locales/de.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua'
}