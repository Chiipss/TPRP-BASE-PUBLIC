-- resource manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- dependency
dependency 'essentialmode'

-- client scripts
client_scripts {
	'client/emotes-chair.lua',
	'client/hideintrunk.lua',
    'client/push_client.lua', 
    'client/pause_menu.lua',
    'client/pointing.lua',
    --'client/watermark.lua',
    'client/NoAirControl.lua',
    'client/heli_client.lua',
    'client/newcarhud.lua',
    'client/discord_presence.lua',
    'client/seat_shuffle.lua',
    'client/RemoveAIServices.lua',
    'client/wheelLock.lua',
    'client/carpos-c.lua',


    'client/hoodandtrunk.lua',
    'client/fistfight.lua',
    'client/crouch_prone.lua',
    'client/blips.lua',
    'client/policeweapdraw.lua',
    'client/enginetoggle.lua',
    'client/hotwire_c.lua',
    'client/infcommand_c.lua',
    'client/ragdoll.lua',
    'client/gunfrombum.lua',
    'config.lua',
    
    

}

-- server scripts
server_scripts {
	'config.lua',
    'server/carpos-s.lua',
    'server/heli_server.lua',
    'server/infcommand_s.lua', 
    'server/anti_s.lua',
    'server/autobills_s.lua',
    '@mysql-async/lib/MySQL.lua',

    'server/hotwire_s.lua',
}