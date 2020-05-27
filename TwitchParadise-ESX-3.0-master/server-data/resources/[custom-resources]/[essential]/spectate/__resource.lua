resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Frags Spectate Script'

client_scripts {
    'client.lua',
    '@mysql-async/lib/MySQL.lua'
}

server_scripts {
    'server.lua',
    '@mysql-async/lib/MySQL.lua'
}

dependencies {
    "tprp_base"
  }