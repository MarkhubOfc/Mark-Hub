local currentTween
local function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end

local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/MacLib/Source.lua"))()
local lp = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

_G.AutoFarmLevel = false
_G.AutoFarmNearest = false
_G.AttackSpeed = 0.1
_G.AttackDistance = 45
_G.FarmDistance = 15
_G.TweenSpeed = 250
_G.AutoAttack = true
_G.AttackPlayers = true

local FastAttackModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/FastAttackModule.lua"))()
local MobList1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/MobList1.lua"))()

local function tweenTo(config)
  local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
  if not hrp or not config.CFrame then return end
  local bv = hrp:FindFirstChild("TweenStabilizer") or new("BodyVelocity", {
    Name = "TweenStabilizer",
    Parent = hrp,
    MaxForce = Vector3.new(9e9, 9e9, 9e9),
    Velocity = Vector3.zero
  })
  if currentTween then 
    currentTween:Cancel() 
  end
  local dist = (hrp.Position - config.CFrame.Position).Magnitude
  local info = TweenInfo.new(
    dist / (_G.TweenSpeed or 250), 
    Enum.EasingStyle.Linear
  )
  currentTween = TweenService:Create(hrp, info, {
    CFrame = config.CFrame
  })
  currentTween:Play()
end

local function cleanPhysics()
  if currentTween then 
    currentTween:Cancel() 
    currentTween = nil 
  end
  local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
  if hrp then
    local bv = hrp:FindFirstChild("TweenStabilizer")
    if bv then 
      bv:Destroy() 
    end
    hrp.Velocity = Vector3.zero
  end
  if lp.Character then
    for _, v in pairs(lp.Character:GetDescendants()) do
      if v:IsA("BasePart") then 
        v.CanCollide = true 
      end
    end
  end
end

