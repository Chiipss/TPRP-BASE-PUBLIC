description 'Skin'

version '1.0.1'

server_scripts {
  '@tprp_base/locale.lua',
  'config.lua',
  'locales/de.lua',
  'locales/br.lua',
  'locales/en.lua',
  'locales/fr.lua',
  '@mysql-async/lib/MySQL.lua',
  'server/main.lua',
}

client_scripts {
  '@tprp_base/locale.lua',
  'config.lua',
  'locales/de.lua',
  'locales/br.lua',
  'locales/en.lua',
  'locales/fr.lua',
  'client/main.lua',
}
