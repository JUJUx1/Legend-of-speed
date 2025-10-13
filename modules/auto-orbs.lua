-- ⚡ LIGHTNING FAST AUTO-ORBS (ZERO LAG)
local enabled = false
local conn = nil

local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent
local places = {"City", "Desert", "Space", "Magma"}
local allOrbs = {"Red Orb", "Yellow Orb", "Blue Orb", "Green Orb"}

-- PRE-CACHE EVERYTHING FOR MAXIMUM SPEED
local fireServer = orbRemote.FireServer
local heartbeat = game:GetService("RunService").Heartbeat

return function(cmd)
    if cmd == "on" then
        enabled = true
        print("⚡ LIGHTNING ORBS ACTIVATED")
        
        if conn then conn:Disconnect() end
        
        conn = heartbeat:Connect(function()
            if not enabled then return end
            
            -- NO WAITS, JUST RAPID FIRE ALL ORBS
            for _, place in ipairs(places) do
                for _, orb in ipairs(allOrbs) do
                    fireServer(orbRemote, "collectOrb", orb, place)
                end
            end
        end)
        
    elseif cmd == "yellow" then
        enabled = true
        print("💛 YELLOW LIGHTNING MODE")
        
        if conn then conn:Disconnect() end
        
        conn = heartbeat:Connect(function()
            if not enabled then return end
            
            -- MAXIMUM YELLOW ORB SPAM
            for _, place in ipairs(places) do
                fireServer(orbRemote, "collectOrb", "Yellow Orb", place)
            end
        end)
        
    elseif cmd == "turbo" then
        enabled = true
        print("🚀 TURBO ORB MODE ACTIVATED")
        
        if conn then conn:Disconnect() end
        
        -- ULTRA FAST - NO LOOPS, JUST DIRECT SPAM
        conn = heartbeat:Connect(function()
            if not enabled then return end
            
            -- DIRECT METHOD CALLS - FASTEST POSSIBLE
            fireServer(orbRemote, "collectOrb", "Red Orb", "City")
            fireServer(orbRemote, "collectOrb", "Yellow Orb", "City")
            fireServer(orbRemote, "collectOrb", "Blue Orb", "City")
            fireServer(orbRemote, "collectOrb", "Green Orb", "City")
            
            fireServer(orbRemote, "collectOrb", "Red Orb", "Desert")
            fireServer(orbRemote, "collectOrb", "Yellow Orb", "Desert")
            fireServer(orbRemote, "collectOrb", "Blue Orb", "Desert")
            fireServer(orbRemote, "collectOrb", "Green Orb", "Desert")
            
            fireServer(orbRemote, "collectOrb", "Red Orb", "Space")
            fireServer(orbRemote, "collectOrb", "Yellow Orb", "Space")
            fireServer(orbRemote, "collectOrb", "Blue Orb", "Space")
            fireServer(orbRemote, "collectOrb", "Green Orb", "Space")
            
            fireServer(orbRemote, "collectOrb", "Red Orb", "Magma")
            fireServer(orbRemote, "collectOrb", "Yellow Orb", "Magma")
            fireServer(orbRemote, "collectOrb", "Blue Orb", "Magma")
            fireServer(orbRemote, "collectOrb", "Green Orb", "Magma")
        end)
        
    elseif cmd == "off" then
        enabled = false
        if conn then
            conn:Disconnect()
            conn = nil
        end
        print("🛑 AUTO-ORBS STOPPED")
    end
end
