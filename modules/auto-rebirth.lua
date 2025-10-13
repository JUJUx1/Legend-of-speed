-- AUTO REBIRTH SYSTEM
local rebirthToggle = false

local function AutoRebirth()
    while rebirthToggle and wait(0.1) do
        pcall(function()
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
        end)
    end
end

return {
    Toggle = function(state)
        rebirthToggle = state
        if state then
            spawn(AutoRebirth)
        end
    end
}