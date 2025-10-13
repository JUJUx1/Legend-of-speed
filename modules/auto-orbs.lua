-- ADVANCED AUTO-ORBS WITH BURST MODE
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

-- FUNCTION TO FIND THE CORRECT REMOTE
local function findOrbRemote()
    print("🔍 Searching for orb remote...")
    
    local possiblePaths = {
        "rEvents.orbEvent",
        "Remotes.OrbEvent",
        "RemoteEvents.OrbEvent", 
        "OrbEvent",
        "orbEvent",
        "Events.OrbEvent"
    }
    
    for _, path in ipairs(possiblePaths) do
        local remote = ReplicatedStorage
        local found = true
        
        for part in path:gmatch("[^.]+") do
            if remote:FindFirstChild(part) then
                remote = remote:FindFirstChild(part)
            else
                found = false
                break
            end
        end
        
        if found and remote:IsA("RemoteEvent") then
            print("✅ FOUND ORB REMOTE: " .. path)
            return remote
        end
    end
    
    warn("❌ COULD NOT FIND ORB REMOTE EVENT")
    return nil
end

local orbRemote = findOrbRemote()

-- BURST COLLECTION FUNCTION (Runs 20 times)
local function burstCollect()
    if not orbRemote then return end
    
    local burstCount = 20  -- Run 20 times
    
    for burst = 1, burstCount do
        pcall(function()
            for _, location in ipairs(locations) do
                for _, orb in ipairs(currentOrbs) do
                    orbRemote:FireServer("collectOrb", orb, location)
                end
            end
        end)
        wait(0.01) -- Small delay between bursts
    end
end

-- SINGLE RUN COLLECTION (Original function)
local function collectOrbs()
    if not orbRemote then return end
    
    pcall(function()
        for _, location in ipairs(locations) do
            for _, orb in ipairs(currentOrbs) do
                orbRemote:FireServer("collectOrb", orb, location)
            end
        end
    end)
end

local function startFarm()
    if connection then return end
    connection = RunService.Heartbeat:Connect(function()
        if orbToggle then
            burstCollect()  -- Use burst mode instead of single collection
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
        print("🎯 AUTO-ORBS BURST MODE ACTIVATED (20x)")
        startFarm()
    elseif option == "off" then
        orbToggle = false
        print("🛑 AUTO-ORBS STOPPED")
        stopFarm()
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("💛 YELLOW ORB BURST MODE ACTIVATED (20x)")
        startFarm()
    elseif type(option) == "table" then
        currentOrbs = option
        orbToggle = true
        print("🎯 AUTO-ORBS CUSTOM BURST MODE ACTIVATED (20x)")
        startFarm()
    else
        warn("Invalid option for auto-orbs.lua! Use \"on\", \"off\", \"yellow\", or a table of orb names.")
    end
end
