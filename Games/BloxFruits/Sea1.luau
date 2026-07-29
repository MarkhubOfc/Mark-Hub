local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/redz-V5-remake/main.luau'))()

local Window = Library:MakeWindow({
  Title = 'Zynkore hub : Blox fruits',
  SubTitle = 'By zynkore',
  ScriptFolder = 'zynkore-hub-blox-fruits-sea-1'
})

Window:Notify({
  Title = 'Info',
  Content = 'Hub loading!',
  Duration = 4,
  Image = 'rbxassetid://127887124660168'
})

-- Services
local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
local WS = (cloneref and cloneref(game:GetService('Workspace')) or game:GetService('Workspace'))
local ReplicatedFirst = (cloneref and cloneref(game:GetService('ReplicatedFirst')) or game:GetService('ReplicatedFirst'))
local ReplicatedStorage = (cloneref and cloneref(game:GetService('ReplicatedStorage')) or game:GetService('ReplicatedStorage'))
local RunService = (cloneref and cloneref(game:GetService('RunService')) or game:GetService('RunService'))
local BadgeService = (cloneref and cloneref(game:GetService('BadgeService')) or game:GetService('BadgeService'))

-- Global var
getgenv().InSpecialArea = false
getgenv().AreaId = 0

getgenv().Farm_distance = 17
getgenv().Tween_speed = 250
getgenv().Bring_mobs_dist = 350
getgenv().Bring_mobs = true
getgenv().Auto_attack = true

-- LocalPlayer
local LP = plr.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild('HumanoidRootPart')
local Humanoid = Char:WaitForChild('Humanoid')
local Backpack = LP:WaitForChild('Backpack')
LP.CharacterAdded:Connect(function(V)
  Char = V
  HRP = V:WaitForChild('HumanoidRootPart')
  Humanoid = V:WaitForChild('Humanoid')
  Backpack = LP:WaitForChild('Backpack')
end)

-- Noclip
local NoclipParts = {}
local NoclipConnection = nil
SetNoclip = function(Value)
  if Value == true then
    if NoclipConnection then
      NoclipConnection:Disconnect()
      NoclipConnection = nil
    end
    for _, part in ipairs(NoclipParts) do
      if part and part.Parent then
        part.CanCollide = true
      end
    end
    table.clear(NoclipParts)
  else
    if NoclipConnection then return end
    for _, instance in ipairs(Char:GetDescendants()) do
      if instance:IsA('BasePart') and instance.CanCollide then
        instance.CanCollide = false
        table.insert(NoclipParts, instance)
      end
    end
    
    NoclipConnection = RunService.Stepped:Connect(function()
      for _, instance in ipairs(Char:GetDescendants()) do
        if instance:IsA('BasePart') and instance.CanCollide then
          instance.CanCollide = false
          table.insert(NoclipParts, instance)
        end
      end
    end)
  end
end

-- User Data
local UserId = LP.UserId
local Data = LP:WaitForChild('Data')
local MyLevel = Data:WaitForChild('Level')
local MyBeli = Data:WaitForChild('Beli')
local MyPoints = Data:WaitForChild('Points')

-- Remotes
local Modules = ReplicatedStorage:WaitForChild('Modules')
local Asset = Modules:WaitForChild('Asset')
local Net = Modules:WaitForChild('Net')
local RE_RegisterAttack = Net:WaitForChild('RE/RegisterAttack')
local RE_RegisterHit = Net:WaitForChild('RE/RegisterHit')
local CommF_ = ReplicatedStorage:WaitForChild('Remotes'):WaitForChild('CommF_')

-- Gui
local PlayerGui = LP:WaitForChild('PlayerGui')
local QuestGui = PlayerGui:WaitForChild('Main'):WaitForChild('Quest')
local QuestTitle = QuestGui:WaitForChild('Container'):WaitForChild('QuestTitle'):WaitForChild('Title')
LP.ChildAdded:Connect(function(Child)
  if Child:IsA('PlayerGui') then
    PlayerGui = Child
    QuestGui = Child:WaitForChild('Main'):WaitForChild('Quest')
    QuestTitle = QuestGui:WaitForChild('Container'):WaitForChild('QuestTitle'):WaitForChild('Title')
  end
end)

