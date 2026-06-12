-- ============================================================================
-- GLOBAL ARCADE BLIP ENGINE (Reads all active doors automatically)
-- ============================================================================
CreateThread(function()
    -- Verifies that the pluralized config list exists before trying to run
    if Config.blips then
        for _, blipData in ipairs(Config.blips) do
            local arcadeBlip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
            
            SetBlipSprite(arcadeBlip, blipData.sprite)
            SetBlipDisplay(arcadeBlip, blipData.display)
            SetBlipScale(arcadeBlip, blipData.scale)
            SetBlipColour(arcadeBlip, blipData.color)
            SetBlipAsShortRange(arcadeBlip, true)
            
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(blipData.label)
            EndTextCommandSetBlipName(arcadeBlip)
        end
    end
end)
