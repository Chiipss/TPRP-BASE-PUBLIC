resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Go Postal Job '

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/sv.lua'
}

client_scripts {
	'client/base.lua',
	'client/cl.lua'
}

dependencies {
	'tprp_base'
}
