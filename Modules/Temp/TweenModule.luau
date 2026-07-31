local Lib = {}

-- R6 Module
local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
local TS = (cloneref and cloneref(game:GetService('TweenService')) or game:GetService('TweenService'))
local RS = (cloneref and cloneref(game:GetService('RunService')) or game:GetService('RunService'))

local LP = plr.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild('HumanoidRootPart')
local Humanoid = Char:WaitForChild('Humanoid')
local Torso = Char:WaitForChild('Torso')
LP.CharacterAdded:Connect(function(V)
  Char = V
  HRP = V:WaitForChild('HumanoidRootPart')
  Humanoid = V:WaitForChild('Humanoid')
  Torso = V:WaitForChild('Torso')
end)

function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end 

function Lib:Init()
  if not HRP:FindFirstChild('Stab') then
    new('BodyVelocity', {
      Name = 'Stab',
      Velocity = Vector3.zero,
      MaxForce = Vector3.one * math.huge,
      Parent = HRP
    })
  end
end

function Lib:Clear()
  if HRP:FindFirstChild('Stab') then
    HRP.Stab:Destroy()
  end
end

local NoclipParts = {}
local NoclipConnection = nil
function Lib:Noclip(Value)
  if Value == false then
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
    
    NoclipConnection = RS.Stepped:Connect(function()
      for _, instance in ipairs(Char:GetDescendants()) do
        if instance:IsA('BasePart') and instance.CanCollide == true then
          instance.CanCollide = false
          table.insert(NoclipParts, instance)
        end
      end
    end)
  end
end

local CurrentTween = nil
function Lib:TweenTo(Args)
  local CFrame = Args[1] or Args.CF or Args.CFrame or Args.Pos or Args.Position or Args.Goto or Args.GotoPos or CFrame.new(0, 0, 0)
  local Speed = Args[2] or Args.Speed or Args.SpeedValue or 50
  if CFrame and Speed then
    if HRP then
      if Humanoid and Humanoid.Health > 0 then
        local Time = ((typeof(CFrame) == 'CFrame' and CFrame.Position or CFrame) - HRP.Position).Magnitude / Speed
        local Info = TweenInfo.new(Time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        
        Lib:Init()
        CurrentTween = TS:Create(
          HRP,
          Info,
          {
            CFrame = (typeof(CFrame) == 'CFrame' and CFrame or CFrame.new(CFrame))
          }
        )
        CurrentTween:Play()
      end
    end
  end
end

function Lib:CancelTween()
  Lib:Clear()
  if CurrentTween then
    CurrentTween:Cancel()
    CurrentTween = nil
  end
  Lib:Clear()
end

function Lib:GetActiveTween()
  return CurrentTween
end

return Lib
