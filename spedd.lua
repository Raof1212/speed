-- Roben V1 Script Hub

-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Roben V1", "DarkTheme")

----------------------------------------------------------------------
-- MAIN TAB
----------------------------------------------------------------------
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Movement")

-- Adjustable Walk Speed
MainSection:NewSlider("Walk Speed", "Adjust your walk speed", 16, 500, function(s) -- min, max
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- Adjustable Fly
local flyEnabled = false
local flySpeed = 50

MainSection:NewToggle("Fly (Q)", "Press Q or toggle here to fly", function(state)
    flyEnabled = state
    local player = game.Players.LocalPlayer
    local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")
    local UserInputService = game:GetService("UserInputService")

    if flyEnabled then
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.Velocity = Vector3.new(0,0,0)
        bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVel.Parent = humanoidRootPart

        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.P = 10000
        bodyGyro.Parent = humanoidRootPart

        local connection
        connection = game:GetService("RunService").RenderStepped:Connect(function()
            if not flyEnabled then
                bodyVel:Destroy()
                bodyGyro:Destroy()
                connection:Disconnect()
                return
            end
            local moveDirection = Vector3.new(0,0,0)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
            end
            bodyVel.Velocity = moveDirection * flySpeed
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end)
    end
end)

MainSection:NewSlider("Fly Speed", "Adjust fly speed", 10, 300, function(s)
    flySpeed = s
end)

----------------------------------------------------------------------
-- JUMP TAB
----------------------------------------------------------------------
local JumpTab = Window:NewTab("Jump")
local JumpSection = JumpTab:NewSection("Jump Controls")

-- Adjustable Jump Power
JumpSection:NewSlider("Jump Power", "Adjust jump height", 50, 500, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

-- Jump Hack (Infinite Jump)
local jumpHack = false
JumpSection:NewToggle("Jump Hack", "Infinite jumping", function(state)
    jumpHack = state
    local UserInputService = game:GetService("UserInputService")
    UserInputService.JumpRequest:Connect(function()
        if jumpHack then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end
    end)
end)

-- Double Jump
local doubleJumpEnabled = false
JumpSection:NewToggle("Double Jump", "Double jump ability", function(state)
    doubleJumpEnabled = state
end)

local canDoubleJump = false
local UserInputService = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")

humanoid.StateChanged:Connect(function(_, newState)
    if doubleJumpEnabled then
        if newState == Enum.HumanoidStateType.Freefall then
            canDoubleJump = true
        elseif newState == Enum.HumanoidStateType.Landed then
            canDoubleJump = false
        end
    end
end)

UserInputService.JumpRequest:Connect(function()
    if doubleJumpEnabled and canDoubleJump then
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        canDoubleJump = false
    end
end)

----------------------------------------------------------------------
-- GRAVITY TAB
----------------------------------------------------------------------
local GravityTab = Window:NewTab("Gravity")
local GravitySection = GravityTab:NewSection("Gravity Control")

GravitySection:NewSlider("Gravity", "Adjust Roblox gravity", 0, 500, function(s)
    workspace.Gravity = s
end)

----------------------------------------------------------------------
-- KEYBINDS TAB
----------------------------------------------------------------------
local KeybindsTab = Window:NewTab("Keybinds")
local KeybindsSection = KeybindsTab:NewSection("Adjust Controls")

KeybindsSection:NewKeybind("Aimbot Toggle", "Enable/Disable Aimbot", Enum.KeyCode.E, function()
    print("Aimbot key pressed!")
end)

KeybindsSection:NewKeybind("Jump Hack", "Toggle Jump Hack", Enum.KeyCode.Space, function()
    jumpHack = not jumpHack
    print("Jump Hack:", jumpHack)
end)

KeybindsSection:NewKeybind("Double Jump", "Toggle Double Jump", Enum.KeyCode.F, function()
    doubleJumpEnabled = not doubleJumpEnabled
    print("Double Jump:", doubleJumpEnabled)
end)

----------------------------------------------------------------------
-- CREDITS TAB
----------------------------------------------------------------------
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Developer")

CreditsSection:NewLabel("Roben - Developer")
CreditsSection:NewLabel("Version: Roben V1")