-- Others
local MapFolder = WS:WaitForChild('Map')
local EnemieFolder = WS:WaitForChild('Enemies')

-- Modules
local TweenModule = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Modules/Universal/TweenModule.luau'))()
local ListModule = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Modules/BloxFruits/MonList/Sea1.luau'))()
local GeneralModule = loadstring(game:HttpGet('https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Modules/BloxFruits/Module.lua'))()
TweenModule:SetGameMode({'R15'})

local InfoTab = Window:MakeTab({
  Title = 'Info',
  Icon = 'user'
})
InfoTab:AddSection('Data')

local MyLevelLabel = InfoTab:AddParagraph(`My level: {MyLevel.Value}`)
task.spawn(function()
  while true do
    MyLevelLabel:SetTitle(`My level: {MyLevel.Value}`)
    task.wait(5)
  end
end)

local MainTab = Window:MakeTab({
  Title = 'Main',
  Icon = 'home'
})
MainTab:AddSection('Farm config')
Window:SelectTab(2)

local ItemList = {
  ['Melee'] = {
    'Combat',
    'Black Leg',
    'Electro',
    'Fishman Karate',
    'Dragon Claw',
    'Superhuman',
    'Death Step',
    'Sharkman Karate',
    'Electric Claw',
    'Dragon Talon',
    'Godhuman',
    'Sanguine Art',
    'Divine Art'
  },
  Type_selected = 'Melee'
} 
MainTab:AddDropdown({
  Title = 'Melee type',
  MultiSelect = false,
  Options = {'Melee'},
  Default = 'Melee',
  Flag = 'Melee_type',
  Callback = function(V)
    ItemList.Type_selected = V
  end
})

getgenv().Auto_buso = nil
MainTab:AddToggle({
  Title = 'Auto buso',
  Default = true,
  Flag = 'Auto_buso',
  Callback = function(V)
    if V then
      if getgenv().Auto_buso then
        getgenv().Auto_buso:Disconnect()
        getgenv().Auto_buso = nil
      end
      
      getgenv().Auto_buso = RunService.Heartbeat:Connect(function()
        if Char then
          if not Char:FindFirstChild('HasBuso') then
            CommF_:InvokeServer('Buso')
          end
        end
      end)
    else
      if getgenv().Auto_buso then
        getgenv().Auto_buso:Disconnect()
        getgenv().Auto_buso = nil
      end
    end
  end
})
MainTab:AddSection('Farm')

function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end

local SpecialQuest = {
  [1] = {
    TpPos = Vector3.new(3911.89355, 12.3084831, -1930.40942), -- CFrame
    Event = MapFolder:WaitForChild('TeleportSpawn'):WaitForChild('Entrance'),
    EventType = 1, -- 1 = touchinterest | 2 = proximityprompt | 3 = requestEntrance | 0 = No special
    SubConfig = {
      Position = Vector3.new(61116, 265, 1354),
      Radius = 1800
    }
  },
  [2] = {
    TpPos = CFrame.new(-4648.90137, 872.584595, -1746.45312, -0.90445441, 9.77905472e-08, -0.426570296, 7.01226028e-08, 1, 8.05678582e-08, 0.426570296, 4.29577369e-08, -0.90445441),
    Event = MapFolder:WaitForChild('SkyArea1'):WaitForChild('PathwayTemple'):WaitForChild('Entrance'),
    EventType = 1,
    SubConfig = {
      Position = Vector3.new(-7885, 5636, -1401),
      Radius = 3400
    }
  }
}

