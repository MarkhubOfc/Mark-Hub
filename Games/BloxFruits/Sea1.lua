if game.PlaceId == 2753915549 then
  local currentTween
  local noclipParts = {}
  local GetAFruit = false

  local function new(c, p)
    local k = Instance.new(c)
    for pp, v in pairs(p or {}) do
      k[pp] = v
    end
    return k
  end

  local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
  local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
  local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()
  local MobList1 = loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/Modules/BloxFruits/MobList1.lua"))()

  local lp = game:GetService("Players").LocalPlayer
  local Char = lp.Character or lp.CharacterAdded:Wait()
  local TweenService = game:GetService("TweenService")
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local RunService = game:GetService("RunService")
  local UIS = game:GetService("UserInputService")
  local CoreGui = game:GetService("CoreGui")
  local CommF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")

  local Net = require(ReplicatedStorage.Modules.Net)
  local CombatUtil = require(ReplicatedStorage.Modules.CombatUtil)
  local hitRemote = Net:RemoteEvent("RegisterHit")
  local attackRemote = ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterAttack")

  lp.CharacterAdded:Connect(function(character)
    Char = character
    task.wait(0.1)
    cleanPhysics()
  end)

  _G.Configs = {
    Farm = {
      AutoLevel = false,
      AutoNearest = false,
      Distance = 15,
      TweenSpeed = 250,
      BringMob = false
    },
    Attack = {
      Enabled = true,
      Players = false,
      Speed = 0.1,
      Distance = 45
    },
    Stats = {
      AutoAdd = false,
      Amount = 1,
      Targets = {
        Melee = false,
        Defense = false,
        Sword = false,
        Gun = false,
        ["Demon Fruit"] = false
      }
    },
    Fruit = {
      AutoGet = false
    },
    Teleport_Islands = {
      ["Marine Starter"] = CFrame.new(-2629, 24, 2099),
      ["Middle Town"] = CFrame.new(-605, 8, 1562),
      ["Pirate Starter"] = CFrame.new(888, 21, 1499),
      ["Jungle"] = CFrame.new(-1637, 37, 142),
      ["Jungle 2"] = CFrame.new(-1148, 13, -364),
      ["Skylands ( Up )"] = CFrame.new(-4875, 718, -2635),
      ["Frozen Village"] = CFrame.new(1196, 27, -1203)
    }
  }

  local CombatStyleList = {
    "Combat",
    "Dark Step",
    "Death Step",
    "Electric",
    "Electric Claw",
    "Water Kung Fu",
    "Sharkman Karate",
    "Dragon Breath",
    "Dragon Talon",
    "Superhuman",
    "Godhuman",
    "Sanguine Art"
  }

  local SwordList = {
    "Cutlass",
    "Dual Katana",
    "Katana",
    "Fishing Trophy",
    "Iron Mace",
    "Shark Saw",
    "Triple Katana",
    "Twin Hooks",
    "Dragon Trident",
    "Dual-Headed Blade",
    "Flail",
    "Gravity Blade",
    "Longsword",
    "Pipe",
    "Soul Cane",
    "Trident",
    "Wardens Sword",
    "Bisento",
    "Buddy Sword",
    "Canvander",
    "Dark Dagger",
    "Dragonheart",
    "Fox Lamp",
    "Koko",
    "Midnight Blade",
    "Oroshi",
    "Pole (1st Form)",
    "Pole (2nd Form)",
    "Rengoku",
    "Saber",
    "Saishi",
    "Shark Anchor",
    "Shizu",
    "Spikey Trident",
    "Tushita",
    "Yama",
    "Cursed Dual Katana",
    "Dark Blade",
    "Hallow Scythe",
    "Triple Dark Blade",
    "True Triple Katana"
  }

  local FruitM1List = {
    "Light-Light",
    "Ice-Ice",
    "Rubber-Rubber",
    "Phoenix-Phoenix",
    "Portal-Portal",
    "Mammoth-Mammoth",
    "T-Rex-T-Rex",
    "Dough-Dough",
    "Spirit-Spirit",
    "Leopard-Leopard",
    "Kitsune-Kitsune",
    "Dragon-Dragon",
    "Yeti-Yeti",
    "Tiger-Tiger",
    "Eagle-Eagle",
    "Awakened Phoenix",
    "Awakened Dough",
    "Creation-Creation",
    "Control-Control",
    "Gravity-Gravity",
    "Gas-Gas",
    "Blizzard-Blizzard",
    "Venom-Venom",
    "Shadow-Shadow",
    "Sound-Sound",
    "Spider-Spider",
    "Love-Love",
    "Ghost-Ghost",
    "Magma-Magma",
    "Sand-Sand",
    "Dark-Dark",
    "Flame-Flame",
    "Diamond-Diamond",
    "Buddha-Buddha"
  }

  local BuddhaSupportList = {
    "Combat",
    "Dark Step",
    "Death Step",
    "Electric",
    "Electric Claw",
    "Water Kung Fu",
    "Sharkman Karate",
    "Dragon Breath",
    "Dragon Talon",
    "Superhuman",
    "Godhuman",
    "Sanguine Art",
    "Cutlass",
    "Dual Katana",
    "Katana",
    "Fishing Trophy",
    "Iron Mace",
    "Shark Saw",
    "Triple Katana",
    "Twin Hooks",
    "Dragon Trident",
    "Dual-Headed Blade",
    "Flail",
    "Gravity Blade",
    "Longsword",
    "Pipe",
    "Soul Cane",
    "Trident",
    "Wardens Sword",
    "Bisento",
    "Buddy Sword",
    "Canvander",
    "Dark Dagger",
    "Dragonheart",
    "Fox Lamp",
    "Koko",
    "Midnight Blade",
    "Oroshi",
    "Pole (1st Form)",
    "Pole (2nd Form)",
    "Rengoku",
    "Saber",
    "Saishi",
    "Shark Anchor",
    "Shizu",
    "Spikey Trident",
    "Tushita",
    "Yama",
    "Cursed Dual Katana",
    "Dark Blade",
    "Hallow Scythe",
    "Triple Dark Blade",
    "True Triple Katana"
  }

  local FightingStyleMode = "Combat"

  local function tweenTo(config)
    if not Char then
      Char = lp.Character
    end

    local hrp = Char and Char:FindFirstChild("HumanoidRootPart")
    if not hrp or not config.CFrame then
      return
    end

    if currentTween then
      pcall(function()
        currentTween:Cancel()
      end)
      currentTween = nil
    end

    local bv = hrp:FindFirstChild("TweenStabilizer")
    if bv then
      bv:Destroy()
    end

    bv = new("BodyVelocity", {
      Name = "TweenStabilizer",
      Parent = hrp,
      MaxForce = Vector3.new(9e9, 9e9, 9e9),
      Velocity = Vector3.zero
    })

    local dist = (hrp.Position - config.CFrame.Position).Magnitude
    local info = TweenInfo.new(dist / _G.Configs.Farm.TweenSpeed, Enum.EasingStyle.Linear)
    currentTween = TweenService:Create(hrp, info, {CFrame = config.CFrame})

    local connection
    connection = Char.Humanoid.Died:Connect(function()
      cleanPhysics()
      if connection then
        connection:Disconnect()
        connection = nil
      end
    end)

    currentTween.Completed:Connect(function()
      if connection then
        connection:Disconnect()
        connection = nil
      end
    end)

    currentTween:Play()
  end

  local function cleanPhysics()
    if currentTween then
      pcall(function()
        currentTween:Cancel()
      end)
      currentTween = nil
    end

    if not Char then
      Char = lp.Character
    end

    local hrp = Char and Char:FindFirstChild("HumanoidRootPart")
    if hrp then
      local bv = hrp:FindFirstChild("TweenStabilizer")
      if bv then
        bv:Destroy()
      end
      hrp.AssemblyLinearVelocity = Vector3.zero
      hrp.AssemblyAngularVelocity = Vector3.zero
    end

    if Char then
      local hum = Char:FindFirstChild("Humanoid")
      if hum then
        hum.AutoRotate = true
        hum.PlatformStand = false
      end

      for part, original in pairs(noclipParts) do
        if part and part.Parent then
          part.CanCollide = original
        end
      end
      table.clear(noclipParts)

      for _, v in pairs(Char:GetDescendants()) do
        if v:IsA("BasePart") then
          v.AssemblyLinearVelocity = Vector3.zero
          v.AssemblyAngularVelocity = Vector3.zero
        end
      end
    end
  end

  local function bringMonsters(name, pcf)
  end

  RunService.Stepped:Connect(function()
    if (_G.Configs.Farm.AutoLevel or _G.Configs.Farm.AutoNearest) and not GetAFruit then
      if not Char then
        Char = lp.Character
      end

      if Char then
        local hrp = Char:FindFirstChild("HumanoidRootPart")
        local hum = Char:FindFirstChild("Humanoid")

        if hrp and hum then
          hum.AutoRotate = false
          hum.PlatformStand = false

          for _, v in pairs(Char:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
              if not noclipParts[v] then
                noclipParts[v] = v.CanCollide
              end
              v.CanCollide = false
            end
          end
        end
      end
    end
  end)

  local Window = Fluent:CreateWindow({
    Title = "Mark Hub - Blox Fruits",
    SubTitle = "by Rain",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
  })

  local MainTab = Window:AddTab({
    Title = "Main",
    Icon = "home"
  })

  local MainTabFarmModeSection = MainTab:AddSection("Farm mode")

  MainTabFarmModeSection:AddDropdown("FightingStyle", {
    Title = "Fighting style",
    Values = {"Combat", "Sword", "Demon fruit"},
    Default = 1,
    Callback = function(v)
      FightingStyleMode = v
    end
  })

  local AutoBuso = nil
  MainTabFarmModeSection:AddToggle("AutoBuso", {
    Title = "Auto buso",
    Default = true,
    Callback = function(v)
      if v then
        AutoBuso = RunService.Heartbeat:Connect(function()
          pcall(function()
            if not Char:FindFirstChild("HasBuso") then
              CommF:InvokeServer("Buso")
            end
          end)
        end)
      else
        if AutoBuso then
          AutoBuso:Disconnect()
          AutoBuso = nil
        end
      end
    end
  })

  local MainTabFarmSection = MainTab:AddSection("Farm")
  local AutoFarmLevelToggle = MainTabFarmSection:AddToggle("AutoFarmLevel", {
    Title = "Auto Farm Level",
    Default = false,
    Callback = function(v)
      if v and _G.Configs.Farm.AutoNearest then
        AutoFarmNearestToggle:SetValue(false)
      end

      _G.Configs.Farm.AutoLevel = v

      if not v then
        task.wait(0.3)
        cleanPhysics()
      else
        task.spawn(function()
          while _G.Configs.Farm.AutoLevel do
            task.wait()
            pcall(function()
              if not _G.Configs.Farm.AutoLevel or GetAFruit then
                return
              end

              if not Char then
                Char = lp.Character
              end

              if not Char or not Char:FindFirstChild("HumanoidRootPart") then
                return
              end

              local LevelData = MobList1:CheckLevel()

              if not lp.PlayerGui.Main.Quest.Visible then
                if FightingStyleMode == "Combat" then
                  for _, LiName in pairs(CombatStyleList) do
                    if Char:FindFirstChild(LiName) then
                      Char.Humanoid:UnequipTools()
                      break
                    end
                  end
                elseif FightingStyleMode == "Sword" then
                  for _, LiName in pairs(SwordList) do
                    if Char:FindFirstChild(LiName) then
                      Char.Humanoid:UnequipTools()
                      break
                    end
                  end
                elseif FightingStyleMode == "Demon fruit" then
                  for _, LiName in pairs(FruitM1List) do
                    if Char:FindFirstChild(LiName) then
                      Char.Humanoid:UnequipTools()
                      break
                    end
                  end
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

                if FightingStyleMode == "Combat" then
                  local equipped = false
                  for _, LiName in pairs(CombatStyleList) do
                    local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                    if tool and tool.Parent ~= Char then
                      Char.Humanoid:EquipTool(tool)
                      equipped = true
                      break
                    end
                  end
                elseif FightingStyleMode == "Sword" then
                  local equipped = false
                  for _, LiName in pairs(SwordList) do
                    local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                    if tool and tool.Parent ~= Char then
                      Char.Humanoid:EquipTool(tool)
                      equipped = true
                      break
                    end
                  end
                elseif FightingStyleMode == "Demon fruit" then
                  local equipped = false
                  for _, LiName in pairs(FruitM1List) do
                    local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                    if tool and tool.Parent ~= Char then
                      Char.Humanoid:EquipTool(tool)
                      equipped = true
                      break
                    end
                  end

                  if Char:FindFirstChild("Buddha-Buddha") then
                    for _, LiName in pairs(BuddhaSupportList) do
                      local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                      if tool and tool.Parent ~= Char then
                        Char.Humanoid:EquipTool(tool)
                        break
                      end
                    end
                  end
                end
              end
            end)
          end
        end)
      end
    end
  })

  local AutoFarmNearestToggle = MainTabFarmSection:AddToggle("AutoFarmNearest", {
    Title = "Auto Farm Nearest",
    Default = false,
    Callback = function(v)
      if v and _G.Configs.Farm.AutoLevel then
        AutoFarmLevelToggle:SetValue(false)
      end

      _G.Configs.Farm.AutoNearest = v

      if not v then
        task.wait(0.3)
        cleanPhysics()
      else
        task.spawn(function()
          local currentTarget = nil
          while _G.Configs.Farm.AutoNearest do
            task.wait(0.2)
            pcall(function()
              if not _G.Configs.Farm.AutoNearest or GetAFruit then
                return
              end

              if not Char then
                Char = lp.Character
              end

              if not Char or not Char:FindFirstChild("HumanoidRootPart") then
                return
              end

              local nearest = nil
              local lastDist = math.huge

              for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                local hrp = enemy:FindFirstChild("HumanoidRootPart")
                local hum = enemy:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                  local d = (Char.HumanoidRootPart.Position - hrp.Position).Magnitude
                  if d < lastDist then
                    lastDist = d
                    nearest = enemy
                  end
                end
              end

              if nearest then
                local nHrp = nearest:FindFirstChild("HumanoidRootPart")
                if nHrp then
                  local TargetPos = nHrp.CFrame * CFrame.new(0, _G.Configs.Farm.Distance, 0)
                  bringMonsters(nearest.Name, TargetPos * CFrame.new(0, -_G.Configs.Farm.Distance, 0))

                  if currentTarget ~= nearest or not currentTween then
                    currentTarget = nearest
                    tweenTo({CFrame = TargetPos})
                  end
                end
              else
                currentTarget = nil
              end

              if FightingStyleMode == "Combat" then
                for _, LiName in pairs(CombatStyleList) do
                  local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                  if tool and tool.Parent ~= Char then
                    Char.Humanoid:EquipTool(tool)
                    break
                  end
                end
              elseif FightingStyleMode == "Sword" then
                for _, LiName in pairs(SwordList) do
                  local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                  if tool and tool.Parent ~= Char then
                    Char.Humanoid:EquipTool(tool)
                    break
                  end
                end
              elseif FightingStyleMode == "Demon fruit" then
                local equipped = false
                for _, LiName in pairs(FruitM1List) do
                  local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                  if tool and tool.Parent ~= Char then
                    Char.Humanoid:EquipTool(tool)
                    equipped = true
                    break
                  end
                end

                if Char:FindFirstChild("Buddha-Buddha") then
                  for _, LiName in pairs(BuddhaSupportList) do
                    local tool = lp.Backpack:FindFirstChild(LiName) or Char:FindFirstChild(LiName)
                    if tool and tool.Parent ~= Char then
                      Char.Humanoid:EquipTool(tool)
                      break
                    end
                  end
                end
              end
            end)
          end
        end)
      end
    end
  })

  local ShopTab = Window:AddTab({
    Title = "Shop",
    Icon = "shopping-cart"
  })
  
  ShopTab:AddButton({
    Title = "Roll gacha fruit",
    Description = "",
    Callback = function()
      local args = {
        "Cousin",
        "Buy",
        "DLCBoxData"
      }
      game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack(args))
    end
  })
  
  local ShopTabAbilitySection = ShopTab:AddSection("Ability")
  ShopTabAbilitySection:AddButton({
    Title = "Buy air jump",
    Description = "Cost: 10000",
    Callback = function()
      CommF:InvokeServer("BuyHaki", "Geppo")
    end
  })
  
  ShopTabAbilitySection:AddButton({
    Title = "Buy buso",
    Description = "Cost: 25000",
    Callback = function()
      CommF:InvokeServer("BuyHaki", "Buso")
    end
  })

  local DemonFruitTab = Window:AddTab({
    Title = "Demon fruit",
    Icon = "banana"
  })

  local DemonFruitSection = DemonFruitTab:AddSection("Fruit Sniper")
  DemonFruitSection:AddToggle("AutoGetFruit", {
    Title = "Auto get fruit",
    Default = false,
    Callback = function(v)
      _G.Configs.Fruit.AutoGet = v
    end
  })

  task.spawn(function()
    local processingFruits = {}

    local function handleFruit(child)
      if not _G.Configs.Fruit.AutoGet then
        return
      end
      if not string.match(string.lower(child.Name), "fruit$") then
        return
      end
      if processingFruits[child] then
        return
      end
      processingFruits[child] = true

      GetAFruit = true

      if currentTween then
        pcall(function()
          currentTween:Cancel()
        end)
        currentTween = nil
      end

      _G.Configs.Farm.AutoLevel = false
      _G.Configs.Farm.AutoNearest = false
      pcall(function()
        AutoFarmLevelToggle:SetValue(false)
      end)
      pcall(function()
        AutoFarmNearestToggle:SetValue(false)
      end)

      cleanPhysics()

      local fruitPart
      if child:IsA("Model") then
        fruitPart = child:FindFirstChildWhichIsA("BasePart") or child:FindFirstChild("Handle") or child.PrimaryPart
      elseif child:IsA("BasePart") then
        fruitPart = child
      end
      if not fruitPart then
        GetAFruit = false
        processingFruits[child] = nil
        return
      end

      tweenTo({CFrame = fruitPart.CFrame})

      local gone = false
      local conn
      conn = child.AncestryChanged:Connect(function()
        if not child.Parent then
          gone = true
          if conn then
            conn:Disconnect()
          end
        end
      end)

      while not gone do
        task.wait()
      end

      GetAFruit = false
      cleanPhysics()
      processingFruits[child] = nil
    end

    workspace.ChildAdded:Connect(handleFruit)

    local fruitSpawns = workspace:WaitForChild("_WorldOrigin"):WaitForChild("FruitSpawns")
    fruitSpawns.ChildAdded:Connect(handleFruit)
  end)
  
  local StatsTab = Window:AddTab({
    Title = "Stats",
    Icon = "bar-chart-2"
  })
  
  local StatsTabSettingsSection = StatsTab:AddSection("Stats Settings")
  StatsTabSettingsSection:AddParagraph({
    Title = "Stats Configuration",
    Content = "Configure your automatic stat distribution"
  })

  StatsTabSettingsSection:AddSlider("AddPoint", {
    Title = "Points to Add",
    Description = "Amount of points per cycle",
    Default = 1,
    Min = 1,
    Max = 100,
    Rounding = 0,
    Callback = function(v)
      _G.Configs.Stats.Amount = v
    end
  })

  StatsTabSettingsSection:AddToggle("AutoAddPoint", {
    Title = "Auto Add Points",
    Default = false,
    Callback = function(v)
      _G.Configs.Stats.AutoAdd = v
      if v then
        task.spawn(function()
          while _G.Configs.Stats.AutoAdd do
            task.wait(0.5)
            pcall(function()
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
            end)
          end
        end)
      end
    end
  })

  local StatsTabPointsSection = StatsTab:AddSection("Points")
  StatsTabPointsSection:AddToggle("Melee", {
    Title = "Melee",
    Default = false,
    Callback = function(v)
      _G.Configs.Stats.Targets.Melee = v
    end
  })

  StatsTabPointsSection:AddToggle("Defense", {
    Title = "Defense",
    Default = false,
    Callback = function(v)
      _G.Configs.Stats.Targets.Defense = v
    end
  })

  StatsTabPointsSection:AddToggle("Sword", {
    Title = "Sword",
    Default = false,
    Callback = function(v)
      _G.Configs.Stats.Targets.Sword = v
    end
  })

  StatsTabPointsSection:AddToggle("Gun", {
    Title = "Gun",
    Default = false,
    Callback = function(v)
      _G.Configs.Stats.Targets.Gun = v
    end
  })

  StatsTabPointsSection:AddToggle("DemonFruit", {
    Title = "Demon Fruit",
    Default = false,
    Callback = function(v)
      _G.Configs.Stats.Targets["Demon Fruit"] = v
    end
  })

  local TeleportTab = Window:AddTab({
    Title = "Teleport",
    Icon = "map-pin"
  })
  
  local TeleportIslandSection = TeleportTab:AddSection("Island")
  TeleportIslandSection:AddParagraph({
    Title = "Teleport",
    Content = "Travel to different islands"
  })

  local SelectedIsland = "Marine Starter"
  TeleportIslandSection:AddDropdown("SelectIsland", {
    Title = "Select Island",
    Values = {
      "Marine Starter",
      "Middle Town",
      "Pirate Starter",
      "Jungle",
      "Jungle 2",
      "Skylands ( Up )",
      "Frozen Village"
    },
    Default = 1,
    Callback = function(v)
      SelectedIsland = v
    end
  })

  TeleportIslandSection:AddButton({
    Title = "Teleport to Island",
    Description = "Click to teleport",
    Callback = function()
      if _G.Configs.Farm.AutoLevel then
        AutoFarmLevelToggle:SetValue(false)
      end

      if _G.Configs.Farm.AutoNearest then
        AutoFarmNearestToggle:SetValue(false)
      end

      task.wait(0.3)

      if Char then
        if FightingStyleMode == "Combat" then
          for _, LiName in pairs(CombatStyleList) do
            if Char:FindFirstChild(LiName) then
              Char.Humanoid:UnequipTools()
              break
            end
          end
        elseif FightingStyleMode == "Sword" then
          for _, LiName in pairs(SwordList) do
            if Char:FindFirstChild(LiName) then
              Char.Humanoid:UnequipTools()
              break
            end
          end
        elseif FightingStyleMode == "Demon fruit" then
          for _, LiName in pairs(FruitM1List) do
            if Char:FindFirstChild(LiName) then
              Char.Humanoid:UnequipTools()
              break
            end
          end
        end
      end

      if SelectedIsland and _G.Configs.Teleport_Islands[SelectedIsland] then
        tweenTo({CFrame = _G.Configs.Teleport_Islands[SelectedIsland]})
        if currentTween then
          currentTween.Completed:Connect(function()
            cleanPhysics()
          end)
        end
      end
    end
  })

  local TeleportTabSeaSection = TeleportTab:AddSection("Sea")
  TeleportTabSeaSection:AddButton({
    Title = "TP to sea 1",
    Callback = function()
      CommF:InvokeServer("DressrosaQuestProgress", "Dressrosa")
    end
  })

  local SettingsTab = Window:AddTab({
    Title = "Settings",
    Icon = "settings"
  })
  
  local SettingsFarmConfigSection = SettingsTab:AddSection("Farm settings")
  SettingsFarmConfigSection:AddSlider("AttackSpeed", {
    Title = "Attack Speed",
    Description = "Attack tick speed",
    Default = 0.1,
    Min = 0.1,
    Max = 1,
    Rounding = 1,
    Callback = function(v)
      _G.Configs.Attack.Speed = v
    end
  })

  SettingsFarmConfigSection:AddSlider("AttackDistance", {
    Title = "Attack Distance",
    Description = "Attack range",
    Default = 45,
    Min = 10,
    Max = 45,
    Rounding = 0,
    Callback = function(v)
      _G.Configs.Attack.Distance = v
    end
  })

  SettingsFarmConfigSection:AddSlider("FarmDistance", {
    Title = "Farm Distance",
    Description = "Distance from mobs",
    Default = 15,
    Min = 7,
    Max = 18,
    Rounding = 0,
    Callback = function(v)
      _G.Configs.Farm.Distance = v
    end
  })

  SettingsFarmConfigSection:AddSlider("TweenSpeed", {
    Title = "Tween Speed",
    Description = "Movement speed",
    Default = 250,
    Min = 50,
    Max = 250,
    Rounding = 0,
    Callback = function(v)
      _G.Configs.Farm.TweenSpeed = v
    end
  })

  SettingsFarmConfigSection:AddToggle("BringMob", {
    Title = "Bring Mob",
    Default = false,
    Callback = function(v)
      _G.Configs.Farm.BringMob = v
    end
  })

  SettingsFarmConfigSection:AddToggle("AutoAttack", {
    Title = "Auto Attack",
    Default = true,
    Callback = function(v)
      _G.Configs.Attack.Enabled = v
      if v then
        task.spawn(function()
          while _G.Configs.Attack.Enabled do
            task.wait(_G.Configs.Attack.Speed)
            pcall(function()
              if not Char then
                Char = lp.Character
              end

              if not Char or not Char:FindFirstChild("HumanoidRootPart") then
                return
              end

              local tool = Char:FindFirstChildOfClass("Tool")
              if not tool then
                return
              end

              local root = Char.HumanoidRootPart
              local mobs = {}

              for _, mob in ipairs(workspace.Enemies:GetChildren()) do
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                local hum = mob:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                  if (hrp.Position - root.Position).Magnitude <= _G.Configs.Attack.Distance then
                    table.insert(mobs, mob)
                  end
                end
              end

              if _G.Configs.Attack.Players then
                for _, plr in ipairs(workspace.Characters:GetChildren()) do
                  local hrp = plr:FindFirstChild("HumanoidRootPart")
                  local hum = plr:FindFirstChild("Humanoid")
                  if plr ~= Char and hrp and hum and hum.Health > 0 then
                    if (hrp.Position - root.Position).Magnitude <= _G.Configs.Attack.Distance then
                      table.insert(mobs, plr)
                    end
                  end
                end
              end

              for _, target in ipairs(mobs) do
                local hrp = target:FindFirstChild("HumanoidRootPart")
                local hum = target:FindFirstChild("Humanoid")
                if hrp and hum and hum.Health > 0 then
                  local weaponName = CombatUtil:GetWeaponName(tool)
                  local uuid = tostring(lp.UserId):sub(2, 4) .. tostring(math.random(10000, 99999))
                  local hitData = {{target, hrp}}

                  if attackRemote then
                    attackRemote:FireServer()
                  end

                  hitRemote:FireServer(hrp, hitData, nil, nil, uuid)
                  CombatUtil:ApplyDamageHighlight(target, Char, weaponName, hrp, nil)
                  tool:Activate()
                end
              end
            end)
          end
        end)
      end
    end
  })

  SettingsFarmConfigSection:AddToggle("AttackPlayers", {
    Title = "Attack Players",
    Default = false,
    Callback = function(v)
      _G.Configs.Attack.Players = v
    end
  })
  
  SaveManager:SetLibrary(Fluent)
  InterfaceManager:SetLibrary(Fluent)
  
  InterfaceManager:SetFolder("Mark-Hub")
  SaveManager:SetFolder("Mark-Hub/Blox-fruits")

  InterfaceManager:BuildInterfaceSection(SettingsTab)
  SaveManager:BuildConfigSection(SettingsTab)
  
  Window:SelectTab(1)
  Fluent:Notify({
    Title = "Fluent:",
    Content = "The script has been loaded.",
    Duration = 5
  })
  
