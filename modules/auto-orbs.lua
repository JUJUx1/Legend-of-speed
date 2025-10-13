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

local function findOrbEvent()
    -- Try different possible remote event paths
    local possiblePaths = {
        "rEvents.orbEvent",
        "RemoteEvents.OrbEvent", 
        "Remotes.OrbEvent",
        "OrbEvent",
        "orbEvent",
        "Events.OrbEvent"
    }
    
    for _, path in ipairs(possiblePaths) do
        local remote = ReplicatedStorage
        for part in path:gmatch("[^.]+") do
            remote = remote:FindFirstChild(part)
            if not remote then break end
        end
        if remote and remote:IsA("RemoteEvent") then
            print("✅ Found orb event at: " .. path)
            return remote
        end
    end
    
    warn("❌ Could not find orb event remote")
    return nil
end

local orbEvent = findOrbEvent()

local function collectOrbs()
    if not orbEvent then
        warn("❌ Orb event not found - cannot collect orbs")
        return
    end
    
    pcall(function()
        for _, location in ipairs(locations) do
            for _, orb in ipairs(currentOrbs) do
                orbEvent:FireServer("collectOrb", orb, location)
                task.wait(0.05) -- Small delay to prevent flooding
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
