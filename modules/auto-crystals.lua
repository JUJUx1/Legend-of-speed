-- AUTO CRYSTAL OPENER
local crystalToggle = false

local function OpenCrystals()
    while crystalToggle and wait(0.3) do
        pcall(function()
            local crystals = {"Red Crystal", "Purple Crystal", "Yellow Crystal"}
            for _, crystal in pairs(crystals) do
                game:GetService('ReplicatedStorage').rEvents.openCrystalRemote:InvokeServer("openCrystal", crystal)
            end
        end)
    end
end

return {
    Toggle = function(state)
        crystalToggle = state
        if state then
            spawn(OpenCrystals)
        end
    end
}