task.spawn(function()
  while true do
    local IsInArea = false
    local CurrentAreaId = 0
    if HRP and HRP.Parent then
      local playerPos = HRP.Position
      for id, AreaData in pairs(SpecialQuest) do
        if not AreaData.SubConfig then  end

        local distMap = (playerPos - AreaData.SubConfig.Position).Magnitude
        if distMap <= AreaData.SubConfig.Radius then
          IsInArea = true
          CurrentAreaId = id + 0.5
          break
        end

        local tpPos = typeof(AreaData.TpPos) == 'CFrame' and AreaData.TpPos.Position or AreaData.TpPos
        if tpPos and (playerPos - tpPos).Magnitude <= 50 then
          IsInArea = true
          CurrentAreaId = id
          break
        end
      end
    end
    getgenv().InSpecialArea = IsInArea
    getgenv().AreaId = CurrentAreaId
    task.wait(0.1)
  end
end)

function GetNearestMon(MonName)
  local MinDist = math.huge
  local Nearest = nil
  for _, Mon in pairs(EnemieFolder:GetChildren()) do
    if Mon.Name == MonName then
      if Mon:IsA('Model') then
        if Mon:FindFirstChild('Humanoid') and Mon.Humanoid.Health > 0 then
          if Mon:FindFirstChild('HumanoidRootPart') then
            if (Mon.HumanoidRootPart.Position - HRP.Position).Magnitude < MinDist then
              MinDist = (Mon.HumanoidRootPart.Position - HRP.Position).Magnitude
              Nearest = Mon
            end
          end
        end
      end
    end
  end
  
  return Nearest
end

function InQuest()
  if QuestGui.Visible == true then
    return true
  else
    return false
  end
  return false
end

function StartQuest(QuestName, QuestLevel)
  CommF_:InvokeServer('StartQuest', QuestName, QuestLevel)
end

function BringMon(Mon)
  if not Mon or not Mon:IsA('Model') then return end
  local BaseHumanoid = Mon:FindFirstChild('Humanoid')
  local BaseRootPart = Mon:FindFirstChild('HumanoidRootPart')
  
  if not BaseHumanoid or BaseHumanoid.Health <= 0 then return end
  if not BaseRootPart then return end
  
  pcall(sethiddenproperty, LP, 'SimulationRadius', 1250)
  local BringPosition = BaseRootPart.Position
  local MonName = Mon.Name
  for _, Enemy in pairs(EnemieFolder:GetChildren()) do
    if not Enemy:IsA('Model') then  end
    local EHumanoid = Enemy:FindFirstChild('Humanoid')
    local ERootPart = Enemy:FindFirstChild('HumanoidRootPart')
    if EHumanoid and EHumanoid.Health > 0 and ERootPart then
      if Enemy.Name == MonName then
        if (BringPosition - ERootPart.Position).Magnitude <= 350 then
          if not ERootPart:FindFirstChild('BringVel') then
            new('BodyVelocity', {
              Name = 'BringVel',
              Velocity = Vector3.zero,
              MaxForce = Vector3.one * math.huge,
              Parent = ERootPart
            })
          end
          ERootPart.Size = Vector3.one * 50
          ERootPart.CFrame = BaseRootPart.CFrame
          ERootPart.CanCollide = false
        end
      end
    end
  end
end

function HaveTool(ToolName)
  local HaveTool = 'No'
  if Backpack:FindFirstChild(ToolName) then
    if Backpack[ToolName]:IsA('Tool') then
      if Backpack[ToolName].Name == ToolName then
        HaveTool = 'Yes, un'
      end
    end
  end
  
  if Char:FindFirstChild(ToolName) and Char[ToolName]:IsA('Tool') then
    HaveTool = 'Yes, eq'
  end
  return HaveTool
end

function EquipTool(Instance)
  Humanoid:EquipTool(Instance)
end

local HasSea2Badge = false
if BadgeService:UserHasBadgeAsync(UserId, 2125253106) then
  HasSea2Badge = true
end

