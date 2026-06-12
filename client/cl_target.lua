-- ============================================================================
-- PURE QBOX CABINET & HACKING TARGET MATRIX (Unified Definition Model)
-- ============================================================================

local arcadeCabinets = {
    -- 1. Standard Prop Strings (Guarantees modern FiveM mapping compatibility)
    'prop_arcade_01',
    'ch_prop_arcade_invade_01a', 
    'ch_prop_arcade_gun_01a',
    'ch_prop_arcade_wizard_01a',
    'ch_prop_arcade_monkey_01a',
    'ch_prop_arcade_space_01a',
    'ch_prop_arcade_street_01a',
    'ch_prop_arcade_street_01b',
    'ch_prop_arcade_street_01c',
    'ch_prop_arcade_street_01d',
    'ch_prop_arcade_street_02b',
    'ch_prop_arcade_race_01a',
    'ch_prop_arcade_race_02a',
    'ch_prop_arcade_race_01b',
    'ch_prop_arcade_penetrator_01a',
    'ch_prop_arcade_degenatron_01a',
    'sum_prop_arcade_qub3d_01a'
}

-- Unified item verification using ox_lib modern notification framework
local function requireToken()
    if not lib.callback.await('qbx-arcade:server:hasToken') then
        TriggerEvent('ox_lib:notify', {
            title = 'Arcade Cabinet',
            description = 'You need a Game Token to use this.',
            type = 'error'
        })
        return false
    end
    return true
end

CreateThread(function()
    -- Native ox_target format utilizing the unified cabinet model list
    exports.ox_target:addModel(arcadeCabinets, {
        {
            name = 'arcade_machine_play',
            icon = 'fas fa-gamepad',
            label = 'Play Arcade Game', 
            distance = 1.5,
            -- MINOR PATCH: Tells ox_target to pierce static map geometry files natively
            canInteract = function(entity, distance, coords, name, bone)
                return true
            end,
            onSelect = function()
                if not requireToken() then return end
                lib.showMenu('arcade_machine')
            end
        },
        {
            name = 'arcade_machine_hack',
            icon = 'fas fa-circle-dot',
            label = 'Hardware Security Override', 
            distance = 1.5,
            -- MINOR PATCH: Tells ox_target to pierce static map geometry files natively
            canInteract = function(entity, distance, coords, name, bone)
                return true
            end,
            onSelect = function()
                if not requireToken() then return end
                lib.showMenu('arcade_hacking')
            end
        }
    })
end)

-- ============================================================================
-- GLOBAL NOVELTY ALIGNMENTS (Pure Model Tracking - 100% Coordinate Free)
-- ============================================================================
CreateThread(function()
    local madameFortunes = {
        "I see a dark suitcase in your future... filled with unmarked bills.",
        "Your luck is rising, but watch your mirrors on the highway.",
        "The cards reveal a grand heist... or a very long prison sentence.",
        "Do not trust the man who promises a high payout today."
    }

    -- 1. Madame Nazar Model Target Registration (Natively fires globally by model name)
    exports.ox_target:addModel('ch_prop_arcade_fortune_01a', { 
        {
            name = 'arcade_madame_nazar_fortune',
            icon = 'fas fa-crystal-ball',
            label = 'Tell My Fortune',
            distance = 1.5,
            canInteract = function(entity, distance, coords, name, bone) return true end,
            onSelect = function()
                if not requireToken() then return end
                local fortune = madameFortunes[math.random(1, #madameFortunes)]
                lib.notify({ title = 'Madame Nazar', description = fortune, type = 'inform' })
            end
        }
    })

    -- 2. The Love Professor Model Target Registration (Natively fires globally by model name)
    exports.ox_target:addModel('ch_prop_arcade_love_01a', { 
        {
            name = 'arcade_love_professor_score',
            icon = 'fas fa-heart',
            label = 'Consult the Love Professor',
            distance = 1.5,
            canInteract = function(entity, distance, coords, name, bone) return true end,
            onSelect = function()
                if not requireToken() then return end
                
                local names = lib.inputDialog('The Love Professor', {
                    { label = 'Your Name', type = 'input', required = true },
                    { label = 'Crush\'s Name', type = 'input', required = true }
                })
                
                if names and names[1] and names[2] then
                    local yourName  = string.lower(names[1])
                    local crushName = string.lower(names[2])
                    
                    -- Symmetrical and collision-safe charSum math loop
                    local mySum = 0
                    for i = 1, #yourName do mySum = mySum + string.byte(yourName, i) end
                    
                    local crushSum = 0
                    for i = 1, #crushName do crushSum = crushSum + string.byte(crushName, i) end
                    
                    local combinedProduct = mySum * crushSum
                    local finalSeed = combinedProduct % 65535
                    
                    math.randomseed(finalSeed)
                    local score = math.random(1, 100)
                    
                    lib.notify({
                        title = 'The Love Professor',
                        description = string.format("Compatibility between %s & %s: %d%%!", names[1], names[2], score),
                        type = score > 50 and 'success' or 'error'
                    })
                end
            end
        }
    })
end)

