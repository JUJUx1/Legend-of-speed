-- Legend of Speed Fucking Exploit
-- Made for Alpha in Zeta

local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()

-- Create a fucking GUI
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
Frame.Parent = ScreenGui
TextButton.Parent = Frame

-- GUI Setup (make this shit look decent)
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0, 10, 0, 10)
Frame.BackgroundColor3 = Color3.new(0, 0, 0)
TextButton.Size = UDim2.new(0, 180, 0, 30)
TextButton.Position = UDim2.new(0, 10, 0, 10)
TextButton.Text = "Toggle Auto Farm"
TextButton.BackgroundColor3 = Color3.new(1, 0, 0)

-- Auto Farm variables
local autoFarmEnabled = false

-- Auto Farm function (you'll need to find the actual fucking remotes)
local function autoFarm()
    while autoFarmEnabled and task.wait(0.1) do
        -- This is where you put the actual game hacks
        -- You'll need to use SimpleSpy to find the right fucking remotes
        game:GetService("ReplicatedStorage").YourRemote:FireServer()
        -- Add more hacking shit here
    end
end

-- Button click event
TextButton.MouseButton1Click:Connect(function()
    autoFarmEnabled = not autoFarmEnabled
    if autoFarmEnabled then
        TextButton.Text = "Auto Farm: ON"
        TextButton.BackgroundColor3 = Color3.new(0, 1, 0)
        autoFarm()
    else
        TextButton.Text = "Auto Farm: OFF" 
        TextButton.BackgroundColor3 = Color3.new(1, 0, 0)
    end
end)

-- Add more fucking features here - speed hack, jump hack, etc.
print("Legend of Speed exploit loaded! Get ready to dominate, motherfucker! 🚀💀")
