local Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/tlredz/Library/refs/heads/main/redz-V5-remake/main.luau"))()

local Window = Lib:MakeWindow({
  Title = "Zynkore hub : Flee The Facility",
  SubTitle = "By Zynkore",
  ScriptFolder = "ZynkoreHub-Settings-FTF"
})

function serv(S)
  return game:GetService(S) or {}
end

local plr = serv('Players')
local RS = serv('RunService')
local WS = serv('Workspace')
local RST = serv('ReplicatedStorage')
local TS = serv('TweenService')
local HS = serv('HttpService')
local SS = serv('SoundService')
local CP = serv('ContentProvider')

local LP = plr.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild('HumanoidRootPart')
local FHRP = Char:FindFirstChild('HumanoidRootPart')

local CurrentTS = nil
local NoclipParts = {}
local FarmBV = nil

function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end

function SetupNoclip(character)
  for _, item in ipairs(NoclipParts) do
    if item.Part and item.Part.Parent then
      item.Part.CanCollide = item.Old
    end
  end
  NoclipParts = {}
  for _, p in ipairs(character:GetDescendants()) do
    if p:IsA("BasePart") then
      table.insert(NoclipParts, {Part = p, Old = p.CanCollide})
      p.CanCollide = false
    end
  end
end

function ApplyFarmBV()
  if HRP and not FarmBV then
    FarmBV = new("BodyVelocity", {
      MaxForce = Vector3.new(400000, 400000, 400000),
      Velocity = Vector3.new(0, 0, 0),
      Parent = HRP
    })
  elseif HRP and FarmBV then
    FarmBV.Parent = HRP
  end
end

function RemoveFarmBV()
  if FarmBV then
    FarmBV:Destroy()
    FarmBV = nil
  end
end

LP.CharacterAdded:Connect(function(char)
  Char = char
  HRP = char:WaitForChild('HumanoidRootPart')
  if AutoFarmS then
    SetupNoclip(char)
    ApplyFarmBV()
    if torsoConn then
      torsoConn:Disconnect()
      torsoConn = nil
    end
    torsoConn = RS.Heartbeat:Connect(function()
      if char and char:FindFirstChild("Torso") then
        char.Torso.CanCollide = false
      end
    end)
  end
end)

local InfoTab = Window:MakeTab({
  Title = 'Info',
  Icon = 'User'
})
InfoTab:AddSection('Hub')

InfoTab:AddParagraph(
  'Info',
  [[ [+] - Added
    [-] - Removed
    [!] - Fixed
    [÷] - Bug/Detected
    [?] - No update
  ]]
)

InfoTab:AddParagraph(
  'Update:',
  [[
      { Mini Update }
    [+] New library
  ]]
)

local MainTab = Window:MakeTab({
  Title = 'Main',
  Icon = 'Home'
})
MainTab:AddSection('Farm')

