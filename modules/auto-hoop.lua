-- Auto-Hoop Module for Legend of Speed
local hoopToggle = false
local hoopConnection = nil
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Configuration
local DELAY = 0.5 -- Delay between calls (in seconds) to avoid rate limits
local CITIES = {"City", "Desert", "Volcano", "Snow City"} -- Known cities in Legend of Speed
local HOOP_ACTIONS = {"collectHoop", "collectStep", "hoopCollected", "stepCollected"} -- Possible remote actions

-- Function to find the hoop/step remote
local function findHoopRemote()
    print("🔍 Searching for hoop/step remote...")

    local possiblePaths = {
        "rEvents.hoopEvent",
        "rEvents.stepEvent",
        "rEvents.CollectHoop",
        "rEvents.CollectStep",
        "Remotes.HoopEvent",
        "Remotes.StepEvent",
        "HoopEvent",
        "StepEvent"
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
    }

    print("⚠️ Searching for any step-related RemoteEvent...")
    for _, child in pairs(ReplicatedStorage:GetDescendants()) do
        if child:IsA("RemoteEvent") and (string.lower(child.Name):find("hoop") or string.lower(child.Name):find("step")) then
            print("🔍 Found potential step remote: " .. child:GetFullName())
            return child
        end
    end

    warn("❌ COULD NOT FIND HOOP/STEP REMOTE EVENT")
    return nil
end

local hoopRemote = findHoopRemote()

-- Function to collect hoops in a specific city
local function collectHoops(city)
    if not hoopRemote then
        print("❌ No hoop/step remote found")
        return false
    end

    local successCount = 0
    for _, action in ipairs(HOOP_ACTIONS) do
        local success, result = pcall(function()
            hoopRemote:FireServer(action, city)
        end)
        if success then
            successCount = successCount + 1
            print("✅ Fired " .. action .. " for " .. city)
        else
            print("❌ Error firing " .. action .. " for " .. city .. ": " .. tostring(result))
        end
    end
    return successCount > 0
end

-- Main farming loop
local function startHoopFarm()
    if hoopConnection then
        print("⚠️ HOOP FARMING ALREADY ACTIVE")
        return
    end
    if not hoopRemote then
        print("❌ Cannot start farming: No hoop/step remote found")
        return
    end

    hoopConnection = RunService.Heartbeat:Connect(function()
        if not hoopToggle then return end

        local lastCallTime = tick()
        local callCount = 0
        local successCount = 0

        -- Cycle through all cities
        for _, city in ipairs(CITIES) do
            if tick() - lastCallTime >= DELAY then
                if collectHoops(city) then
                    successCount = successCount + 1
                end
                callCount = callCount + 1
                lastCallTime = tick()

                -- Periodic status update (every 10 calls)
                if callCount % 10 == 0 then
                    print("📊 HOOP FARM STATUS: " .. callCount .. " calls made, " .. successCount .. " successful")
                end
            end
        end
    end)
end

-- Stop farming
local function stopHoopFarm()
    if hoopConnection then
        hoopConnection:Disconnect()
        hoopConnection = nil
    end
end

-- Debug function to test remote and arguments
local function debugHoops()
    print("🔍 DEBUG MODE - Testing hoop collection...")
    if not hoopRemote then
        print("❌ No hoop/step remote found")
        return
    end

    for _, city in ipairs(CITIES) do
        print("📡 Testing arguments for " .. city)
        for _, action in ipairs(HOOP_ACTIONS) do
            local tests = {
                {action, city}, -- Standard: action, city
                {action}, -- Action only
                {action, city, "hoop"}, -- Action, city, extra arg
                {city, action}, -- Reversed
                {} -- Empty
            }

            for i, args in ipairs(tests) do
                local success, result = pcall(function()
                    hoopRemote:FireServer(unpack(args))
                end)
                print("TEST #" .. i .. " (" .. action .. ", " .. city .. "): " .. (success and "✅ SUCCESS" or "❌ FAILED: " .. tostring(result)))
                wait(DELAY) -- Avoid rate limits
            end
        end
    end
    print("✅ DEBUG TESTS COMPLETE - Check output above!")
end

-- Module interface
return function(cmd, city)
    if cmd == "toggle" then
        hoopToggle = not hoopToggle
        if hoopToggle then
            print("🏀 AUTO-HOOP (STEPS) ACTIVATED")
            startHoopFarm()
        else
            print("🛑 AUTO-HOOP STOPPED")
            stopHoopFarm()
        end
    elseif cmd == "start" then
        hoopToggle = true
        print("🏀 AUTO-HOOP (STEPS) ACTIVATED")
        startHoopFarm()
    elseif cmd == "stop" then
        hoopToggle = false
        print("🛑 AUTO-HOOP STOPPED")
        stopHoopFarm()
    elseif cmd == "debug" then
        debugHoops()
    elseif cmd == "find" then
        hoopRemote = findHoopRemote()
    elseif cmd == "city" and city then
        hoopToggle = true
        print("🏀 STARTING HOOP FARM IN: " .. city)
        collectHoops(city)
    else
        print("❓ UNKNOWN COMMAND: " .. tostring(cmd))
        print("Available commands: toggle, start, stop, debug, find, city <city_name>")
    end
end
