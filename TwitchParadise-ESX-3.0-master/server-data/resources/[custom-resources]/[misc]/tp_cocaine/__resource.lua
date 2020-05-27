resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

client_scripts {
	'config.lua',
  'utils.lua',
	'client.lua',
}

server_scripts {	
  '@mysql-async/lib/MySQL.lua',
	'config.lua',
  'utils.lua',
	'server.lua',
}

dependencies {
  'progressBars',
}
