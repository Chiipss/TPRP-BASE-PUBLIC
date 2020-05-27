resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

version '1.0'

description 'Bike Rental Service'


client_scripts {
  '@tprp_base/locale.lua',
  'locales/da.lua',
  'locales/en.lua',
  'locales/fr.lua',
  'config.lua',
  'client/client.lua'
}

server_scripts {
	'@tprp_base/locale.lua',
  'locales/da.lua',
  'locales/en.lua',
  'locales/fr.lua',
	'config.lua',
	'server/server.lua'
}	
