resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Society'

version '1.0.4'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@tprp_base/locale.lua',
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
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'tprp_base',
	'cron',
	'accounts'
}