SaveManager:LoadAutoloadConfig()
  
  local dragGui = new("ScreenGui", {
    Name = "MarkHubToggleGui",
    Parent = CoreGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  })

  local dragBtn = new("TextButton", {
    Size = UDim2.fromOffset(44, 44),
    Position = UDim2.new(1, -60, 0.5, -22),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    Text = "M",
    TextColor3 = Color3.new(1, 1, 1),
    Font = Enum.Font.GothamBold,
    TextSize = 18,
    Parent = dragGui,
    AutoButtonColor = false
  })

  new("UICorner", {
    CornerRadius = UDim.new(0.5, 0),
    Parent = dragBtn
  })

  new("UIStroke", {
    Color = Color3.fromRGB(80, 80, 80),
    Thickness = 1,
    Parent = dragBtn
  })

  local dragging = false
  local dragInput, mousePos, framePos

  dragBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      mousePos = input.Position
      framePos = dragBtn.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          dragging = false
        end
      end)
    end
  end)

  dragBtn.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
      dragInput = input
    end
  end)

  UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
      local delta = input.Position - mousePos
      dragBtn.Position = UDim2.new(
        framePos.X.Scale,
        framePos.X.Offset + delta.X,
        framePos.Y.Scale,
        framePos.Y.Offset + delta.Y
      )
    end
  end)

  dragBtn.MouseButton1Click:Connect(function()
    Window:Minimize()
  end)
else
  print("Please join blox fruits.")
end
