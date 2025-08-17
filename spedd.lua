-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Theme
local theme = {Dark={bg=Color3.fromRGB(30,30,30), fg=Color3.fromRGB(255,255,255)}, Light={bg=Color3.fromRGB(245,245,245), fg=Color3.fromRGB(0,0,0)}}
local currentTheme = "Dark"

-- Function: Notification
local function showNotification(msg)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,300,0,80)
    frame.Position = UDim2.new(1,-320,1,-120)
    frame.AnchorPoint = Vector2.new(1,1)
    frame.BackgroundColor3 = theme[currentTheme].bg
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = msg
    label.TextColor3 = theme[currentTheme].fg
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.Parent = frame

    -- Tween animation
    local tweenIn = TweenService:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-120)})
    tweenIn:Play()
    tweenIn.Completed:Wait()
    wait(3)
    local tweenOut = TweenService:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1,-320,1,-220), BackgroundTransparency=1})
    tweenOut:Play()
    tweenOut.Completed:Wait()
    frame:Destroy()
end

showNotification("Welcome to the program")

-- Main Dashboard
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,400,0,500)
mainFrame.Position = UDim2.new(0.5,-200,0.5,-250)
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.BackgroundColor3 = theme[currentTheme].bg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,0)
title.Text = "Roben Dashboard"
title.BackgroundTransparency = 1
title.TextColor3 = theme[currentTheme].fg
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Parent = mainFrame

-- Theme Toggle
local themeBtn = Instance.new("TextButton")
themeBtn.Size = UDim2.new(0,120,0,40)
themeBtn.Position = UDim2.new(1,-130,0,10)
themeBtn.Text = "Toggle Theme"
themeBtn.BackgroundColor3 = theme[currentTheme].bg
themeBtn.TextColor3 = theme[currentTheme].fg
themeBtn.Font = Enum.Font.Gotham
themeBtn.TextSize = 14
themeBtn.Parent = mainFrame

themeBtn.MouseButton1Click:Connect(function()
    currentTheme = currentTheme=="Dark" and "Light" or "Dark"
    mainFrame.BackgroundColor3 = theme[currentTheme].bg
    title.TextColor3 = theme[currentTheme].fg
    themeBtn.BackgroundColor3 = theme[currentTheme].bg
    themeBtn.TextColor3 = theme[currentTheme].fg
end)

-- Movement Section
local movementFrame = Instance.new("Frame")
movementFrame.Size = UDim2.new(1,-20,0,250)
movementFrame.Position = UDim2.new(0,10,0,60)
movementFrame.BackgroundTransparency = 0.1
movementFrame.Parent = mainFrame

-- WalkSpeed
local wsSlider = Instance.new("TextButton")
wsSlider.Size = UDim2.new(1,0,0,30)
wsSlider.Position = UDim2.new(0,0,0,10)
wsSlider.Text = "WalkSpeed: 16"
wsSlider.Parent = movementFrame
wsSlider.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = 50
    wsSlider.Text = "WalkSpeed: "..tostring(humanoid.WalkSpeed)
end)

-- JumpPower
local jpSlider = Instance.new("TextButton")
jpSlider.Size = UDim2.new(1,0,0,30)
jpSlider.Position = UDim2.new(0,0,0,50)
jpSlider.Text = "JumpPower: 50"
jpSlider.Parent = movementFrame
jpSlider.MouseButton1Click:Connect(function()
    humanoid.JumpPower = 100
    jpSlider.Text = "JumpPower: "..tostring(humanoid.JumpPower)
end)

-- Infinite Jump
local infJump = false
UserInputService.JumpRequest:Connect(function()
    if infJump then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)
local infJumpBtn = Instance.new("TextButton")
infJumpBtn.Size = UDim2.new(1,0,0,30)
infJumpBtn.Position = UDim2.new(0,0,0,90)
infJumpBtn.Text = "Infinite Jump: OFF"
infJumpBtn.Parent = movementFrame
infJumpBtn.MouseButton1Click:Connect(function()
    infJump = not infJump
    infJumpBtn.Text = "Infinite Jump: "..(infJump and "ON" or "OFF")
end)

