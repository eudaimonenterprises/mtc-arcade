-- ============================================================================
-- PURE QBOX ARCADE ECONOMY ENFORCER
-- ============================================================================

-- 1. Secure token callback validator for cabinet operations
lib.callback.register('qbx-arcade:server:hasToken', function(source)
    local src = source
    
    -- Fetches the standard ox_inventory item count directly (0ms lookup)
    local tokenCount = exports.ox_inventory:GetItemCount(src, Config.TokenItem)
    
    if tokenCount and tokenCount >= 1 then
        -- Secure server-side removal of exactly 1 item
        exports.ox_inventory:RemoveItem(src, Config.TokenItem, 1)
        return true
    else
        return false
    end
end)

-- 2. Pure Qbox Bulk Token Purchase Transaction Engine
RegisterNetEvent('qbx-arcade:server:buyToken', function(amount)
    local src = source
    
    -- Safety validation conversion check to block exploit parameters
    local purchaseAmount = tonumber(amount)
    if not purchaseAmount or purchaseAmount <= 0 then return end
    
    local price = tonumber(Config.TokenPrice) * purchaseAmount

    -- Native Qbox framework player data fetch
    local qbxPlayer = exports.qbx_core:GetPlayer(src)
    if not qbxPlayer then return end

    -- FIXED: Swapped legacy player.Functions out for native Qbox balance subtraction exports
    local success = exports.qbx_core:RemoveMoney(src, Config.PaymentType, price, 'arcade-token-purchase')
    
    if not success then 
        -- Modern ox_lib notification fallback sent directly to the client
        TriggerClientEvent('ox_lib:notify', src, {
            title = 'Token Booth',
            description = "You do not have enough money!",
            type = 'error'
        })
        return 
    end

    -- Secure item drop natively handled by ox_inventory
    exports.ox_inventory:AddItem(src, Config.TokenItem, purchaseAmount)
end)
