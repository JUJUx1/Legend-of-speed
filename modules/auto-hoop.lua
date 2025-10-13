-- AUTO HOOP MODULE
local hoopToggle = false
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local hoopConnection

-- FUNCTION TO FIND HOOP REMOTE
local function findHoopRemote()
    print("🔍 Searching for hoop remote...")
    
    local possiblePaths = {
        "rEvents.hoopEvent",
        "Remotes.HoopEvent",
        "RemoteEvents.HoopEvent", 
        "HoopEvent",
        "hoopEvent",
        "Events.HoopEvent",
        "rEvents.CollectHoop",
        "Remotes.CollectHoop",
        "GameEvents.HoopEvent"
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
            print("✅ FOUND HOOP REMOTE: " .. path)
            return remote
        end
    end
    
    warn("❌ COULD NOT FIND HOOP REMOTE EVENT")
    return nil
end

local hoopRemote = findHoopRemote()

local function collectHoops()
    if not hoopRemote then
        print("❌ No hoop remote found")
        return
    end
    
    pcall(function()
        hoopRemote:FireServer("collectHoop")
        -- Alternative common hoop calls:
        -- hoopRemote:FireServer()
        -- hoopRemote:FireServer("collect")
    end)
end

local function startHoopFarm()
    if hoopConnection then return end
    hoopConnection = RunService.Heartbeat:Connect(function()
        if hoopToggle then
            collectHoops()
        end
    end)
end

local function stopHoopFarm()
    if hoopConnection then
        hoopConnection:Disconnect()
        hoopConnection = nil
    end
end

return function(state)
    hoopToggle = state
    if state then
        print("🏀 AUTO-HOOP ACTIVATED")
        startHoopFarm()
    else
        print("🛑 AUTO-HOOP STOPPED")
        stopHoopFarm()
    end
end
