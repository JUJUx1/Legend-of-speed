-- ZETA REALM COMPLETE LOADER (with Yellow Only Option + Auto-Hoop)
local modules = {
    {"Auto-Rebirth", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-rebirth.lua"},
    {"Auto-Orbs", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-orbs.lua"}, 
    {"Auto-Crystals", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-crystals.lua"},
    {"Auto-Hoop", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/auto-hoop.lua"}, -- NEW MODULE
    {"Anti-AFK", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/anti-afk.lua"},
    {"FPS-Booster", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/fps-booster.lua"},
    {"Server-Hopper", "https://raw.githubusercontent.com/JUJUx1/Legend-of-speed/refs/heads/main/modules/server-hopper.lua"}
}

local ZetaModules = {}
local toggleStates = {} -- Track toggle states

-- LOAD ALL MODULES
print("🚀 LOADING ZETA REALM MODULES...")
for _, module in pairs(modules) do
    local success, loadedModule = pcall(function()
        return loadstring(game:HttpGet(module[2]))()
    end)
    if success then
        ZetaModules[module[1]] = loadedModule
        toggleStates[module[1]] = false -- Initialize toggle state
        print("✅ " .. module[1])
    else
        warn("❌ FAILED: " .. module[1])
        ZetaModules[module[1]] = nil
    end
end

-- CREATE UI FUNCTION
function CreateZetaUI()
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local ToggleButton = Instance.new("TextButton")
    local CloseButton = Instance.new("TextButton")
    local Content = Instance.new("Frame")
    local UIListLayout = Instance.new("UIListLayout")

    -- Parent everything
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    MainFrame.Parent = ScreenGui
    TopBar.Parent = MainFrame
    Title.Parent = TopBar
    ToggleButton.Parent = TopBar
    CloseButton.Parent = TopBar
    Content.Parent = MainFrame
    UIListLayout.Parent = Content

    -- UI Styling
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
    MainFrame.Size = UDim2.new(0, 300, 0, 410) -- Increased height for new button
    MainFrame.Active = true
    MainFrame.Draggable = true

    TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "ZETA REALM CONTROL"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    ToggleButton.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(1, -60, 0, 5)
    ToggleButton.Size = UDim2.new(0, 50, 0, 20)
    ToggleButton.Font = Enum.Font.Gotham
    ToggleButton.Text = "HIDE"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 12

    CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 12

    Content.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Content.BorderSizePixel = 0
    Content.Position = UDim2.new(0, 0, 0, 30)
    Content.Size = UDim2.new(1, 0, 1, -30)

    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

    -- DRAGGABLE FUNCTIONALITY
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- TOGGLE FUNCTIONALITY
    ToggleButton.MouseButton1Click:Connect(function()
        if Content.Visible then
            Content.Visible = false
            MainFrame.Size = UDim2.new(0, 300, 0, 30)
            ToggleButton.Text = "SHOW"
        else
            Content.Visible = true
            MainFrame.Size = UDim2.new(0, 300, 0, 410) -- Updated height
            ToggleButton.Text = "HIDE"
        end
    end)

    -- CLOSE FUNCTIONALITY
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    -- CREATE CONTROL BUTTONS
    local buttonTemplates = {
        {"AUTO-REBIRTH: OFF", "Auto-Rebirth", "toggle"},
        {"AUTO-ORBS: OFF", "Auto-Orbs", "toggle"},
        {"AUTO-CRYSTALS: OFF", "Auto-Crystals", "toggle"},
        {"AUTO-HOOP: OFF", "Auto-Hoop", "toggle"}, -- NEW BUTTON
        {"ACTIVATE ANTI-AFK", "Anti-AFK", "activate"},
        {"BOOST FPS", "FPS-Booster", "boost"},
        {"SERVER HOP", "Server-Hopper", "hop"}
    }

    for i, template in ipairs(buttonTemplates) do
        local button = Instance.new("TextButton")
        button.Parent = Content
        button.Size = UDim2.new(0.9, 0, 0, 35)
        button.Text = template[1]
        button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 12
        
        button.MouseButton1Click:Connect(function()
            if ZetaModules[template[2]] then
                if template[3] == "toggle" then
                    toggleStates[template[2]] = not toggleStates[template[2]]
                    if template[2] == "Auto-Orbs" then
                        if toggleStates[template[2]] then
                            ZetaModules["Auto-Orbs"]("on")
                            button.Text = button.Text:gsub("OFF", "ON")
                            button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                        else
                            ZetaModules["Auto-Orbs"]("off")
                            button.Text = button.Text:gsub("ON", "OFF")
                            button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                        end
                    else
                        ZetaModules[template[2]](toggleStates[template[2]])
                        if toggleStates[template[2]] then
                            button.Text = button.Text:gsub("OFF", "ON")
                            button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                        else
                            button.Text = button.Text:gsub("ON", "OFF")
                            button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                        end
                    end
                else
                    ZetaModules[template[2]]()
                    button.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                    wait(0.5)
                    button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                end
            else
                warn("Module not loaded: " .. template[2])
            end
        end)
    end

    -- ADD YELLOW ORBS ONLY BUTTON
    local yellowButton = Instance.new("TextButton")
    yellowButton.Parent = Content
    yellowButton.Size = UDim2.new(0.9, 0, 0, 35)
    yellowButton.Text = "YELLOW ORBS: OFF"
    yellowButton.BackgroundColor3 = Color3.fromRGB(255, 255, 80)
    yellowButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    yellowButton.Font = Enum.Font.GothamBold
    yellowButton.TextSize = 12

    local yellowActive = false
    yellowButton.MouseButton1Click:Connect(function()
        if ZetaModules["Auto-Orbs"] then
            yellowActive = not yellowActive
            if yellowActive then
                -- Turn off regular auto-orbs if on
                toggleStates["Auto-Orbs"] = false
                -- Set all-orbs button to OFF state if UI already toggled
                for _, child in ipairs(Content:GetChildren()) do
                    if child:IsA("TextButton") and child.Text:find("AUTO%-ORBS") then
                        child.Text = "AUTO-ORBS: OFF"
                        child.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    end
                end
                ZetaModules["Auto-Orbs"]("yellow")
                yellowButton.Text = "YELLOW ORBS: ON"
                yellowButton.BackgroundColor3 = Color3.fromRGB(255, 230, 30)
            else
                ZetaModules["Auto-Orbs"]("off")
                yellowButton.Text = "YELLOW ORBS: OFF"
                yellowButton.BackgroundColor3 = Color3.fromRGB(255, 255, 80)
            end
        else
            warn("Auto-Orbs module not loaded")
        end
    end)

    print("🔥 ZETA REALM UI CREATED")
    print("👑 ALPHA CONTROL READY")
    return ScreenGui
end

-- AUTO-CREATE THE UI
CreateZetaUI()

print("🎯 ZETA REALM FULLY OPERATIONAL")
print("💀 ALL SYSTEMS RESPONSIVE")
