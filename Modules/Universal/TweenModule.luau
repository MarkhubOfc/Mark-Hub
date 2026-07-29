local TweenModule = {}
local TS = game:GetService('TweenService')
local Players = game:GetService('Players')

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild('HumanoidRootPart')
local Humanoid = Char:WaitForChild('Humanoid')
local TorsoPart = nil
local Mode = 'R15'

local CurrentTween = nil
local function new(c, p)
	local k = Instance.new(c)
	for pp, v in pairs(p or {}) do
		k[pp] = v
	end
	return k
end

local function UpdateCharacterReferences()
	if not LP.Character then return end
	Char = LP.Character
	HRP = Char:WaitForChild('HumanoidRootPart', 5)
	Humanoid = Char:WaitForChild('Humanoid', 5)
	if Mode == 'R6' then
		TorsoPart = Char:FindFirstChild('Torso')
	elseif Mode == 'R15' then
		TorsoPart = Char:FindFirstChild('UpperTorso')
	end
end

LP.CharacterAdded:Connect(UpdateCharacterReferences)
UpdateCharacterReferences()

function TweenModule:SetGameMode(mode)
	if mode == 'R6' or mode == 'R15' then
		Mode = mode
		UpdateCharacterReferences()
	end
end

function TweenModule:SetNoclip(Value)
	
end

function TweenModule:TweenTo(Config)
	local TweenCframe = Config[1] or Config.CF or Config.CFrame or Config.Pos or Config.Position
	local TweenSpeed = Config[2] or Config.Speed or Config.S or 250
	
	if HRP and TweenCframe then
		local dist = (TweenCframe.Position - HRP.Position).Magnitude
		local time = dist / TweenSpeed
		local info = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		local goal = {CFrame = TweenCframe}
		CurrentTween = TS:Create(HRP, info, goal)
		if not HRP:FindFirstChild('StabDontDelete') then
			new('BodyVelocity', {
				Name = 'StabDontDelete',
				Velocity = Vector3.zero,
				MaxForce = Vector3.new(40000, 40000, 40000),
				Parent = HRP
			})
		end
		CurrentTween:Play()
		if TorsoPart then
			TorsoPart.CanCollide = false
		end
		CurrentTween.Completed:Connect(function()
			CurrentTween = nil
			if HRP:FindFirstChild('StabDontDelete') then
				HRP:FindFirstChild('StabDontDeleted'):Destroy()
			elseif HRP:FindFirstChild('StabDontDelete') then
				HRP.StabDontDelete:Destroy()
			end
			if CurrentTween then
				CurrentTween:Cancel()
				CurrentTween = nil
			end
			if TorsoPart then
				if TorsoPart.CanCollide == false then
					TorsoPart.CanCollide = true
				end
			end
		end)
	end
	return CurrentTween
end

function TweenModule:GetActiveTween()
	return CurrentTween
end

function TweenModule:CancelTween()
    local FlyBV = HRP:FindFirstChild('StabDontDeleted')
	if FlyBV then
		FlyBV:Destroy()
		FlyBV = nil
	elseif HRP and HRP:FindFirstChild('StabDontDelete') then
		HRP.StabDontDelete:Destroy()
	end
	if CurrentTween then
		CurrentTween:Cancel()
		CurrentTween = nil
	end
	if TorsoPart then
		if TorsoPart.CanCollide == false then
			TorsoPart.CanCollide = true
		end
	end
end

return TweenModule
