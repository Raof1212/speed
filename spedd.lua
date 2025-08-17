--// Roben V1 - Base Build
--// Developer: Roben

--// Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

--// Variables
local flying = false
local flySpeed = 50
local walkSpeed = 16
local jumpPower = 50
local gravity = 196.2
local doubleJumpEnabled = false
local canDoubleJump = true

--// UI Library (simple)
local Library = {}
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "RobenV1"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Title.Text = "Roben V1"
Title.TextColor3 = Color3.fromRGB(0, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20

-- Tabs
local Tabs = Instance.new("Folder", MainFrame)

local MovementTab = Instance.new("Frame", Tabs)
MovementTab.Size = UDim2.new(1, 0, 1, -40)
MovementTab.Position = UDim2.new(0, 0, 0, 40)
MovementTab.BackgroundTransparency = 1

local KeybindsTab = Instance.new("Frame", Tabs)
KeybindsTab.Size = UDim2.new(1, 0, 1, -40)
KeybindsTab.Position = UDim2.new(0, 0, 0, 40)
KeybindsTab.BackgroundTransparency = 1
KeybindsTab.Visible = false

local CreditsTab = Instance.new("Frame", Tabs)
CreditsTab.Size = UDim2.new(1, 0, 1, -40)
CreditsTab.Position = UDim2.new(0, 0, 0, 40)
CreditsTab.BackgroundTransparency = 1
CreditsTab.Visible = false

-- Tab Buttons
local function createTabButton(name, order, tabFrame)
    local Button = Instance.new("TextButton", MainFrame)
    Button.Size = UDim2.new(0, 120, 0, 30)
    Button.Position = UDim2.new(0, (order-1) * 120, 0, 40)
    Button.Text = name
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.MouseButton1Click:Connect(function()
        for _, frame in pairs(Tabs:GetChildren()) do
            frame.Visible = false
        end
        tabFrame.Visible = true
    end)
end

createTabButton("Movement", 1, MovementTab)
createTabButton("Keybinds", 2, KeybindsTab)
createTabButton("Credits", 3, CreditsTab)

-- Movement Controls
local SpeedBox = Instance.new("TextBox", MovementTab)
SpeedBox.PlaceholderText = "WalkSpeed (Default 16)"
SpeedBox.Size = UDim2.new(0, 200, 0, 30)
SpeedBox.Position = UDim2.new(0, 10, 0, 10)
SpeedBox.Text = ""
SpeedBox.FocusLost:Connect(function()
    local val = tonumber(SpeedBox.Text)
    if val then
        walkSpeed = val
        Humanoid.WalkSpeed = val
    end
end)

local FlyBox = Instance.new("TextBox", MovementTab)
FlyBox.PlaceholderText = "FlySpeed (Default 50)"
FlyBox.Size = UDim2.new(0, 200, 0, 30)
FlyBox.Position = UDim2.new(0, 10, 0, 50)
FlyBox.Text = ""
FlyBox.FocusLost:Connect(function()
    local val = tonumber(FlyBox.Text)
    if val then
        flySpeed = val
    end
end)

local JumpBox = Instance.new("TextBox", MovementTab)
JumpBox.PlaceholderText = "JumpPower (Default 50)"
JumpBox.Size = UDim2.new(0, 200, 0, 30)
JumpBox.Position = UDim2.new(0, 10, 0, 90)
JumpBox.Text = ""
JumpBox.FocusLost:Connect(function()
    local val = tonumber(JumpBox.Text)
    if val then
        jumpPower = val
        Humanoid.JumpPower = val
    end
end)

local GravityBox = Instance.new("TextBox", MovementTab)
GravityBox.PlaceholderText = "Gravity (Default 196.2)"
GravityBox.Size = UDim2.new(0, 200, 0, 30)
GravityBox.Position = UDim2.new(0, 10, 0, 130)
GravityBox.Text = ""
GravityBox.FocusLost:Connect(function()
    local val = tonumber(GravityBox.Text)
    if val then
        gravity = val
        workspace.Gravity = val
    end
end)

local DoubleJumpToggle = Instance.new("TextButton", MovementTab)
DoubleJumpToggle.Size = UDim2.new(0, 200, 0, 30)
DoubleJumpToggle.Position = UDim2.new(0, 10, 0, 170)
DoubleJumpToggle.Text = "Double Jump: OFF"
DoubleJumpToggle.MouseButton1Click:Connect(function()
    doubleJumpEnabled = not doubleJumpEnabled
    DoubleJumpToggle.Text = "Double Jump: " .. (doubleJumpEnabled and "ON" or "OFF")
end)

-- Fly System
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        flying = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Space then
        flying = false
    end
end)

RunService.RenderStepped:Connect(function()
    if flying then
        Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        local camCF = workspace.CurrentCamera.CFrame
        local moveDir = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
        Character:TranslateBy(moveDir * flySpeed * RunService.Heartbeat:Wait())
    end
end)

-- Keybinds (for now just show info, later expand)
local KeybindsLabel = Instance.new("TextLabel", KeybindsTab)
KeybindsLabel.Size = UDim2.new(1, 0, 0, 30)
KeybindsLabel.Text = "Keybinds Tab (customize coming soon)"
KeybindsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeybindsLabel.BackgroundTransparency = 1

-- Credits
local CreditsLabel = Instance.new("TextLabel", CreditsTab)
CreditsLabel.Size = UDim2.new(1, 0, 1, 0)
CreditsLabel.Text = "Roben – Developer | Version 1"
CreditsLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
CreditsLabel.Font = Enum.Font.GothamBold
CreditsLabel.TextSize = 20
CreditsLabel.BackgroundTransparency = 1

