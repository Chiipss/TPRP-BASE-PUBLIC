resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Scoreboard'

version '1.0.0'

server_scripts {
	'server/main.lua',
	 '@mysql-async/lib/MySQL.lua'
}

client_scripts {
	'client/main.lua',
}

ui_page 'html/scoreboard.html'

files {
	'html/scoreboard.html',
	'html/style.css',
	'html/listener.js',
	'html/tp.png'
}