local AutoFarmS = false
local torsoConn = nil
MainTab:AddToggle({
  Title = "Auto farm all pc",
  Description = "Survivor only",
  Default = false,
  Flag = "Auto-farm-all-pc",
  Callback = function(V)
    AutoFarmS = V
    if V then
      if torsoConn then
        torsoConn:Disconnect()
        torsoConn = nil
      end
      torsoConn = RS.Heartbeat:Connect(function()
        if Char and Char:FindFirstChild("Torso") then
          Char.Torso.CanCollide = false
        end
      end)
      local fugaAtiva = false
      local ExitReached = false
      local LastExitTarget = nil
      local CachedComputers = {}
      local CachedExits = {}
      local CacheTick = 0
      task.spawn(function()
        while AutoFarmS do
          task.wait(0.3)
          if not AutoFarmS then break end
          local function IsInGame()
            local stats = LP:FindFirstChild("TempPlayerStatsModule")
            if stats and stats:FindFirstChild("IsBeast") and stats.IsBeast.Value == true then
              return true
            end
            local screenGui = LP:FindFirstChild("PlayerGui")
            if not screenGui then return false end
            local screen = screenGui:FindFirstChild("ScreenGui")
            if not screen then return false end
            local statusBars = screen:FindFirstChild("StatusBars")
            if not statusBars then return false end
            local healthBars = {"HealthBarA", "HealthBarB", "HealthBarC", "HealthBarD"}
            for _, barName in ipairs(healthBars) do
              local bar = statusBars:FindFirstChild(barName)
              if bar and bar:IsA("TextLabel") and bar.Text == LP.Name then
                if bar.TextColor3 == Color3.new(0, 0, 0) and bar.TextStrokeColor3 == Color3.new(0, 0, 0) and bar.BorderColor3 == Color3.new(0, 0, 0) and bar.BackgroundColor3 == Color3.new(0, 0, 0) then
                  return false
                end
                return true
              end
            end
            return false
          end
          local inGame = IsInGame()
          if not inGame then
            task.wait(1)
            continue
          end
          if not Char or not Char.Parent then
            Char = LP.Character
            if Char then
              HRP = Char:WaitForChild('HumanoidRootPart')
            end
          end
          if not Char or not HRP or not HRP.Parent then
            task.wait(0.5)
            continue
          end
          local hum = Char:FindFirstChild("Humanoid")
          if not hum or hum.Health <= 0 then
            task.wait(0.5)
            continue
          end
          if Char:FindFirstChild("Hammer") then
            task.wait(0.5)
            continue
          end
          local stats = LP:FindFirstChild("TempPlayerStatsModule")
          if not stats then
            task.wait(0.5)
            continue
          end
          if stats:FindFirstChild("IsBeast") and stats.IsBeast.Value == true then
            AutoFarmS = false
            if CurrentTS then CurrentTS:Cancel() end
            CurrentTS = nil
            RemoveFarmBV()
            if torsoConn then
              torsoConn:Disconnect()
              torsoConn = nil
            end
            for _, item in ipairs(NoclipParts) do
              if item.Part and item.Part.Parent then
                item.Part.CanCollide = item.Old
              end
            end
            NoclipParts = {}
            break
          end
          if stats:FindFirstChild("Captured") and stats.Captured.Value == true then
            if CurrentTS then CurrentTS:Cancel() end
            CurrentTS = nil
            ExitReached = false
            LastExitTarget = nil
            task.wait(2)
            continue
          end
          if stats:FindFirstChild("Escaped") and stats.Escaped.Value == true then
            if CurrentTS then CurrentTS:Cancel() end
            CurrentTS = nil
            ExitReached = false
            LastExitTarget = nil
            task.wait(2)
            continue
          end
          if stats:FindFirstChild("Ragdoll") and stats.Ragdoll.Value == true then
            if CurrentTS then CurrentTS:Cancel() end
            CurrentTS = nil
            fugaAtiva = false
            ExitReached = false
            LastExitTarget = nil
            task.wait(0.5)
            continue
          end
          if stats:FindFirstChild("CurrentAnimation") and stats.CurrentAnimation.Value == "Typing" then
            task.wait(0.3)
            continue
          end
          if not FarmBV then
            SetupNoclip(Char)
            ApplyFarmBV()
          end
          local beastNearMe = false
          local beastHRP = nil
          local allPlayers = plr:GetPlayers()
          for _, p in ipairs(allPlayers) do
            if p ~= LP and p.Character then
              if p.Character:FindFirstChild("Hammer") then
                local th = p.Character:FindFirstChild("HumanoidRootPart")
                if th and (th.Position - HRP.Position).Magnitude <= 25 then
                  beastNearMe = true
                  beastHRP = th
                  break
                end
              end
            end
          end
          if beastNearMe and beastHRP then
            fugaAtiva = true
            ExitReached = false
            LastExitTarget = nil
            if CurrentTS then CurrentTS:Cancel() end
            CurrentTS = nil
            local targetY = beastHRP.Position.Y + 25
            local d = math.abs(targetY - HRP.Position.Y) / 200
            CurrentTS = TS:Create(HRP, TweenInfo.new(d < 0.1 and 0.1 or d, Enum.EasingStyle.Linear), {CFrame = CFrame.new(HRP.Position.X, targetY, HRP.Position.Z)})
            CurrentTS:Play()
            local twDone = false
            local twCon = CurrentTS.Completed:Connect(function() twDone = true end)
            while not twDone and AutoFarmS and CurrentTS do task.wait() end
            twCon:Disconnect()
          elseif fugaAtiva then
            fugaAtiva = false
            if CurrentTS then CurrentTS:Cancel() end
            CurrentTS = nil
            task.wait(2)
          else
            local capturedPlayer = nil
            for _, p in ipairs(allPlayers) do
              if p ~= LP and p:FindFirstChild("TempPlayerStatsModule") then
                local pStats = p:FindFirstChild("TempPlayerStatsModule")
                if pStats and pStats:FindFirstChild("Captured") and pStats.Captured.Value == true then
                  if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    capturedPlayer = p
                    break
                  end
                end
              end
            end
            if AutoSavePlayer and capturedPlayer then
              ExitReached = false
              LastExitTarget = nil
              if CurrentTS then CurrentTS:Cancel() end
              CurrentTS = nil
              local targetPos = capturedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-2, -1, 0)
              HRP.CFrame = targetPos
              task.wait(0.1)
              continue
            end
            if capturedPlayer then
              ExitReached = false
              LastExitTarget = nil
              if CurrentTS then CurrentTS:Cancel() end
              CurrentTS = nil
              local targetPos = capturedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(-2, -1, 0)
              HRP.CFrame = targetPos
            else
              CacheTick = CacheTick + 1
              if CacheTick >= 10 or #CachedComputers == 0 then
                CachedComputers = {}
                CachedExits = {}
                for _, obj in ipairs(WS:GetDescendants()) do
                  if obj.Name == "ComputerTable" and obj:IsA("Model") then
                    table.insert(CachedComputers, obj)
                  elseif obj.Name == "ExitDoor" and obj:IsA("Model") then
                    local trigger = obj:FindFirstChild("ExitDoorTrigger")
                    if trigger and trigger:IsA("BasePart") then
                      table.insert(CachedExits, obj)
                    end
                  end
                end
                CacheTick = 0
              end
              local allDone = true
              for _, obj in ipairs(CachedComputers) do
                if obj.Parent then
                  local screen = obj:FindFirstChild("Screen") or obj:FindFirstChild("screen")
                  if not screen or screen.Color ~= Color3.fromRGB(40, 127, 71) then
                    allDone = false
                    break
                  end
                end
              end
              local exitTarget = nil
              local exitDist = math.huge
              for _, obj in ipairs(CachedExits) do
                if obj.Parent then
                  local trigger = obj:FindFirstChild("ExitDoorTrigger")
                  if trigger and trigger:IsA("BasePart") then
                    local dist = (HRP.Position - trigger.Position).Magnitude
                    if dist < exitDist then
                      exitDist = dist
                      exitTarget = trigger
                    end
                  end
                end
              end
              if not exitTarget then
                for _, obj in ipairs(CachedExits) do
                  if obj.Parent then
                    local area = obj:FindFirstChild("ExitArea")
                    if area and area:IsA("BasePart") then
                      local dist = (HRP.Position - area.Position).Magnitude
                      if dist < exitDist then
                        exitDist = dist
                        exitTarget = area
                      end
                    end
                  end
                end
              end
              if exitTarget and (allDone or LastExitTarget) then
                if LastExitTarget and LastExitTarget ~= exitTarget then
                  ExitReached = false
                end
                LastExitTarget = exitTarget
                if ExitReached and (HRP.Position - exitTarget.Position).Magnitude < 5 then
                  task.wait(1)
                  continue
                end
                if CurrentTS then CurrentTS:Cancel() end
                CurrentTS = nil
                local finalExitPos = exitTarget.Position
                local targetY = exitTarget.Position.Y + 25
                local d1 = math.abs(targetY - HRP.Position.Y) / 200
                CurrentTS = TS:Create(HRP, TweenInfo.new(d1 < 0.1 and 0.1 or d1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(HRP.Position.X, targetY, HRP.Position.Z)})
                CurrentTS:Play()
                local twDone1 = false
                local twCon1 = CurrentTS.Completed:Connect(function() twDone1 = true end)
                while not twDone1 and AutoFarmS and CurrentTS do task.wait() end
                twCon1:Disconnect()
                task.wait(2)
                if not AutoFarmS then break end
                local d2 = (Vector3.new(HRP.Position.X, targetY, HRP.Position.Z) - Vector3.new(finalExitPos.X, targetY, finalExitPos.Z)).Magnitude / 200
                CurrentTS = TS:Create(HRP, TweenInfo.new(d2 < 0.1 and 0.1 or d2, Enum.EasingStyle.Linear), {CFrame = CFrame.new(finalExitPos.X, targetY, finalExitPos.Z)})
                CurrentTS:Play()
                local twDone2 = false
                local twCon2 = CurrentTS.Completed:Connect(function() twDone2 = true end)
                while not twDone2 and AutoFarmS and CurrentTS do task.wait() end
                twCon2:Disconnect()
                task.wait(1)
                if not AutoFarmS then break end
                local d3 = math.abs(targetY - finalExitPos.Y) / 200
                CurrentTS = TS:Create(HRP, TweenInfo.new(d3 < 0.1 and 0.1 or d3, Enum.EasingStyle.Linear), {CFrame = CFrame.new(finalExitPos) * CFrame.new(0, 1.5, 0)})
                CurrentTS:Play()
                local twDone3 = false
                local twCon3 = CurrentTS.Completed:Connect(function() twDone3 = true end)
                while not twDone3 and AutoFarmS and CurrentTS do task.wait() end
                twCon3:Disconnect()
                if (HRP.Position - exitTarget.Position).Magnitude < 8 then
                  ExitReached = true
                end
              else
                ExitReached = false
                LastExitTarget = nil
                local nearest = nil
                local nearestDist = math.huge
                for _, obj in ipairs(CachedComputers) do
                  if obj.Parent then
                    local screen = obj:FindFirstChild("Screen") or obj:FindFirstChild("screen")
                    local isFull = screen and screen.Color == Color3.fromRGB(40, 127, 71)
                    if not isFull then
                      for i = 1, 3 do
                        local t = obj:FindFirstChild("ComputerTrigger" .. i)
                        if t then
                          local beastNear = false
                          for _, p in ipairs(allPlayers) do
                            if p ~= LP and p.Character then
                              if p.Character:FindFirstChild("Hammer") then
                                local th = p.Character:FindFirstChild("HumanoidRootPart")
                                if th and (th.Position - t.Position).Magnitude <= 25 then
                                  beastNear = true
                                  break
                                end
                              end
                            end
                          end
                          local playerOn = false
                          for _, p in ipairs(allPlayers) do
                            if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                              if (p.Character.HumanoidRootPart.Position - t.Position).Magnitude <= 3 then
                                playerOn = true
                                break
                              end
                            end
                          end
                          if not beastNear and not playerOn then
                            local dist = (HRP.Position - t.Position).Magnitude
                            if dist < nearestDist then
                              nearestDist = dist
                              nearest = {Table = obj, Trigger = t}
                            end
                          end
                        end
                      end
                    end
                  end
                end
                if nearest and nearest.Trigger and nearest.Trigger.Parent then
                  local tpos = nearest.Trigger.Position
                  local dist = (HRP.Position - tpos).Magnitude
                  local screen = nearest.Table:FindFirstChild("Screen") or nearest.Table:FindFirstChild("screen")
                  if not nearest.Table.Parent or (screen and screen.Color == Color3.fromRGB(40, 127, 71)) then
                    continue
                  end
                  if dist > 5 then
                    if CurrentTS then CurrentTS:Cancel() end
                    CurrentTS = nil
                    local targetY = tpos.Y + 25
                    local d1 = math.abs(targetY - HRP.Position.Y) / 200
                    CurrentTS = TS:Create(HRP, TweenInfo.new(d1 < 0.1 and 0.1 or d1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(HRP.Position.X, targetY, HRP.Position.Z)})
                    CurrentTS:Play()
                    local twDone1 = false
                    local twCon1 = CurrentTS.Completed:Connect(function() twDone1 = true end)
                    while not twDone1 and AutoFarmS and CurrentTS do task.wait() end
                    twCon1:Disconnect()
                    if not nearest.Table.Parent or not nearest.Trigger.Parent then
                      continue
                    end
                    task.wait(2)
                    if not AutoFarmS then break end
                    local currentTpos = nearest.Trigger and nearest.Trigger.Position or tpos
                    local d2 = (Vector3.new(HRP.Position.X, targetY, HRP.Position.Z) - Vector3.new(currentTpos.X, targetY, currentTpos.Z)).Magnitude / 25
                    CurrentTS = TS:Create(HRP, TweenInfo.new(d2 < 0.1 and 0.1 or d2, Enum.EasingStyle.Linear), {CFrame = CFrame.new(currentTpos.X, targetY, currentTpos.Z)})
                    CurrentTS:Play()
                    local twDone2 = false
                    local twCon2 = CurrentTS.Completed:Connect(function() twDone2 = true end)
                    while not twDone2 and AutoFarmS and CurrentTS do task.wait() end
                    twCon2:Disconnect()
                    if not nearest.Table.Parent or not nearest.Trigger.Parent then
                      continue
                    end
                    task.wait(1)
                    if not AutoFarmS then break end
                    local finalTpos = nearest.Trigger and nearest.Trigger.Position or currentTpos
                    local d3 = math.abs(targetY - finalTpos.Y) / 200
                    CurrentTS = TS:Create(HRP, TweenInfo.new(d3 < 0.1 and 0.1 or d3, Enum.EasingStyle.Linear), {CFrame = CFrame.new(finalTpos) * CFrame.new(0, 1.5, 0)})
                    CurrentTS:Play()
                    local twDone3 = false
                    local twCon3 = CurrentTS.Completed:Connect(function() twDone3 = true end)
                    while not twDone3 and AutoFarmS and CurrentTS do task.wait() end
                    twCon3:Disconnect()
                  end
                end
              end
            end
          end
        end
        if torsoConn then
          torsoConn:Disconnect()
          torsoConn = nil
        end
      end)
    else
      AutoFarmS = false
      if CurrentTS then CurrentTS:Cancel() end
      CurrentTS = nil
      RemoveFarmBV()
      if torsoConn then
        torsoConn:Disconnect()
        torsoConn = nil
      end
      for _, item in ipairs(NoclipParts) do
        if item.Part and item.Part.Parent then
          item.Part.CanCollide = item.Old
        end
      end
      NoclipParts = {}
      if Char and Char:FindFirstChild("Humanoid") then
        Char.Humanoid.PlatformStand = false
        Char.Humanoid.Sit = false
      end
    end
  end
})
MainTab:AddSection('Beast')

