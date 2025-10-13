local rebirthToggle = false

local function RebirthLoop()
    while true do
        if rebirthToggle then
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            end)
        end
        wait(1)
    end
end

spawn(RebirthLoop)

return function(state)
    rebirthToggle = state
    if state then
        print("🔄 AUTO-REBIRTH ACTIVATED")
    else
        print("🛑 AUTO-REBIRTH STOPPED")
    end
end
