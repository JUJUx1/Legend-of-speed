-- WORKING AUTO-REBIRTH
local rebirthToggle = false

local function AutoRebirth()
    while rebirthToggle and wait(0.5) do
        pcall(function()
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
        end)
    end
end

return {
    Toggle = function(state)
        rebirthToggle = state
        if state then
            print("🔄 AUTO-REBIRTH ACTIVATED")
            spawn(AutoRebirth)
        else
            print("🛑 AUTO-REBIRTH STOPPED")
        end
    end
}
