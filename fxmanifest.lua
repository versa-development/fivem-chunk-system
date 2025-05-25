fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'versa-chunk-system'
author 'Versa Development'
version '0.1'
repository 'https://github.com/versa-development/fivem-chunk-system/'
description 'Dynamic chunk system for FiveM — spawn objects & peds efficiently like Minecraft!'

dependencies {
  '/onesync',
  'ox_lib'
}

shared_script '@ox_lib/init.lua'

files {
  'data/config.lua',
  'modules/**/client.lua',
  'modules/**/server.lua',
  'modules/**/shared.lua',
  'utils/*.lua'
}

client_script 'init.lua'
server_script 'init.lua'