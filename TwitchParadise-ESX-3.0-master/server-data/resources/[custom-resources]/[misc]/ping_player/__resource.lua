resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

name 'Mythic Ping'
description 'Allow Players To Ping Eachother Their Location'
author 'Alzar - https://github.com/Alzar'
version 'v1.0.0'
url 'https://github.com/mythicrp/mythic_ping/'

client_scripts {
    'config.lua',
	'client/main.lua',
}

server_scripts {
	'server/main.lua',
}

dependencies {
	'mythic_notify',
}