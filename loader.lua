-- ZETA REALM LOADER (MAIN FILE)
local modules = {
    {"Auto-Rebirth", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-rebirth.lua"},
    {"Auto-Orbs", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-orbs.lua"}, 
    {"Auto-Crystals", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-crystals.lua"},
    {"Auto-Hoop", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-hoop.lua"},
    {"Anti-AFK", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/anti-afk.lua"},
    {"FPS-Booster", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/fps-booster.lua"},
    {"Server-Hopper", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/server-hopper.lua"}
}

local ZetaModules = {}
local toggleStates = {}

-- LOAD ALL MODULES
print("🚀 LOADING ZETA REALM MODULES...")
for _, module in pairs(modules) do
    local success, loadedModule = pcall(function()
        return loadstring(game:HttpGet(module[2]))()
    end)
    if success then
        ZetaModules[module[1]] = loadedModule
        toggleStates[module[1]] = false
        print("✅ " .. module[1])
    else
        warn("❌ FAILED: " .. module[1])
        ZetaModules[module[1]] = nil
    end
end

-- LOAD UI FROM SEPARATE FILE
local function LoadUI()
    local success, uiFunction = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/ui/main-ui.lua"))()
    end)
    
    if success then
        uiFunction(ZetaModules, toggleStates)
        print("🔥 ZETA REALM UI CREATED")
    else
        warn("❌ FAILED TO LOAD UI")
    end
end

-- AUTO-CREATE THE UI
LoadUI()

print("🎯 ZETA REALM FULLY OPERATIONAL")
print("💀 ALL SYSTEMS RESPONSIVE")
