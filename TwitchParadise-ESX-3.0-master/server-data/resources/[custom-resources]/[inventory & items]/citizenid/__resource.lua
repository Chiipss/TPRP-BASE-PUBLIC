resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "Citizen ID Card"
version "0.1"
author "FragAverage"

client_scripts {
    "@tprp_base/locale.lua",
    "client.lua",
    "en.lua",
    "config.lua"
  }
  
  server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "@tprp_base/locale.lua",
    "server.lua",
    "en.lua",
    "config.lua"
  }

  dependencies {
    "tprp_base"
  }