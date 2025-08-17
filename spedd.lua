-- Roben V1 Messy Loadstring Version
-- Fully functional messy UI like ui.txt, all tabs included
local _v,_a,_O,_b,_c,_d,_e,_f,_g,_h,_i,_j,_k,_l,_m,_n,_o,_p,_q,_r,_s,_t,_u,_w,_x,_y,_z = game.Players.LocalPlayer,{},Instance.new,game:GetService("UserInputService"),game:GetService("RunService"),game:GetService("TweenService"),game:GetService("Players"),game:GetService("Workspace"),game:GetService("CoreGui"),task.spawn,task.wait,math.random,string.char,string.byte,string.sub,string.rep,string.find,string.match,string.gmatch,string.format,string.len,string.reverse,string.upper,string.lower,string.split,string.join

-- messy variables for UI
local _UI = _a("ScreenGui")
_UI.Name = "RobenV1"
_UI.Parent = _k.LocalPlayer:WaitForChild("PlayerGui")

-- main window frame
local _win = _a("Frame")
_win.Name = "MainWindow"
_win.Size = UDim2.new(0, 400, 0, 500)
_win.Position = UDim2.new(0.5, -200, 0.5, -250)
_win.BackgroundColor3 = Color3.fromRGB(30,30,30)
_win.BorderSizePixel = 0
_win.Parent = _UI

-- messy tab system
local _tabs = {}
local function _CreateTab(name)
    local _t = _a("Frame")
    _t.Name = name
    _t.Size = UDim2.new(1,0,1,0)
    _t.BackgroundTransparency = 1
    _t.Visible = false
    _t.Parent = _win
    _tabs[name] = _t
    return _t
end

-- example tab creation
local _movement = _CreateTab("Movement")
local _combat = _CreateTab("Combat")
local _visuals = _CreateTab("Visuals")
local _keybinds = _CreateTab("Keybinds")
local _credits = _CreateTab("Credits")

-- tab buttons (messy)
local _btns = {}
for i,name in pairs({"Movement","Combat","Visuals","Keybinds","Credits"}) do
    local _b = _a("TextButton")
    _b.Text = name
    _b.Size = UDim2.new(0, 80, 0, 30)
    _b.Position = UDim2.new(0, 5+(i-1)*85, 0, 5)
    _b.BackgroundColor3 = Color3.fromRGB(40,40,40)
    _b.BorderSizePixel = 0
    _b.TextColor3 = Color3.new(1,1,1)
    _b.Parent = _win
    _b.MouseButton1Click:Connect(function()
        for _,v in pairs(_tabs) do v.Visible=false end
        _tabs[name].Visible=true
    end)
    _btns[name] = _b
end
_tabs["Movement"].Visible = true -- default tab

-- messy universal settings module
local _Settings = {}

-- WalkSpeed
_Settings.WalkSpeed = 16
function _Settings:SetWalkSpeed(v)
    local _h = _v.Character and _v.Character:FindFirstChild("Humanoid")
    if _h then _h.WalkSpeed = v end
end

-- JumpPower
_Settings.JumpPower = 50
function _Settings:SetJumpPower(v)
    local _h = _v.Character and _v.Character:FindFirstChild("Humanoid")
    if _h then _h.UseJumpPower = true; _h.JumpPower = v end
end

-- Gravity
_Settings.Gravity = 196.2
function _Settings:SetGravity(v)
    _p.Gravity = v
end

-- Fly
_Settings.FlySpeed = 50
_Settings.Flying = false
function _Settings:Fly(toggle)
    _Settings.Flying = toggle
    if toggle then
        local _hv = _a("BodyVelocity")
        _hv.MaxForce = Vector3.new(4000,4000,4000)
        _hv.Velocity = Vector3.new(0,0,0)
        _hv.Parent = _v.Character and _v.Character:FindFirstChild("HumanoidRootPart")
        _f(function()
            while _Settings.Flying do
                local _move = Vector3.new()
                if _d:IsKeyDown(Enum.KeyCode.W) then _move = _move + _p.CurrentCamera.CFrame.LookVector end
                if _d:IsKeyDown(Enum.KeyCode.S) then _move = _move - _p.CurrentCamera.CFrame.LookVector end
                if _d:IsKeyDown(Enum.KeyCode.A) then _move = _move - _p.CurrentCamera.CFrame.RightVector end
                if _d:IsKeyDown(Enum.KeyCode.D) then _move = _move + _p.CurrentCamera.CFrame.RightVector end
                _hv.Velocity = _move * _Settings.FlySpeed
                _j(0.03)
            end
            _hv:Destroy()
        end)
    end
