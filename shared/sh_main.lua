Config = {}

-- REMOVED: QBCore = exports['qb-core']:GetCoreObject()

-- Item that players get when they buy tokens and use to pay for a game.
Config.TokenItem = "gametoken"
Config.TokenPrice = "5"
Config.PaymentType = "cash" -- cash, bank, crypto

-- ============================================================================
--  INTERNAL SERVICE COUNTER (Your Exact Stand Position)
-- ============================================================================
Config.Zones = {
    vector3(2730.35, -383.2, -50.015) -- The interactive spot right at his desk
}

-- ============================================================================
--  THE SINGLE INTERIOR TICKETEER (Jimmy's Permanent Office Workstation)
-- ============================================================================
Config.shops = {
    {
        model = 'ig_jimmydisanto',
        coords = vector4(2730.35, -383.2, -50.015, 320.48), -- Your exact internal coordinates
        scenario = 'WORLD_HUMAN_CLIPBOARD',
        icon = 'fas fa-cart-shopping'
    }
}

-- Plural blips array ready to feed your cl_blip.lua loop
Config.blips = {
    { coords = vector3(-1269.94, -305.26, 36.99), label = "Insert Coin Arcade", sprite = 484, color = 0, scale = 0.7, display = 2 },
    { coords = vector3(1695.75, 4785.15, 42.00),  label = "Wonderama Arcade",    sprite = 484, color = 0, scale = 0.7, display = 2 },
    { coords = vector3(759.10, -816.10, 26.30),   label = "Videogeddon Arcade",   sprite = 484, color = 0, scale = 0.7, display = 2 },
    { coords = vector3(-600.82, 279.41, 82.04),   label = "Eight-Bit Arcade",     sprite = 484, color = 0, scale = 0.7, display = 2 },
    { coords = vector3(-116.39, -1772.22, 29.86), label = "Warehouse Arcade",     sprite = 484, color = 0, scale = 0.7, display = 2 },
    { coords = vector3(-247.50, 6213.11, 31.94),  label = "Pixel Pete's Arcade",  sprite = 484, color = 0, scale = 0.7, display = 2 }
}

Config.games = {
    {
        label = "Pacman",
        args = "http://xogos.robinko.eu/PACMAN/",
        icon = 'ghost'
    },
    {
        label = "Tetris",
        args = "http://xogos.robinko.eu/TETRIS/",
        icon = "cube"
    },
    {
        label = "Uno",
        args = "https://duowfriends.eu/",
        icon = "diamond"
    },
    {
        label = "FlappyParrot",
        args = "http://xogos.robinko.eu/FlappyParrot/",
        icon = "dove"
    },
    {
        label = 'slither',
        args = 'http://slither.io',
        icon = 'staff-snake',
    },
    {
        label = 'Duke Nukem 3D',
        args = string.format("nui://mtc-arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/duke3d.zip", "./DUKE3D.EXE"),
        icon = 'gun'
    },
    {
        label = 'DOOM',
        args = string.format("nui://mtc-arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Doom.zip", "./DOOM.EXE"),
        icon = 'gun'
    },
    {
        label = 'Wolfenstein 3D',
        args = string.format("nui://mtc-arcade/html/msdos.html?url=%s&params=%s", "https://www.retrogames.cz/dos/zip/Wolfenstein3D.zip", "./WOLF3D.EXE"),
        icon = 'gun'
    }
}

Config.hacks = {
    {
        label = "Lockpick",
        icon = 'fa-regular fa-circle',
        action = function()
            exports['ps-ui']:Circle(function(success)
                if success then
                    -- CHANGED: Replaced QBCore notification with pure ox_lib notification export
                    lib.notify({
                        title = 'Lockpick',
                        description = 'You opened the lock',
                        type = 'success'
                    })
                else
                    -- CHANGED: Replaced QBCore notification with pure ox_lib notification export
                    lib.notify({
                        title = 'Lockpick',
                        description = 'You closed the lock',
                        type = 'error'
                    })
                end
            end, 2, 20) -- NumberOfCircles, MS
        end
    },
}
