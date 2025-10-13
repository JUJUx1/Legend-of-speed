-- 🎯 DEBUG MODE - FIND THE REAL ORB COLLECTION METHOD
local enabled = false
local conn = nil
local orbRemote = game:GetService("ReplicatedStorage").rEvents.orbEvent

-- HOOK THE REMOTE TO SEE WHAT'S BEING SENT
local originalFire = orbRemote.FireServer
orbRemote.FireServer = function(self, ...)
    local args = {...}
    print("🎯 REMOTE FIRED:", unpack(args))
    return originalFire(self, ...)
end

return function(cmd)
    if cmd == "debug" then
        print("🔍 DEBUG MODE - Checking orb collection...")
        print("📡 Testing different argument combinations...")
        
        -- TEST DIFFERENT ARGUMENT PATTERNS
        orbRemote:FireServer("collectOrb", "Yellow Orb", "City")
        wait(0.1)
        orbRemote:FireServer("collectOrb", "City", "Yellow Orb") -- REVERSED
        wait(0.1)
        orbRemote:FireServer("collectOrb", "YellowOrb", "City") -- NO SPACE
        wait(0.1)
        orbRemote:FireServer("CollectOrb", "Yellow Orb", "City") -- CAPITAL C
        wait(0.1)
        orbRemote:FireServer("collectorb", "Yellow Orb", "City") -- LOWERCASE
        wait(0.1)
        orbRemote:FireServer("collectOrb", "Yellow", "City") -- SHORT NAME
        wait(0.1)
        orbRemote:FireServer("collectOrb") -- NO ARGS
        wait(0.1)
        orbRemote:FireServer() -- EMPTY
        
        print("✅ DEBUG TESTS COMPLETE - Check output above!")
        
    elseif cmd == "test" then
        enabled = true
        print("⚡ TESTING MAXIMUM THROUGHPUT...")
        
        local startTime = tick()
        local callCount = 0
        
        conn = game:GetService("RunService").Heartbeat:Connect(function()
            if not enabled then return end
            
            -- TEST SINGLE CALL
            orbRemote:FireServer("collectOrb", "Yellow Orb", "City")
            callCount = callCount + 1
            
            -- SHOW SPEED EVERY SECOND
            if tick() - startTime >= 1 then
                print("📊 CALLS PER SECOND: " .. callCount)
                enabled = false
                conn:Disconnect()
            end
        end)
        
    elseif cmd == "find" then
        print("🔎 SEARCHING FOR REAL ORB METHODS...")
        
        -- CHECK IF THERE ARE OTHER REMOTES
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                if string.find(obj.Name:lower(), "orb") then
                    print("🎯 FOUND ORB REMOTE:", obj:GetFullName())
                end
            end
        end
        
    elseif cmd == "off" then
        enabled = false
        if conn then
            conn:Disconnect()
            conn = nil
        end
        print("🛑 DEBUG STOPPED")
    end
end
