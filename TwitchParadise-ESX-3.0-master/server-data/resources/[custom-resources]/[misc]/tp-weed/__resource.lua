resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

dependencies {'tprp_base','mysql-async'}

shared_scripts {
    '@tprp_base/locale.lua',
    'locales/*.lua',
    'config.lua',
    'lib/octree.lua',
    'lib/growth.lua',
    'lib/cropstate.lua',
}
client_scripts {
    'lib/debug.lua',
    'cl_uteknark.lua',
}
server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'sv_uteknark.lua',
}