getgenv().Auto_farm_level = false
MainTab:AddToggle({
  Title = 'Auto farm level',
  Default = false,
  Flag = 'Auto_farm_level',
  Callback = function(V)
    getgenv().Auto_farm_level = V
    if V then
      task.spawn(function()
        while getgenv().Auto_farm_level do
          if not getgenv().Auto_farm_level then break end
          SetNoclip(false)
          if not HRP:FindFirstChild('Stab') then
            new('BodyVelocity', {
              Name = 'Stab',
              Velocity = Vector3.zero,
              MaxForce = Vector3.one * math.huge,
              Parent = HRP
            })
          end
          
          local MyQuest = ListModule:Check()
          if not MyQuest then task.wait(0.1) continue end
          local SpecialId = MyQuest.SpecialId or 0
          local MonName = MyQuest.MonName
          
          local QName = MyQuest.QName
          local QLevel = MyQuest.QLevel
          local QTitle = MyQuest.QTitle
          
          local QPos = MyQuest.QPos
          local CPos = MyQuest.CPos
          if SpecialId ~= 0 and SpecialQuest[SpecialId] then
            local AreaData = SpecialQuest[SpecialId]
            local entranceCFrame = (AreaData.Event.CFrame or CFrame.new(AreaData.TpPos))
            local targetId = SpecialId + 0.5
            local entranceId = SpecialId
            
            repeat
              if not getgenv().Auto_farm_level then break end
              local currentId = getgenv().AreaId or 0
              
              if currentId == 0 then
                if not TweenModule:GetActiveTween() then
                  TweenModule:TweenTo({
                    CFrame = entranceCFrame,
                    Speed = getgenv().Tween_speed
                  })
                end
              elseif currentId == entranceId then
                if (entranceCFrame.Position - HRP.Position).Magnitude <= 40 then
                  if AreaData.EventType == 1 and AreaData.Event then
                    pcall(function()
                      firetouchinterest(AreaData.Event, HRP, 0)
                      task.wait(0.08)
                      firetouchinterest(AreaData.Event, HRP, 1)
                    end)
                  elseif AreaData.EventType == 2 and AreaData.Event then
                    pcall(function()
                      fireproximityprompt(AreaData.Event, 1)
                    end)
                  elseif AreaData.EventType == 3 then
                    pcall(function()
                      local pos = typeof(AreaData.TpPos) == 'CFrame' and AreaData.TpPos.Position or AreaData.TpPos
                      CommF_:InvokeServer('requestEntrance', pos)
                    end)
                  end
                else
                  if not TweenModule:GetActiveTween() then
                    TweenModule:TweenTo({
                      CFrame = entranceCFrame,
                      Speed = getgenv().Tween_speed
                    })
                  end
                end
              end
              task.wait(0.15)
            until getgenv().AreaId == targetId and getgenv().InSpecialArea == true
          end
          
          if not getgenv().Auto_farm_level then break end
          if InQuest() then
            if QuestTitle.Text:find(QTitle) then
              local Mon = GetNearestMon(MonName)
              if Mon then
                if Mon:FindFirstChild('HumanoidRootPart') then
                  local MonRotationX, MonRotationY, MonRotationZ = Mon:FindFirstChild('HumanoidRootPart').CFrame:ToOrientation()
                  TweenModule:TweenTo({
                    CFrame = CFrame.new(Mon:FindFirstChild('HumanoidRootPart').CFrame.Position.X, Mon:FindFirstChild('HumanoidRootPart').CFrame.Position.Y, Mon:FindFirstChild('HumanoidRootPart').CFrame.Position.Z) * CFrame.Angles(0, MonRotationY, 0) + Vector3.new(0, getgenv().Farm_distance, 0),
                    Speed = getgenv().Tween_speed
                  })
                  if Mon and Mon:FindFirstChild('HumanoidRootPart') and getgenv().Bring_mobs then
                    BringMon(Mon)
                  end
                  local MonHRP = Mon:FindFirstChild('HumanoidRootPart')
                  if (MonHRP.Position - HRP.Position).Magnitude <= getgenv().Bring_mobs_dist then
                    if ItemList.Type_selected then
                      for Name, Value in pairs(ItemList[ItemList.Type_selected]) do
                        if HaveTool(Value) == 'Yes, un' then
                          EquipTool(Backpack[Value])
                        elseif HaveTool(Value) == 'Yes, eq' then
                          local Tool = Char[Value]
                          if MonHRP then
                            if getgenv().Auto_attack then
                              local Token = GeneralModule:GetToken()
                              
                              RE_RegisterAttack:FireServer()
                              RE_RegisterHit:FireServer(MonHRP, {Mon, MonHRP}, nil, nil, Token)
                              Tool:Activate()
                            end
                          end
                        end
                      end
                    end
                  end
                else
                  TweenModule:TweenTo({
                    CFrame = CPos,
                    Speed = getgenv().Tween_speed
                  })
                end
              else
                TweenModule:TweenTo({
                  CFrame = CPos,
                  Speed = getgenv().Tween_speed
                })
              end
            else
              if (QPos.Position - HRP.Position).Magnitude <= 10 then
                StartQuest(QName, QLevel)
              end
              TweenModule:TweenTo({
                CFrame = QPos,
                Speed = getgenv().Tween_speed
              })
            end
          else
            if (QPos.Position - HRP.Position).Magnitude <= 10 then
              StartQuest(QName, QLevel)
            end
            TweenModule:TweenTo({
              CFrame = QPos,
              Speed = getgenv().Tween_speed
            })
          end
          task.wait()
        end
      end)
    else
      if TweenModule:GetActiveTween() then
        TweenModule:CancelTween()
        if HRP:FindFirstChild('Stab') then HRP.Stab:Destroy() end
      end
      if HRP:FindFirstChild('Stab') then HRP.Stab:Destroy() end
      SetNoclip(true)
    end
  end
})

