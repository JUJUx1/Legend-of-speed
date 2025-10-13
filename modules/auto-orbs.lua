-- 🚀 MAXIMUM SPEED AUTO-ORBS
local enabled = false
local conn = nil
local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent

return function(cmd)
    if cmd == "on" then
        enabled = true
        print("🚀 MAXIMUM SPEED ORBS ACTIVATED")
        
        if conn then conn:Disconnect() end
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- ABSOLUTE MAXIMUM SPAM - NO DELAYS, NO SAFETY
            for i = 1, 50 do  -- SPAM 50 TIMES PER FRAME
                orbRemote:FireServer("collectOrb", "Red Orb", "City")
                orbRemote:FireServer("collectOrb", "Yellow Orb", "City") 
                orbRemote:FireServer("collectOrb", "Blue Orb", "City")
                orbRemote:FireServer("collectOrb", "Green Orb", "City")
                orbRemote:FireServer("collectOrb", "Red Orb", "Desert")
                orbRemote:FireServer("collectOrb", "Yellow Orb", "Desert")
                orbRemote:FireServer("collectOrb", "Blue Orb", "Desert")
                orbRemote:FireServer("collectOrb", "Green Orb", "Desert")
                orbRemote:FireServer("collectOrb", "Red Orb", "Space")
                orbRemote:FireServer("collectOrb", "Yellow Orb", "Space")
                orbRemote:FireServer("collectOrb", "Blue Orb", "Space")
                orbRemote:FireServer("collectOrb", "Green Orb", "Space")
                orbRemote:FireServer("collectOrb", "Red Orb", "Magma")
                orbRemote:FireServer("collectOrb", "Yellow Orb", "Magma")
                orbRemote:FireServer("collectOrb", "Blue Orb", "Magma")
                orbRemote:FireServer("collectOrb", "Green Orb", "Magma")
            end
        end)
        
    elseif cmd == "yellow" then
        enabled = true
        print("💛 MAXIMUM YELLOW SPAM")
        
        if conn then conn:Disconnect() end
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- YELLOW ORB SPAM x100
            for i = 1, 100 do
                orbRemote:FireServer("collectOrb", "Yellow Orb", "City")
                orbRemote:FireServer("collectOrb", "Yellow Orb", "Desert")
                orbRemote:FireServer("collectOrb", "Yellow Orb", "Space")
                orbRemote:FireServer("collectOrb", "Yellow Orb", "Magma")
            end
        end)
        
    elseif cmd == "nuke" then
        enabled = true
        print("💥 ORB NUKE MODE ACTIVATED")
        
        if conn then conn:Disconnect() end
        
        -- NUCLEAR OPTION - SPAM EVERY POSSIBLE COMBINATION
        local allLocations = {"City", "Desert", "Space", "Magma", "Forest", "Winter", "Beach", "Sky"}
        local allOrbTypes = {"Red Orb", "Yellow Orb", "Blue Orb", "Green Orb", "White Orb", "Black Orb", "Rainbow Orb", "Diamond Orb"}
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- SPAM EVERY COMBINATION x20
            for i = 1, 20 do
                for _, location in ipairs(allLocations) do
                    for _, orb in ipairs(allOrbTypes) do
                        orbRemote:FireServer("collectOrb", orb, location)
                    end
                end
            end
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
