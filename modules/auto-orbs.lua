-- WORKING AUTO-ORBS
local orbToggle = false

local function OrbLoop()
    while true do
        if orbToggle then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Yellow Orb", "City")
                game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", "Red Orb", "City")
            end)
        end
        wait(0.5)
    end
end

spawn(OrbLoop)

return function(state)
    orbToggle = state
    if state then
        print("🎯 AUTO-ORBS ACTIVATED")
    else
        print("🛑 AUTO-ORBS STOPPED")
    end
end
