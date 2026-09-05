local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()

local Window = Library:CreateWindow({
  Title = "Zynkore Hub",
  Footer = "By zynkore / Flee the Facility / Open Source",
  Center = true,
  AlwaysOnTop = true,
  Icon = 95816097006870,
  NotifySide = "Right",
  Resizable = true,
  ShowMobileButtons = true,
  EnableSidebarResize = true,
  EnableCompacting = true
})
Library:Notify("Beta version!", 3)

function serv(Service)
  if Service ~= nil or Service ~= "" then
    return (cloneref and cloneref(game:GetService(Service)) or game:GetService(Service))
  end
  return game:GetService(Service)
end

local WS = serv("Workspace")
local plr = serv("Players")
local RPS = serv("ReplicatedStorage")
local RS = serv("RunService")
local CS = serv("CollectionService")
local Lighting = serv("Lighting")

local LP = plr.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Humanoid = Char:WaitForChild("Humanoid")
local HRP = Char:WaitForChild("HumanoidRootPart")
LP.CharacterAdded:Connect(function(Value)
  Char = Value
  Humanoid = Char:WaitForChild("Humanoid")
  HRP = Char:WaitForChild("HumanoidRootPart")
end)

local CoreGui = (gethui and gethui() or serv("CoreGui"))
local PlayerGui = LP:WaitForChild("PlayerGui")

local MenusScreenGui = PlayerGui:WaitForChild("MenusScreenGui")
local ScreenGui = PlayerGui:WaitForChild("ScreenGui")
local InventoryMenuWindow = MenusScreenGui:WaitForChild("InventoryMenuWindow")

local CurrentHammer = InventoryMenuWindow:WaitForChild("Body"):WaitForChild("CurrentHammer")
local CurrentGemstone = InventoryMenuWindow:WaitForChild("Body"):WaitForChild("CurrentGemstone")
local TimingCircle = ScreenGui:WaitForChild("TimingCircle")
local StatusBar = PlayerGui:WaitForChild("ScreenGui"):WaitForChild("RoundBar"):WaitForChild("StatusBars")

local CurrentHammerName = CurrentHammer:WaitForChild("BottomLabel")
local CurrentGemstoneName = CurrentGemstone:WaitForChild("BottomLabel")

local TempPlayerStatsModule = LP:WaitForChild("TempPlayerStatsModule")

local ActionInput = TempPlayerStatsModule:WaitForChild("ActionInput")
local OnTrigger = TempPlayerStatsModule:WaitForChild("OnTrigger")
local Escaped = TempPlayerStatsModule:WaitForChild("Escaped")
local Captured = TempPlayerStatsModule:WaitForChild("Captured")
local Ragdoll = TempPlayerStatsModule:WaitForChild("Ragdoll")

local RemoteEvent = RPS:WaitForChild("RemoteEvent")

local Atmosphere = Lighting:WaitForChild("Atmosphere")
local GameStatus = RPS:WaitForChild("GameStatus")
local GameTimer = RPS:WaitForChild("GameTimer")
local ComputersLeft = RPS:WaitForChild("ComputersLeft")
local IsGameActive = RPS:WaitForChild("IsGameActive")
local CurrentMap = RPS:WaitForChild("CurrentMap")

local CurrentPower = RPS:WaitForChild("CurrentPower")
local PowerActive = RPS:WaitForChild("PowerActive")

local BeastColor = Color3.fromRGB(255, 0, 0)
local SurvivorColor = Color3.fromRGB(0, 255, 0)

local ComputerColorIdle = Color3.fromRGB(13, 105, 172)
local ComputerColorHacked = Color3.fromRGB(40, 127, 71)
local ComputerColorError = Color3.fromRGB(196, 40, 28)

local ExitColorClosed = Color3.fromRGB(255, 0, 0)
local ExitColorCanOpen = Color3.fromRGB(255, 255, 0)
local ExitColorOpen = Color3.fromRGB(0, 255, 0)

local FreezeColor = Color3.fromRGB(43, 185, 251)
local LockerColor = Color3.fromRGB(255, 105, 180)

local Lockers = CS:GetTagged("LOCKER")
CS:GetInstanceAddedSignal("LOCKER"):Connect(function(Obj)
  if table.find(Lockers, Obj) == nil then
    table.insert(Lockers, Obj)
  end
end)

CS:GetInstanceRemovedSignal("LOCKER"):Connect(function(Obj)
  local Index = table.find(Lockers, Obj)
  if Index ~= nil then
    table.remove(Lockers, Index)
  end
end)

function GetBeast()
  local CurrentBeast = nil
  for _, p in pairs(plr:GetPlayers()) do
    if p and p.Character then
      if p.Character:FindFirstChild("Hammer") then
        CurrentBeast = p.Character
      end
    end
  end
  return CurrentBeast
end

function GetBeastName()
  for _, p in pairs(plr:GetPlayers()) do
    if p then
      if p.Character then
        if p.Character:FindFirstChild("Hammer") then
          return "<font color='rgb(255, 0, 0)'>" .. p.Name .. "</font>"
        end
      end
    end
  end
  return "Waiting <font color='rgb(255, 0, 0)'>beast</font> name..."
