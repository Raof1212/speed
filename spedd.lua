-- Roben V1 Script Hub

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Roben V1", "DarkTheme")

-- MAIN TAB
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main Features")

MainSection:NewButton("Speed Hack", "Increase walk speed", function()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    character.Humanoid.WalkSpeed = 100
end)

MainSection:NewButton("Fly (Q)", "Press Q to toggle fly", function()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    local flying = false
    local speed = 5
    local bodyVel
    local bodyGyro

    mouse.KeyDown:Connect(function(key)
        if key == "q" then
            flying = not flying
            if flying then
                local humanoidRootPart = player.Character.HumanoidRootPart
                bodyVel = Instance.new("BodyVelocity")
                bodyVel.Velocity = Vector3.new(0,0,0)
                bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bodyVel.Parent = humanoidRootPart

                bodyGyro = Instance.new("BodyGyro")
                bodyGyro.CFrame = humanoidRootPart.CFrame
                bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                bodyGyro.P = 10000
                bodyGyro.Parent = humanoidRootPart

                game:GetService("RunService").RenderStepped:Connect(function()
                    if flying then
                        local moveDirection = Vector3.new(0,0,0)
                        if game.UserInputService:IsKeyDown(Enum.KeyCode.W) then
                            moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.LookVector)
                        end
                        if game.UserInputService:IsKeyDown(Enum.KeyCode.S) then
                            moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.LookVector)
                        end
                        if game.UserInputService:IsKeyDown(Enum.KeyCode.A) then
                            moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.RightVector)
                        end
                        if game.UserInputService:IsKeyDown(Enum.KeyCode.D) then
                            moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.RightVector)
                        end
                        bodyVel.Velocity = moveDirection * speed
                        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
                    end
                end)
            else
                if bodyVel then bodyVel:Destroy() end
                if bodyGyro then bodyGyro:Destroy() end
            end
        end
    end)
end)

-- KEYBINDS TAB
local KeybindsTab = Window:NewTab("Keybinds")
local KeybindsSection = KeybindsTab:NewSection("Adjust Controls")

-- Aimbot Keybind
KeybindsSection:NewKeybind("Aimbot Toggle", "Enable/Disable Aimbot", Enum.KeyCode.E, function()
    print("Aimbot key pressed!")
    -- your aimbot toggle logic goes here
end)

-- Jump Hack Keybind
KeybindsSection:NewKeybind("Jump Hack", "Toggle Jump Hack", Enum.KeyCode.Space, function()
    print("Jump Hack triggered!")
    -- your jump hack logic goes here
end)

-- Double Jump Hack Keybind
KeybindsSection:NewKeybind("Double Jump", "Activate Double Jump", Enum.KeyCode.F, function()
    print("Double Jump triggered!")
    -- your double jump logic goes here
end)

-- CREDITS TAB
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Developer")

CreditsSection:NewLabel("Roben - Developer")
CreditsSection:NewLabel("Version: Roben V1")











