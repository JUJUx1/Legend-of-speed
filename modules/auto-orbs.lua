-- ⚡ FAST ORBS + GEMS COLLECTOR ⚡
local orbToggle = false
local allOrbs = {
    "Red Orb", "Orange Orb", "Yellow Orb", "Blue Orb",
    "Eternal Orb", "Green Orb", "Gem Orb", "Diamond Orb"
}
local locations = { "City", "Desert", "Space", "Magma", "Legends Highway", "Snow", "Dark Matter" }
local currentOrbs = allOrbs

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local connection

local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent
local gemRemote = game:GetService("ReplicatedStorage").rEvents.gemEvent  -- GEM REMOTE

-- FAST ORBS + GEMS COLLECTION
local function collectEverything()
    if not orbRemote then return end
    
    pcall(function()
        -- COLLECT ORBS (5X SPEED)
        for i = 1, 5 do
            for _, location in ipairs(locations) do
                for _, orb in ipairs(currentOrbs) do
                    orbRemote:FireServer("collectOrb", orb, location)
                end
            end
            wait(0.001)
        end
        
        -- COLLECT GEMS FROM ALL LOCATIONS
        for _, location in ipairs(locations) do
            gemRemote:FireServer("collectGem", "Red Gem", location)
            gemRemote:FireServer("collectGem", "Blue Gem", location) 
            gemRemote:FireServer("collectGem", "Green Gem", location)
            gemRemote:FireServer("collectGem", "Yellow Gem", location)
            gemRemote:FireServer("collectGem", "Purple Gem", location)
        end
    end)
end

local function startFarm()
    if connection then return end
    connection = RunService.Heartbeat:Connect(function()
        if orbToggle then
            collectEverything()
        end
    end)
end

local function stopFarm()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return function(option)
    if option == "on" then
        currentOrbs = allOrbs
        orbToggle = true
        print("⚡ FAST ORBS + GEMS ACTIVATED (Everything!)")
        startFarm()
    elseif option == "off" then
        orbToggle = false
        print("🛑 ORBS + GEMS STOPPED")
        stopFarm()
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("💛 FAST YELLOW ORBS + GEMS ACTIVATED")
        startFarm()
    end
end
