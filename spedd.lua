-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- Theme
local theme = {Dark={bg=Color3.fromRGB(30,30,30), fg=Color3.fromRGB(255,255,255)}, Light={bg=Color3.fromRGB(245,245,245), fg=Color3.fromRGB(0,0,0)}}
local currentTheme = "Dark"

-- Function: Show bottom-right notification
local function showNotification(message)
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
    label.Text = message
    label.TextColor3 = theme[currentTheme].fg
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20
    label.Parent = frame

    -- Slide-in animation
    local tweenIn = TweenService:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=UDim2.new(1,-320,1,-120)})
    tweenIn:Play()
    tweenIn.Completed:Wait()

    wait(3)

    -- Slide-out animation
    local tweenOut = TweenService:Create(frame,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Position=UDim2.new(1,-320,1,-220), BackgroundTransparency=1})
    tweenOut:Play()
    tweenOut.Completed:Wait()

    frame:Destroy()
end

-- Show the notification
showNotification("Welcome to the program")

-- Basic Program Dashboard Frame
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