local Auto_Hit_nearest_plr
MainTab:AddToggle({
  Title = 'Auto hit nearest player',
  Description = 'Only beast | Distance: 10 studs',
  Default = false,
  Flag = 'Auto-Hit-Nearest-plr',
  Callback = function(V)
    if V then
      Auto_Hit_nearest_plr = RS.Heartbeat:Connect(function()
        for _, p in pairs(plr:GetPlayers()) do
          if p ~= LP then
            if p and p.Character then
              local PChar = p.Character
              if not PChar:FindFirstChild('Hammer') then
                if Char:FindFirstChild('Hammer') then
                  if (Char.HumanoidRootPart.Position - PChar.HumanoidRootPart.Position).Magnitude < 10 then
                    local args = {
                      "HammerHit",
                      PChar.HumanoidRootPart,
                    }
                    Char:FindFirstChild("Hammer"):FindFirstChild("HammerEvent"):FireServer(unpack(args))
                  end
                end
              end
            end
          end
        end
      end)
    else
      if Auto_Hit_nearest_plr then
        Auto_Hit_nearest_plr:Disconnect()
        Auto_Hit_nearest_plr = nil
      end
    end
  end
})

local Auto_Tie_nearest_plr
MainTab:AddToggle({
  Title = 'Auto tie up nearest player',
  Description = 'Only beast | Distance: 10 studs',
  Default = false,
  Flag = 'Auto-Tie-Up-Nearest',
  Callback = function(V)
    if V then
      Auto_Tie_nearest_plr = RS.Heartbeat:Connect(function()
        for _, p in pairs(plr:GetPlayers()) do
          if p ~= LP then
            if p and p.Character then
              local PChar = p.Character
              if not PChar:FindFirstChild('Hammer') then
                if Char:FindFirstChild('Hammer') then
                  if (Char.HumanoidRootPart.Position - PChar.HumanoidRootPart.Position).Magnitude < 10 then
                    local args = {
                      "HammerTieUp",
                      PChar.HumanoidRootPart,
                      PChar.HumanoidRootPart.Position
                    }
                    Char:FindFirstChild("Hammer"):FindFirstChild("HammerEvent"):FireServer(unpack(args))
                  end
                end
              end
            end
          end
        end
      end)
    else
      if Auto_Tie_nearest_plr then
        Auto_Tie_nearest_plr:Disconnect()
        Auto_Tie_nearest_plr = nil
      end
    end
  end
})

