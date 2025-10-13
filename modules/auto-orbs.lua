-- ⚡ SMART FAST AUTO-ORBS (NO LAG)
local enabled = false
local conn = nil
local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent

-- OPTIMIZED: SINGLE FIRE FUNCTION
local function fireOrb(orb, place)
    orbRemote:FireServer("collectOrb", orb, place)
end

return function(cmd)
    if cmd == "on" then
        enabled = true
        print("⚡ SMART FAST ORBS ACTIVATED")
        
        if conn then conn:Disconnect() end
        
        -- SMART: ROTATE THROUGH ORBS EACH FRAME (NO SPAM)
        local currentIndex = 1
        local locations = {"City", "Desert", "Space", "Magma"}
        local orbs = {"Red Orb", "Yellow Orb", "Blue Orb", "Green Orb"}
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- ONLY FIRE 1 ORB PER FRAME BUT CYCLE THROUGH THEM
            local orb = orbs[currentIndex]
            for _, location in ipairs(locations) do
                fireOrb(orb, location)
            end
            
            -- CYCLE TO NEXT ORB
            currentIndex = currentIndex + 1
            if currentIndex > #orbs then
                currentIndex = 1
            end
        end)
        
    elseif cmd == "fast" then
        enabled = true
        print("🚀 ULTRA EFFICIENT MODE")
        
        if conn then conn:Disconnect() end
        
        -- EFFICIENT: 4 ORBS PER FRAME (ONE OF EACH COLOR)
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- FIRE ONE OF EACH ORB TYPE PER LOCATION
            fireOrb("Red Orb", "City")
            fireOrb("Yellow Orb", "Desert") 
            fireOrb("Blue Orb", "Space")
            fireOrb("Green Orb", "Magma")
        end)
        
    elseif cmd == "yellow" then
        enabled = true
        print("💛 FOCUSED YELLOW MODE")
        
        if conn then conn:Disconnect() end
        
        -- FOCUSED: ONLY YELLOW BUT ALL LOCATIONS
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            fireOrb("Yellow Orb", "City")
            fireOrb("Yellow Orb", "Desert")
            fireOrb("Yellow Orb", "Space") 
            fireOrb("Yellow Orb", "Magma")
        end)
        
    elseif cmd == "off" then
        enabled = false
        if conn then
            conn:Disconnect()
            conn = nil
        end
        print("🛑 ORBS STOPPED")
    end
end
