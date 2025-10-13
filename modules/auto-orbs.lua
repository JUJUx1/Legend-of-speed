-- AUTO ORB COLLECTOR
local orbToggle = false

local function CollectOrbs()
    while orbToggle and wait(0.2) do
        pcall(function()
            local locations = {"City", "Snow City", "Magma City"}
            local orbTypes = {"Yellow Orb", "Red Orb", "Gem"}
            
            for _, location in pairs(locations) do
                for _, orbType in pairs(orbTypes) do
                    game:GetService('ReplicatedStorage').rEvents.orbEvent:FireServer("collectOrb", orbType, location)
                end
            end
        end)
    end
end

return {
    Toggle = function(state)
        orbToggle = state
        if state then
            spawn(CollectOrbs)
        end
    end
}