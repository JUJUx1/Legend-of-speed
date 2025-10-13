-- AUTO-COLLECT ALL ORBS (Red, Orange, Yellow, Blue, Eternal, Green, Gem, Diamond, etc.)
local orbToggle = false
local orbs = {
    "Red Orb", "Orange Orb", "Yellow Orb", "Blue Orb",
    "Eternal Orb", "Green Orb", "Gem Orb", "Diamond Orb"
}
local locations = { "City", "Desert", "Space", "Magma", "Legends Highway", "Snow", "Dark Matter" }

local function OrbLoop()
    while true do
        if orbToggle then
            pcall(function()
                for _, location in ipairs(locations) do
                    for _, orb in ipairs(orbs) do
                        game:GetService("ReplicatedStorage").rEvents.orbEvent:FireServer("collectOrb", orb, location)
                    end
                end
            end)
        end
        task.wait(0.1) -- Faster than 0.5
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
