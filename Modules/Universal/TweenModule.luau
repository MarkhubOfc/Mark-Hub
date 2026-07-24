local TweenModule = {}
local TS = game:GetService('TweenService')
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')

local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local HRP = Char:WaitForChild('HumanoidRootPart')
local Humanoid = Char:WaitForChild('Humanoid')
local Mode = 'R15'

local CurrentTween = nil
local FlyBV = nil
local NoclipConnection = nil
local NoclipParts = {}
local TweenId = 0

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
end

LP.CharacterAdded:Connect(function()
	TweenModule:CancelTween()
	UpdateCharacterReferences()
end)
UpdateCharacterReferences()

function TweenModule:SetGameMode(mode)
	if mode == 'R6' or mode == 'R15' then
		Mode = mode
	end
end

function TweenModule:TweenTo(Config)
	if CurrentTween then
		local t = CurrentTween
		CurrentTween = nil
		t:Cancel()
	end
	
	TweenId = TweenId + 1
	local MyId = TweenId
	
	local TweenCframe = Config[1] or Config.CF or Config.CFrame or Config.Pos or Config.Position
	local TweenSpeed = Config[2] or Config.Speed or Config.S or 250
	
	if HRP and TweenCframe then
		local dist = (TweenCframe.Position - HRP.Position).Magnitude
		local time = math.max(dist / TweenSpeed, 0.05)
		local info = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
		local goal = {CFrame = TweenCframe}
		
		if not FlyBV then
			FlyBV = new('BodyVelocity', {
				Name = 'StabDontDelete',
				Velocity = Vector3.zero,
				MaxForce = Vector3.new(40000, 40000, 40000),
				Parent = HRP
			})
		end
		
		if not NoclipConnection then
			NoclipParts = {}
			for _, part in ipairs(Char:GetDescendants()) do
				if part:IsA('BasePart') and part.CanCollide and (part.Parent == Char or part:FindFirstAncestorOfClass('Accessory')) then
					part.CanCollide = false
					table.insert(NoclipParts, part)
				end
			end
			NoclipConnection = RunService.Stepped:Connect(function()
				if not Char then return end
				for _, part in ipairs(Char:GetDescendants()) do
					if part:IsA('BasePart') and part.CanCollide and (part.Parent == Char or part:FindFirstAncestorOfClass('Accessory')) then
						part.CanCollide = false
						table.insert(NoclipParts, part)
					end
				end
			end)
		end
		
		CurrentTween = TS:Create(HRP, info, goal)
		CurrentTween:Play()
		
		CurrentTween.Completed:Connect(function(state)
			if CurrentTween and TweenId == MyId and state == Enum.PlaybackState.Completed then
				TweenModule:CancelTween()
			end
		end)
	end
	return CurrentTween
end

function TweenModule:GetActiveTween()
	return CurrentTween
end

function TweenModule:CancelTween()
	TweenId = TweenId + 1
	
	if NoclipConnection then
		NoclipConnection:Disconnect()
		NoclipConnection = nil
	end
	for _, part in ipairs(NoclipParts) do
		if part and part.Parent then part.CanCollide = true end
	end
	NoclipParts = {}
	
	if FlyBV then
		FlyBV:Destroy()
		FlyBV = nil
	end
	if HRP and HRP:FindFirstChild('StabDontDelete') then
		HRP.StabDontDelete:Destroy()
	end
	
	if CurrentTween then
		local t = CurrentTween
		CurrentTween = nil
		t:Cancel()
	end
end

return TweenModule
