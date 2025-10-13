-- IMPROVED AUTO-ORBS
local orbToggle = false
local orbs = {"Yellow Orb", "Red Orb"}
local location = "City"

local function OrbLoop()
    while true do
        if orbToggle then
            pcall(function()
                for _, orb in ipairs(orbs) do
                    game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", orb, location)
                end
            end)
        end
        task.wait(0.5) -- more accurate than wait()
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
