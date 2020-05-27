resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    'client/main.lua',
    'utils.lua',
    'config.lua',
    'client/markers.lua'
}

server_scripts {
    'utils.lua',
    'config.lua',
    'server/items.lua',
    'server/main.lua',
    'server/cron.lua',
    '@mysql-async/lib/MySQL.lua',
}