local function getNearestMonster(monsterName)
  local nearest = nil
  local lastDist = math.huge
  for _, v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == monsterName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
      local dist = (lp.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
      if dist < lastDist then
        lastDist = dist
        nearest = v
      end
    end
  end
  return nearest
end

local function bringMonsters(name, pcf)
  for _, v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
      v.HumanoidRootPart.CanCollide = false
      local bringBv = v.HumanoidRootPart:FindFirstChild("BringBv") or new("BodyVelocity", {
        Name = "BringBv",
        Parent = v.HumanoidRootPart,
        MaxForce = Vector3.new(9e9, 9e9, 9e9)
      })
      local bringBg = v.HumanoidRootPart:FindFirstChild("BringBg") or new("BodyGyro", {
        Name = "BringBg",
        Parent = v.HumanoidRootPart,
        MaxTorque = Vector3.new(9e9, 9e9, 9e9)
      })
      bringBv.Velocity = (pcf.Position - v.HumanoidRootPart.Position).Unit * 75
      if (pcf.Position - v.HumanoidRootPart.Position).Magnitude < 5 then
        bringBv.Velocity = Vector3.zero
      end
      bringBg.CFrame = pcf
    end
  end
end

RunService.Stepped:Connect(function()
  if (_G.AutoFarmLevel or _G.AutoFarmNearest) and lp.Character then
    for _, v in pairs(lp.Character:GetDescendants()) do
      if v:IsA("BasePart") then 
        v.CanCollide = false 
      end
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(_G.AttackSpeed)
    if not _G.AutoFarmLevel and not _G.AutoFarmNearest then 
      if FastAttackModule and FastAttackModule.Enabled then 
        FastAttackModule:Toggle(false) 
      end
      continue 
    end
    pcall(function()
      local Char = lp.Character
      if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
      local LevelData = MobList1:CheckLevel()
      local TargetInstance = getNearestMonster(LevelData.NameMon)
      if not lp.PlayerGui.Main.Quest.Visible then
        if FastAttackModule.Enabled then 
          FastAttackModule:Toggle(false) 
        end
        if Char:FindFirstChild("Combat") then 
          Char.Humanoid:UnequipTools() 
        end
        tweenTo({
          CFrame = LevelData.CFrameQuest
        })
        if (Char.HumanoidRootPart.Position - LevelData.CFrameQuest.Position).Magnitude < 10 then
          CommF:InvokeServer("StartQuest", LevelData.NameQuest, LevelData.LevelQuest)
        end
      else
        local TargetPos = TargetInstance and TargetInstance.HumanoidRootPart.CFrame * CFrame.new(0, _G.FarmDistance, 0) or LevelData.CFrameMon * CFrame.new(0, _G.FarmDistance, 0)
        if TargetInstance then
          bringMonsters(LevelData.NameMon, Char.HumanoidRootPart.CFrame)
        end
        local currentDist = (Char.HumanoidRootPart.Position - TargetPos.Position).Magnitude
        tweenTo({
          CFrame = TargetPos
        })
        if currentDist <= 30 then
          local tool = lp.Backpack:FindFirstChild("Combat") or Char:FindFirstChild("Combat")
          if tool and tool.Parent ~= Char then
            Char.Humanoid:EquipTool(tool)
          end
          if Char:FindFirstChild("Combat") and _G.AutoAttack then
            if not FastAttackModule.Enabled then 
              FastAttackModule:Toggle(true) 
            end
            for _, m in pairs(workspace.Enemies:GetChildren()) do
              if m:FindFirstChild("Humanoid") and m.Humanoid.Health > 0 and (m.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude <= _G.AttackDistance then
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
              end
            end
            if _G.AttackPlayers then
              for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and (p.Character.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude <= _G.AttackDistance then
                  game:GetService("VirtualUser"):CaptureController()
                  game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end
              end
            end
          end
        else
          if FastAttackModule.Enabled then 
            FastAttackModule:Toggle(false) 
          end
        end
      end
    end)
  end
end)

local Window = MacLib:Window({
  Title = "Mark hub",
  Subtitle = "Blox Fruits",
  Size = UDim2.fromOffset(860, 450),
  DragStyle = 2,
  ShowUserInfo = true,
  Keybind = Enum.KeyCode.RightControl,
  AcrylicBlur = true,
})

local TabGroup = Window:TabGroup()

local MainTab = TabGroup:Tab({
  Name = "Main", 
  Image = "rbxassetid://10734949013"
})

local SettingsTab = TabGroup:Tab({
  Name = "Settings",
  Image = "rbxassetid://10734950309"
})

local SectionLeftMain = MainTab:Section({
  Side = "Left"
})

SectionLeftMain:Toggle({
  Name = "Auto farm level",
  Default = false,
  Callback = function(value)
    _G.AutoFarmLevel = value
    if not value then 
      cleanPhysics() 
    end
  end,
}, "AutoLevelFlag")

SectionLeftMain:Toggle({
  Name = "Auto farm nearest",
  Default = false,
  Callback = function(value)
    _G.AutoFarmNearest = value
    if not value then 
      cleanPhysics() 
    end
  end,
}, "AutoNearestFlag")

local SectionLeftSettings = SettingsTab:Section({
  Side = "Left"
})

SectionLeftSettings:Label({
  Name = "Farm settings"
})

SectionLeftSettings:Slider({
  Name = "Attack speed",
  Default = 0.1,
  Minimum = 0.1,
  Maximum = 1,
  DisplayMethod = "Value",
  Callback = function(Value)
    _G.AttackSpeed = Value
  end,
}, "AttackSpeedSlider")

SectionLeftSettings:Slider({
  Name = "Attack distance",
  Default = 45,
  Minimum = 10,
  Maximum = 45,
  DisplayMethod = "Value",
  Callback = function(Value)
    _G.AttackDistance = Value
  end,
}, "AttackDistanceSlider")

SectionLeftSettings:Slider({
  Name = "Farm distance",
  Default = 15,
  Minimum = 7,
  Maximum = 18,
  DisplayMethod = "Value",
  Callback = function(Value)
    _G.FarmDistance = Value
  end,
}, "FarmDistanceSlider")

SectionLeftSettings:Slider({
  Name = "Tween speed",
  Default = 250,
  Minimum = 50,
  Maximum = 250,
  DisplayMethod = "Value",
  Callback = function(Value)
    _G.TweenSpeed = Value
  end,
}, "TweenSpeedSlider")

SectionLeftSettings:Toggle({
  Name = "Auto attack",
  Default = true,
  Callback = function(value)
    _G.AutoAttack = value
  end,
}, "AutoAttackFlag")

SectionLeftSettings:Toggle({
  Name = "Attack players",
  Default = true,
  Callback = function(value)
    _G.AttackPlayers = value
  end,
}, "AttackPlayersFlag")

local dragGui = new("ScreenGui", {
  Name = "MarkHubToggleGui", 
  ResetOnSpawn = false
})

pcall(function() 
  dragGui.Parent = CoreGui 
end)

local dragBtn = new("TextButton", {
  Size = UDim2.fromOffset(44, 44),
  Position = UDim2.new(1, -60, 0.5, -22),
  BackgroundColor3 = Color3.fromRGB(30, 30, 30),
  Text = "M",
  TextColor3 = Color3.new(1, 1, 1),
  Font = Enum.Font.GothamBold,
  TextSize = 18,
  Parent = dragGui
})

new("UICorner", {
  CornerRadius = UDim.new(1, 0), 
  Parent = dragBtn
})

local dragging, dragStart, startPos

dragBtn.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    dragging = true 
    dragStart = input.Position 
    startPos = dragBtn.Position
  end
end)

UIS.InputChanged:Connect(function(input)
  if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    local delta = input.Position - dragStart
    dragBtn.Position = UDim2.new(
      startPos.X.Scale, 
      startPos.X.Offset + delta.X, 
      startPos.Y.Scale, 
      startPos.Y.Offset + delta.Y
    )
  end
end)

dragBtn.MouseButton1Click:Connect(function() 
  Window:SetState(not Window:GetState()) 
end)

UIS.InputEnded:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
    dragging = false 
  end
end)