local anti_stun
MainTab:AddToggle({
  Title = 'Anti stun',
  Description = 'No stun ( Beast )',
  Default = false,
  Flag = 'Anti-Stun',
  Callback = function(V)
    if V then
      anti_stun = RS.Heartbeat:Connect(function()
        if Char then
          if Char:FindFirstChild('Humanoid') then
            if Char:FindFirstChild('Hammer') then
              if Char:WaitForChild('Humanoid').WalkSpeed <= 15 then
                Char:WaitForChild('Humanoid').WalkSpeed = 16
              end
            end
          end
        end
      end)
    else
      if anti_stun then
        anti_stun:Disconnect()
        anti_stun = nil
      end
    end
  end
})

MainTab:AddSection('Survivor')

local AutoSavePlayer = false
MainTab:AddToggle({
  Title = 'Auto save player',
  Description = 'Instantly teleport under captured players',
  Default = false,
  Flag = 'Auto-save-player',
  Callback = function(V)
    AutoSavePlayer = V
  end
})

local OriginalNamecall
local AntiHackActive = false

OriginalNamecall = hookmetamethod(game, "__namecall", function(Self, ...)
  if AntiHackActive then
    local Args = {...}
    local NamecallMethod = getnamecallmethod()
    if NamecallMethod == "FireServer" and Args[1] == "SetPlayerMinigameResult" then
      Args[2] = true
      return OriginalNamecall(Self, unpack(Args))
    end
  end
  return OriginalNamecall(Self, ...)
end)

