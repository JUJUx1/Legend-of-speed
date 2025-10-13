-- 💥 50X ULTRA FAST ORBS 💥
local running = false
local conn = nil

local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent
local allOrbs = {"Red Orb", "Orange Orb", "Yellow Orb", "Blue Orb", "Eternal Orb", "Green Orb", "Gem Orb", "Diamond Orb"}
local places = {"City", "Desert", "Space", "Magma", "Legends Highway", "Snow", "Dark Matter"}

return function(cmd)
    if cmd == "on" then
        running = true
        print("💥 50X ALL ORBS ACTIVATED!")
        
        if conn then conn:Disconnect() end
        conn = game:GetService("RunService").RenderStepped:Connect(function()
            if not running then return end
            
            -- 50X SPEED - 50 BURSTS PER FRAME
            for i = 1, 50 do
                for _, place in ipairs(places) do
                    for _, orb in ipairs(allOrbs) do
                        orbRemote:FireServer("collectOrb", orb, place)
                    end
                end
            end
        end)
        
    elseif cmd == "yellow" then
        running = true
        print("💛 50X YELLOW ORBS ACTIVATED!")
        
        if conn then conn:Disconnect() end
        conn = game:GetService("RunService").RenderStepped:Connect(function()
            if not running then return end
            
            -- 50X YELLOW ONLY
            for i = 1, 50 do
                for _, place in ipairs(places) do
                    orbRemote:FireServer("collectOrb", "Yellow Orb", place)
                end
            end
        end)
        
    elseif cmd == "off" then
        running = false
        if conn then
            conn:Disconnect()
            conn = nil
        end
        print("🛑 50X ORBS STOPPED")
    end
end
