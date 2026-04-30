local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/MacLib/Source.lua"))()

local lp = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

_G.AutoFarmLevel = false
_G.AutoFarmNearest = false

local FastAttackModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/FastAttackModule.lua"))() -- Original: https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/Utils/Module/FastAttack.luau
local MobList = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/MobList.lua"))()

local Window = MacLib:Window({
  Title = "Mark hub",
  Subtitle = "Blox Fruits | Free",
  Size = UDim2.fromOffset(860, 450),
  DragStyle = 1,
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
  local tween = TweenService:Create(hrp, info, {CFrame = config.CFrame})
  
  tween:Play()
  return tween
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

local function CheckLevel()
  local lvl = lp.Data.Level.Value
  for _, data in ipairs(MobList) do
    if lvl >= data.LevelMin and lvl <= data.LevelMax then
      return data
    end
  end
  return MobList[#MobList]
end

task.spawn(function()
  while true do
    task.wait()
    pcall(function()
      if not (_G.AutoFarmLevel or _G.AutoFarmNearest) then 
        if FastAttackModule.Enabled then 
          FastAttackModule:Toggle(false) 
        end
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
        local LevelData = CheckLevel()
        
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
        local Nearest = nil
        local minDist = math.huge
        
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
