-- AUTO HOOP MODULE - COLLECT STEPS
local hoopToggle = false
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local hoopConnection

-- FUNCTION TO FIND HOOP/STEP REMOTE
local function findHoopRemote()
    print("🔍 Searching for hoop/step remote...")
    
    local possiblePaths = {
        "rEvents.hoopEvent",
        "Remotes.HoopEvent",
        "RemoteEvents.HoopEvent", 
        "HoopEvent",
        "hoopEvent",
        "Events.HoopEvent",
        "rEvents.CollectHoop",
        "Remotes.CollectHoop",
        "GameEvents.HoopEvent",
        "rEvents.stepEvent",
        "Remotes.StepEvent",
        "StepEvent",
        "stepEvent",
        "Events.StepEvent",
        "rEvents.CollectStep",
        "Remotes.CollectStep"
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
            print("✅ FOUND HOOP/STEP REMOTE: " .. path)
            return remote
        end
    end
    
    -- Search for any RemoteEvent that might work for steps
    print("⚠️  Searching for any step-related RemoteEvent...")
    for _, child in pairs(ReplicatedStorage:GetDescendants()) do
        if child:IsA("RemoteEvent") then
            if string.lower(child.Name):find("hoop") or string.lower(child.Name):find("step") then
                print("🔍 Found potential step remote: " .. child:GetFullName())
                return child
            end
        end
    end
    
    warn("❌ COULD NOT FIND HOOP/STEP REMOTE EVENT")
    return nil
end

local hoopRemote = findHoopRemote()

local function collectSteps()
    if not hoopRemote then
        print("❌ No hoop/step remote found")
        return
    end
    
    pcall(function()
        -- Try different possible call methods
        hoopRemote:FireServer("collectHoop")
        hoopRemote:FireServer("collectStep") 
        hoopRemote:FireServer("hoopCollected")
        hoopRemote:FireServer("stepCollected")
        hoopRemote:FireServer() -- Sometimes it works with no arguments
    end)
end

local function startHoopFarm()
    if hoopConnection then return end
    hoopConnection = RunService.Heartbeat:Connect(function()
        if hoopToggle then
            collectSteps()
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
        print("🏀 AUTO-HOOP (STEPS) ACTIVATED")
        startHoopFarm()
    else
        print("🛑 AUTO-HOOP STOPPED")
        stopHoopFarm()
    end
end
