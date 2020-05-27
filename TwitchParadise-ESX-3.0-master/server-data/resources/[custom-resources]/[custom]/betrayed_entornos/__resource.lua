resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
  'Vector3.lua',
  'utils.lua',
  'incl.lua',
  'config.lua',
	'client.lua',
}

server_scripts {	
  '@mysql-async/lib/MySQL.lua',
  'Vector3.lua',
  'utils.lua',
  'incl.lua',
	'config.lua',
	'server.lua',
}