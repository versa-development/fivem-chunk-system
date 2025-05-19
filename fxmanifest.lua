fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Versa Development'
version '0.1'
description 'Dynamic chunk system for FiveM — spawn objects & peds efficiently like Minecraft!'

shared_scripts {
    '@ox_lib/init.lua',
    'config/sh_*.lua',
    'shared/sh_*.lua'
}

client_scripts {
    'client/cl_*.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config/sv_*.lua',
    'server/sv_*.lua'
}

dependencies {
    'ox_lib',
}