local ShopTab = Window:MakeTab({
  Title = 'Shop',
  Icon = 'shoppingcart'
})
ShopTab:AddSection('Ability Teacher')

ShopTab:AddButton({
  Title = 'Buy Geppo',
  Description = 'Cost: 10.000K',
  Debounce = 0.5,
  Callback = function()
    if MyBeli.Value >= 10000 then
      CommF_:InvokeServer('BuyHaki', 'Geppo')
    else
      Window:Notify({
        Title = 'Info',
        Content = "You don't have enough money.",
        Duration = 3.5
      })
    end
  end
})

ShopTab:AddButton({
  Title = 'Buy Buso',
  Description = 'Cost: 25.000K',
  Debounce = 0.5,
  Callback = function()
    if MyBeli.Value >= 25000 then
      CommF_:InvokeServer('BuyHaki', 'Buso')
    else
      Window:Notify({
        Title = 'Info',
        Content = "You don't have enough money.",
        Duration = 3.5
      })
    end
  end
})

ShopTab:AddButton({
  Title = 'Buy Soru',
  Description = 'Cost: 100.000K',
  Debounce = 0.5,
  Callback = function()
    if MyBeli.Value >= 100000 then
      CommF_:InvokeServer('BuyHaki', 'Soru')
    else
      Window:Notify({
        Title = 'Info',
        Content = "You don't have enough money.",
        Duration = 3.5
      })
    end
  end
})
ShopTab:AddSection('Sword Dealer')

ShopTab:AddButton({
  Title = 'Buy Katana',
  Description = 'Cost: 1.000K',
  Debounce = 0.5,
  Callback = function()
    if MyBeli.Value >= 1000 then
      CommF_:InvokeServer('BuyItem', 'Katana')
    else
      Window:Notify({
        Title = 'Info',
        Content = "You don't have enough money.",
        Duration = 3.5
      })
    end
  end
})

ShopTab:AddButton({
  Title = 'Buy Cutlass',
  Description = 'Cost: 1.000K',
  Debounce = 0.5,
  Callback = function()
    if MyBeli.Value >= 1000 then
      CommF_:InvokeServer('BuyItem', 'Cutlass')
    else
      Window:Notify({
        Title = 'Info',
        Content = "You don't have enough money.",
        Duration = 3.5
      })
    end
  end
})

local TeleportTab = Window:MakeTab({
  Title = 'Teleport',
  Icon = 'Map'
})
TeleportTab:AddSection('Teleport (Map)')

