repeat task.wait() until game:IsLoaded()
if game.PlaceId == 70876832253163 then
  if queue_on_teleport then
    queue_on_teleport([[
      if getgenv().Auto_load == true then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Games/Dead%20Rails/Auto%20bond.luau"))()
      end
    ]])
  else
    
  end
  
  task.wait(2)
  local Prefix = getgenv().Game_config
  local Config = {
    Auto_reset = Prefix.Auto_reset,
    Auto_teleport = Prefix.Auto_teleport,
    Only_drop_bond = Prefix.Only_drop_bond
  }

  local Player = game:GetService("Players")
  local RS = game:GetService("ReplicatedStorage")
  local TeleportService = game:GetService("TeleportService")

  local LP = Player.LocalPlayer

  local world = require(RS:WaitForChild("Shared"):WaitForChild("Universe"):WaitForChild("ECS"):WaitForChild("world"))
  local comps = require(RS:WaitForChild("Shared"):WaitForChild("Universe"):WaitForChild("ECS"):WaitForChild("components"))
  local replicator = require(RS:WaitForChild("Client"):WaitForChild("Universe"):WaitForChild("Replication"):WaitForChild("clientReplicator"))
  local Remotes = require(RS:WaitForChild("Shared"):WaitForChild("Universe"):WaitForChild("Remotes"))
  local PlayerData = require(RS:WaitForChild("Client"):WaitForChild("Universe"):WaitForChild("PlayerDataController"))
  local Event = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Universe"):WaitForChild("Network"):WaitForChild("RemoteEvent"):WaitForChild("Actionable")

  local CollectedBond = 0
  local CoreGui = (gethui and gethui() or game:GetService("CoreGui"))
  if CoreGui:FindFirstChild("Auto_bond_open_source") then
    CoreGui["Auto_bond_open_source"]:Destroy()
  end

  local s = Instance.new("ScreenGui", CoreGui)
  s.Name = "Auto_bond_open_source"

  local Window = Instance.new("Frame", s)
  Window.Name = "Window"
  Window.Size = UDim2.new(0, 335, 0, 125)
  Window.Position = UDim2.new(0.5, -170, 0.5, -150)
  Window.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
  Window.Active = true
  Window.Draggable = true

  local WindowCorner = Instance.new("UICorner", Window)
  WindowCorner.CornerRadius = UDim.new(0, 10)

  local WindowStroke = Instance.new("UIStroke", Window)
  WindowStroke.Color = Color3.fromRGB(60, 60, 70)
  WindowStroke.Thickness = 1

  local TitleBar = Instance.new("Frame", Window)
  TitleBar.Size = UDim2.new(1, 0, 0, 32)
  TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
  TitleBar.BorderSizePixel = 0

  local TitleBarCorner = Instance.new("UICorner", TitleBar)
  TitleBarCorner.CornerRadius = UDim.new(0, 10)

  local TitleLabel = Instance.new("TextLabel", TitleBar)
  TitleLabel.Name = "Title label"
  TitleLabel.Text = "Auto Bond - Zynkore / Open source / free"
  TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  TitleLabel.TextSize = 14
  TitleLabel.Font = Enum.Font.GothamBold
  TitleLabel.Size = UDim2.new(1, -10, 1, 0)
  TitleLabel.Position = UDim2.new(0, 10, 0, 0)
  TitleLabel.BackgroundTransparency = 1
  TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

  local Line = Instance.new("Frame", Window)
  Line.Size = UDim2.new(1, 0, 0, 1)
  Line.Position = UDim2.new(0, 0, 0, 32)
  Line.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
  Line.BorderSizePixel = 0

  local BondLabel = Instance.new("TextLabel", Window)
  BondLabel.Name = "Bond(s) label"
  BondLabel.Text = "Bond(s): " .. CollectedBond or 0
  BondLabel.TextColor3 = Color3.fromRGB(0, 200, 120)
  BondLabel.TextSize = 16
  BondLabel.Font = Enum.Font.GothamBold
  BondLabel.Position = UDim2.new(0, 45, 0, 45)
  BondLabel.BackgroundTransparency = 1
  
  local CurrentBond = LP:WaitForChild("PlayerGui"):WaitForChild("BondGui"):WaitForChild("BondInfo"):WaitForChild("BondCount")
  local CurrentBondLabel = Instance.new("TextLabel", Window)
  CurrentBondLabel.Name = "Current bond label"
  CurrentBondLabel.Text = "Current bond(s): ???"
  CurrentBondLabel.TextColor3 = Color3.fromRGB(0, 170, 255)
  CurrentBondLabel.TextSize = 16
  CurrentBondLabel.Font = Enum.Font.GothamBold
  CurrentBondLabel.Position = UDim2.new(0, 75, 0, 72)
  CurrentBondLabel.BackgroundTransparency = 1
  CurrentBond:GetPropertyChangedSignal("Text"):Connect(function()
    CurrentBondLabel.Text = "Current bond(s): " .. tonumber(CurrentBond.Text)
  end)
  task.spawn(function()
    local char = world:get_resource(comps.ClientStateResource).localCharacter
    if char then
      if not world:has(char, comps.Sack) then
        world:add(char, comps.Sack)
        world:set(char, comps.Sack, { contents = {}, maxContents = 10 })
      end
      for id = 1, 100000 do
        if world:has(id, comps.Storable) and world:get(id, comps.ObjectId) == "bond" then
          local sr = replicator:get_server_entity(id)
          if sr and sr ~= id then
            Remotes.Store:FireServer(sr)
            Remotes.Store:FireServer()
            if Config.Only_drop_bond == false then
              Event:FireServer(sr)
            end

            CollectedBond += 1
            BondLabel.Text = "Bond(s): " .. CollectedBond or 0
            task.wait(0.20)
          end
        end
      end
      
      if id >= 999999 then
        if Config.Auto_reset == true then
          LP.Character:WaitForChild("Humanoid").Health = 0
        end
        if Config.Auto_teleport == true then
          TeleportService:Teleport(116495829188952, LP)
        end
      end
    end
  end)
