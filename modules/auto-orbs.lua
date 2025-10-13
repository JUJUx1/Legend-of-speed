-- ADVANCED AUTO-ORBS WITH SELECTABLE ORB COLORS (FIXED FOR LOADER)
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

local function collectOrbs()
    local orbEvent = ReplicatedStorage.rEvents and ReplicatedStorage.rEvents.orbEvent
    if not orbEvent then return end
    for _, location in ipairs(locations) do
        for _, orb in ipairs(currentOrbs) do
            pcall(function()
                orbEvent:FireServer("collectOrb", orb, location)
            end)
        end
    end
end

local function startFarm()
    stopFarm()
    orbToggle = true
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
    orbToggle = false
end

-- 🔧 FIXED: Now accepts true/false AND "on"/"off"/"yellow"
return function(option)
    if option == true or option == "on" then
        currentOrbs = allOrbs
        orbToggle = true
        print("🟨 AUTO-ORBS (ALL) ACTIVATED")
        startFarm()
    elseif option == false or option == "off" then
        orbToggle = false
        print("🛑 AUTO-ORBS STOPPED")
        stopFarm()
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("🟨 AUTO-ORBS (YELLOW) ACTIVATED")
        startFarm()
    elseif type(option) == "table" then
        currentOrbs = option
        orbToggle = true
        print("🟨 AUTO-ORBS (CUSTOM) ACTIVATED")
        startFarm()
    else
        warn("Invalid option for auto-orbs.lua! Use true/false, \"on\", \"off\", \"yellow\", or a table of orb names.")
    end
end
