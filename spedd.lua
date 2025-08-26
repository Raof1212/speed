--// Services
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

--// Main UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0

--// Make draggable
local function makeDraggable(frame)
    local dragToggle, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

makeDraggable(MainFrame)

--// Tabs holder
local Tabs = Instance.new("Frame", MainFrame)
Tabs.Size = UDim2.new(0, 120, 1, 0)
Tabs.BackgroundColor3 = Color3.fromRGB(35, 35, 35)

--// Scrolling area for settings
local Content = Instance.new("ScrollingFrame", MainFrame)
Content.Position = UDim2.new(0, 120, 0, 0)
Content.Size = UDim2.new(1, -120, 1, 0)
Content.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ScrollBarThickness = 6

--// Layout for scrolling
local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 6)
Layout.SortOrder = Enum.SortOrder.LayoutOrder

--// Example Section (replace with your real settings)
local Example = Instance.new("TextButton", Content)
Example.Size = UDim2.new(1, -10, 0, 30)
Example.Position = UDim2.new(0, 5, 0, 5)
Example.Text = "WalkSpeed"
Example.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Example.TextColor3 = Color3.fromRGB(255, 255, 255)

local Example2 = Instance.new("TextButton", Content)
Example2.Size = UDim2.new(1, -10, 0, 30)
Example2.Text = "JumpPower"
Example2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Example2.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Add the rest of your sections/settings below this
-- (Fly, Gravity, Inf Jump, Noclip, Velocity Spoofer, etc.)
-- They will all fit automatically inside the scrolling frame now
