local pedEntities = {}

-- ============================================================================
-- FIXED INTERIOR TICKETEER ENGINE (Bypassed Locale Layer to Prevent Boot Crash)
-- ============================================================================

-- 1. Self-Contained Text Prompt & Keybind Point Loop
CreateThread(function()
    for _, v in ipairs(Config.Zones) do
        lib.points.new({
            coords = v,
            distance = 3.0, 

            onEnter = function()
                -- FIXED: Hardcoded clean plain-text string directly to guarantee boot execution
                lib.showTextUI('[E] Purchase Game Token', {
                    position = "left-center",
                    icon = 'e'
                })
            end,

            onExit = function()
                lib.hideTextUI()
            end,

            nearby = function(self)
                if IsControlJustReleased(0, 38) then -- 'E' Key
                    lib.hideTextUI()
                    lib.showContext('arcade_purchase_token')
                end
            end
        })
    end
end)

-- 2. NPC Generation & Third-Eye Attachment Loop
CreateThread(function()
    for i, v in ipairs(Config.shops) do
        lib.points.new({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z),
            distance = 25.0,

            onEnter = function()
                local model = joaat(v.model)
                lib.requestModel(model)
                
                local ped = CreatePed(4, model, v.coords.x, v.coords.y, v.coords.z, false, false, false)
                SetEntityHeading(ped, v.coords.w)
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                SetPedDiesWhenInjured(ped, false)
                SetPedCanPlayAmbientAnims(ped, true)

                if v.scenario then
                    TaskStartScenarioInPlace(ped, v.scenario, 0, true)
                end
                pedEntities[i] = ped

                -- FIXED: Hardcoded plain-text label string directly into ox_target export
                exports.ox_target:addLocalEntity(ped, {
                    {
                        name = 'arcade_token_ped_' .. i,
                        icon = v.icon or 'fas fa-cart-shopping',
                        label = 'Purchase Game Tokens',
                        distance = 2.0,
                        onSelect = function()
                            lib.showContext('arcade_purchase_token')
                        end
                    }
                })
            end,

            onExit = function()
                if DoesEntityExist(pedEntities[i]) then
                    exports.ox_target:removeLocalEntity(pedEntities[i], 'arcade_token_ped_' .. i)
                    DeleteEntity(pedEntities[i])
                end
            end,
        })
    end
end)
