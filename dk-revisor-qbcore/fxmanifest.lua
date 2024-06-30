fx_version 'cerulean'
game 'gta5'
lua54 "yes"

author 'DalleFar - Pelifix'
description 'Accountantjob for Qbcore made by Dallefar and Pelifix'
version '1.0.0'

shared_scripts {
	'@ox_lib/init.lua',
  'config.lua'
}

client_scripts { 
  "client.lua"
}
  
server_scripts { 
  "server.lua"
}

escrow_ignore {
  "config.lua"
}