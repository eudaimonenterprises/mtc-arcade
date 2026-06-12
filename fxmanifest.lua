fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'More Than Code'
description 'Arcade (mtc-arcade) 1.0.0 - Pure Qbox Edition'
version '1.0.0'

-- Forces the server to load these core frameworks before booting the arcade
dependencies {
    'qbx_core',
    'ox_lib',
    'ox_target',
    'ox_inventory'
}

client_scripts {
    'client/*',
}

server_scripts {
    'server/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'locales/en.lua',   -- Cleaned: Removed @qb-core wrapper dependency
    'locales/*.lua',
    'shared/*.lua'
}

files {
    "html/css/*.css",
    "html/css/img/*.png",
    "html/*.html",
    "html/scripts/*.js",
}

ui_page "html/index.html"
