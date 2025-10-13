-- WORKING AUTO-ORBS COLLECTOR
local orbToggle = false

local function OrbCollector()
    while orbToggle and wait(0.3) do -- Safe speed
        pcall(function()
            -- Use the EXACT remote path we found
            game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "City")
            game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City") 
            game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Gem", "City")
        end)
    end
end

return {
    Toggle = function(state)
        orbToggle = state
        if state then
            print("🎯 ORB COLLECTOR ACTIVATED")
            spawn(OrbCollector)
        else
            print("🛑 ORB COLLECTOR STOPPED")
        end
    end
}        end
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
