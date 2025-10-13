-- ADVANCED AUTO-ORBS WITH SELECTABLE ORB COLORS
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
    
    -- Common remote paths in Legend of Speed
    local possiblePaths = {
        "rEvents.orbEvent",
        "Remotes.OrbEvent",
        "RemoteEvents.OrbEvent", 
        "OrbEvent",
        "orbEvent",
        "Events.OrbEvent",
        "rEvents.OrbRemote",
        "Remotes.OrbRemote",
        "GameEvents.OrbEvent",
        "Network.OrbEvent"
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
    
    -- If no remote found, try to find any RemoteEvent that might be for orbs
    print("⚠️  Searching for any RemoteEvent...")
    for _, child in pairs(ReplicatedStorage:GetDescendants()) do
        if child:IsA("RemoteEvent") then
            print("🔍 Found RemoteEvent: " .. child:GetFullName())
            -- Try calling it to see if it works
            pcall(function()
                child:FireServer("test")
                print("✅ Potential orb remote: " .. child:GetFullName())
                return child
            end)
        end
    end
    
    warn("❌ COULD NOT FIND ORB REMOTE EVENT")
    return nil
end

local orbRemote = findOrbRemote()

local function collectOrbs()
    if not orbRemote then
        print("❌ No orb remote found - please check the remote path")
        return
    end
    
    pcall(function()
        for _, location in ipairs(locations) do
            for _, orb in ipairs(currentOrbs) do
                orbRemote:FireServer("collectOrb", orb, location)
                task.wait(0.01) -- Small delay to prevent crashing
            end
        end
    end)
end

local function startFarm()
    if connection then return end
    connection = RunService.Heartbeat:Connect(function()
        if orbToggle then
            collectOrbs()
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
        print("🎯 AUTO-ORBS (ALL) ACTIVATED")
        startFarm()
    elseif option == "off" then
        orbToggle = false
        print("🛑 AUTO-ORBS STOPPED")
        stopFarm()
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("🎯 AUTO-ORBS (YELLOW) ACTIVATED")
        startFarm()
    elseif type(option) == "table" then
        currentOrbs = option
        orbToggle = true
        print("🎯 AUTO-ORBS (CUSTOM) ACTIVATED")
        startFarm()
    else
        warn("Invalid option for auto-orbs.lua! Use \"on\", \"off\", \"yellow\", or a table of orb names.")
    end
end
