
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
        return loadstring(game:HttpGet(module[2], true))()
    end)
    if success then
        ZetaModules[module[1]] = loadedModule
        toggleStates[module[1]] = false
        print("✅ Loaded " .. module[1])
    else
        warn("❌ FAILED to load " .. module[1] .. ": " .. tostring(loadedModule))
        ZetaModules[module[1]] = nil
    end
end

-- COMMAND EXECUTOR FOR DIRECT MODULE CONTROL
local function ExecuteModule(moduleName, cmd, ...)
    if ZetaModules[moduleName] then
        local success, result = pcall(function()
            return ZetaModules[moduleName](cmd, ...)
        end)
        if success then
            print("🎯 Executed " .. moduleName .. " with command: " .. tostring(cmd))
        else
            warn("❌ FAILED to execute " .. moduleName .. " with command " .. tostring(cmd) .. ": " .. tostring(result))
        end
    else
        warn("❌ Module " .. moduleName .. " not loaded")
    end
end

-- LOAD UI FROM SEPARATE FILE
local function LoadUI()
    local success, uiFunction = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/ui/main-ui.lua", true))()
    end)
    if success then
        uiFunction(ZetaModules, toggleStates, ExecuteModule)
        print("🔥 ZETA REALM UI CREATED")
    else
        warn("❌ FAILED TO LOAD UI: " .. tostring(uiFunction))
    end
end

-- AUTO-CREATE THE UI
LoadUI()

-- EXAMPLE: AUTO-START ORB FARMING (Optional)
-- ExecuteModule("Auto-Orbs", "farm", "Red Orb", "Desert")

print("🎯 ZETA REALM FULLY OPERATIONAL")
print("💀 ALL SYSTEMS RESPONSIVE")
