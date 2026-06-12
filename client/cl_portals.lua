-- ============================================================================
-- GLOBAL UNLOCKED DOOR PORTALS (Memory-Safe Instance Routing Engine)
-- ============================================================================

local internalArcadeShell = vec3(2730.0, -380.0, -50.0) 
local internalArcadeExit  = vec3(2737.83, -373.89, -47.99)

-- Stored locally inside this specific player's client memory slot
local playerOriginLocation = nil 

-- All 6 verified street entrances open for business globally
local streetEntrances = {
    { name = "Insert Coin Arcade (Rockford Autos)", coords = vec3(-1269.94, -305.26, 36.99) },
    { name = "Wonderama Arcade (Grapeseed)",        coords = vec3(1695.75, 4785.15, 42.00) },
    { name = "Videogeddon Arcade (La Mesa)",        coords = vec3(759.10, -816.10, 26.30) },
    { name = "Eight-Bit Arcade (Rockford Comm.)",   coords = vec3(-600.82, 279.41, 82.04) },
    { name = "Warehouse Arcade (Davis Underpass)",  coords = vec3(-116.39, -1772.22, 29.86) },
    { name = "Pixel Pete's Arcade (Paleto Highway)",coords = vec3(-247.50, 6213.11, 31.94) }
}

-- Smooth screen fade and entity orientation handler
local function doorTransition(targetCoords, heading)
    DoScreenFadeOut(400)
    while not IsScreenFadedOut() do Wait(10) end
    
    local ped = PlayerPedId()
    SetEntityCoords(ped, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, true)
    if heading then SetEntityHeading(ped, heading) end
    Wait(400)
    
    DoScreenFadeIn(400)
end

-- Generate all 6 outside door interaction zones
CreateThread(function()
    for _, entrance in ipairs(streetEntrances) do
        lib.points.new({
            coords = entrance.coords,
            distance = 1.5,
            nearby = function(self)
                lib.showTextUI('[E] Enter ' .. entrance.name, { position = 'left-center' })
                
                if IsControlJustReleased(0, 38) then -- 'E' Key
                    lib.hideTextUI()
                    
                    -- Saves the coordinate point strictly to this player's session memory
                    playerOriginLocation = entrance.coords 
                    
                    doorTransition(internalArcadeShell, 174.5)
                end
            end,
            onExit = function()
                lib.hideTextUI()
            end
        })
    end
end)

-- The single inside exit door point (Monitors your glass doors exit spot)
CreateThread(function()
    lib.points.new({
        coords = internalArcadeExit,
        distance = 2.0,
        nearby = function(self)
            lib.showTextUI('[E] Exit Arcade to Street', { position = 'left-center' })
            
            if IsControlJustReleased(0, 38) then -- 'E' Key
                lib.hideTextUI()
                
                -- Grab the destination or fallback to Rockford Autos if data is missing
                local destination = playerOriginLocation or vec3(-1269.94, -305.26, 36.99)
                
                doorTransition(destination)
                
                -- FLASH FLUSH: Erases the location completely out of memory upon exiting
                playerOriginLocation = nil 
            end
        end,
        onExit = function()
            lib.hideTextUI()
        end
    })
end)
