-- ULTRA FAST ORB COLLECTOR
local orbToggle = false
local orbSpeed = 0.05 -- INSANE SPEED

-- SPECIFIC ORB TYPES YOU WANT
local targetOrbs = {
    "Yellow Orb",    -- Fast coins
    "Red Orb",       -- Good value  
    "Gem",           -- Best value
    "Diamond Orb",   -- If exists
    "Rainbow Orb",   -- If exists
    "Blue Orb"       -- If exists
}

-- SPECIFIC LOCATIONS YOU WANT
local targetLocations = {
    "City",          -- Main area
    "Snow City",     -- Cold area
    "Magma City",    -- Fire area
    "Space",         -- Space area
    "Desert",        -- Sand area
    "Fantasy World"  -- If exists
}

local function UltraOrbCollector()
    while orbToggle and wait(orbSpeed) do
        pcall(function()
            -- MASS COLLECTION - Hits ALL locations and orb types simultaneously
            for _, location in pairs(targetLocations) do
                for _, orbType in pairs(targetOrbs) do
                    -- Spam 3x per orb type for maximum efficiency
                    for i = 1, 3 do
                        game:GetService('ReplicatedStorage').rEvents.orbEvent:FireServer("collectOrb", orbType, location)
                    end
                end
            end
        end)
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
