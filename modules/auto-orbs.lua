-- 🎯 LESS LAGGY AUTO-ORBS
local enabled = false
local conn = nil

local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent
local places = {"City", "Desert", "Space", "Magma"} -- REDUCED LOCATIONS
local allOrbs = {"Red Orb", "Yellow Orb", "Blue Orb", "Green Orb"} -- REDUCED ORBS

return function(cmd)
    if cmd == "on" then
        enabled = true
        print("🎯 AUTO-ORBS ACTIVATED (LOW LAG)")
        
        if conn then conn:Disconnect() end
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- SLOWER COLLECTION - LESS LAG
            for _, place in ipairs(places) do
                for _, orb in ipairs(allOrbs) do
                    orbRemote:FireServer("collectOrb", orb, place)
                end
                wait(0.02) -- ADDED DELAY BETWEEN LOCATIONS
            end
        end)
        
    elseif cmd == "yellow" then
        enabled = true
        print("💛 YELLOW ORBS ACTIVATED (LOW LAG)")
        
        if conn then conn:Disconnect() end
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- YELLOW ONLY - EVEN LESS LAG
            for _, place in ipairs(places) do
                orbRemote:FireServer("collectOrb", "Yellow Orb", place)
                wait(0.03) -- MORE DELAY FOR YELLOW ONLY
            end
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
