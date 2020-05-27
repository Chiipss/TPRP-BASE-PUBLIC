-- James

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

description "Frag's Finance Menu"

version "V0.1"

client_scripts {
	"config.lua",
	"client/cl_functions.lua",
	"client/cl_main.lua"
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	"config.lua",
	"server/s_main.lua",
	"server/s_functions.lua",
}