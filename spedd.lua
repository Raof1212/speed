-- High Jump Toggle Script (Luau)
-- Put this in StarterPlayerScripts as a LocalScript

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- SETTINGS
local TOGGLE_KEY = Enum.KeyCode.J -- Press J to toggle
local HIGH_JUMP_POWER = 150       -- Default Roblox jump power is ~50
local ENABLED = false

-- Store original jump power
local ORIGINAL_JUMP_POWER = Humanoid.JumpPower

-- Function to enable/disable high jump
local function SetHighJump(state)
	if state then
		Humanoid.JumpPower = HIGH_JUMP_POWER
		print("High Jump ENABLED")
	else
		Humanoid.JumpPower = ORIGINAL_JUMP_POWER
		print("High Jump DISABLED")
	end
end

-- Toggle on key press
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == TOGGLE_KEY then
		ENABLED = not ENABLED
		SetHighJump(ENABLED)
	end
end)

-- Reapply settings if character respawns
LocalPlayer.CharacterAdded:Connect(function(newChar)
	Character = newChar
	Humanoid = newChar:WaitForChild("Humanoid")
	SetHighJump(ENABLED)
end)
