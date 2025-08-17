loadstring(game:HttpGet("https://pastebin.com/raw/your-paste-id", true))()

--[[ 
Replace the Pastebin URL with a hosted version of the full script below if needed.
This is the single-file version. Copy-paste into a local script or executor.
--]]

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.ResetOnSpawn = false

-- Theme Colors
local theme = {Dark={bg=Color3.fromRGB(25,25,25), fg=Color3.fromRGB(255,255,255)}, Light={bg=Color3.fromRGB(245,245,245), fg=Color3.fromRGB(0,0,0)}}
local currentTheme = "Dark"

-- Main Frame
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0,400,0,500)
mainFrame.Position = UDim2.new(0.5,-200,0.5,-250)
mainFrame.BackgroundColor3 = theme[currentTheme].bg
mainFrame.BorderSizePixel = 0
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1,0,0,50)
title.Text = "Roben Dashboard"
title.BackgroundTransparency = 1
title.TextColor3 = theme[currentTheme].fg
title.Font = Enum.Font.GothamBold
title.TextSize = 24

-- Theme Toggle Button
local themeBtn = Instance.new("TextButton", mainFrame)
themeBtn.Size = UDim2.new(0,120,0,40)
themeBtn.Position = UDim2.new(1,-130,0,10)
themeBtn.Text = "Toggle Theme"
themeBtn.BackgroundColor3 = theme[currentTheme].bg
themeBtn.TextColor3 = theme[currentTheme].fg
themeBtn.Font = Enum.Font.Gotham
themeBtn.TextSize = 14

themeBtn.MouseButton1Click:Connect(function()
    currentTheme = currentTheme=="Dark" and "Light" or "Dark"
    mainFrame.BackgroundColor3 = theme[currentTheme].bg
    title.TextColor3 = theme[currentTheme].fg
    themeBtn.BackgroundColor3 = theme[currentTheme].bg
    themeBtn.TextColor3 = theme[currentTheme].fg
end)

-- Notification Function
local function showNotification(msg)
    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.new(0,300,0,80)
    frame.Position = UDim2.new(1,-320,1,-120)
    frame.AnchorPoint = Vector2.new(1,1)
    frame.BackgroundColor3 = theme[currentTheme].bg
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.Text = msg
    label.TextColor3 = theme[currentTheme].fg
    label.TextSize = 20
    label.Font = Enum.Font.GothamBold

    local tweenIn = TweenService:Create(frame, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-120)})
    tweenIn:Play()
    tweenIn.Completed:Wait()
    wait(3)
    local tweenOut = TweenService:Create(frame, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1,-320,1,-220), BackgroundTransparency=1})
    tweenOut:Play()
    tweenOut.Completed:Wait()
    frame:Destroy()
end

showNotification("Welcome to the program")

-- Movement Section
local movementFrame = Instance.new("Frame", mainFrame)
movementFrame.Size = UDim2.new(1,-20,0,250)
movementFrame.Position = UDim2.new(0,10,0,60)
movementFrame.BackgroundTransparency = 0.1

-- WalkSpeed Slider
local wsSlider = Instance.new("TextButton", movementFrame)
wsSlider.Size = UDim2.new(1,0,0,30)
wsSlider.Position = UDim2.new(0,0,0,10)
wsSlider.Text = "WalkSpeed: 16"
wsSlider.MouseButton1Click:Connect(function()
    humanoid.WalkSpeed = 50
    wsSlider.Text = "WalkSpeed: "..tostring(humanoid.WalkSpeed)
end)

-- JumpPower Slider
local jpSlider = Instance.new("TextButton", movementFrame)
jpSlider.Size = UDim2.new(1,0,0,30)
jpSlider.Position = UDim2.new(0,0,0,50)
jpSlider.Text = "JumpPower: 50"
jpSlider.MouseButton1Click:Connect(function()
    humanoid.JumpPower = 100
    jpSlider.Text = "JumpPower: "..tostring(humanoid.JumpPower)
end)

-- Infinite Jump
local infJump = false
UserInputService.JumpRequest:Connect(function()
    if infJump then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)
local infJumpBtn = Instance.new("TextButton", movementFrame)
infJumpBtn.Size = UDim2.new(1,0,0,30)
infJumpBtn.Position = UDim2.new(0,0,0,90)
infJumpBtn.Text = "Infinite Jump: OFF"
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
local noclipBtn = Instance.new("TextButton", movementFrame)
noclipBtn.Size = UDim2.new(1,0,0,30)
noclipBtn.Position = UDim2.new(0,0,0,130)
noclipBtn.Text = "Noclip: OFF"
noclipBtn.MouseButton1Click:Connect(function()
    noclip = not noclip
    noclipBtn.Text = "Noclip: "..(noclip and "ON" or "OFF")
end)

-- Fly
local flying = false
local flySpeed = 50
local flyBtn = Instance.new("TextButton", movementFrame)
flyBtn.Size = UDim2.new(1,0,0,30)
flyBtn.Position = UDim2.new(0,0,0,170)
flyBtn.Text = "Fly: OFF"
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = "Fly: "..(flying and "ON" or "OFF")
end)

-- Fly Logic
local flyDir = Vector3.new()
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W then flyDir = Vector3.new(0,0,-1) end
    if input.KeyCode == Enum.KeyCode.S then flyDir = Vector3.new(0,0,1) end
    if input.KeyCode == Enum.KeyCode.A then flyDir = Vector3.new(-1,0,0) end
    if input.KeyCode == Enum.KeyCode.D then flyDir = Vector3.new(1,0,0) end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode==Enum.KeyCode.W or input.KeyCode==Enum.KeyCode.S or input.KeyCode==Enum.KeyCode.A or input.KeyCode==Enum.KeyCode.D then
        flyDir = Vector3.new()
    end
end)
RunService.RenderStepped:Connect(function(delta)
    if flying then
        root.CFrame = root.CFrame + flyDir * flySpeed * delta
    end
end)