elseif game.PlaceId == 116495829188952 then
  if queue_on_teleport then
    queue_on_teleport([[
      if getgenv().Auto_load == true then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Games/Dead%20Rails/Auto%20bond.luau"))()
      end
    ]])
  else
    
  end
  
  task.wait(1.8)
  local Prefix = getgenv().Lobby_config
  local Config = {
    Players_number = math.clamp(Prefix.Players_number or 1, 1, 10),
    Auto_create_party = Prefix.Auto_create_party,
    Auto_recreate_party = Prefix.Auto_recreate_party
  }

  local Players = game:GetService("Players")
  local RS = game:GetService("ReplicatedStorage")
  local LP = Players.LocalPlayer

  local Remotes = require(RS:WaitForChild("Shared"):WaitForChild("Universe"):WaitForChild("Remotes"))
  local PartyConstants = require(RS:WaitForChild("Shared"):WaitForChild("Universe"):WaitForChild("Party"):WaitForChild("PartyConstants"))
  local PartyCreationState = require(RS:WaitForChild("Client"):WaitForChild("Lobby"):WaitForChild("Party"):WaitForChild("PartyCreationState"))

  partyCreated = false
  partyMembers = 0
  currentZoneIndex = 0
  stuckCheckStart = 0
  waitingForReservation = false

  function getPartyZones()
    local partyZones = workspace:WaitForChild("PartyZones")
    local zones = partyZones:GetChildren()
    table.sort(zones, function(a, b) return a.Name < b.Name end)
    return zones
  end

  function getNextZone()
    local zones = getPartyZones()
    currentZoneIndex += 1
    if currentZoneIndex > #zones then
      currentZoneIndex = 1
    end
    return zones[currentZoneIndex]
  end

  function teleportToZone(zone)
    local character = LP.Character
    if not character then return false end
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    if zone and zone:FindFirstChild("Hitbox") then
      humanoidRootPart.CFrame = zone.Hitbox.CFrame + Vector3.new(0, 3, 0)
      return true
    end
    return false
  end

  function doCreateParty()
    local settings = PartyCreationState.partySettings()
    if not settings then
      waitingForReservation = true
      return false
    end
    local newSettings = table.clone(settings)
    newSettings.maxMembers = Config.Players_number
    newSettings.isPrivate = false
    PartyCreationState.partySettings(newSettings)
    Remotes.CreateParty:FireServer(PartyCreationState.partySettings())
    partyCreated = true
    waitingForReservation = false
    stuckCheckStart = 0
    return true
  end

  function resetAndRetry()
    partyCreated = false
    waitingForReservation = false
    stuckCheckStart = 0
    local zone = getNextZone()
    if zone then
      teleportToZone(zone)
    end
  end

  if Config.Auto_create_party == true then
    task.spawn(function()
      teleportToZone(getPartyZones()[1])

      reservedConnection = Remotes.PartyZoneReserved.OnClientEvent:Connect(function()
        waitingForReservation = false
        if not partyCreated then
          task.wait(0.2)
          doCreateParty()
        end
      end)

      createdConnection = Remotes.CreateParty.OnClientEvent:Connect(function()
        partyCreated = true
        waitingForReservation = false
        stuckCheckStart = 0
      end)

      exitConnection = Remotes.ExitParty.OnClientEvent:Connect(function()
        partyCreated = false
        partyMembers = 0
        if Config.Auto_recreate_party then
          task.spawn(function()
            task.wait(0.5)
            resetAndRetry()
          end)
        end
      end)

      joinedConnection = Remotes.JoinnedParty.OnClientEvent:Connect(function()
        partyMembers += 1
      end)

      expiredConnection = Remotes.PartyZoneReservationExpired.OnClientEvent:Connect(function()
        partyCreated = false
        waitingForReservation = false
        stuckCheckStart = 0
        if Config.Auto_recreate_party then
          task.spawn(function()
            task.wait(0.3)
            resetAndRetry()
          end)
        end
      end)

      while Config.Auto_create_party do
        task.wait(0.3)

        if waitingForReservation and not partyCreated then
          if stuckCheckStart == 0 then
            stuckCheckStart = tick()
          elseif tick() - stuckCheckStart > 2 then
            resetAndRetry()
          end
        end

        if PartyCreationState.isOpen() and not partyCreated and not waitingForReservation then
          task.wait(0.2)
          doCreateParty()
        end

        if not partyCreated and not PartyCreationState.isOpen() and not waitingForReservation then
          if Config.Auto_recreate_party then
            resetAndRetry()
            task.wait(1)
          end
        end
      end

      if reservedConnection then reservedConnection:Disconnect() end
      if createdConnection then createdConnection:Disconnect() end
      if exitConnection then exitConnection:Disconnect() end
      if joinedConnection then joinedConnection:Disconnect() end
      if expiredConnection then expiredConnection:Disconnect() end
    end)
  end
else
  print("Please join: Game or Lobby, Dead rails")
end
