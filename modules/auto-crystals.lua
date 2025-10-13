-- WORKING AUTO-CRYSTALS
local crystalToggle = false

local function OpenCrystals()
    while crystalToggle and wait(1) do
        pcall(function()
            game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Red Crystal")
        end)
    end
end

return {
    Toggle = function(state)
        crystalToggle = state
        if state then
            print("💎 AUTO-CRYSTALS ACTIVATED")
            spawn(OpenCrystals)
        else
            print("🛑 AUTO-CRYSTALS STOPPED")
        end
    end
}