MainTab:AddToggle({
  Title = "Anti hack fail",
  Default = false,
  Flag = "Anti-hack-fail",
  Callback = function(V)
    if game:GetService("RunService"):IsStudio() then
      return
    end
    AntiHackActive = V
  end
})

local Stun_Beast
MainTab:AddToggle({
  Title = 'Stun beast',
  Description = 'Ragebait beast',
  Default = false,
  Flag = 'Stun-Beast',
  Callback = function(V)
    if V then
      Stun_Beast = RS.Heartbeat:Connect(function()
        if Char then
          if not Char:FindFirstChild('Hammer') then
            for _, p in pairs(plr:GetPlayers()) do
              if p and p ~= LP then
                if p.Character then
                  local PChar = p.Character
                  if PChar:FindFirstChild('Hammer') then
                    local args = {
                      "Jumped"
                    }
                    PChar:FindFirstChild("BeastPowers"):FindFirstChild("PowersEvent"):FireServer(unpack(args))
                  end
                end
              end
            end
          end
        end
      end)
    else
      if Stun_Beast then
        Stun_Beast:Disconnect()
        Stun_Beast = nil
      end
    end
  end
})

MainTab:AddSection('Players')

local Auto_Delay = 0.05
local Auto_Last = 0

local Auto_Interact
MainTab:AddToggle({
  Title = 'Auto interact',
  Description = 'No desc',
  Default = false,
  Flag = 'Auto-interact',
  Callback = function(V)
    if V then
      Auto_Interact = RS.Heartbeat:Connect(function()
        if time() - Auto_Last < Auto_Delay then
          return
        end
        Auto_Last = time()
        local stats = LP:FindFirstChild("TempPlayerStatsModule")
        if not stats then
          return
        end
        if stats:FindFirstChild("ActionEvent") and stats.ActionEvent.Value ~= "Event" then
          local args = {
            "Input",
            "Action",
            true
          }
          game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
        end
      end)
    else
      if Auto_Interact then
        Auto_Interact:Disconnect()
        Auto_Interact = nil
      end
    end
  end
})

local EspTab = Window:MakeTab({
  Title = 'Esp',
  Icon = 'Eye'
})
EspTab:AddSection('Players')

local Esp_Beast
EspTab:AddToggle({
  Title = 'Beast',
  Description = 'Create an esp for the beast',
  Default = false,
  Flag = 'Esp-Beast',
  Callback = function(V)
    if V then
      Esp_Beast = RS.Heartbeat:Connect(function()
        for _, p in pairs(plr:GetPlayers()) do
          if p ~= LP then
            if p and p.Character then
              local PChar = p.Character
              if PChar:FindFirstChild('Hammer') and PChar.Hammer:IsA('Model') then
                if PChar:FindFirstChild('Esp_Survivor') then
                  PChar.Esp_Survivor:Destroy()
                end
                if not PChar:FindFirstChild('Esp_Beast') then
                  new('Highlight', {
                    Name = 'Esp_Beast',
                    FillColor = Color3.fromHex('#ff0303'),
                    FillTransparency = 0.6,
                    Parent = PChar
                  })
                end
              end
            end
          end
        end
      end)
    else
      if Esp_Beast then
        Esp_Beast:Disconnect()
        Esp_Beast = nil
      end
      for _, p in pairs(plr:GetPlayers()) do
        if p ~= LP then
          if p and p.Character then
            local PChar = p.Character
            if PChar:FindFirstChild('Hammer') and PChar.Hammer:IsA('Model') then
              if PChar:FindFirstChild('Esp_Beast') then
                PChar.Esp_Beast:Destroy()
              end
            end
          end
        end
      end
    end
  end
})

local Esp_Survivor
EspTab:AddToggle({
  Title = 'Survivor',
  Description = 'Create an esp for the survivor(s)',
  Default = false,
  Flag = 'Esp-Survivor',
  Callback = function(V)
    if V then
      Esp_Survivor = RS.Heartbeat:Connect(function()
        for _, p in pairs(plr:GetPlayers()) do
          if p ~= LP then
            if p and p.Character then
              local PChar = p.Character
              if not PChar:FindFirstChild('Hammer') then
                if PChar:FindFirstChild('Esp_Beast') then
                  PChar.Esp_Beast:Destroy()
                end
                if not PChar:FindFirstChild('Esp_Survivor') then
                  new('Highlight', {
                    Name = 'Esp_Survivor',
                    FillColor = Color3.fromHex('#14ff00'),
                    FillTransparency = 0.6,
                    Parent = PChar
                  })
                end
              end
            end
          end
        end
      end)
    else
      if Esp_Survivor then
        Esp_Survivor:Disconnect()
        Esp_Survivor = nil
      end
      for _, p in pairs(plr:GetPlayers()) do
        if p ~= LP then
          if p and p.Character then
            local PChar = p.Character
            if not PChar:FindFirstChild('Hammer') then
              if PChar:FindFirstChild('Esp_Survivor') then
                PChar.Esp_Survivor:Destroy()
              end
            end
          end
        end
      end
    end
  end
})

