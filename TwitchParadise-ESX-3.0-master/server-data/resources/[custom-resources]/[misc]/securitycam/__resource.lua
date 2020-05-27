resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Security Cam'

version '1.2.0'

server_scripts {
	'@tprp_base/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@tprp_base/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua'
}

ui_page 'ui/index.html'

files {
	'ui/index.html',
	'ui/vue.min.js',
	'ui/script.js'
}
