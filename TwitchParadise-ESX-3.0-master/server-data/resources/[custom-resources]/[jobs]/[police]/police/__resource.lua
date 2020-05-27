resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Police'

version '1.3.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@tprp_base/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua',
	'server/gsr_s.lua',
	'server/luxveh_s.lua',
	'server/panic_s.lua'
}

client_scripts {
	'@tprp_base/locale.lua',
	'locales/br.lua',
	'locales/de.lua',
	'locales/en.lua',
	'locales/pl.lua',
	'locales/fr.lua',
	'locales/fi.lua',
	'locales/es.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua',
	'client/gsr_c.lua',
	'client/luxveh_c.lua',
	'client/panic_c.lua'
}

ui_page "html/index.html"

files {
	"whitelist.json",
	"html/index.html",
	"html/sounds/panic.mp3",
	"html/sounds/metaldetected.mp3",
}

dependencies {
	'tprp_base',
	'billing'
}