local TeleportTarget = 'Pirate Starter'
TeleportTab:AddDropdown({
  Title = 'Teleport position',
  MultiSelect = false,
  Options = {
    'Fountain City',
    'Prison',
    'Frozen Village',
    'Jungle (Part 1)',
    'Jungle (Part 2)',
    'Pirate Starter',
    'Marine Starter',
    'Middle Town'
  },
  Default = 'Pirate Starter',
  Flag = 'TeleportTarget',
  Callback = function(V)
    TeleportTarget = V
  end
})

TeleportTab:AddButton({
  Title = 'Teleport to position',
  Debounce = 0.5,
  Callback = function()
    if TeleportTarget == 'Fountain City' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(5208, 39, 4072),
        Speed = getgenv().Tween_speed
      })
    elseif TeleportTarget == 'Prison' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(4876, 65, 735),
        Speed = getgenv().Tween_speed
      })
    elseif TeleportTarget == 'Frozen Village' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(1282, 87, -1258),
        Speed = getgenv().Tween_speed
      })
    elseif TeleportTarget == 'Jungle (Part 1)' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(-1446, 48, 54),
        Speed = getgenv().Tween_speed
      })
    elseif TeleportTarget == 'Jungle (Part 2)' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(-1181, 13, -317),
        Speed = getgenv().Tween_speed
      })
    elseif TeleportTarget == 'Pirate Starter' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(887, 20, 1488),
        Speed = getgenv().Tween_speed
      })
    elseif TeleportTarget == 'Marine Starter' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(-2635, 24, 2099),
        Speed = getgenv().Tween_speed
      })
    elseif TeleportTarget == 'Middle Town' then
      SetNoclip(false)
      TweenModule:TweenTo({
        CFrame = CFrame.new(-808, 59, 1576),
        Speed = getgenv().Tween_speed
      })
    end
  end
})

TeleportTab:AddButton({
  Title = 'Cancel any tween',
  Debounce = 0.5,
  Callback = function()
    if TweenModule:GetActiveTween() then
      TweenModule:CancelTween()
      if HRP:FindFirstChild('Stab') then HRP.Stab:Destroy() end
    end
    if HRP:FindFirstChild('Stab') then HRP.Stab:Destroy() end
    SetNoclip(true)
  end
})
TeleportTab:AddSection('Teleport (Sea)')

local UpdateLabel1
if MyLevel.Value < 700 then
  UpdateLabel1 = TeleportTab:AddParagraph('Please level >= 700', '')
end

TeleportTab:AddButton({
  Title = 'Teleport to sea 1',
  Debounce = 0.5,
  Callback = function()
    CommF_:InvokeServer('TravelMain')
  end
})

