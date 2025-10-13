local orbToggle = false

spawn(function()
    while wait(0.5) do
        if orbToggle then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "City")
                game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
            end)
        end
    end
end)

return function(state)
    orbToggle = state
    if state then
        print("🎯 AUTO-ORBS ACTIVATED")
    else
        print("🛑 AUTO-ORBS STOPPED")
    end
endreturn {
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
