local Lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/MarkhubOfc/Librarys/refs/heads/main/RedzLib/V5/Source.lua'))()

local Window = Lib:MakeWindow({
  Title = "Zynkore hub : Flee The Facility",
  SubTitle = "By Zynkore",
  SaveFolder = "ZynkoreHub/Settings.json"
})

function serv(S)
  return game:GetService(S) or {}
end

local plr = serv('Players')
local RS = serv('RunService')
local WS = serv('Workspace')
local RST = serv('ReplicatedStorage')
local LP = plr.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
LP.CharacterAdded:Connect(function(char)
  Char = char
end)

function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end

local InfoTab = Window:MakeTab({
  Title = 'Info',
  Icon = 'User'
})
InfoTab:AddSection({'Hub'})

InfoTab:AddParagraph({
  'Info',
  [[
   [+] - Added
   [-] - Removed
   [!] - Fixed
   [÷] - Bug/Detected
   [?] - No update
  ]]
})

InfoTab:AddParagraph({
  'Added:',
  [[
   [+] Update de linguagens, se eu tou errado foi mal
  ]]
})

local MainTab = Window:MakeTab({
  Title = 'Main',
  Icon = 'Home'
})
MainTab:AddSection({'Beast'})

local Auto_Hit_nearest_plr
MainTab:AddToggle({
  Title = 'Auto marretar o player mais próximo',
  Description = 'Apenas a fera | Distância: 10 studs',
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
  Title = 'Auto amarrar player mais próximo',
  Description = 'Apenas a fera | Distancia: 10 studs',
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
  Description = 'Sem stun ( Beast )',
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
MainTab:AddSection({'Survivor'})

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
  Description = "Olá mano!",
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
MainTab:AddSection({'Players'})

local Auto_Delay = 0.05
local Auto_Last = 0

local Auto_Interact
MainTab:AddToggle({
  Title = 'Auto interagir',
  Description = 'Sem descrição',
  Default = false,
  Flag = 'Auto-interact',
  Callback = function(V)
    if V then
      Auto_Interact = RS.Heartbeat:Connect(function()
        if time() - Auto_Last < Auto_Delay then
          return
        end
        Auto_Last = time()
         
        local args = {
          "Input",
          "Action",
          true
        }
        game:GetService("ReplicatedStorage"):WaitForChild("RemoteEvent"):FireServer(unpack(args))
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
EspTab:AddSection({'Players'})

local Esp_Beast
EspTab:AddToggle({
  Title = 'Fera',
  Description = 'Criar um esp para a fera',
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
  Title = 'Sobrevivente',
  Description = 'Criar um esp para o sobrevivente(s)',
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
EspTab:AddSection({'Map'})

local Esp_Computer
EspTab:AddToggle({
  Title = 'Computador',
  Description = 'Criar um esp para o computador(es)',
  Default = false,
  Flag = 'Esp-Computer',
  Callback = function(V)
    if V then
      for _, obj in pairs(WS:GetDescendants()) do
        if obj.Name == 'ComputerTable' then
          if obj:IsA('Model') then
            if not obj:FindFirstChild('Esp_Computer') then
              local esp = new('Highlight', {
                Name = 'Esp_Computer',
                FillColor = obj:WaitForChild('Screen').Color,
                FillTransparency = 0.6,
                Parent = obj
              })
              
              if obj:WaitForChild('Screen') then
                obj.Screen:GetPropertyChangedSignal('Color'):Connect(function()
                  esp.FillColor = obj.Screen.Color
                end)
              end
            end
          end
        end
      end
      
      Esp_Computer = WS.DescendantAdded:Connect(function(obj)
        if obj.Name == 'ComputerTable' then
          if obj:IsA('Model') then
            if not obj:FindFirstChild('Esp_Computer') then
              local esp = new('Highlight', {
                Name = 'Esp_Computer',
                FillColor = obj:WaitForChild('Screen').Color,
                FillTransparency = 0.6,
                Parent = obj
              })
              
              if obj:WaitForChild('Screen') then
                obj.Screen:GetPropertyChangedSignal('Color'):Connect(function()
                  esp.FillColor = obj.Screen.Color
                end)
              end
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
  Title = 'Congelador',
  Description = 'Criar um esp para o congelado(res)',
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

local ExtraTab = Window:MakeTab({'Extra'})
ExtraTab:AddSection({'Visual'})

ExtraTab:AddButton({
  Title = 'Remover neblina',
  Callback = function()
    game:GetService("Lighting").Atmosphere.Density = 0
  end
})

local NoFog
ExtraTab:AddToggle({
  Title = 'Sem neblina',
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
ExtraTab:AddSection({'Game'})

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
  Description = 'Anti lag ( Textura de baixa qualidade)',
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

ExtraTab:AddSection({'Test'})

local Open_Btn = new('ScreenGui', {
  Name = 'Open button',
  Parent = gethui and gethui() or game.CoreGui
})

local Drag_and_click_btn = new('TextButton', {
  Name = 'Drag and click btn',
  Size = UDim2.new(0, 35, 0, 35),
  Position = UDim2.new(0.5, 0, 0.5, 0),
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
