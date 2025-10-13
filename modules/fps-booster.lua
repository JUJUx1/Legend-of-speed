-- FPS BOOSTER
return {
    Boost = function()
        settings().Rendering.QualityLevel = 1
        game:GetService("Lighting").GlobalShadows = false
    end
}