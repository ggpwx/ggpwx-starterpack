fx_version 'cerulean'
game 'gta5'

author 'GGWPx'
description 'Advance StarterPack'
version '1.0.0'

-- Client Scripts
client_scripts {
    'client/main.lua',
}

-- Server Scripts
server_scripts {
    '@oxmysql/lib/MySQL.lua', -- Pastikan oxmysql terpasang dan aktif
    'server/main.lua',
}

-- Shared Scripts (config)
shared_scripts {
    'config.lua',
}

-- Dependencies
dependencies {
    'qb-vehiclekeys',
    'oxmysql',
}
