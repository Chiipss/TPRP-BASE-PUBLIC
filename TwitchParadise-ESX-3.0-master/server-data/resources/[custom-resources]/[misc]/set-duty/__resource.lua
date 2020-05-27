resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Set your duty'

version '1.0.0'

server_scripts {
  '@tprp_base/locale.lua',
  'translation/sv.lua',
  'translation/en.lua',
  'translation/pl.lua',
  'config.lua',
  'server/main.lua',
}

client_scripts {
  '@tprp_base/locale.lua',
  'translation/sv.lua',
  'translation/en.lua',
  'translation/pl.lua',
  'config.lua',
  'client/main.lua',
}