EspTab:AddSection('Map')

local Esp_Computer
EspTab:AddToggle({
  Title = 'Computer',
  Description = 'Create an esp for computer(s)',
  Default = false,
  Flag = 'Esp-Computer',
  Callback = function(V)
    if V then
      for _, obj in pairs(WS:GetDescendants()) do
        if obj.Name == 'ComputerTable' then
          if obj:IsA('Model') then
            if not obj:FindFirstChild('Esp_Computer') then
              task.spawn(function()
                local screen = obj:WaitForChild('Screen')
                local esp = new('Highlight', {
                  Name = 'Esp_Computer',
                  FillColor = screen.Color,
                  FillTransparency = 0.6,
                  Parent = obj
                })
                screen:GetPropertyChangedSignal('Color'):Connect(function()
                  esp.FillColor = screen.Color
                end)
              end)
            end
          end
        end
      end
      Esp_Computer = WS.DescendantAdded:Connect(function(obj)
        if obj.Name == 'ComputerTable' then
          if obj:IsA('Model') then
            if not obj:FindFirstChild('Esp_Computer') then
              task.spawn(function()
                local screen = obj:WaitForChild('Screen')
                local esp = new('Highlight', {
                  Name = 'Esp_Computer',
                  FillColor = screen.Color,
                  FillTransparency = 0.6,
                  Parent = obj
                })
                screen:GetPropertyChangedSignal('Color'):Connect(function()
                  esp.FillColor = screen.Color
                end)
              end)
            end
          end
        end
      end)
    else
      if Esp_Computer then
        Esp_Computer:Disconnect()
        Esp_Computer = nil
      end
      for _, obj in pairs(WS:GetDescendants()) do
        if obj.Name == 'ComputerTable' then
          if obj:IsA('Model') then
            if obj:FindFirstChild('Esp_Computer') then
              obj.Esp_Computer:Destroy()
            end
          end
        end
      end
    end
  end
})

local Esp_FreezePod
EspTab:AddToggle({
  Title = 'Freeze',
  Description = 'Create an esp for freeze(s)',
  Default = false,
  Flag = 'Esp-FreezePod',
  Callback = function(V)
    if V then
      for _, obj in pairs(WS:GetDescendants()) do
        if obj.Name == 'FreezePod' then
          if obj:IsA('Model') then
            if not obj:FindFirstChild('Esp_FreezePod') then
              new('Highlight', {
                Name = 'Esp_FreezePod',
                FillColor = Color3.fromHex('#2bb7fb'),
                FillTransparency = 0.6,
                Parent = obj
              })
            end
          end
        end
      end
      Esp_FreezePod = WS.DescendantAdded:Connect(function(obj)
        if obj.Name == 'FreezePod' then
          if obj:IsA('Model') then
            if not obj:FindFirstChild('Esp_FreezePod') then
              new('Highlight', {
                Name = 'Esp_FreezePod',
                FillColor = Color3.fromHex('#2bb7fb'),
                FillTransparency = 0.6,
                Parent = obj
              })
            end
          end
        end
      end)
    else
      if Esp_FreezePod then
        Esp_FreezePod:Disconnect()
        Esp_FreezePod = nil
      end
      for _, obj in pairs(WS:GetDescendants()) do
        if obj.Name == 'FreezePod' then
          if obj:IsA('Model') then
            if obj:FindFirstChild('Esp_FreezePod') then
              obj.Esp_FreezePod:Destroy()
            end
          end
        end
      end
    end
  end
})

local Esp_ExitDoor
EspTab:AddToggle({
  Title = 'Exit door',
  Description = 'Create an esp for ExitDoor(s)',
  Default = false,
  Flag = 'Esp-Exit-Door',
  Callback = function(V)
    if V then
      for _, obj in pairs(WS:GetChildren()) do
        if obj.Name == 'ExitDoor' then
          if obj:IsA('Model') then
            local ExitEsp = obj:FindFirstChild('Esp_ExitDoor')
            if not ExitEsp then
              local Esp = new('Highlight', {
                Name = 'Esp_ExitDoor',
                FillColor = obj:WaitForChild('Light').Color or Color3.fromHex('#f9ff00'),
                FillTransparency = 0.5,
                Adornee = obj,
                Parent = obj
              })
              obj:WaitForChild('Light'):GetPropertyChangedSignal('Color'):Connect(function()
                Esp.FillColor = obj:WaitForChild('Light').Color
              end)
            end
          end
        end
      end
      Esp_ExitDoor = WS.DescendantAdded:Connect(function(obj)
        if obj.Name == 'ExitDoor' then
          if obj:IsA('Model') then
            local ExitEsp = obj:FindFirstChild('Esp_ExitDoor')
            if not ExitEsp then
              local Esp = new('Highlight', {
                Name = 'Esp_ExitDoor',
                FillColor = obj:WaitForChild('Light').Color or Color3.fromHex('#f9ff00'),
                FillTransparency = 0.5,
                Adornee = obj,
                Parent = obj
              })
              obj:WaitForChild('Light'):GetPropertyChangedSignal('Color'):Connect(function()
                Esp.FillColor = obj:WaitForChild('Light').Color
              end)
            end
          end
        end
      end)
    else
      for _, obj in pairs(WS:GetChildren()) do
        if obj.Name == 'ExitDoor' then
          if obj:IsA('Model') then
            local ExitEsp = obj:FindFirstChild('Esp_ExitDoor')
            if ExitEsp then
              ExitEsp:Destroy()
            end
          end
        end
      end
      if Esp_ExitDoor then
        Esp_ExitDoor:Disconnect()
        Esp_ExitDoor = nil
      end
    end
  end
})

