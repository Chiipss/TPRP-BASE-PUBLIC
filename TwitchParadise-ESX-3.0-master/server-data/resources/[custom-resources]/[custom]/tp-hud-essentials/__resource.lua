resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'



client_script {		
   "config.lua",								
   'client/MinimapValues.lua',
   'client/RadarWhileDriving.lua',
   --'client/real-veh-fail_c.lua',
   --'client/toggleid.lua',
   'client/noretical.lua',
   
   

}

server_script {			
    "config.lua",							
	'server/UpdateCheck.lua',
	--'server/real-veh-fail_s.lua',

	
}

data_file 'HANDLING_FILE' 'handling.meta'

files {
	'client/handling.meta'
}