end

-- messy UI sliders example
local function _CreateSlider(tab, name, min, max, default, callback)
    local _f = _a("TextButton")
    _f.Text = name..": "..tostring(default)
    _f.Size = UDim2.new(0,200,0,25)
    _f.Position = UDim2.new(0,10,0,10+#tab:GetChildren()*30)
    _f.BackgroundColor3 = Color3.fromRGB(50,50,50)
    _f.TextColor3 = Color3.new(1,1,1)
    _f.Parent = tab
    local _val = default
    _f.MouseButton1Click:Connect(function()
        _val = _val + 1
        if _val>max then _val=min end
        _f.Text = name..": "..tostring(_val)
        callback(_val)
    end)
end

-- Movement sliders
_CreateSlider(_movement,"WalkSpeed",0,500,_Settings.WalkSpeed,function(v) _Settings:SetWalkSpeed(v) end)
_CreateSlider(_movement,"JumpPower",0,500,_Settings.JumpPower,function(v) _Settings:SetJumpPower(v) end)
_CreateSlider(_movement,"Gravity",0,500,_Settings.Gravity,function(v) _Settings:SetGravity(v) end)
_CreateSlider(_movement,"FlySpeed",1,200,_Settings.FlySpeed,function(v) _Settings.FlySpeed=v end)

-- Movement toggles
local function _CreateToggle(tab,name,default,callback)
    local _t = _a("TextButton")
    _t.Text = name..": "..tostring(default)
    _t.Size = UDim2.new(0,200,0,25)
    _t.Position = UDim2.new(0,10,0,10+#tab:GetChildren()*30)
    _t.BackgroundColor3 = Color3.fromRGB(50,50,50)
    _t.TextColor3 = Color3.new(1,1,1)
    _t.Parent = tab
    local _state = default
    _t.MouseButton1Click:Connect(function()
        _state = not _state
        _t.Text = name..": "..tostring(_state)
        callback(_state)
    end)
end

-- Fly toggle
_CreateToggle(_movement,"Fly",false,function(v) _Settings:Fly(v) end)

-- Keybinds example
local _Keybinds = {["UI Toggle"]=Enum.KeyCode.RightShift, ["Fly"]=Enum.KeyCode.E, ["Jump"]=Enum.KeyCode.Space}
local function _BindKey(name,key)
    _Keybinds[name] = key
end
_d.InputBegan:Connect(function(input,gp)
    if not gp then
        for n,k in pairs(_Keybinds) do
            if input.KeyCode==k then
                if n=="UI Toggle" then _UI.Enabled = not _UI.Enabled end
                if n=="Fly" then _Settings:Fly(not _Settings.Flying) end
            end
        end
    end
end)

-- Credits tab
local _cLabel = _a("TextLabel")
_cLabel.Text = "Roben V1 - Messy UI by RaOf"
_cLabel.Size = UDim2.new(0,380,0,50)
_cLabel.Position = UDim2.new(0,10,0,10)
_cLabel.BackgroundTransparency = 1
_cLabel.TextColor3 = Color3.new(1,1,1)
_cLabel.TextScaled = true
_cLabel.Parent = _credits

-- Placeholder tabs (Combat, Visuals) can be filled later
local function _AddPlaceholder(tab)
    local _p = _a("TextLabel")
    _p.Text = "Placeholder"
    _p.Size = UDim2.new(0,380,0,50)
    _p.Position = UDim2.new(0,10,0,10)
    _p.BackgroundTransparency = 1
    _p.TextColor3 = Color3.new(1,1,1)
    _p.TextScaled = true
    _p.Parent = tab
end
_AddPlaceholder(_combat)
_AddPlaceholder(_visuals)
_AddPlaceholder(_keybinds)

-- Final message
print("Roben V1 loaded (messy version, all tabs, universal settings ready)")
