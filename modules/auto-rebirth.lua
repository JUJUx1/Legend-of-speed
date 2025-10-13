local rebirthToggle = false

spawn(function()
    while wait(1) do
        if rebirthToggle then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            end)
        end
    end
end)

return function(state)
    rebirthToggle = state
    if state then
        print("🔄 AUTO-REBIRTH ACTIVATED")
    else
        print("🛑 AUTO-REBIRTH STOPPED")
    end
end
