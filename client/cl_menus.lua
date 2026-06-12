-- ============================================================================
-- PURE QBOX ARCADE MENU SELECTOR ENGINE (Finalized Interface Loop)
-- ============================================================================

local isPlayingGame = false -- Local memory flag to safely monitor player game state

local function GenerateOptions()
    local options = {}
    for i = 1, #Config.games, 1 do
        options[#options + 1] = {
            label = Config.games[i].label,
            icon = Config.games[i].icon or 'fa-gamepad',
        }
    end
    return options
end

local function GenerateHacks()
    local options = {}
    for i = 1, #Config.hacks, 1 do
        options[#options + 1] = {
            label = Config.hacks[i].label,
            icon = Config.hacks[i].icon or 'fa-gamepad',
        }
    end
    return options
end

CreateThread(function()
    -- 1. Cabinet Selection Menu Configuration
    lib.registerMenu({
        id = 'arcade_machine',
        title = 'Retro Arcade Cabinets',
        position = 'top-right',
        options = GenerateOptions(),
    }, function(selected, scrollIndex, args)
        -- FIXED: Instantly closes the ox_lib list menu so it releases control inputs!
        lib.hideMenu()

        -- Freezes the character ped so they don't slide away while playing
        local playerPed = cache.ped or PlayerPedId()
        FreezeEntityPosition(playerPed, true)

        -- Pass your game url parameters straight to your browser UI engine
        SendNUIMessage({
            type = "on",
            game = Config.games[selected].args,
            gpu = "ETX2080",
            cpu = "U9_9900"
        })
        
        -- Give the player keyboard and mouse focus to look at the screen container
        SetNuiFocus(true, true)
        isPlayingGame = true -- Activates our emergency escape monitor loop below
    end)

    -- 2. Arcade Hacking Menu Setup
    lib.registerMenu({
        id = 'arcade_hacking',
        title = 'Hardware Security Overrides',
        position = 'top-right',
        options = GenerateHacks(),
    }, function(selected, scrollIndex, args)
        Config.hacks[selected].action()
    end)

    -- 3. Token Vendor Shop (Fixed Input Dialog Prompt Configuration)
    lib.registerContext({
        id = 'arcade_purchase_token',
        title = 'Token Purchasing Booth',
        options = {{
            title = 'Select Token Purchase Quantity',
            description = 'Price: $' .. Config.TokenPrice .. ' Cash per Token',
            icon = 'fa-shopping-cart',
            onSelect = function()
                local amount = lib.inputDialog('Token Dispenser', {
                    {
                        label = 'Enter Token Amount',
                        type = 'number',
                        min = 1,
                        required = true,
                    }
                })
                
                if amount and amount[1] then
                    TriggerServerEvent('qbx-arcade:server:buyToken', amount[1])
                end
            end
        }}
    })
end)

-- ============================================================================
-- FIXED: EMERGENCY BACKSPACE / ESCAPE KEY UNSTICK THREAD
-- ============================================================================
-- Keeps resmon at 0.00ms until a game boots, then actively watches for exit keys
CreateThread(function()
    while true do
        if isPlayingGame then
            -- Listens for Backspace (Control ID 202) or Escape (Control ID 200) release triggers
            if IsControlJustReleased(0, 202) or IsControlJustReleased(0, 200) then
                local playerPed = cache.ped or PlayerPedId()
                
                SetNuiFocus(false, false)        -- Strips input lock from screen
                FreezeEntityPosition(playerPed, false) -- Unfreezes your feet instantly
                SendNUIMessage({ type = "off" }) -- Shuts down the HTML panel layout
                
                isPlayingGame = false            -- Disarms key listener cycle safely
            end
            Wait(0) -- Zero lag reaction execution path while actively playing a title
        else
            Wait(500) -- Fully sleeps the thread cycle when you are walking the floor
        end
    end
end)

-- ============================================================================
-- FIXED: NUI INTERFACE EXIT BACKEND TRIGGER
-- ============================================================================
-- When players hit escape or exit the game layout, this unfreezes their player
RegisterNUICallback('close', function(data, cb)
    local playerPed = cache.ped or PlayerPedId()
    
    -- 1. Strip keyboard and mouse focus from the screen container
    SetNuiFocus(false, false)
    
    -- 2. Safely unfreeze your character so you can walk away from the cabinet
    FreezeEntityPosition(playerPed, false)
    
    -- 3. Turn off the hidden browser screen completely
    SendNUIMessage({
        type = "off"
    })
    
    isPlayingGame = false -- Synchronizes the emergency listener flag state
    cb('ok')
end)
