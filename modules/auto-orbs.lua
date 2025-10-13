local orbToggle = false
local orbs = {
    "Red Orb", "Orange Orb", "Yellow Orb", "Blue Orb",
    "Eternal Orb", "Green Orb", "Gem Orb", "Diamond Orb"
}
local locations = { "City", "Desert", "Space", "Magma", "Legends Highway", "Snow", "Dark Matter" }

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local connection

local function collectOrbs()
    pcall(function()
        for _, location in ipairs(locations) do
            for _, orb in ipairs(orbs) do
                -- OPTIONAL: Only try to collect if the orb exists in workspace!
                -- local orbFolder = workspace:FindFirstChild(location .. " Orbs")
                -- if orbFolder and orbFolder:FindFirstChild(orb) then
                    ReplicatedStorage.rEvents.orbEvent:FireServer("collectOrb", orb, location)
                -- end
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