end

function PlayerInGame(PlayerName)
  for i = 1, 4 do
    local CellPrefix = "SurvivorCell" .. tostring(i)
    if StatusBar:WaitForChild(tostring(CellPrefix)):WaitForChild("NameLabel").Text == PlayerName then
      return true
    end
  end
  return false
end

local OptimizeHub = true

local InfoTab = Window:AddTab("Info", "info")
local InfoTabA = InfoTab:AddGroupbox({
  Side = "Left",
  Name = "Changelog",
  IconName = "list",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

InfoTabA:AddLabel({
  Text = [[  [<font color="rgb(0, 255, 0)">+</font>] Added auto enable/disable optimize hub
  [<font color="rgb(0, 255, 0)">+</font>] Added auto enable/disable optimize hub slider]],
  DoesWrap = true,
  Size = 15,
  Visible = true
})

local InfoTabB = InfoTab:AddGroupbox({
  Side = "Left",
  Name = "User info",
  IconName = "user",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local ShowUserName = false
local UserNameLabel1 = InfoTabB:AddLabel({
  Text = "User name: " .. (ShowUserName and LP.Name or "*******"),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
InfoTabB:AddToggle("Show_user_name", {
  Text = "Show user name",
  Default = false,
  Callback = function(V)
    ShowUserName = V
    UserNameLabel1:SetText("User name: " .. (ShowUserName and LP.Name or "*******"))
  end,
  Risky = true,
  Disabled = false,
  Visible = true
})

local ShowUserDisplayName = true
local UserDisplayNameLabel1 = InfoTabB:AddLabel({
  Text = "User display name: " .. (ShowUserDisplayName and LP.DisplayName or "*******"),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
InfoTabB:AddToggle("Show_user_display_name", {
  Text = "Show user display name",
  Default = true,
  Callback = function(V)
    ShowUserDisplayName = V
    UserDisplayNameLabel1:SetText("User display name: " .. (ShowUserDisplayName and LP.DisplayName or "*******"))
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local InfoTabC = InfoTab:AddGroupbox({
  Side = "Right",
  Name = "User info (game)",
  IconName = "user",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local CurrentHammerLabel = InfoTabC:AddLabel({
  Text = "Current hammer: " .. (tostring(CurrentHammerName.Text) ~= "" and tostring(CurrentHammerName.Text) or "Please open inventory"),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
CurrentHammerName:GetPropertyChangedSignal("Text"):Connect(function()
  if CurrentHammerName.Text ~= "" then
    CurrentHammerLabel:SetText("Current hammer: " .. tostring(CurrentHammerName.Text))
  end
end)

local CurrentGemstoneLabel = InfoTabC:AddLabel({
  Text = "Current gemstone: " .. (tostring(CurrentGemstoneName.Text) ~= "" and tostring(CurrentGemstoneName.Text) or "Please open inventory"),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
CurrentGemstoneName:GetPropertyChangedSignal("Text"):Connect(function()
  if CurrentGemstoneName.Text ~= "" then
    CurrentGemstoneLabel:SetText("Current gemstone: " .. (tostring(CurrentGemstoneName.Text) ~= "" and tostring(CurrentGemstoneName.Text)))
  end
end)

InfoTabC:AddButton({
  Text = "Check gemstone & hammer",
  Func = function()
    local OldState = InventoryMenuWindow.Visible
    InventoryMenuWindow.Visible = true
    InventoryMenuWindow.Visible = OldState
  end
})

local MainTab = Window:AddTab("Main", "house")
local MainTabA = MainTab:AddGroupbox({
  Side = "Left",
  Name = "Beast ragebait",
  IconName = "star",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local Spam_beast_ability = false
MainTabA:AddToggle("Spam_beast_ability", {
  Text = "Spam beast ability",
  Callback = function(V)
    Spam_beast_ability = V
    while Spam_beast_ability do
      if not Spam_beast_ability then break end
      local Beast = GetBeast()
      if Beast ~= nil and Beast ~= Char then
        Beast:WaitForChild("BeastPowers"):WaitForChild("PowersEvent"):FireServer("Input")
      end
      if OptimizeHub then
        task.wait(0.1)
      else
        task.wait()
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local Beast_untie_player = false
MainTabA:AddToggle("Beast_untie_player", {
  Text = "Beast untie player",
  Callback = function(V)
    Beast_untie_player = V
    while Beast_untie_player do
      if not Beast_untie_player then break end
      local Beast = GetBeast()
      if Beast ~= nil then
        if Beast ~= Char then
          local Hammer = Beast:WaitForChild("Hammer")
          local HammerEvent = Hammer:WaitForChild("HammerEvent")
          if Beast:FindFirstChild("Part") and Beast.Part:FindFirstChild("RopeConstraint") then
            HammerEvent:FireServer("HammerClick", true)
          end
        end
      end
      if OptimizeHub then
        task.wait(0.20)
      else
        task.wait(0.15)
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local Slow_beast = false
MainTabA:AddToggle("Slow_beast", {
  Text = "Slow beast",
  Callback = function(V)
    Slow_beast = V
    while Slow_beast do
      if not Slow_beast then break end
      local Beast = GetBeast()
      if Beast ~= nil and Beast ~= Char then
        Beast:WaitForChild("BeastPowers"):WaitForChild("PowersEvent"):FireServer("Jumped")
      end
      if OptimizeHub then
        task.wait(0.1)
      else
        task.wait()
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local Slow_beast_aura_distance = 25
local Slow_beast_aura = false
MainTabA:AddToggle("Slow_beast_aura", {
  Text = "Slow beast aura",
  Callback = function(V)
    Slow_beast_aura = V
    while Slow_beast_aura do
      local Beast = GetBeast()
      if Beast ~= nil then
        if Beast ~= Char then
          if Beast:FindFirstChild("HumanoidRootPart") and HRP then
            if Beast:FindFirstChild("Humanoid") and Beast.Humanoid.Health > 0 then
              local PHRP = Beast.HumanoidRootPart
              if (PHRP.Position - HRP.Position).Magnitude <= Slow_beast_aura_distance then
                Beast.BeastPowers.PowersEvent:FireServer("Jumped")
              end
            end
          end
        end
      end
      if OptimizeHub then
        task.wait(0.35)
      else
        task.wait()
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

MainTabA:AddSlider("Slow_beast_aura_distance", {
  Text = "Distance",
  Default = 25,
  Min = 1,
  Max = 50,
  Rounding = 0,
  Compact = true,
  HideMax = false,
  Callback = function(V)
    Slow_beast_aura_distance = V
  end,
  AllowRightClickInput = false,
  Disabled = false,
  Visible = true
})

local MainTabAA = MainTab:AddTabbox({
  Side = "Right",
  PopOut = false
})
local MainTabAAA = MainTabAA:AddTab("Beast info", "user")

local BeastNameLabel = MainTabAAA:AddLabel({
  Text = "Beast name: " .. (GetBeastName() ~= LP.Name and GetBeastName() or "You are the <font color='rgb(255, 0, 0)'>beast</font>."),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
task.spawn(function()
  while true do
    BeastNameLabel:SetText("Beast name: " .. (GetBeastName() ~= LP.Name and GetBeastName() or "You are the <font color='rgb(255, 0, 0)'>beast</font>."))
    if OptimizeHub then
      task.wait(1.5)
    else
      task.wait(0.8)
    end
  end
end)

local CurrentPowerLabel = MainTabAAA:AddLabel({
  Text = 'Current power: ' .. (IsGameActive.Value and '<font color="rgb(80, 188, 71)">' .. tostring(CurrentPower.Value) .. '</font>' or 'Waiting for the <font color="rgb(255, 255, 0)">game</font> to start.'),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
CurrentPower:GetPropertyChangedSignal("Value"):Connect(function()
  CurrentPowerLabel:SetText('Current power: ' .. (IsGameActive.Value and '<font color="rgb(80, 188, 71)">' .. tostring(CurrentPower.Value) .. '</font>' or 'Waiting for the <font color="rgb(255, 255, 0)">game</font> start.'))
end)

local PowerActiveLabel = MainTabAAA:AddLabel({
  Text = "Power active: " .. (PowerActive.Value and '<font color="rgb(30, 193, 5)">true</font>' or '<font color="rgb(193, 5, 5)">false</font>'),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
PowerActive:GetPropertyChangedSignal("Value"):Connect(function()
  PowerActiveLabel:SetText("Power active: " .. (PowerActive.Value and '<font color="rgb(30, 193, 5)">true</font>' or '<font color="rgb(193, 5, 5)">false</font>'))
end)

local MainTabAAB = MainTabAA:AddTab("Game info", "map")

local CurrentMapLabel = MainTabAAB:AddLabel({
  Text = "Current map: <font color='rgb(251, 177, 43)'>" .. (tostring(CurrentMap.Value) ~= "" and tostring(CurrentMap.Value) or "No map avaible!") .. "</font>",
  DoesWrap = true,
  Size = 14,
  Visible = true
})
CurrentMap:GetPropertyChangedSignal("Value"):Connect(function()
  CurrentMapLabel:SetText("Current map: <font color='rgb(251, 177, 43)'>" .. (tostring(CurrentMap.Value) ~= "" and tostring(CurrentMap.Value) or "No map avaible!") .. "</font>")
end)
MainTabAAB:AddDivider()

local ComputersLeftLabel = MainTabAAB:AddLabel({
  Text = "Computers left: <font color='rgb(133, 251, 43)'>" .. tostring(ComputersLeft.Value) .. "</font>",
  DoesWrap = true,
  Size = 14,
  Visible = true
})
ComputersLeft:GetPropertyChangedSignal("Value"):Connect(function()
  ComputersLeftLabel:SetText("Computers left: <font color='rgb(133, 251, 43)'>" .. tostring(ComputersLeft.Value) .. "</font>")
end)

local GameStatusLabel = MainTabAAB:AddLabel({
  Text = "Game status: <font color='rgb(240, 255, 0)'>" .. tostring(GameStatus.Value) .. "</font>",
  DoesWrap = true,
  Size = 14,
  Visible = true
})
GameStatus:GetPropertyChangedSignal("Value"):Connect(function()
  GameStatusLabel:SetText("Game status: <font color='rgb(240, 255, 0)'>" .. tostring(GameStatus.Value) .. "</font>")
end)

local GameTimerLabel = MainTabAAB:AddLabel({
  Text = "Game timer: <font color='rgb(45, 251, 43)'>" .. tostring(GameTimer.Value) .. "</font>",
  DoesWrap = true,
  Size = 14,
  Visible = true
})
GameTimer:GetPropertyChangedSignal("Value"):Connect(function()
  GameTimerLabel:SetText("Game timer: <font color='rgb(45, 251, 43)'>" .. tostring(GameTimer.Value) .. "</font>")
end)

local IsGameActiveLabel = MainTabAAB:AddLabel({
  Text = "Game active: " .. (IsGameActive.Value and '<font color="rgb(30, 193, 5)">true</font>' or '<font color="rgb(193, 5, 5)">false</font>'),
  DoesWrap = true,
  Size = 14,
  Visible = true
})
IsGameActive:GetPropertyChangedSignal("Value"):Connect(function()
  IsGameActiveLabel:SetText("Game active: " .. (IsGameActive.Value and '<font color="rgb(30, 193, 5)">true</font>' or '<font color="rgb(193, 5, 5)">false</font>'))
  CurrentPowerLabel:SetText('Current power: ' .. (IsGameActive.Value and '<font color="rgb(80, 188, 71)">' .. tostring(CurrentPower.Value) .. '</font>' or 'Waiting for the <font color="rgb(255, 255, 0)">game</font> to start.'))
end)

local EspTab = Window:AddTab("Esp", "eye")
local EspTabA = EspTab:AddGroupbox({
  Side = "Left",
  Name = "Player esp",
  IconName = "wrench",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local BeastV = false
local BeastToggle = EspTabA:AddToggle("Esp_beast", {
  Text = "Beast",
  Default = false,
  Callback = function(Value)
    BeastV = Value
    if BeastV then
      task.spawn(function()
        while BeastV do
          for _, Player in pairs(plr:GetPlayers()) do
            if Player ~= LP then
              local Character = Player.Character
              if Character ~= nil then
                local IsBeast = Character:FindFirstChild("Hammer") ~= nil
                if IsBeast then
                  local Highlight = Character:FindFirstChild("Esp_beast")
                  if Highlight == nil then
                    Highlight = Instance.new("Highlight")
                    Highlight.Name = "Esp_beast"
                    Highlight.FillTransparency = 0.5
                    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    Highlight.Parent = Character
                  end
                  Highlight.FillColor = BeastColor
                  Highlight.OutlineColor = BeastColor
                else
                  local Highlight = Character:FindFirstChild("Esp_beast")
                  if Highlight ~= nil then
                    Highlight:Destroy()
                  end
                end
              end
            end
          end
          if OptimizeHub then
            task.wait(1)
          else
            task.wait()
          end
        end
      end)
    else
      for _, Player in pairs(plr:GetPlayers()) do
        if Player.Character ~= nil then
          local Highlight = Player.Character:FindFirstChild("Esp_beast")
          if Highlight ~= nil then
            Highlight:Destroy()
          end
        end
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
BeastToggle:AddColorPicker("BeastColor", {
  Default = BeastColor,
  Title = "Beast color",
  Transparency = 0,
  Callback = function(Color)
    BeastColor = Color
  end
})

local SurvivorV = false
local SurvivorToggle = EspTabA:AddToggle("Esp_survivor", {
  Text = "Survivor",
  Default = false,
  Callback = function(Value)
    SurvivorV = Value
    if SurvivorV then
      task.spawn(function()
        while SurvivorV do
          for _, Player in pairs(plr:GetPlayers()) do
            if Player ~= LP then
              local Character = Player.Character
              if Character ~= nil then
                local IsBeast = Character:FindFirstChild("Hammer") ~= nil
                if IsBeast == false then
                  local Highlight = Character:FindFirstChild("Esp_survivor")
                  if Highlight == nil then
                    Highlight = Instance.new("Highlight")
                    Highlight.Name = "Esp_survivor"
                    Highlight.FillTransparency = 0.5
                    Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    Highlight.Parent = Character
                  end
                  Highlight.FillColor = SurvivorColor
                  Highlight.OutlineColor = SurvivorColor
                else
                  local Highlight = Character:FindFirstChild("Esp_survivor")
                  if Highlight ~= nil then
                    Highlight:Destroy()
                  end
                end
              end
            end
          end
          if OptimizeHub then
            task.wait(1)
          else
            task.wait()
          end
        end
      end)
    else
      for _, Player in pairs(plr:GetPlayers()) do
        if Player.Character ~= nil then
          local Highlight = Player.Character:FindFirstChild("Esp_survivor")
          if Highlight ~= nil then
            Highlight:Destroy()
          end
        end
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
SurvivorToggle:AddColorPicker("SurvivorColor", {
  Default = SurvivorColor,
  Title = "Survivor color",
  Transparency = 0,
  Callback = function(Color)
    SurvivorColor = Color
  end
})

EspTabA:AddButton({
  Text = "Reload esp (Players)",
  Func = function()
    for _, Player in pairs(plr:GetPlayers()) do
      if Player.Character ~= nil then
        local BeastHighlight = Player.Character:FindFirstChild("Esp_beast")
        local SurvivorHighlight = Player.Character:FindFirstChild("Esp_survivor")
        if BeastHighlight ~= nil then
          BeastHighlight:Destroy()
        end
        if SurvivorHighlight ~= nil then
          SurvivorHighlight:Destroy()
        end
      end
    end
    Library:Notify("Esp info: \nPlayers esp reloaded!", 2.7)
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
local EspTabB = EspTab:AddGroupbox({
  Side = "Right",
  Name = "Map esp",
  IconName = "hammer",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local ComputerV = false
local ComputerToggle = EspTabB:AddToggle("Esp_computer", {
  Text = "Computer",
  Default = false,
  Callback = function(Value)
    ComputerV = Value
    if ComputerV then
      task.spawn(function()
        while ComputerV do
          local MapFolder = WS
          if CurrentMap.Value ~= "" then
            local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
            if Found ~= nil then
              MapFolder = Found
            end
          end
          for _, Obj in pairs(MapFolder:GetChildren()) do
            if Obj:IsA("Model") and Obj.Name == "ComputerTable" then
              local Screen = Obj:WaitForChild("Screen")
              local Green = false
              local Red = false
              if Screen.Color == Color3.fromRGB(40, 127, 71) then
                Green = true
              elseif Screen.Color == Color3.fromRGB(196, 40, 28) then
                Red = true
              elseif Screen.Color == Color3.fromRGB(13, 105, 172) then
                Green = false
                Red = false
              end

              local Color = ComputerColorIdle
              if Green then
                Color = ComputerColorHacked
              elseif Red then
                Color = ComputerColorError
              end
              local Highlight = Obj:FindFirstChild("Esp_computer")
              if Highlight == nil then
                Highlight = Instance.new("Highlight")
                Highlight.Name = "Esp_computer"
                Highlight.FillTransparency = 0.5
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                Highlight.Parent = Obj
              end
              Highlight.FillColor = Color
              Highlight.OutlineColor = Color
            end
          end
          if OptimizeHub then
            task.wait(1)
          else
            task.wait(0.25)
          end
        end
      end)
    else
      local MapFolder = WS
      if CurrentMap.Value ~= "" then
        local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
        if Found ~= nil then
          MapFolder = Found
        end
      end
      for _, Obj in pairs(MapFolder:GetChildren()) do
        if Obj:IsA("Model") then
          local Highlight = Obj:FindFirstChild("Esp_computer")
          if Highlight ~= nil then
            Highlight:Destroy()
          end
        end
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
ComputerToggle:AddColorPicker("ComputerColorIdle", {
  Default = ComputerColorIdle,
  Title = "Idle color",
  Transparency = 0,
  Callback = function(Color)
    ComputerColorIdle = Color
  end
})
ComputerToggle:AddColorPicker("ComputerColorHacked", {
  Default = ComputerColorHacked,
  Title = "Hacked color",
  Transparency = 0,
  Callback = function(Color)
    ComputerColorHacked = Color
  end
})
ComputerToggle:AddColorPicker("ComputerColorError", {
  Default = ComputerColorError,
  Title = "Error color",
  Transparency = 0,
  Callback = function(Color)
    ComputerColorError = Color
  end
})

local FreezeV = false
local FreezeToggle = EspTabB:AddToggle("Esp_freezePod", {
  Text = "FreezePod",
  Default = false,
  Callback = function(Value)
    FreezeV = Value
    if FreezeV then
      task.spawn(function()
        while FreezeV do
          local MapFolder = WS
          if CurrentMap.Value ~= "" then
            local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
            if Found ~= nil then
              MapFolder = Found
            end
          end
          for _, Obj in pairs(MapFolder:GetChildren()) do
            if Obj:IsA("Model") and Obj.Name == "FreezePod" then
              local Highlight = Obj:FindFirstChild("Esp_freeze")
              if Highlight == nil then
                Highlight = Instance.new("Highlight")
                Highlight.Name = "Esp_freeze"
                Highlight.FillTransparency = 0.5
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                Highlight.Parent = Obj
              end
              Highlight.FillColor = FreezeColor
              Highlight.OutlineColor = FreezeColor
            end
          end
          if OptimizeHub then
            task.wait(1)
          else
            task.wait(0.25)
          end
        end
      end)
    else
      local MapFolder = WS
      if CurrentMap.Value ~= "" then
        local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
        if Found ~= nil then
          MapFolder = Found
        end
      end
      for _, Obj in pairs(MapFolder:GetChildren()) do
        if Obj:IsA("Model") then
          local Highlight = Obj:FindFirstChild("Esp_freeze")
          if Highlight ~= nil then
            Highlight:Destroy()
          end
        end
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
FreezeToggle:AddColorPicker("FreezeColorPicker", {
  Default = FreezeColor,
  Title = "FreezePod color",
  Transparency = 0,
  Callback = function(Color)
    FreezeColor = Color
  end
})

local ExitV = false
local ExitToggle = EspTabB:AddToggle("Esp_exitDoor", {
  Text = "ExitDoor",
  Default = false,
  Callback = function(Value)
    ExitV = Value
    if ExitV then
      task.spawn(function()
        while ExitV do
          local MapFolder = WS
          if CurrentMap.Value ~= "" then
            local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
            if Found ~= nil then
              MapFolder = Found
            end
          end
          for _, Obj in pairs(MapFolder:GetChildren()) do
            if Obj:IsA("Model") and Obj.Name == "ExitDoor" then
              local Green = false
              local Yellow = false
              local Red = false
              if Obj:WaitForChild("Light").Color == Color3.fromRGB(0, 255, 0) then
                Green = true
              elseif Obj:WaitForChild("Light").Color == Color3.fromRGB(255, 255, 0) then
                Yellow = true
              elseif Obj:WaitForChild("Light").Color == Color3.fromRGB(255, 0, 0) then
                Red = true
              end
              
              local Color = ExitColorClosed
              if Green then
                Color = ExitColorOpen
              elseif Yellow then
                Color = ExitColorCanOpen
              elseif Red then
                Color = ExitColorClosed
              end

              local Highlight = Obj:FindFirstChild("Esp_exitDoor")
              if Highlight == nil then
                Highlight = Instance.new("Highlight")
                Highlight.Name = "Esp_exitDoor"
                Highlight.FillTransparency = 0.5
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                Highlight.Parent = Obj
              end
              Highlight.FillColor = Color
              Highlight.OutlineColor = Color
            end
          end
          if OptimizeHub then
            task.wait(1)
          else
            task.wait(0.25)
          end
        end
      end)
    else
      local MapFolder = WS
      if CurrentMap.Value ~= "" then
        local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
        if Found ~= nil then
          MapFolder = Found
        end
      end
      for _, Obj in pairs(MapFolder:GetChildren()) do
        if Obj:IsA("Model") then
          local Highlight = Obj:FindFirstChild("Esp_exitDoor")
          if Highlight ~= nil then
            Highlight:Destroy()
          end
        end
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
ExitToggle:AddColorPicker("ExitColorClosed", {
  Default = ExitColorClosed,
  Title = "Locked color",
  Transparency = 0,
  Callback = function(Color)
    ExitColorClosed = Color
  end
})
ExitToggle:AddColorPicker("ExitColorCanOpen", {
  Default = ExitColorCanOpen,
  Title = "Can open color",
  Transparency = 0,
  Callback = function(Color)
    ExitColorCanOpen = Color
  end
})
ExitToggle:AddColorPicker("ExitColorOpen", {
  Default = ExitColorOpen,
  Title = "Open color",
  Transparency = 0,
  Callback = function(Color)
    ExitColorOpen = Color
  end
})

local LockerV = false
local LockerToggle = EspTabB:AddToggle("Esp_locker", {
  Text = "Locker",
  Default = false,
  Callback = function(Value)
    LockerV = Value
    if LockerV then
      task.spawn(function()
        while LockerV do
          for _, Obj in pairs(Lockers) do
            if Obj.Parent ~= nil then
              local Highlight = Obj:FindFirstChild("Esp_locker")
              if Highlight == nil then
                Highlight = Instance.new("Highlight")
                Highlight.Name = "Esp_locker"
                Highlight.FillTransparency = 0.5
                Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                Highlight.Parent = Obj
              end
              Highlight.FillColor = LockerColor
              Highlight.OutlineColor = LockerColor
            end
          end
          if OptimizeHub then
            task.wait(1)
          else
            task.wait(0.25)
          end
        end
      end)
    else
      for _, Obj in pairs(Lockers) do
        if Obj.Parent ~= nil then
          local Highlight = Obj:FindFirstChild("Esp_locker")
          if Highlight ~= nil then
            Highlight:Destroy()
          end
        end
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
LockerToggle:AddColorPicker("LockerColorPicker", {
  Default = LockerColor,
  Title = "Locker color",
  Transparency = 0,
  Callback = function(Color)
    LockerColor = Color
  end
})

EspTabB:AddButton({
  Text = "Reload esp (Map)",
  Func = function()
    local MapFolder = WS
    if CurrentMap.Value ~= "" then
      local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
      if Found ~= nil then
        MapFolder = Found
      end
    end
    for _, Obj in pairs(MapFolder:GetChildren()) do
      if Obj:IsA("Model") then
        local ComputerHighlight = Obj:FindFirstChild("Esp_computer")
        local FreezeHighlight = Obj:FindFirstChild("Esp_freeze")
        local ExitHighlight = Obj:FindFirstChild("Esp_exitDoor")
        if ComputerHighlight ~= nil then
          ComputerHighlight:Destroy()
        end
        if FreezeHighlight ~= nil then
          FreezeHighlight:Destroy()
        end
        if ExitHighlight ~= nil then
          ExitHighlight:Destroy()
        end
      end
    end
    for _, Obj in pairs(Lockers) do
      if Obj.Parent ~= nil then
        local Highlight = Obj:FindFirstChild("Esp_locker")
        if Highlight ~= nil then
          Highlight:Destroy()
        end
      end
    end
    
    Lockers = CS:GetTagged("LOCKER")
    Library:Notify("Esp info: \nMap esp reloaded!", 4)
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local ToolsTab = Window:AddTab("Tools", "wrench")
local ToolsTabA = ToolsTab:AddGroupbox({
  Side = "Left",
  Name = "Beast tools",
  IconName = "hammer",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local Hit_distance = 15
local Auto_hit_nearest_player = false
ToolsTabA:AddToggle("Auto_hit_nearest_player", {
  Text = "Auto hit nearest player",
  Callback = function(V)
    Auto_hit_nearest_player = V
    while Auto_hit_nearest_player do
      local Beast = GetBeast()
      if Beast ~= nil then
        local MinDist = math.huge
        local Nearest = nil
        if Beast == Char then
          for _, p in pairs(plr:GetPlayers()) do
            if p and p ~= LP and PlayerInGame(tostring(p.Name)) then
              if p.Character then
                if p.Character:FindFirstChild("HumanoidRootPart") then
                  local PHRP = p.Character.HumanoidRootPart
                  if (HRP.Position - PHRP.Position).Magnitude <= Hit_distance then
                    MinDist = (HRP.Position - PHRP.Position).Magnitude
                    Nearest = p.Character
                  end
                end
              end
            end
          end
        end
        if Nearest ~= nil then
          if Nearest:FindFirstChild("HumanoidRootPart") then
            Beast.Hammer.HammerEvent:FireServer("HammerHit", Nearest.HumanoidRootPart)
          end
        end
      end
      if OptimizeHub then
        task.wait(0.35)
      else
        task.wait()
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
ToolsTabA:AddSlider("Auto_hit_nearest_player_distance", {
  Text = "Hit distance",
  Default = 15,
  Min = 1,
  Max = 25,
  Rounding = 0,
  Compact = true,
  HideMax = false,
  Callback = function(V)
    Hit_distance = V
  end,
  AllowRightClickInput = false,
  Disabled = false,
  Visible = true
})

local Tie_up_distance = 15
local Auto_tie_up_nearest_player = false
ToolsTabA:AddToggle("Auto_tie_up_nearest_player", {
  Text = "Auto tie up nearest player",
  Callback = function(V)
    Auto_tie_up_nearest_player = V
    while Auto_tie_up_nearest_player do
      local Beast = GetBeast()
      if Beast ~= nil then
        local MinDist = math.huge
        local Nearest = nil
        if Beast == Char then
          for _, p in pairs(plr:GetPlayers()) do
            if p and p ~= LP and PlayerInGame(tostring(p.Name)) then
              if p.Character then
                if p.Character:FindFirstChild("HumanoidRootPart") then
                  local PHRP = p.Character.HumanoidRootPart
                  if (HRP.Position - PHRP.Position).Magnitude <= Tie_up_distance then
                    MinDist = (HRP.Position - PHRP.Position).Magnitude
                    Nearest = p.Character
                  end
                end
              end
            end
          end
        end
        if Nearest ~= nil then
          if not Beast:FindFirstChild("Part") then
            Beast.Hammer.HammerEvent:FireServer("HammerTieUp", Nearest.HumanoidRootPart, Nearest.HumanoidRootPart.Position + Vector3.new(0, 0.001, 0))
          end
        end
      end
        
      if OptimizeHub then
        task.wait(0.35)
      else
        task.wait()
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
ToolsTabA:AddSlider("Auto_tie_up_nearest_player_distance", {
  Text = "Tie up distance",
  Default = 15,
  Min = 1,
  Max = 25,
  Rounding = 0,
  Compact = true,
  HideMax = false,
  Callback = function(V)
    Tie_up_distance = V
  end,
  AllowRightClickInput = false,
  Disabled = false,
  Visible = true
})

local ToolsTabB = ToolsTab:AddGroupbox({
  Side = "Right",
  Name = "Survivor tools",
  IconName = "user",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local No_hack_fail = false
local OldHook
OldHook = hookmetamethod(game, "__namecall", function(self, ...)
  local Method = getnamecallmethod()
  local Args = {...}
  if Method == "FireServer" and self == RemoteEvent then
    if Args[1] == "SetPlayerMinigameResult" then
      Args[2] = (No_hack_fail and true or Args[2])
    end
  end
  
  return OldHook(self, table.unpack(Args))
end)

ToolsTabB:AddToggle("No_hack_fail", {
  Text = "No hack fail",
  Default = false,
  Callback = function(V)
    No_hack_fail = V
    while No_hack_fail do
      if not No_hack_fail then return end
      if TimingCircle.Visible then
        RemoteEvent:FireServer("Input", "Action", true)
        RemoteEvent:FireServer("SetPlayerMinigameResult", true)
      end
      task.wait()
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local Auto_save_players_silent = false
ToolsTabB:AddToggle("Auto_save_players_silent", {
  Text = "Auto save players (silent)",
  Callback = function(V)
    Auto_save_players_silent = V
    while Auto_save_players_silent do
      local MapFolder = WS
      if CurrentMap.Value ~= "" then
        local Found = WS:FindFirstChild(tostring(CurrentMap.Value))
        if Found ~= nil then
          MapFolder = Found
        end
      end
      if PlayerInGame(tostring(LP.Name)) and GetBeast() ~= nil and GetBeast() ~= Char and IsGameActive.Value then
        for _, Obj in pairs(MapFolder:GetChildren()) do
          if Obj.Name == "FreezePod" and Obj:IsA("Model") then
            if Obj:FindFirstChild("PodTrigger") and Obj.PodTrigger:FindFirstChild("CapturedTorso") then
              local TorsoPart = Obj.PodTrigger.CapturedTorso
              if TorsoPart.Value ~= nil then
                if Ragdoll.Value == false then
                  if Escaped.Value == false then
                    if Captured.Value == false then
                      local OldTriggerPos = Obj.PodTrigger.CFrame
                      local OldOnTriggerValue = OnTrigger.Value
                      task.wait()
                      Obj.PodTrigger.CFrame = HRP.CFrame -- + Vector3.new(0, 0, 5)
                      task.wait(0.01)
                      -- firetouchinterest(Obj.PodTrigger, HRP, 1)
                      RemoteEvent:FireServer("Input", "Action", true, Obj.PodTrigger.Event)
                      Obj.PodTrigger.CFrame = OldTriggerPos
                      ActionInput.Value = OldOnTriggerValue
                    end
                  end
                end
              end
            end
          end
        end
      end
      if OptimizeHub then
        task.wait(0.43)
      else
        task.wait(0.3)
      end
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local FogTab = Window:AddTab("Fog", "hand")
local FogTabA = FogTab:AddGroupbox({
  Side = "Left",
  Name = "Fog settings",
  IconName = "eye",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local NoFog = false
Atmosphere:GetPropertyChangedSignal("Density"):Connect(function()
  if NoFog then
    Atmosphere.Density = 0
  end
end)
Atmosphere:GetPropertyChangedSignal("Offset"):Connect(function()
  if NoFog then
    Atmosphere.Offset = 0
  end
end)
FogTabA:AddToggle("NoFog", {
  Text = "No fog",
  Callback = function(V)
    NoFog = V
    if V then
      Atmosphere.Density = 0
      Atmosphere.Offset = 0
    end
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local SettingsTab = Window:AddTab("Settings", "settings")
local SettingsTabA = SettingsTab:AddGroupbox({
  Side = "Left",
  Name = "Hub settings",
  IconName = "star",
  Visible = true,
  Collapsed = false,
  DisableCollapsing = false,
  PopOut = false
})

local OptimizeHubToggle = SettingsTabA:AddToggle("Optimize_hub", {
  Text = "Optimize hub",
  Default = true,
  Callback = function(Value)
    OptimizeHub = Value
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})

local Min_fps = 40
local Auto_enable_optimize_hub = true
SettingsTabA:AddToggle("Auto_enable_optimize_hub", {
  Text = "Auto enable optimize hub",
  Default = true,
  Callback = function(V)
    Auto_enable_optimize_hub = V
  end,
  Risky = false,
  Disabled = false,
  Visible = true
})
task.spawn(function()
  while true do
    task.wait(1)
    if Auto_enable_optimize_hub then
      local fps = math.floor(WS:GetRealPhysicsFPS())
      if fps <= Min_fps then
        if OptimizeHub == false then
          Library:Notify("Optimize hub auto enabled!", 3)
          OptimizeHubToggle:SetValue(true)
        end
      elseif fps > Min_fps then
        if OptimizeHub == true then
          Library:Notify("Optimize hub auto disabled!", 3)
          OptimizeHubToggle:SetValue(false)
        end
      end
    end
  end
end)
SettingsTabA:AddSlider("Min_fps", {
  Text = "Min fps",
  Default = 40,
  Min = 10,
  Max = 60,
  Rounding = 0,
  Compact = true,
  Callback = function(V)
    Min_fps = V
  end,
  Disabled = false,
  Visible = true
})

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("Zynkore/Flee the facility")
ThemeManager:ApplyToTab(SettingsTab)
ThemeManager:LoadDefault()

SaveManager:SetLibrary(Library)
SaveManager:SetFolder("Zynkore/Flee the Facility")
SaveManager:BuildConfigSection(SettingsTab)
SaveManager:LoadAutoloadConfig()
Library:Notify("Hub loaded!", 3)
