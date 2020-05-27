resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
  'incl.lua',
  'config.lua',
  'utils.lua',
	'client.lua',
}

server_scripts {	
  'incl.lua',
	'config.lua',
  'utils.lua',
	'server.lua',
	'@mysql-async/lib/MySQL.lua',
}

dependencies {
  'Safecracker',
}