if MyLevel.Value >= 700 then
  if HasSea2Badge then
    TeleportTab:AddButton({
      Title = 'Teleport to sea 2',
      Debounce = 0.5,
      Callback = function()
        CommF_:InvokeServer('TravelDressrosa')
      end
    })
    
    if MyLevel.Value >= 1500 then
      TeleportTab:AddButton({
        Title = 'Teleport to sea 3 (No func)',
        Debounce = 0.5,
        Callback = function()
          
        end
      })
    end
  else
    getgenv().Auto_unlock_sea_2 = false
    TeleportTab:AddToggle({
      Title = 'Auto unlock sea 2',
      Description = 'Only if you do not have sea 2 and min level: 700',
      Default = false,
      Flag = 'Auto_unlock_sea_2',
      Callback = function(V)
        getgenv().Auto_unlock_sea_2 = V
        if V then
          SetNoclip(false)
          while getgenv().Auto_unlock_sea_2 do
            if not HRP:FindFirstChild('Stab') then
              new('BodyVelocity', {
                Name = 'Stab',
                Velocity = Vector3.zero,
                MaxForce = Vector3.one * math.huge,
                Parent = HRP
              })
            end
            
            if Humanoid.Health > 0 then
              if HaveTool('Key') == 'Yes, un' then
                EquipTool(Backpack['Key'])
              elseif HaveTool('Key') == 'Yes, eq' then
                TweenModule:TweenTo({
                  CFrame = CFrame.new(1348.4552, 37.3910789, -1325.38257),
                  Speed = getgenv().Tween_speed
                })
              elseif HaveTool('Key') == 'No' then
                if MapFolder:FindFirstChild('Ice'):FindFirstChild('Door').CanCollide == true and MapFolder:FindFirstChild('Ice'):FindFirstChild('Door').Transparency == 0 then
                  if (Vector3.new(4849.2583, 5.69297218, 717.992859) - HRP.Position).Magnitude <= 15 then
                    CommF_:InvokeServer('DressrosaQuestProgress', 'Detective')
                  else
                    TweenModule:TweenTo({
                      CFrame = CFrame.new(4849.2583, 5.69297218, 717.992859),
                      Speed = getgenv().Tween_speed
                    })
                  end
                elseif MapFolder:FindFirstChild('Ice'):FindFirstChild('Door').CanCollide == false and MapFolder:FindFirstChild('Ice'):FindFirstChild('Door').Transparency == 1 then
                  if EnemieFolder:FindFirstChild('Ice Admiral') then
                    local Mon = EnemieFolder:FindFirstChild('Ice Admiral')
                    if Mon:FindFirstChild('HumanoidRootPart') then
                      local MonHRP = Mon:FindFirstChild('HumanoidRootPart')
                      local MonRotationX, MonRotationY, MonRotationZ = MonHRP.CFrame:ToOrientation()
                      TweenModule:TweenTo({
                        CFrame = CFrame.new(MonHRP.CFrame.Position.X, MonHRP.CFrame.Position.Y, MonHRP.CFrame.Position.Z) * CFrame.Angles(0, MonRotationY, 0) + Vector3.new(0, getgenv().Farm_distance, 0),
                        Speed = getgenv().Tween_speed
                      })
                      
                      if (MonHRP.Position - HRP.Position).Magnitude <= getgenv().Bring_mobs_dist then
                        if ItemList.Type_selected then
                          for Name, Value in pairs(ItemList[ItemList.Type_selected]) do
                            if HaveTool(Value) == 'Yes, un' then
                              EquipTool(Backpack[Value])
                            elseif HaveTool(Value) == 'Yes, eq' then
                              local Tool = Char[Value]
                              if MonHRP then
                                if getgenv().Auto_attack then
                                  local Token = GeneralModule:GetToken()
                                  
                                  RE_RegisterAttack:FireServer()
                                  RE_RegisterHit:FireServer(MonHRP, {Mon, MonHRP}, nil, nil, Token)
                                  Tool:Activate()
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  else
                    TweenModule:TweenTo({
                      CFrame = CFrame.new(1298.56531, 29.6214142, -1337.3407, 0.883535564, 7.3295908e-08, 0.46836406, -5.97956031e-08, 1, -4.36932908e-08, -0.46836406, 1.05984652e-08, 0.883535564),
                      Speed = getgenv().Tween_speed
                    })
                  end
                end
              end
            end
            task.wait()
          end
        else
          if TweenModule:GetActiveTween() then
            TweenModule:CancelTween()
            if HRP:FindFirstChild('Stab') then HRP.Stab:Destroy() end
          end
          if HRP:FindFirstChild('Stab') then HRP.Stab:Destroy() end
          SetNoclip(true)
        end
      end
    })
  end
end

task.spawn(function()
  if MyLevel.Value < 700 then
    while true do
      if MyLevel.Value >= 700 then
        if UpdateLabel1 then
          Window:Destroy(UpdateLabel1)
        end
        return
      end
      task.wait(1)
    end
  elseif MyLevel.Value >= 1500 then
    if UpdateLabel1 then
      Window:Destroy(UpdateLabel1)
    end
    return
  end
end)

local StatsTab = Window:MakeTab({
  Title = 'Stats',
  Icon = 'banana'
})
StatsTab:AddSection('Stats settings')

