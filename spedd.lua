-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Theme
local theme = {Dark={bg=Color3.fromRGB(30,30,30), fg=Color3.fromRGB(255,255,255)}, Light={bg=Color3.fromRGB(245,245,245), fg=Color3.fromRGB(0,0,0)}}
local currentTheme = "Dark"

-- Dashboard visibility toggle
local dashboardVisible = true
local function toggleDashboard()
    dashboardVisible = not dashboardVisible
    mainFrame.Visible = dashboardVisible
end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,400,0,500)
mainFrame.Position = UDim2.new(0.5,-200,0.5,-250)
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.BackgroundColor3 = theme[currentTheme].bg
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,0)
title.Text = "RaOf v1"
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

-- Sections container
local sectionsY = 60

local function createSection(name)
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1,-20,0,100)
    section.Position = UDim2.new(0,10,0,sectionsY)
    section.BackgroundTransparency = 0.1
    section.Parent = mainFrame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,20)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = theme[currentTheme].fg
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = section

    sectionsY = sectionsY + 110
    return section
end

-- Keybinds Section
local keybindsSection = createSection("Keybinds")
local keybindLabel = Instance.new("TextLabel")
keybindLabel.Size = UDim2.new(1,0,0,30)
keybindLabel.Position = UDim2.new(0,0,0,30)
keybindLabel.BackgroundTransparency = 1
keybindLabel.Text = "Left Ctrl: Toggle Dashboard"
keybindLabel.TextColor3 = theme[currentTheme].fg
keybindLabel.Font = Enum.Font.Gotham
keybindLabel.TextSize = 14
keybindLabel.Parent = keybindsSection

-- Aimbot Settings Section
local aimbotSection = createSection("Aimbot Settings")
local sensLabel = Instance.new("TextLabel")
sensLabel.Size = UDim2.new(1,0,0,30)
sensLabel.Position = UDim2.new(0,0,0,30)
sensLabel.BackgroundTransparency = 1
sensLabel.Text = "Sensitivity: 1.0"
sensLabel.TextColor3 = theme[currentTheme].fg
sensLabel.Font = Enum.Font.Gotham
sensLabel.TextSize = 14
sensLabel.Parent = aimbotSection

local predLabel = Instance.new("TextLabel")
predLabel.Size = UDim2.new(1,0,0,30)
predLabel.Position = UDim2.new(0,0,0,60)
predLabel.BackgroundTransparency = 1
predLabel.Text = "Prediction: 0.0"
predLabel.TextColor3 = theme[currentTheme].fg
predLabel.Font = Enum.Font.Gotham
predLabel.TextSize = 14
predLabel.Parent = aimbotSection

-- Teammates Section
local teammatesSection = createSection("Teammates")
local teammateList = Instance.new("TextBox")
teammateList.Size = UDim2.new(1,0,0,50)
teammateList.Position = UDim2.new(0,0,0,30)
teammateList.PlaceholderText = "Add username to ignore"
teammateList.TextColor3 = theme[currentTheme].fg
teammateList.BackgroundColor3 = theme[currentTheme].bg
teammateList.ClearTextOnFocus = false
teammateList.Font = Enum.Font.Gotham
teammateList.TextSize = 14
teammateList.Parent = teammatesSection

-- Visibility Toggle
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        toggleDashboard()
    end
end)




