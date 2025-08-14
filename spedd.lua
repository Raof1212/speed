-- Combined Speed & Jump Toggle Script (LocalScript)

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local HIGH_JUMP_POWER = 60
local HIGH_WALK_SPEED = 40
local DEFAULT_JUMP_POWER = 50
local DEFAULT_WALK_SPEED = 30

local jumpEnabled = false
local speedEnabled = false

-- Utility: toggle jump
local function SetHighJump(humanoid, state)
    humanoid.JumpPower = state and HIGH_JUMP_POWER or DEFAULT_JUMP_POWER
end

-- Utility: toggle speed
local function SetWalkSpeed(humanoid, state)
    humanoid.WalkSpeed = state and HIGH_WALK_SPEED or DEFAULT_WALK_SPEED
end

-- Setup toggles for a given humanoid
local function SetupToggles(humanoid)
    UserInputService.InputBegan:Connect(function(input, gp)
        if gp then return end
        if input.KeyCode == Enum.KeyCode.J then
            jumpEnabled = not jumpEnabled
            SetHighJump(humanoid, jumpEnabled)
        elseif input.KeyCode == Enum.KeyCode.K then
            speedEnabled = not speedEnabled
            SetWalkSpeed(humanoid, speedEnabled)
        end
    end)
end

-- Initialize when character spawns
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    SetHighJump(humanoid, jumpEnabled)
    SetWalkSpeed(humanoid, speedEnabled)
    SetupToggles(humanoid)
end)

-- If already spawned
if LocalPlayer.Character then
    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        SetHighJump(humanoid, jumpEnabled)
        SetWalkSpeed(humanoid, speedEnabled)
        SetupToggles(humanoid)
    end
end



