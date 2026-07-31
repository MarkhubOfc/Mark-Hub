local Lib = {}

-- R6 Module
local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
local TS = (cloneref and cloneref(game:GetService('TweenService')) or game:GetService('TweenService'))

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
      Velocity = Vector2.zero,
      MaxForce = Vector2.one * math.huge,
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
    
    NoclipConnection = RunService.Stepped:Connect(function()
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
        local Time = (CFrame.Position - HRP.Position).Magnitude / Speed
        local Info = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        
        CurrentTween = TS:Create(
          HRP,
          Info,
          {
            CFrame = (typeof(CFrame) == 'CFrame' and CFrame or CFrame.new(CFrame))
          }
        )
      end
    end
  end
end

function Lib:CancelTween()
  Clear()
  if CurrentTween then
    CurrentTween:Cancel()
    CurrentTween = nil
  end
  Clear()
end

function Lib:GetActiveTween()
  return CurrentTween
end

return Lib
