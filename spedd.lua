-- Roben V1 Messy Working Loadstring
local _p=game.Players.LocalPlayer
local _pg=_p:WaitForChild("PlayerGui")
local _u=_pg:FindFirstChild("RobenV1") or Instance.new("ScreenGui")
_u.Name="RobenV1"
_u.ResetOnSpawn=false
_u.Parent=_pg

-- Main frame
local _f=Instance.new("Frame")
_f.Size=UDim2.new(0,400,0,500)
_f.Position=UDim2.new(0.5,-200,0.5,-250)
_f.BackgroundColor3=Color3.fromRGB(30,30,30)
_f.BorderSizePixel=0
_f.Parent=_u

-- Tabs table
local _tabs={}
local function _CreateTab(name)
    local t=Instance.new("Frame")
    t.Name=name
    t.Size=UDim2.new(1,0,1,0)
    t.BackgroundTransparency=1
    t.Visible=false
    t.Parent=_f
    _tabs[name]=t
    return t
end

local _Movement=_CreateTab("Movement")
local _Combat=_CreateTab("Combat")
local _Visuals=_CreateTab("Visuals")
local _Keybinds=_CreateTab("Keybinds")
local _Credits=_CreateTab("Credits")
_Movement.Visible=true

-- Tab buttons
local _btns={}
for i,n in pairs({"Movement","Combat","Visuals","Keybinds","Credits"}) do
    local b=Instance.new("TextButton")
    b.Text=n
    b.Size=UDim2.new(0,80,0,30)
    b.Position=UDim2.new(0,5+(i-1)*85,0,5)
    b.BackgroundColor3=Color3.fromRGB(40,40,40)
    b.BorderSizePixel=0
    b.TextColor3=Color3.new(1,1,1)
    b.Parent=_f
    b.MouseButton1Click:Connect(function()
        for _,v in pairs(_tabs) do v.Visible=false end
        _tabs[n].Visible=true
    end)
    _btns[n]=b
end

-- Settings table
local _S={}
_S.WalkSpeed=16
_S.JumpPower=50
_S.Gravity=196.2
_S.FlySpeed=50
_S.Flying=false

-- Wait for character
local function _GetHumanoid()
    local c=_p.Character or _p.CharacterAdded:Wait()
    return c:WaitForChild("Humanoid"),c:WaitForChild("HumanoidRootPart")
end

-- WalkSpeed
function _S:SetWalkSpeed(v)
    local h,_= _GetHumanoid()
    h.WalkSpeed=v
end

-- JumpPower
function _S:SetJumpPower(v)
    local h,_=_GetHumanoid()
    h.UseJumpPower=true
    h.JumpPower=v
end

-- Gravity
function _S:SetGravity(v)
    workspace.Gravity=v
end

-- Fly
function _S:Fly(toggle)
    local h,r=_GetHumanoid()
    _S.Flying=toggle
    if toggle then
        local bv=Instance.new("BodyVelocity")
        bv.MaxForce=Vector3.new(4000,4000,4000)
        bv.Velocity=Vector3.new(0,0,0)
        bv.Parent=r
        spawn(function()
            local UIS=game:GetService("UserInputService")
            while _S.Flying do
                local mv=Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.W) then mv=mv + workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then mv=mv - workspace.CurrentCamera.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then mv=mv - workspace.CurrentCamera.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then mv=mv + workspace.CurrentCamera.CFrame.RightVector end
                bv.Velocity=mv*_S.FlySpeed
                task.wait()
            end
            bv:Destroy()
        end)
    end
end

-- Slider creator
local function _Slider(tab,name,min,max,def,callback)
    local s=Instance.new("TextButton")
    s.Text=name..": "..tostring(def)
    s.Size=UDim2.new(0,200,0,25)
    s.Position=UDim2.new(0,10,0,10+#tab:GetChildren()*30)
    s.BackgroundColor3=Color3.fromRGB(50,50,50)
    s.TextColor3=Color3.new(1,1,1)
    s.Parent=tab
    local val=def
    s.MouseButton1Click:Connect(function()
        val=val+1
        if val>max then val=min end
        s.Text=name..": "..tostring(val)
        callback(val)
    end)
end

-- Movement sliders
_Slider(_Movement,"WalkSpeed",0,500,_S.WalkSpeed,function(v) _S:SetWalkSpeed(v) end)
_Slider(_Movement,"JumpPower",0,500,_S.JumpPower,function(v) _S:SetJumpPower(v) end)
_Slider(_Movement,"Gravity",0,500,_S.Gravity,function(v) _S:SetGravity(v) end)
_Slider(_Movement,"FlySpeed",1,200,_S.FlySpeed,function(v) _S.FlySpeed=v end)

-- Toggle creator
local function _Toggle(tab,name,def,callback)
    local t=Instance.new("TextButton")
    t.Text=name..": "..tostring(def)
    t.Size=UDim2.new(0,200,0,25)
    t.Position=UDim2.new(0,10,0,10+#tab:GetChildren()*30)
    t.BackgroundColor3=Color3.fromRGB(50,50,50)
    t.TextColor3=Color3.new(1,1,1)
    t.Parent=tab
    local state=def
    t.MouseButton1Click:Connect(function()
        state=not state
        t.Text=name..": "..tostring(state)
        callback(state)
    end)
end

-- Fly toggle
_Toggle(_Movement,"Fly",false,function(v) _S:Fly(v) end)

-- Keybinds
local _K={["UI Toggle"]=Enum.KeyCode.RightShift,["Fly"]=Enum.KeyCode.E,["Jump"]=Enum.KeyCode.Space}
game:GetService("UserInputService").InputBegan:Connect(function(input,gp)
    if not gp then
        for n,k in pairs(_K) do
            if input.KeyCode==k then
                if n=="UI Toggle" then _u.Enabled=not _u.Enabled end
                if n=="Fly" then _S:Fly(not _S.Flying) end
            end
        end
    end
end)

-- Credits
local cl=Instance.new("TextLabel")
cl.Text="Roben V1 - Messy UI by RaOf"
cl.Size=UDim2.new(0,380,0,50)
cl.Position=UDim2.new(0,10,0,10)
cl.BackgroundTransparency=1
cl.TextColor3=Color3.new(1,1,1)
cl.TextScaled=true
cl.Parent=_Credits

-- Placeholder tabs
local function _PH(tab)
    local l=Instance.new("TextLabel")
    l.Text="Placeholder"
    l.Size=UDim2.new(0,380,0,50)
    l.Position=UDim2.new(0,10,0,10)
    l.BackgroundTransparency=1
    l.TextColor3=Color3.new(1,1,1)
    l.TextScaled=true
    l.Parent=tab
end
_PH(_Combat)
_PH(_Visuals)
_PH(_Keybinds)

print("Roben V1 loaded (messy working version, all tabs, universal settings ready)")
