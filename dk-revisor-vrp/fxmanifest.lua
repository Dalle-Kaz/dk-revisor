fx_version 'cerulean'
game 'gta5'
lua54 "yes"

author 'DalleFar'
description 'Meget simpel Revisor job til vrp.'
version '1.0.0'

shared_scripts {
	'@ox_lib/init.lua',
  'config.lua'
}

client_scripts{ 
  "client/main.lua"
}
  
server_scripts{ 
  "@vrp/lib/utils.lua", 
  "server/main.lua"
}