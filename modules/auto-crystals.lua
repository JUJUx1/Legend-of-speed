local crystalToggle = false

local function CrystalLoop()
    while true do
        if crystalToggle then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Red Crystal")
            end)
        end
        wait(2)
    end
end

spawn(CrystalLoop)

return function(state)
    crystalToggle = state
    if state then
        print("💎 AUTO-CRYSTALS ACTIVATED")
    else
        print("🛑 AUTO-CRYSTALS STOPPED")
    end
end
