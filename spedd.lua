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
local theme = {
    Dark = {bg=Color3.fromRGB(30,30,30), fg=Color3.fromRGB(255,255,255), section=Color3.fromRGB(45,45,45)},
    Light = {bg=Color3.fromRGB(245,245,245), fg=Color3.fromRGB(0,0,0), section=Color3.fromRGB(220,220,220)}
}
local currentTheme = "Dark"

-- Dashboard visibility
local dashboardVisible = true
local function toggleDashboard()
    dashboardVisible = not dashboardVisible
    mainFrame.Visible = dashboardVisible
end

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0,450,0,500)
mainFrame.Position = UDim2.new(0.5,-225,0.5,-250)
mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
mainFrame.BackgroundColor3 = theme[currentTheme].bg
mainFrame.BorderSizePixel = 0
mainFrame.RoundedCorner = Instance.new("UICorner", mainFrame)
mainFrame.RoundedCorner.CornerRadius = UDim.new(0,12)
mainFrame.Parent = gui

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,50)
title.Position = UDim2.new(0,0,0,0)
title.BackgroundTransparency = 1
title.Text = "RaOf v1"
title.TextColor3 = theme[currentTheme].fg
title.Font = Enum.Font.GothamBold
title.TextSize = 26
title.Parent = mainFrame

-- Theme Toggle Button
local themeBtn = Instance.new("TextButton")
themeBtn.Size = UDim2.new(0,120,0,35)
themeBtn.Position = UDim2.new(1,-140,0,10)
themeBtn.Text = "Toggle Theme"
themeBtn.BackgroundColor3 = theme[currentTheme].section
themeBtn.TextColor3 = theme[currentTheme].fg
themeBtn.Font = Enum.Font.Gotham
themeBtn.TextSize = 14
themeBtn.AutoButtonColor = true
themeBtn.Parent = mainFrame

themeBtn.MouseButton1Click:Connect(function()
    currentTheme = currentTheme == "Dark" and "Light" or "Dark"
    mainFrame.BackgroundColor3 = theme[currentTheme].bg
    title.TextColor3 = theme[currentTheme].fg
    themeBtn.BackgroundColor3 = theme[currentTheme].section
    themeBtn.TextColor3 = theme[currentTheme].fg
    -- Update section colors dynamically
    for _, section in ipairs(mainFrame:GetChildren()) do
        if section:IsA("Frame") and section ~= mainFrame then
            section.BackgroundColor3 = theme[currentTheme].section
            for _, child in ipairs(section:GetChildren()) do
                if child:IsA("TextLabel") or child:IsA("TextBox") then
                    child.TextColor3 = theme[currentTheme].fg
                    if child:IsA("TextBox") then
                        child.BackgroundColor3 = theme[currentTheme].bg
                    end
                end
            end
        end
    end
end)

-- Helper function: create section
local sectionsY = 60
local function createSection(name, height)
    height = height or 100
    local section = Instance.new("Frame")
    section.Size = UDim2.new(1,-20,0,height)
    section.Position = UDim2.new(0,10,0,sectionsY)
    section.BackgroundColor3 = theme[currentTheme].section
    section.BorderSizePixel = 0
    section.Parent = mainFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,8)
    corner.Parent = section

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,25)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = theme[currentTheme].fg
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = section

    sectionsY = sectionsY + height + 10
    return section
end

-- Keybinds Section
local keybindSection = createSection("Keybinds", 60)
local keybindLabel = Instance.new("TextLabel")
keybindLabel.Size = UDim2.new(1,0,0,30)
keybindLabel.Position = UDim2.new(0,0,0,30)
keybindLabel.BackgroundTransparency = 1
keybindLabel.Text = "Left Ctrl: Toggle Dashboard"
keybindLabel.TextColor3 = theme[currentTheme].fg
keybindLabel.Font = Enum.Font.Gotham
keybindLabel.TextSize = 14
keybindLabel.Parent = keybindSection

-- Aimbot Settings Section
local aimbotSection = createSection("Aimbot Settings", 100)
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
local teammatesSection = createSection("Teammates", 80)
local teammateBox = Instance.new("TextBox")
teammateBox.Size = UDim2.new(1,0,0,40)
teammateBox.Position = UDim2.new(0,0,0,30)
teammateBox.PlaceholderText = "Add username to ignore"
teammateBox.TextColor3 = theme[currentTheme].fg
teammateBox.BackgroundColor3 = theme[currentTheme].bg
teammateBox.ClearTextOnFocus = false
teammateBox.Font = Enum.Font.Gotham
teammateBox.TextSize = 14
teammateBox.Parent = teammatesSection

-- Left Ctrl: toggle dashboard
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.LeftControl then
        toggleDashboard()
    end
end)



