description 'Store`s System'
version 'a0.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua',
}

ui_page('html/index.html')

files({
  'html/index.html',
  'html/js/app.js',
  'html/css/styles.css',
  'html/fonts/typewriter.ttf',
})

client_scripts {
	'client/main.lua',
	'client/mine.lua',
	'client/wood.lua',
	'client/food.lua',
	'client/water.lua',
	'client/trucker.lua'
}