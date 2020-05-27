resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Illegal Drugs'

version '1.0.4'

server_scripts {
	'@tprp_base/locale.lua',
	'locales/en.lua',
	'server/esx_illegal_drugs_sv.lua',
	'config.lua'
}

client_scripts {
	'@tprp_base/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/esx_illegal_drugs_cl.lua'
}
