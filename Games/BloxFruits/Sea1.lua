local currentTween
local function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end

local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/MacLib/Source.lua"))()
local FastAttackModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/FastAttackModule.lua"))()
local MobList1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/MobList1.lua"))()

local lp = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

_G.Configs = {
  Farm = {
    AutoLevel = false,
    AutoNearest = false,
    Distance = 15,
    TweenSpeed = 250
  },
  Attack = {
    Enabled = true,
    Players = true,
    Speed = 0.1,
    Distance = 45
  },
  Stats = {
    AutoAdd = false,
    Amount = 3,
    Targets = {
      Melee = false,
      Defense = false,
      Sword = false,
      Gun = false,
      ["Demon Fruit"] = false
    }
  }
}

local function tweenTo(config)
  local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
  if not hrp or not config.CFrame then
    return
  end
  
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
  local info = TweenInfo.new(dist / _G.Configs.Farm.TweenSpeed, Enum.EasingStyle.Linear)
  currentTween = TweenService:Create(hrp, info, {CFrame = config.CFrame})
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
    hrp.AssemblyLinearVelocity = Vector3.zero
  end
  
  if lp.Character then
    lp.Character.Humanoid.AutoRotate = true
    for _, v in pairs(lp.Character:GetDescendants()) do
      if v:IsA("BasePart") then 
        v.CanCollide = true 
      end
    end
  end
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
        MaxTorque = Vector3.new(9e9, 9e9, 9e9), 
        CFrame = CFrame.new(0, 0, 0)
      })
      
      bringBv.Velocity = (pcf.Position - v.HumanoidRootPart.Position).Unit * 50
      if (pcf.Position - v.HumanoidRootPart.Position).Magnitude < 1 then 
        bringBv.Velocity = Vector3.zero 
      end
    end
  end
end

RunService.Stepped:Connect(function()
  if (_G.Configs.Farm.AutoLevel or _G.Configs.Farm.AutoNearest) and lp.Character then
    lp.Character.Humanoid.AutoRotate = false
    for _, v in pairs(lp.Character:GetDescendants()) do
      if v:IsA("BasePart") then 
        v.CanCollide = false 
      end
    end
  end
end)