local MusicTab = Window:MakeTab({
  Title = 'Music',
  Icon = 'Sound'
})
MusicTab:AddSection('Music ( pre-set )')

local MusicId = nil
MusicTab:AddDropdown({
  Title = 'Select music',
  Options = {
    'Happy Song',
    'See You In Hell',
    'Speed Metal Overture',
    'Stadium Rave',
    'Relaxed Scene',
    'Tears Of Sorrow',
    'Tear It Up',
    'Prima Bossa Nova',
    'Gathers Under Night',
    'Raining Tacos'
  },
  Default = 'Happy Song',
  Flag = 'Selected-Music',
  Callback = function(V)
    if V == 'Happy Song' then
      MusicId = 1843404009
    elseif V == 'See You In Hell' then
      MusicId = 1837853076
    elseif V == 'Speed Metal Overture' then
      MusicId = 9042370693
    elseif V == 'Stadium Rave' then
      MusicId = 1846368080
    elseif V == 'Relaxed Scene' then
      MusicId = 1848354536
    elseif V == 'Tears Of Sorrow' then
      MusicId = 1843286166
    elseif V == 'Tear It Up' then
      MusicId = 1842763322
    elseif V == 'Prima Bossa Nova' then
      MusicId = 1837070127
    elseif V == 'Gathers Under Night' then
      MusicId = 9106232976
    elseif V == 'Raining Tacos' then
      MusicId = 142376088
    end
  end
})

local MusicVol = 0.3
MusicTab:AddSlider({
  Title = 'Music volume',
  Min = 0.1,
  Max = 10,
  Increase = 0.1,
  Default = 0.3,
  Flag = 'Music-Volume',
  Callback = function(V)
    MusicVol = V
    if IsSoundPlaying then
      IsSoundPlaying.Volume = V
    end
  end
})

local MusicF = new('Folder', {
  Name = 'RunningMusic',
  Parent = SS
})

local IsSoundPlaying = new('Sound', {
  Name = 'Music',
  SoundId = 'rbxassetid://0',
  Playing = false,
  Looped = true,
  Volume = MusicVol,
  Parent = MusicF
})

local MusicRunning = false
MusicTab:AddToggle({
  Title = 'Run music',
  Default = false,
  Flag = 'Run-Music',
  Callback = function(V)
    MusicRunning = V
    if V then
      if MusicId then
        IsSoundPlaying.SoundId = 'rbxassetid://' .. MusicId
        IsSoundPlaying.Volume = MusicVol
        CP:PreloadAsync({IsSoundPlaying}, function(id, status)
          if status == Enum.AssetFetchStatus.Success then
            if MusicRunning then
              IsSoundPlaying:Play()
            end
          end
        end)
      end
    else
      MusicRunning = false
      if IsSoundPlaying.Playing then
        IsSoundPlaying:Stop()
      end
    end
  end
})

local FakeTab = Window:MakeTab({
  Title = 'Fake'
})
FakeTab:AddSection('Local player')

FakeTab:AddButton({
  Title = 'Reset user name',
  Callback = function()
    LP:WaitForChild('PlayerGui'):WaitForChild('ScreenGui'):WaitForChild('PlayerNamesFrame'):WaitForChild(LP.Name .. 'PlayerFrame'):WaitForChild('NameLabel').Text = LP.Name
  end
})

local UserLevel = LP.SavedPlayerStatsModule.Level.Value
FakeTab:AddButton({
  Title = 'Reset user level',
  Callback = function()
    LP:WaitForChild('PlayerGui'):WaitForChild('ScreenGui'):WaitForChild('PlayerNamesFrame'):WaitForChild(LP.Name .. 'PlayerFrame'):WaitForChild('LevelLabel').Text = UserLevel or 1
  end
})

local UserName = LP.Name
FakeTab:AddTextBox({
  Name = "Fake user name",
  Default = LP.Name,
  Placeholder = "input name...",
  ClearOnFocus = true,
  Callback = function(V)
    UserName = V
  end
})
FakeTab:AddButton({
  Title = 'Set user name',
  Callback = function()
    LP:WaitForChild('PlayerGui'):WaitForChild('ScreenGui'):WaitForChild('PlayerNamesFrame'):WaitForChild(LP.Name .. 'PlayerFrame'):WaitForChild('NameLabel').Text = UserName or 'Hello'
  end
})

