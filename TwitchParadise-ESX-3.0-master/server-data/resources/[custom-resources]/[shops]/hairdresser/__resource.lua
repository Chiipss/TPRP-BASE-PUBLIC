resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'hairdresser'

version '1.1.0'

server_scripts {
	'@tprp_base/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@tprp_base/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}

dependencies {
	'tprp_base',
	'skin'
}
