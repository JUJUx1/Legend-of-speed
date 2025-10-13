-- FIXED AUTO-ORBS.LUA
local orbToggle = false
local orbSpeed = 0.2 -- SLOWER BUT SAFE

local targetOrbs = {
    "Yellow Orb",
    "Red Orb", 
    "Gem"
}

local targetLocations = {
    "City",
    "Snow City",
    "Magma City"
}

local function SafeOrbCollector()
    while orbToggle and wait(orbSpeed) do
        pcall(function()
            -- Only do ONE location per cycle to avoid spam
            local location = targetLocations[math.random(1, #targetLocations)]
            local orbType = targetOrbs[math.random(1, #targetOrbs)]
            
            game:GetService('ReplicatedStorage').rEvents.orbEvent:FireServer("collectOrb", orbType, location)
        end)
    end
end

return {
    Toggle = function(state)
        orbToggle = state
        if state then
            print("🎯 SAFE ORB COLLECTOR ACTIVATED")
            spawn(SafeOrbCollector)
        else
            print("🛑 ORB COLLECTOR DEACTIVATED")
        end
    end
}        end)
    end
end

-- SPEED CONTROL FUNCTION
local function SetOrbSpeed(newSpeed)
    orbSpeed = newSpeed
    print("🔥 ORB SPEED SET TO: " .. newSpeed)
end

return {
    Toggle = function(state)
        orbToggle = state
        if state then
            print("🚀 ULTRA ORB COLLECTOR ACTIVATED")
            print("🎯 TARGETS: " .. #targetOrbs .. " orb types")
            print("🌍 LOCATIONS: " .. #targetLocations .. " areas") 
            print("💨 SPEED: " .. orbSpeed .. " seconds")
            spawn(UltraOrbCollector)
        else
            print("🛑 ORB COLLECTOR DEACTIVATED")
        end
    end,
    
    SetSpeed = SetOrbSpeed,
    
    AddOrbType = function(orbName)
        table.insert(targetOrbs, orbName)
        print("✅ ADDED ORB TYPE: " .. orbName)
    end,
    
    AddLocation = function(locationName)
        table.insert(targetLocations, locationName)
        print("✅ ADDED LOCATION: " .. locationName)
    end,
    
    GetStats = function()
        return {
            OrbTypes = #targetOrbs,
            Locations = #targetLocations,
            Speed = orbSpeed,
            Active = orbToggle
        }
    end
}
