resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Inventory-Sorter'

version '1.1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/classes/addoninventory.lua',
	'server/main.lua'
}

dependency 'tprp_base'