local UserLevel = LP:WaitForChild('PlayerGui'):WaitForChild('ScreenGui'):WaitForChild('PlayerNamesFrame'):WaitForChild(LP.Name .. 'PlayerFrame'):WaitForChild('LevelLabel').Text or 1
FakeTab:AddTextBox({
  Name = "Fake user level",
  Default = UserLevel,
  Placeholder = "input level...",
  ClearOnFocus = true,
  Callback = function(V)
    UserLevel = V
  end
})
FakeTab:AddButton({
  Title = 'Set user level',
  Callback = function()
    LP:WaitForChild('PlayerGui'):WaitForChild('ScreenGui'):WaitForChild('PlayerNamesFrame'):WaitForChild(LP.Name .. 'PlayerFrame'):WaitForChild('LevelLabel').Text = UserLevel or 'Hello'
  end
})

local ExtraTab = Window:MakeTab({
  Title = 'Extra',
  Icon = 'Settings'
})
ExtraTab:AddSection('Visual')

ExtraTab:AddButton({
  Title = 'Remove fog',
  Callback = function()
    game:GetService("Lighting").Atmosphere.Density = 0
  end
})

local NoFog
ExtraTab:AddToggle({
  Title = 'No fog',
  Default = false,
  Flag = 'No-fog',
  Callback = function(V)
    if V then
      game:GetService("Lighting").Atmosphere.Density = 0
      NoFog = game:GetService("Lighting").Atmosphere:GetPropertyChangedSignal('Density'):Connect(function()
        game:GetService("Lighting").Atmosphere.Density = 0
      end)
    else
      if NoFog then
        NoFog:Disconnect()
        NoFog = nil
      end
    end
  end
})
ExtraTab:AddSection('Game')

ExtraTab:AddButton({
  Title = 'fps boost',
  Callback = function()
    for _, obj in pairs(workspace:GetDescendants()) do
      if obj:IsA("BasePart") then
        obj.CastShadow = false
        obj.Material = Enum.Material.SmoothPlastic
        obj.Reflectance = 0
        obj.TopSurface = Enum.SurfaceType.Smooth
        obj.BottomSurface = Enum.SurfaceType.Smooth
        obj.LeftSurface = Enum.SurfaceType.Smooth
        obj.RightSurface = Enum.SurfaceType.Smooth
        obj.FrontSurface = Enum.SurfaceType.Smooth
        obj.BackSurface = Enum.SurfaceType.Smooth
        if obj:IsA("MeshPart") then
          obj.RenderFidelity = Enum.RenderFidelity.Performance
        end
        for _, child in ipairs(obj:GetChildren()) do
          if child:IsA("Decal") or child:IsA("Texture") then
            child:Destroy()
          end
        end
      end
    end
  end
})

local fps_boost
ExtraTab:AddToggle({
  Title = 'fps boost',
  Description = 'Anti lag ( Low texture )',
  Default = false,
  Flag = 'fps-boost',
  Callback = function(V)
    if V then
      for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
          obj.CastShadow = false
          obj.Material = Enum.Material.SmoothPlastic
          obj.Reflectance = 0
          obj.TopSurface = Enum.SurfaceType.Smooth
          obj.BottomSurface = Enum.SurfaceType.Smooth
          obj.LeftSurface = Enum.SurfaceType.Smooth
          obj.RightSurface = Enum.SurfaceType.Smooth
          obj.FrontSurface = Enum.SurfaceType.Smooth
          obj.BackSurface = Enum.SurfaceType.Smooth
          if obj:IsA("MeshPart") then
            obj.RenderFidelity = Enum.RenderFidelity.Performance
          end
          for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
              child:Destroy()
            end
          end
        end
      end
      fps_boost = workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("BasePart") then
          obj.CastShadow = false
          obj.Material = Enum.Material.SmoothPlastic
          obj.Reflectance = 0
          obj.TopSurface = Enum.SurfaceType.Smooth
          obj.BottomSurface = Enum.SurfaceType.Smooth
          obj.LeftSurface = Enum.SurfaceType.Smooth
          obj.RightSurface = Enum.SurfaceType.Smooth
          obj.FrontSurface = Enum.SurfaceType.Smooth
          obj.BackSurface = Enum.SurfaceType.Smooth
          if obj:IsA("MeshPart") then
            obj.RenderFidelity = Enum.RenderFidelity.Performance
          end
          for _, child in ipairs(obj:GetChildren()) do
            if child:IsA("Decal") or child:IsA("Texture") then
              child:Destroy()
            end
          end
        end
      end)
    else
      if fps_boost then
        fps_boost:Disconnect()
        fps_boost = nil
      end
    end
  end
})

local Open_Btn = new('ScreenGui', {
  Name = 'Open button',
  Parent = game.CoreGui
})

local Drag_and_click_btn = new('TextButton', {
  Name = 'Drag and click btn',
  Size = UDim2.new(0, 35, 0, 35),
  Position = UDim2.new(0.5, 300, 0.5, -63),
  Active = true,
  Draggable = true,
  AutoButtonColor = false,
  BackgroundColor3 = Color3.fromHex('#2bb7fb'),
  Text = 'Zyn',
  TextColor3 = Color3.fromHex('#ffffff'),
  Parent = Open_Btn
})
new('UICorner', {
  CornerRadius = UDim.new(0, 5),
  Parent = Drag_and_click_btn
})
new('UIStroke', {
  Color = Color3.fromHex('#12394c'),
  ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  Parent = Drag_and_click_btn
})
new('UIStroke', {
  Color = Color3.fromHex('#828282'),
  Thickness = 1,
  Parent = Drag_and_click_btn
})
Drag_and_click_btn.MouseButton1Click:Connect(function()
  Window:Minimize()
end)
