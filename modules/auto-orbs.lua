-- ⚡ OPTIMIZED FAST ORBS (NO LAG) ⚡
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
local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent

-- OPTIMIZED COLLECTION (NO LAG)
local function collectOrbs()
    if not orbRemote then return end
    
    pcall(function()
        -- FAST BUT NOT TOO FAST - 3x SPEED
        for i = 1, 3 do
            for _, location in ipairs(locations) do
                for _, orb in ipairs(currentOrbs) do
                    orbRemote:FireServer("collectOrb", orb, location)
                end
            end
        end
    end)
end

local function startFarm()
    if connection then return end
    connection = RunService.Heartbeat:Connect(function()  -- Use Heartbeat instead of RenderStepped
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
        print("⚡ FAST ORBS ACTIVATED (3x SPEED - NO LAG)")
        startFarm()
    elseif option == "off" then
        orbToggle = false
        print("🛑 ORBS STOPPED")
        stopFarm()
    elseif option == "yellow" then
        currentOrbs = {"Yellow Orb"}
        orbToggle = true
        print("💛 FAST YELLOW ORBS ACTIVATED (3x SPEED - NO LAG)")
        startFarm()
    end
end
