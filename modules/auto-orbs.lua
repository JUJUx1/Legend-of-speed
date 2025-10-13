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
    pcall(function()
        for _, location in ipairs(locations) do
            for _, orb in ipairs(currentOrbs) do
                ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", orb, location)
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
        print("Invalid option! Use \"on\", \"off\", \"yellow\", or a table of orb names.")
    end
end    end
end

-- The returned function can be called as:
-- autoOrbsModule("on")         -- Start farming all orbs (default)
-- autoOrbsModule("off")        -- Stop farming
-- autoOrbsModule("yellow")     -- Farm only yellow orbs
-- autoOrbsModule({"Yellow Orb", "Blue Orb"}) -- Farm only yellow and blue orbs
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
        print("Invalid option! Use \"on\", \"off\", \"yellow\", or a table of orb names.")
    end
end
return function(state)
    orbToggle = state
    if state then
        print("🎯 AUTO-ORBS ACTIVATED (Optimized)")
        startFarm()
    else
        print("🛑 AUTO-ORBS STOPPED")
        stopFarm()
    end
end        connection:Disconnect()
        connection = nil
    end
end

return function(state)
    orbToggle = state
    if state then
        print("🎯 AUTO-ORBS ACTIVATED (Optimized)")
        startFarm()
    else
        print("🛑 AUTO-ORBS STOPPED")
        stopFarm()
    end
end
