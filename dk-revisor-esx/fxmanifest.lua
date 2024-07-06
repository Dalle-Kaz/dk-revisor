fx_version 'cerulean'
game 'gta5'
lua54 "yes"

author 'DalleFar'
description 'Meget simpel Revisor job til esx.'
version '1.0.0'

shared_scripts {
	'@ox_lib/init.lua',
  '@es_extended/imports.lua',
  'config.lua'
}

client_scripts{ 
  "client/main.lua"
}
  
server_scripts{ 
  "@vrp/lib/utils.lua", 
  "server/main.lua"
}