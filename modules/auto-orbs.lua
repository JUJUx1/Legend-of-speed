local enabled = false
local conn = nil
local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent
local RunService = game:GetService("RunService")

-- Configuration
local ORB_NAME = "Yellow Orb" -- Change to the desired orb name
local LOCATION = "City" -- Change to the desired location
local DELAY = 0.5 -- Delay between calls (in seconds) to avoid rate limits

-- Hook the remote to log arguments
local originalFire = orbRemote.FireServer
orbRemote.FireServer = function(self, ...)
    local args = {...}
    print("🎯 REMOTE FIRED:", unpack(args))
    return originalFire(self, ...)
end

return function(cmd, orbName, location)
    -- Allow overriding default orb name and location
    local targetOrb = orbName or ORB_NAME
    local targetLocation = location or LOCATION

    if cmd == "farm" then
        if enabled then
            print("⚠️ FARMING ALREADY ACTIVE")
            return
        end
        enabled = true
        print("🌟 STARTING ORB FARMING: " .. targetOrb .. " in " .. targetLocation)

        local callCount = 0
        local successCount = 0
        local lastCallTime = tick()

        conn = RunService.Heartbeat:Connect(function()
            if not enabled then return end

            -- Only fire if enough time has passed to respect the delay
            if tick() - lastCallTime >= DELAY then
                local success, result = pcall(function()
                    orbRemote:FireServer("collectOrb", targetOrb, targetLocation)
                end)
                callCount = callCount + 1
                if success then
                    successCount = successCount + 1
                    print("✅ SUCCESSFUL CALL #" .. callCount .. ": " .. targetOrb .. " in " .. targetLocation)
                else
                    print("❌ ERROR ON CALL #" .. callCount .. ": " .. tostring(result))
                end
                lastCallTime = tick()
                
                -- Periodic status update (every 10 calls)
                if callCount % 10 == 0 then
                    print("📊 STATUS: " .. callCount .. " calls made, " .. successCount .. " successful")
                end
            end
        end)

    elseif cmd == "debug" then
        print("🔍 DEBUG MODE - Testing orb collection...")
        print("📡 Testing different argument combinations for " .. targetOrb .. " in " .. targetLocation)

        local tests = {
            {"collectOrb", targetOrb, targetLocation},
            {"collectOrb", targetLocation, targetOrb}, -- Reversed
            {"collectOrb", targetOrb:gsub(" ", ""), targetLocation}, -- No space
            {"CollectOrb", targetOrb, targetLocation}, -- Capital C
            {"collectorb", targetOrb, targetLocation}, -- Typo
            {"collectOrb", targetOrb:match("^%w+"), targetLocation}, -- Short name
            {"collectOrb"}, -- No args
            {} -- Empty
        }

        for i, args in ipairs(tests) do
            local success, result = pcall(function()
                orbRemote:FireServer(unpack(args))
            end)
            print("TEST #" .. i .. ": " .. (success and "✅ SUCCESS" or "❌ FAILED: " .. tostring(result)))
            wait(0.5) -- Increased delay to avoid rate limits
        end
        print("✅ DEBUG TESTS COMPLETE - Check output above!")

    elseif cmd == "find" then
        print("🔎 SEARCHING FOR ORB REMOTES...")
        for _, obj in pairs(game:GetDescendants()) do
            if (obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction")) and string.find(obj.Name:lower(), "orb") then
                print("🎯 FOUND ORB REMOTE: " .. obj:GetFullName())
            end
        end

    elseif cmd == "off" then
        enabled = false
        if conn then
            conn:Disconnect()
            conn = nil
        end
        print("🛑 FARMING STOPPED")

    else
        print("❓ UNKNOWN COMMAND: " .. tostring(cmd))
        print("Available commands: farm, debug, find, off")
    end
end
