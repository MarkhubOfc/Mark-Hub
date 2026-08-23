--[[
getgenv().Game_config = {
  Auto_reset = true,
  Auto_teleport = true,
  Only_drop_bond = false
}

getgenv().Lobby_config = {
  Players_number = 1,
  Auto_create_party = true
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Games/Dead%20Rails/Auto%20bond.luau"))()
]]

if game.PlaceId == 70876832253163 then
  local Config = {
    Auto_reset = getgenv().Game_config.Auto_reset,
    Auto_teleport = getgenv().Game_config.Auto_teleport,
    Only_drop_bond = getgenv().Game_config.Only_drop_bond
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
            task.wait(0.05)
            Remotes.Store:FireServer()
            task.wait(0.05)
            if Config.Only_drop_bond == false then
              Event:FireServer(sr)
            end
            
            CollectedBond += 1
            BondLabel.Text = "Bond(s): " .. CollectedBond or 0
            task.wait(0.10)
          end
        end
      end
    end
  end)
  
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
  
  task.wait(30)
  if Config.Auto_reset == true then
    LP.Character:WaitForChild("Humanoid").Health = 0
  end
  if Config.Auto_teleport == true then
    -- StatusLabel.Text = "Status: Teleport to (Lobby)"
    TeleportService:Teleport(116495829188952, LP)
  end
elseif game.PlaceId == 116495829188952 then
  
else
  print("Please join: Game or Lobby, Dead rails")
end
