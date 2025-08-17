-- Combined Speed & Jump Toggle Script (LocalScript)
--// Example Script Hub
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MyHub V1", "DarkTheme")

-- Tabs
local Tab1 = Window:NewTab("Target")
local Tab2 = Window:NewTab("Client")
local Tab3 = Window:NewTab("Misc")
local Tab4 = Window:NewTab("Credits")

-- Sections
local Section1 = Tab1:NewSection("Target Tools")
Section1:NewButton("Set Nearest", "Locks onto nearest player", function()
    print("Nearest player locked")
end)

Section1:NewTextBox("Input Target", "Enter username", function(txt)
    print("Target: "..txt)
end)

Section1:NewButton("Goto Player", "Teleports to target", function()
    print("Teleporting...")
end)

-- Example Trolling Section
local Section2 = Tab3:NewSection("Trolling")
Section2:NewButton("Copy Username", "Copies username", function()
    setclipboard(game.Players.LocalPlayer.Name)
end)












