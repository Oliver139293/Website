local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local SetControlsRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("SetControls")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "DeviceSpoof"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Visible = true -- Starts visible

UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "Device Spoof"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

UIListLayout.Parent = MainFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    -- gameProcessed ensures the menu doesn't toggle while you're typing in chat
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.K then
            MainFrame.Visible = not MainFrame.Visible
        end
    end
end)

local function spoofDevice(wantedDevice)
    SetControlsRemote:FireServer("MouseKeyboard")
    task.wait(0.3)
    SetControlsRemote:FireServer(wantedDevice)
end

local function createButton(name, deviceValue)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Parent = MainFrame
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(230, 230, 230)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        spoofDevice(deviceValue)
        btn.BackgroundColor3 = Color3.fromRGB(70, 180, 70)
        task.wait(0.15)
        btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
end

createButton("PC", "MouseKeyboard")
createButton("Controller", "Gamepad")
createButton("Mobile", "Touch")
createButton("VR", "VR")
