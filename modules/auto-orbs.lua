-- 🚀 20X FASTER AUTO-ORBS 🚀
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

-- FIND ORB REMOTE
local orbRemote
for _, path in pairs({
    "rEvents.orbEvent", "Remotes.OrbEvent", "RemoteEvents.OrbEvent", 
    "OrbEvent", "orbEvent", "Events.OrbEvent"
}) do
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
        orbRemote = remote
        break
    end
end

-- 20X FASTER COLLECTION
local function collectOrbs()
    if not orbRemote then return end
    
    -- RUN 20 TIMES FASTER
    for burst = 1, 20 do
        pcall(function()
            for _, location in ipairs(locations) do
                for _, orb in ipairs(currentOrbs) do
                    orbRemote:FireServer("collectOrb", orb, location)
                end
            end
        end)
        -- NO DELAY = MAXIMUM SPEED
    end
end

local function startFarm()
    if connection then return end
    connection = RunService.RenderStepped:Connect(function()  -- FASTER THAN HEARTBEAT
        if orbToggle then
            collectOrbs()  -- THIS RUNS 20X PER FRAME
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
        print("🚀 AUTO-ORBS 20X ACTIVATED (ALL ORBS)")
        startFarm()
    elseif option == "off" then
        orbToggle = false
        print("🛑 AUTO-ORBS STOPPED")
        stopFarm()
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("💛 YELLOW ORBS 20X ACTIVATED")
        startFarm()
    elseif type(option) == "table" then
        currentOrbs = option
        orbToggle = true
        print("🎯 AUTO-ORBS 20X (CUSTOM) ACTIVATED")
        startFarm()
    else
        warn("Invalid option for auto-orbs.lua! Use \"on\", \"off\", \"yellow\", or a table of orb names.")
    end
end