-- Noclip
local noclip = false
RunService.Stepped:Connect(function()
    if noclip then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)
local noclipBtn = Instance.new("TextButton")
noclipBtn.Size = UDim2.new(1,0,0,30)
noclipBtn.Position = UDim2.new(0,0,0,130)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.Parent = movementFrame
noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = "Noclip: "..(noclip and "ON" or "OFF")
end)

-- Fly
local flying = false
local flySpeed = 50
local flyBtn = Instance.new("TextButton")
flyBtn.Size = UDim2.new(1,0,0,30)
flyBtn.Position = UDim2.new(0,0,0,170)
flyBtn.Text = "Fly: OFF"
flyBtn.Parent = movementFrame
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = "Fly: "..(flying and "ON" or "OFF")
end)

local flyDir = Vector3.new()
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode==Enum.KeyCode.W then flyDir = Vector3.new(0,0,-1) end
    if input.KeyCode==Enum.KeyCode.S then flyDir = Vector3.new(0,0,1) end
    if input.KeyCode==Enum.KeyCode.A then flyDir = Vector3.new(-1,0,0) end
    if input.KeyCode==Enum.KeyCode.D then flyDir = Vector3.new(1,0,0) end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode==Enum.KeyCode.W or input.KeyCode==Enum.KeyCode.S or input.KeyCode==Enum.KeyCode.A or input.KeyCode==Enum.KeyCode.D then
        flyDir = Vector3.new()
    end
end)
RunService.RenderStepped:Connect(function(delta)
    if flying then
        root.CFrame = root.CFrame + flyDir*flySpeed*delta
    end
end)

-- ===============================
-- Aimbot Integration
-- ===============================

local TeammatesUsernames = {
    "hamza_x007j","Roben121200","ALG_DZ3","mikey7y77","haithem123k",
    "Player6","Player7","Player8","Player9","Player10",
}

local function IsTeammate(username)
    for _, name in ipairs(TeammatesUsernames) do
        if name == username then return true end
    end
    return false
end

local Aimbot = {
    Enabled = true,
    AimPart = "Head",
    Sensitivity = 0.3,
    Prediction = 0.05,
    MaxRange = 300,
}

local aiming = false
local tabToggle = true
local currentTarget = nil
local aimFlowTrigger = false

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Tab then
        tabToggle = not tabToggle
        print("Aimbot "..(tabToggle and "Enabled" or "Disabled"))
        if not tabToggle then currentTarget = nil end
    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = true
    elseif input.KeyCode == Enum.KeyCode.Space then
        aimFlowTrigger = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gp)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        aiming = false
        currentTarget = nil
    end
end)

local function IsValidTarget(plr)
    if not plr or not plr.Character or not plr.Character:FindFirstChild(Aimbot.AimPart) or not plr.Character:FindFirstChild("Humanoid") then return false end
    if plr.Character.Humanoid.Health <= 0 then return false end
    if IsTeammate(plr.Name) then return false end
    return true
end

local function GetClosestToCrosshair()
    local bestTarget = nil
    local closestDist = math.huge
    local mousePos = UserInputService:GetMouseLocation()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = myChar.HumanoidRootPart.Position

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and IsValidTarget(plr) then
            local head = plr.Character[Aimbot.AimPart]
            local dist3D = (head.Position - myPos).Magnitude
            if dist3D <= Aimbot.MaxRange then
                local predictedPos = head.Position + (head.Velocity * Aimbot.Prediction)
                local screenPos, onScreen = Camera:WorldToViewportPoint(predictedPos)
                if onScreen then
                    local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mousePos.X, mousePos.Y)).Magnitude
                    if screenDist < closestDist then
                        closestDist = screenDist
                        bestTarget = plr
                    end
                end
            end
        end
    end
    return bestTarget
end

RunService.RenderStepped:Connect(function()
    if tabToggle and aiming and Aimbot.Enabled and aimFlowTrigger then
        if





