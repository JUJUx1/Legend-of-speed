-- 🚀 RAW MAXIMUM SPEED ORBS
local enabled = false
local conn = nil
local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent
local fire = orbRemote.FireServer

return function(cmd)
    if cmd == "on" then
        enabled = true
        print("🚀 RAW SPEED ORBS ACTIVATED")
        
        if conn then conn:Disconnect() end
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- RAW DIRECT CALLS - MAXIMUM POSSIBLE
            fire(orbRemote, "collectOrb", "Red Orb", "City")
            fire(orbRemote, "collectOrb", "Yellow Orb", "City")
            fire(orbRemote, "collectOrb", "Blue Orb", "City")
            fire(orbRemote, "collectOrb", "Green Orb", "City")
            fire(orbRemote, "collectOrb", "Red Orb", "Desert")
            fire(orbRemote, "collectOrb", "Yellow Orb", "Desert")
            fire(orbRemote, "collectOrb", "Blue Orb", "Desert")
            fire(orbRemote, "collectOrb", "Green Orb", "Desert")
            fire(orbRemote, "collectOrb", "Red Orb", "Space")
            fire(orbRemote, "collectOrb", "Yellow Orb", "Space")
            fire(orbRemote, "collectOrb", "Blue Orb", "Space")
            fire(orbRemote, "collectOrb", "Green Orb", "Space")
            fire(orbRemote, "collectOrb", "Red Orb", "Magma")
            fire(orbRemote, "collectOrb", "Yellow Orb", "Magma")
            fire(orbRemote, "collectOrb", "Blue Orb", "Magma")
            fire(orbRemote, "collectOrb", "Green Orb", "Magma")
        end)
        
    elseif cmd == "ultra" then
        enabled = true
        print("💥 ULTRA RAW SPEED")
        
        if conn then conn:Disconnect() end
        
        -- USE RENDERSTEP FOR MAXIMUM FRAME RATE
        conn = game:GetService("RunService").RenderStepped:Connect(function()
            if not enabled then return end
            
            -- MAXIMUM CALLS PER RENDER FRAME
            for i = 1, 3 do  -- 3 FULL CYCLES PER FRAME
                fire(orbRemote, "collectOrb", "Red Orb", "City")
                fire(orbRemote, "collectOrb", "Yellow Orb", "City")
                fire(orbRemote, "collectOrb", "Blue Orb", "City")
                fire(orbRemote, "collectOrb", "Green Orb", "City")
                fire(orbRemote, "collectOrb", "Red Orb", "Desert")
                fire(orbRemote, "collectOrb", "Yellow Orb", "Desert")
                fire(orbRemote, "collectOrb", "Blue Orb", "Desert")
                fire(orbRemote, "collectOrb", "Green Orb", "Desert")
                fire(orbRemote, "collectOrb", "Red Orb", "Space")
                fire(orbRemote, "collectOrb", "Yellow Orb", "Space")
                fire(orbRemote, "collectOrb", "Blue Orb", "Space")
                fire(orbRemote, "collectOrb", "Green Orb", "Space")
                fire(orbRemote, "collectOrb", "Red Orb", "Magma")
                fire(orbRemote, "collectOrb", "Yellow Orb", "Magma")
                fire(orbRemote, "collectOrb", "Blue Orb", "Magma")
                fire(orbRemote, "collectOrb", "Green Orb", "Magma")
            end
        end)
        
    elseif cmd == "nuclear" then
        enabled = true
        print("☢️ NUCLEAR SPEED MODE")
        
        if conn then conn:Disconnect() end
        
        -- MULTIPLE CONNECTIONS FOR MAXIMUM THROUGHPUT
        local conn1 = game:GetService("RunService").Heartbeat:Connect(function()
            fire(orbRemote, "collectOrb", "Red Orb", "City")
            fire(orbRemote, "collectOrb", "Yellow Orb", "City")
            fire(orbRemote, "collectOrb", "Blue Orb", "City")
            fire(orbRemote, "collectOrb", "Green Orb", "City")
        end)
        
        local conn2 = game:GetService("RunService").Heartbeat:Connect(function()
            fire(orbRemote, "collectOrb", "Red Orb", "Desert")
            fire(orbRemote, "collectOrb", "Yellow Orb", "Desert")
            fire(orbRemote, "collectOrb", "Blue Orb", "Desert")
            fire(orbRemote, "collectOrb", "Green Orb", "Desert")
        end)
        
        local conn3 = game:GetService("RunService").RenderStepped:Connect(function()
            fire(orbRemote, "collectOrb", "Red Orb", "Space")
            fire(orbRemote, "collectOrb", "Yellow Orb", "Space")
            fire(orbRemote, "collectOrb", "Blue Orb", "Space")
            fire(orbRemote, "collectOrb", "Green Orb", "Space")
        end)
        
        local conn4 = game:GetService("RunService").RenderStepped:Connect(function()
            fire(orbRemote, "collectOrb", "Red Orb", "Magma")
            fire(orbRemote, "collectOrb", "Yellow Orb", "Magma")
            fire(orbRemote, "collectOrb", "Blue Orb", "Magma")
            fire(orbRemote, "collectOrb", "Green Orb", "Magma")
        end)
        
        conn = {conn1, conn2, conn3, conn4}
        
    elseif cmd == "off" then
        enabled = false
        if conn then
            if type(conn) == "table" then
                for _, c in pairs(conn) do
                    c:Disconnect()
                end
            else
                conn:Disconnect()
            end
            conn = nil
        end
        print("🛑 ORBS STOPPED")
    end
end
