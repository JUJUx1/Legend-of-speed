local crystalToggle = false

spawn(function()
    while wait(2) do
        if crystalToggle then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.openCrystalRemote:InvokeServer("openCrystal", "Red Crystal")
            end)
        end
    end
end)

return function(state)
    crystalToggle = state
    if state then
        print("💎 AUTO-CRYSTALS ACTIVATED")
    else
        print("🛑 AUTO-CRYSTALS STOPPED")
    end
end
