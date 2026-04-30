local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/MacLib/Source.lua"))()

local lp = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

_G.AutoFarmLevel = false
_G.AutoFarmNearest = false

local FastAttackModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/FastAttackModule.lua"))()
local MobList = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/MobList.lua"))()

local function tweenTo(config)
  local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
  if not hrp or not config.CFrame then return end

  local bv = hrp:FindFirstChild("TweenStabilizer") or Instance.new("BodyVelocity")
  bv.Name = "TweenStabilizer"
  bv.Parent = hrp
  bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
  bv.Velocity = Vector3.zero

  local dist = (hrp.Position - config.CFrame.Position).Magnitude
  local info = TweenInfo.new(dist / (config.Speed or 250), Enum.EasingStyle.Linear)
  TweenService:Create(hrp, info, {CFrame = config.CFrame}):Play()
end

local function stopFastAttack()
  if FastAttackModule and FastAttackModule.Toggle then
    FastAttackModule:Toggle(false)
  end
end

RunService.Stepped:Connect(function()
  if lp.Character then
    for _, v in pairs(lp.Character:GetDescendants()) do
      if v:IsA("BasePart") then
        v.CanCollide = false
      end
    end
  end
end)

task.spawn(function()
  while true do
    task.wait()
    pcall(function()
      if not (_G.AutoFarmLevel or _G.AutoFarmNearest) then
        stopFastAttack()
        return
      end

      local Char = lp.Character
      if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end

      local tool = lp.Backpack:FindFirstChild("Combat") or Char:FindFirstChild("Combat")
      if tool and tool.Parent ~= Char then
        Char.Humanoid:EquipTool(tool)
      end

      if Char:FindFirstChild("Combat") and not FastAttackModule.Enabled then
        FastAttackModule:Toggle(true)
      end

      if _G.AutoFarmLevel then
        local LevelData = MobList:CheckLevel()

        if not lp.PlayerGui.Main.Quest.Visible then
          tweenTo({CFrame = LevelData.QuestPos, Speed = 250})
          if (Char.HumanoidRootPart.Position - LevelData.QuestPos.Position).Magnitude < 10 then
            CommF:InvokeServer("StartQuest", LevelData.QuestName, LevelData.QuestLvl)
          end
        else
          local Target = nil
          for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == LevelData.EnemyName and v.Humanoid.Health > 0 then
              Target = v
              break
            end
          end

          if Target then
            tweenTo({CFrame = Target.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0), Speed = 250})
          else
            tweenTo({CFrame = LevelData.fPos, Speed = 250})
          end
        end

      elseif _G.AutoFarmNearest then
        local Nearest, minDist = nil, math.huge

        for _, v in pairs(workspace.Enemies:GetChildren()) do
          if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
            local mag = (Char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
            if mag < minDist then
              minDist = mag
              Nearest = v
            end
          end
        end

        if Nearest then
          tweenTo({CFrame = Nearest.HumanoidRootPart.CFrame * CFrame.new(0, 12, 0), Speed = 250})
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
  DisabledWindowControls = {},
  ShowUserInfo = true,
  Keybind = Enum.KeyCode.RightControl,
  AcrylicBlur = true,
})

local TabGroup = Window:TabGroup()
local MainTab = TabGroup:Tab({
  Name = "Main",
  Image = "rbxassetid://10734949013"
})

local SectionLeft = MainTab:Section({
  Side = "Left"
})

SectionLeft:Label({
  Text = "Farm page"
})

SectionLeft:Divider()

SectionLeft:Toggle({
  Name = "Auto farm level",
  Default = false,
  Callback = function(value)
    _G.AutoFarmLevel = value
  end,
}, "AutoLevelFlag")

SectionLeft:Toggle({
  Name = "Auto farm nearest",
  Default = false,
  Callback = function(value)
    _G.AutoFarmNearest = value
  end,
}, "AutoNearestFlag")

local dragGui = Instance.new("ScreenGui")
dragGui.Name = "MarkHubToggleGui"
dragGui.ResetOnSpawn = false
dragGui.Parent = lp.PlayerGui

local dragBtn = Instance.new("TextButton")
dragBtn.Size = UDim2.fromOffset(44, 44)
dragBtn.Position = UDim2.new(1, -60, 0.5, -22)
dragBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
dragBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
dragBtn.Text = "M"
dragBtn.Font = Enum.Font.GothamBold
dragBtn.TextSize = 20
dragBtn.BorderSizePixel = 0
dragBtn.Parent = dragGui

local dragCorner = Instance.new("UICorner")
dragCorner.CornerRadius = UDim.new(1, 0)
dragCorner.Parent = dragBtn

local dragActive, dragStart, dragStartPos, dragMoved = false, nil, nil, false

dragBtn.InputBegan:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    dragActive = true
    dragMoved = false
    dragStart = input.Position
    dragStartPos = dragBtn.Position
  end
end)

UIS.InputChanged:Connect(function(input)
  if dragActive and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    local delta = input.Position - dragStart
    if delta.Magnitude > 5 then dragMoved = true end
    dragBtn.Position = UDim2.new(dragStartPos.X.Scale, dragStartPos.X.Offset + delta.X, dragStartPos.Y.Scale, dragStartPos.Y.Offset + delta.Y)
  end
end)

UIS.InputEnded:Connect(function(input)
  if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    if dragActive and not dragMoved then
      local currentState = Window:GetState()
      Window:SetState(not currentState)
    end
    dragActive = false
  end
end)