local StatConfig = {
  AddPointNum = 1,
  ['Melee'] = false,
  ['Defense'] = false,
  ['Gun'] = false,
  ['Sword'] = false,
  ['Demon Fruit'] = false
}

StatsTab:AddSlider({
  Title = 'Point number',
  Min = 1,
  Max = 100,
  Increment = 1,
  Default = 1,
  Flag = 'AddPointNum',
  Callback = function(V)
    StatConfig.AddPointNum = V
  end
})

local Auto_add_points = false
StatsTab:AddToggle({
  Title = 'Auto add points',
  Default = false,
  Flag = 'Auto_add_points',
  Callback = function(V)
    Auto_add_points = V
    while Auto_add_points do
      if not Auto_add_points then
        break
      end
      
      for Name, Value in pairs(StatConfig) do
        if Name ~= 'AddPointNum' then
          if Value == true then
            if MyPoints.Value >= 1 then
              CommF_:InvokeServer('AddPoint', Name, StatConfig.AddPointNum)
            end
          end
        end
      end
      task.wait(0.25)
    end
  end
})
StatsTab:AddSection('Point')

StatsTab:AddToggle({
  Title = 'Melee',
  Default = true,
  Flag = 'Melee_point',
  Callback = function(V)
    StatConfig['Melee'] = V
  end
})

StatsTab:AddToggle({
  Title = 'Defense',
  Default = false,
  Flag = 'Defense_point',
  Callback = function(V)
    StatConfig['Defense'] = V
  end
})

StatsTab:AddToggle({
  Title = 'Gun',
  Default = false,
  Flag = 'Gun_point',
  Callback = function(V)
    StatConfig['Gun'] = V
  end
})

StatsTab:AddToggle({
  Title = 'Sword',
  Default = false,
  Flag = 'Sword_point',
  Callback = function(V)
    StatConfig['Sword'] = V
  end
})

StatsTab:AddToggle({
  Title = 'Demon fruit',
  Default = false,
  Flag = 'Demon_fruit_point',
  Callback = function(V)
    StatConfig['Demon Fruit'] = V
  end
})

local SettingsTab = Window:MakeTab({
  Title = 'Settings',
  Icon = 'Settings'
})
SettingsTab:AddSection('Settings')

SettingsTab:AddSlider({
  Title = 'Farm distance',
  Min = 5,
  Max = 25,
  Increment = 1,
  Default = 17,
  Flag = 'Farm_distance',
  Callback = function(V)
    getgenv().Farm_distance = V
  end
})

SettingsTab:AddSlider({
  Title = 'Tween speed',
  Min = 50,
  Max = 300,
  Increment = 1,
  Default = 250,
  Flag = 'Tween_speed',
  Callback = function(V)
    getgenv().Tween_speed = V
  end
})

SettingsTab:AddSlider({
  Title = 'Bring & attack distance',
  Min = 25,
  Max = 500,
  Increment = 1,
  Default = 350,
  Flag = 'Bring_mobs_dist',
  Callback = function(V)
    getgenv().Bring_mobs_dist = V
  end
})

SettingsTab:AddToggle({
  Title = 'Bring mobs',
  Default = true,
  Flag = 'Bring_mobs',
  Callback = function(V)
    getgenv().Bring_mobs = V
  end
})

SettingsTab:AddToggle({
  Title = 'Auto attack',
  Description = 'Only in-loop',
  Default = true,
  Flag = 'Auto_attack',
  Callback = function(V)
    getgenv().Auto_attack = V
  end
})
SettingsTab:AddSection('Team')

SettingsTab:AddButton({
  Title = 'Switch to team Pirates',
  Debounce = 0.5,
  Callback = function()
    CommF_:InvokeServer('SetTeam2', 'Pirates')
  end
})

SettingsTab:AddButton({
  Title = 'Switch to team Marines',
  Debounce = 0.5,
  Callback = function()
    CommF_:InvokeServer('SetTeam2', 'Marines')
  end
})

Window:Notify({
  Title = 'Info',
  Content = 'Hub loaded!',
  Duration = 4,
  Image = 'rbxassetid://127887124660168'
})
