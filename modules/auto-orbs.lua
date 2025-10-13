-- ⚡ FIXED AUTO-ORBS + GEMS COLLECTOR ⚡
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

-- FIND ORB REMOTE (SAFE VERSION)
local orbRemote
pcall(function()
    orbRemote = ReplicatedStorage:FindFirstChild("rEvents")
    if orbRemote then
        orbRemote = orbRemote:FindFirstChild("orbEvent")
    end
end)

if not orbRemote then
    warn("❌ Orb remote not found!")
end

-- FIND GEM REMOTE (SAFE VERSION)
local gemRemote
pcall(function()
    gemRemote = ReplicatedStorage:FindFirstChild("rEvents")
    if gemRemote then
        gemRemote = gemRemote:FindFirstChild("gemEvent")
    end
end)

if not gemRemote then
    print("⚠️  Gem remote not found - collecting orbs only")
end

-- FAST COLLECTION FUNCTION
local function collectEverything()
    if not orbRemote then return end
    
    pcall(function()
        -- COLLECT ORBS (3X SPEED - SAFE)
        for i = 1, 3 do
            for _, location in ipairs(locations) do
                for _, orb in ipairs(currentOrbs) do
                    orbRemote:FireServer("collectOrb", orb, location)
                end
            end
        end
        
        -- COLLECT GEMS IF REMOTE EXISTS
        if gemRemote then
            for _, location in ipairs(locations) do
                gemRemote:FireServer("collectGem", "Red Gem", location)
                gemRemote:FireServer("collectGem", "Blue Gem", location)
            end
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
        print("⚡ AUTO-ORBS ACTIVATED")
        startFarm()
    elseif option == "off" then
        orbToggle = false
        print("🛑 AUTO-ORBS STOPPED")
        stopFarm()
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("💛 YELLOW ORBS ACTIVATED")
        startFarm()
    else
        warn("Invalid option for auto-orbs.lua! Use 'on', 'off', or 'yellow'")
    end
end