task.spawn(function()
  while true do
    task.wait(_G.Configs.Attack.Speed)
    pcall(function()
      local Char = lp.Character
      if not Char or not Char:FindFirstChild("HumanoidRootPart") then
        return
      end

      if _G.Configs.Stats.AutoAdd then
        local pPoints = lp.Data:FindFirstChild("Points")
        if pPoints and pPoints.Value > 0 then
          local activeStats = {}
          for sName, enabled in pairs(_G.Configs.Stats.Targets) do
            if enabled then 
              table.insert(activeStats, sName) 
            end
          end
          
          if #activeStats > 0 then
            local toSpend = math.min(pPoints.Value, _G.Configs.Stats.Amount)
            for i = 1, toSpend do
              local target = activeStats[(i - 1) % #activeStats + 1]
              CommF:InvokeServer("AddPoint", target, 1)
            end
          end
        end
      end

      if _G.Configs.Attack.Enabled or _G.Configs.Attack.Players then
        if Char:FindFirstChild("Combat") then
          if not FastAttackModule.Enabled then 
            FastAttackModule:Toggle(true) 
          end
          
          if _G.Configs.Attack.Enabled then
            for _, m in pairs(workspace.Enemies:GetChildren()) do
              if m:FindFirstChild("Humanoid") and m.Humanoid.Health > 0 and (m.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude <= _G.Configs.Attack.Distance then
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
              end
            end
          end
          
          if _G.Configs.Attack.Players then
            for _, p in pairs(game:GetService("Players"):GetPlayers()) do
              if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and (p.Character.HumanoidRootPart.Position - Char.HumanoidRootPart.Position).Magnitude <= _G.Configs.Attack.Distance then
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
              end
            end
          end
        end
      end

      if _G.Configs.Farm.AutoLevel or _G.Configs.Farm.AutoNearest then
        local LevelData = MobList1:CheckLevel()
        
        if not lp.PlayerGui.Main.Quest.Visible then
          if Char:FindFirstChild("Combat") then 
            Char.Humanoid:UnequipTools() 
          end
          
          tweenTo({CFrame = LevelData.CFrameQuest})
          
          if (Char.HumanoidRootPart.Position - LevelData.CFrameQuest.Position).Magnitude < 10 then
            CommF:InvokeServer("StartQuest", LevelData.NameQuest, LevelData.LevelQuest)
          end
        else
          local nearest = nil
          local lastDist = math.huge
          
          for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == LevelData.NameMon and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
              local d = (Char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
              if d < lastDist then 
                lastDist = d 
                nearest = v 
              end
            end
          end
          
          local TargetPos = nearest and nearest.HumanoidRootPart.CFrame * CFrame.new(0, _G.Configs.Farm.Distance, 0) or LevelData.CFrameMon * CFrame.new(0, _G.Configs.Farm.Distance, 0)
          
          if nearest then 
            bringMonsters(LevelData.NameMon, TargetPos * CFrame.new(0, -_G.Configs.Farm.Distance, 0)) 
          end
          
          tweenTo({CFrame = TargetPos})
          
          local tool = lp.Backpack:FindFirstChild("Combat") or Char:FindFirstChild("Combat")
          if tool and tool.Parent ~= Char then 
            Char.Humanoid:EquipTool(tool) 
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
  AcrylicBlur = true
})

local UI = {
  Tabs = Window:TabGroup(),
  Elements = {}
}

UI.Elements.Main = UI.Tabs:Tab({
  Name = "Main", 
  Image = "rbxassetid://10734949013"
})

UI.Elements.Stats = UI.Tabs:Tab({
  Name = "Stats", 
  Image = "rbxassetid://10734950039"
})

UI.Elements.Settings = UI.Tabs:Tab({
  Name = "Settings", 
  Image = "rbxassetid://10734950309"
})

local Sections = {
  Main = UI.Elements.Main:Section({Side = "Left"}),
  Stats = UI.Elements.Stats:Section({Side = "Left"}),
  Settings = UI.Elements.Settings:Section({Side = "Left"})
}

Sections.Main:Toggle({
  Name = "Auto farm level", 
  Default = false, 
  Callback = function(v) 
    _G.Configs.Farm.AutoLevel = v 
    if not v then
      cleanPhysics()
    end 
  end
})

Sections.Main:Toggle({
  Name = "Auto farm nearest", 
  Default = false, 
  Callback = function(v) 
    _G.Configs.Farm.AutoNearest = v 
    if not v then
      cleanPhysics()
    end 
  end
})

Sections.Stats:Label({
  Name = "Stats config"
})

Sections.Stats:Slider({
  Name = "Add point", 
  Default = 3, 
  Minimum = 1, 
  Maximum = 100, 
  DisplayMethod = "Percent", 
  Callback = function(v) 
    _G.Configs.Stats.Amount = v 
  end
})

Sections.Stats:Toggle({
  Name = "Auto add point", 
  Default = false, 
  Callback = function(v) 
    _G.Configs.Stats.AutoAdd = v 
  end
})

Sections.Stats:Divider()

Sections.Stats:Toggle({
  Name = "Melee", 
  Callback = function(v) 
    _G.Configs.Stats.Targets.Melee = v 
  end
})

Sections.Stats:Toggle({
  Name = "Defense", 
  Callback = function(v) 
    _G.Configs.Stats.Targets.Defense = v 
  end
})

Sections.Stats:Toggle({
  Name = "Sword", 
  Callback = function(v) 
    _G.Configs.Stats.Targets.Sword = v 
  end
})

Sections.Stats:Toggle({
  Name = "Gun", 
  Callback = function(v) 
    _G.Configs.Stats.Targets.Gun = v 
  end
})

Sections.Stats:Toggle({
  Name = "Demon fruit", 
  Callback = function(v) 
    _G.Configs.Stats.Targets["Demon Fruit"] = v 
  end
})

Sections.Settings:Slider({
  Name = "Attack speed", 
  Default = 0.1, 
  Minimum = 0.1, 
  Maximum = 1, 
  DisplayMethod = "Value", 
  Callback = function(v) 
    _G.Configs.Attack.Speed = v 
  end
})

Sections.Settings:Slider({
  Name = "Attack distance", 
  Default = 45, 
  Minimum = 10, 
  Maximum = 45, 
  DisplayMethod = "Value", 
  Callback = function(v) 
    _G.Configs.Attack.Distance = v 
  end
})

Sections.Settings:Slider({
  Name = "Farm distance", 
  Default = 15, 
  Minimum = 7, 
  Maximum = 18, 
  DisplayMethod = "Value", 
  Callback = function(v) 
    _G.Configs.Farm.Distance = v 
  end
})

Sections.Settings:Slider({
  Name = "Tween speed", 
  Default = 250, 
  Minimum = 50, 
  Maximum = 250, 
  DisplayMethod = "Value", 
  Callback = function(v) 
    _G.Configs.Farm.TweenSpeed = v 
  end
})

Sections.Settings:Toggle({
  Name = "Auto attack", 
  Default = true, 
  Callback = function(v) 
    _G.Configs.Attack.Enabled = v 
  end
})

Sections.Settings:Toggle({
  Name = "Attack players", 
  Default = true, 
  Callback = function(v) 
    _G.Configs.Attack.Players = v 
  end
})

local dragGui = new("ScreenGui", {
  Name = "MarkHubToggleGui", 
  Parent = CoreGui
})

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

dragBtn.MouseButton1Click:Connect(function() 
  Window:SetState(not Window:GetState()) 
end)
