-- INSTANT STOP AUTO-ORBS
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
local burstRunning = false  -- TRACK IF BURST IS RUNNING

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

-- SINGLE FAST COLLECTION (NO LOOPS)
local function fastCollect()
    if not orbRemote or not orbToggle then return end
    
    pcall(function()
        for _, location in ipairs(locations) do
            for _, orb in ipairs(currentOrbs) do
                orbRemote:FireServer("collectOrb", orb, location)
            end
        end
    end)
end

local function startFarm()
    if connection then 
        connection:Disconnect()
        connection = nil
    end
    
    connection = RunService.Heartbeat:Connect(function()
        if orbToggle then
            -- Run 20x collections per frame instead of loops
            for i = 1, 20 do
                if not orbToggle then break end  -- INSTANT BREAK
                fastCollect()
            end
        end
    end)
end

local function stopFarm()
    orbToggle = false  -- SET FIRST FOR INSTANT STOP
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

return function(option)
    if option == "on" then
        currentOrbs = allOrbs
        orbToggle = true
        print("🎯 AUTO-ORBS ACTIVATED (20x PER FRAME)")
        startFarm()
    elseif option == "off" then
        stopFarm()
        print("🛑 AUTO-ORBS INSTANT STOPPED")
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("💛 YELLOW ORBS ACTIVATED (20x PER FRAME)")
        startFarm()
    elseif type(option) == "table" then
        currentOrbs = option
        orbToggle = true
        print("🎯 CUSTOM ORBS ACTIVATED (20x PER FRAME)")
        startFarm()
    else
        warn("Invalid option for auto-orbs.lua! Use \"on\", \"off\", \"yellow\", or a table of orb names.")
    end
end
