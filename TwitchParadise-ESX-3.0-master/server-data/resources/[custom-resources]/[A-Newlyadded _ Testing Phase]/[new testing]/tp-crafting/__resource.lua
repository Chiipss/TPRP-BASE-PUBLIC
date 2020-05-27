resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Crafting Table 1.11'

files {
	'html/menu.html',
	'html/css/style.css',
	'html/css/scotty.css',
	'html/js/script.js',
	'html/js/scotty.js',
	'html/js/jquery-3.1.0.min.js',
	-- ICONS 
  'html/images/items/*.png',
}

ui_page {
	'html/menu.html'
}

client_scripts {
  'config.lua',
	'client.lua',
}

server_scripts {
	'config.lua',
	'config_sv.lua',
	'server.lua'
}