--// Roben V1 Script
--// Developer: Roben | Version: 1
--// Based on Mercy Script structure, rebranded & customized

--// Services
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

--// UI Library (Mercy Script base)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Hm5011/hussain/refs/heads/main/Mercy%20Script"))()
local Window = Library:CreateWindow("Roben V1")

--// Settings storage
local Settings = {
    Aimbot = {Enabled = false, Key = Enum.KeyCode.E},
    Fly = {Enabled = false, Key = Enum.KeyCode.Q, Speed = 50},
    Speed = {Value = 16},
    Jump = {Power = 50, DoubleJump = false, Key = Enum.KeyCode.Space},
    Gravity = {Value = workspace.Gravity},
    UIToggle = Enum.KeyCode.RightShift,
}

-- Load saved settings if exist
pcall(function()
    local data = game:GetService("HttpService"):JSONDecode(readfile("RobenV1_Settings.json"))
    if data then Settings = data end
end)

local function SaveSettings()
    writefile("RobenV1_Settings.json", game:GetService("HttpService"):JSONEncode(Settings))
end

--// Main Tab (Aimbot)
local Main = Window:CreateTab("Main")
Main:CreateToggle("Aimbot", Settings.Aimbot.Enabled, function(state)
    Settings.Aimbot.Enabled = state
    SaveSettings()
end)

--// Movement Tab
local Movement = Window:CreateTab("Movement")
Movement:CreateSlider("Speed", 16, 200, Settings.Speed.Value, function(val)
    Settings.Speed.Value = val
    Humanoid.WalkSpeed = val
    SaveSettings()
end)

Movement:CreateSlider("Fly Speed", 10, 200, Settings.Fly.Speed, function(val)
    Settings.Fly.Speed = val
    SaveSettings()
end)

Movement:CreateToggle("Fly", Settings.Fly.Enabled, function(state)
    Settings.Fly.Enabled = state
    SaveSettings()
end)

Movement:CreateSlider("Jump Power", 50, 300, Settings.Jump.Power, function(val)
    Settings.Jump.Power = val
    Humanoid.JumpPower = val
    SaveSettings()
end)

Movement:CreateToggle("Double Jump", Settings.Jump.DoubleJump, function(state)
    Settings.Jump.DoubleJump = state
    SaveSettings()
end)

Movement:CreateSlider("Gravity", 0, 500, Settings.Gravity.Value, function(val)
    Settings.Gravity.Value = val
    workspace.Gravity = val
    SaveSettings()
end)

--// Keybinds Tab
local Keybinds = Window:CreateTab("Keybinds")
Keybinds:CreateKeybind("Aimbot Key", Settings.Aimbot.Key, function(key)
    Settings.Aimbot.Key = key
    SaveSettings()
end)
Keybinds:CreateKeybind("Fly Toggle", Settings.Fly.Key, function(key)
    Settings.Fly.Key = key
    SaveSettings()
end)
Keybinds:CreateKeybind("Double Jump Key", Settings.Jump.Key, function(key)
    Settings.Jump.Key = key
    SaveSettings()
end)
Keybinds:CreateKeybind("UI Toggle", Settings.UIToggle, function(key)
    Settings.UIToggle = key
    Library:SetToggleKey(key)
    SaveSettings()
end)

--// Credits Tab
local Credits = Window:CreateTab("Credits")
Credits:CreateLabel("Roben – Developer")
Credits:CreateLabel("Version 1")

--// Features Logic
-- Fly logic
local flying = false
local bodyVel, bodyGyro

local function StartFly()
    if not flying then
        flying = true
        local char = LocalPlayer.Character
        local root = char:WaitForChild("HumanoidRootPart")

        bodyVel = Instance.new("BodyVelocity", root)
        bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)

        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    end
end

local function StopFly()
    flying = false
    if bodyVel then bodyVel:Destroy() end
    if bodyGyro then bodyGyro:Destroy() end
end

-- Fly handler
game:GetService("RunService").Heartbeat:Connect(function()
    if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local root = LocalPlayer.Character.HumanoidRootPart
        bodyVel.Velocity = (LocalPlayer:GetMouse().Hit.p - root.Position).unit * Settings.Fly.Speed
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
    end
end)

-- Double Jump handler
local jumpCount = 0
Humanoid.StateChanged:Connect(function(_, new)
    if new == Enum.HumanoidStateType.Landed then
        jumpCount = 0
    elseif new == Enum.HumanoidStateType.Jumping then
        jumpCount += 1
        if jumpCount == 2 and Settings.Jump.DoubleJump then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Input handling for toggles
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Settings.Fly.Key then
        if flying then StopFly() else StartFly() end
    end
end)

-- Apply saved values on load
Humanoid.WalkSpeed = Settings.Speed.Value
Humanoid.JumpPower = Settings.Jump.Power
workspace.Gravity = Settings.Gravity.Value
Library:SetToggleKey(Settings.UIToggle)

-- Done ✅

