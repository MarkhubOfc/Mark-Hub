local Module = {}

function Module.Check()
  local MyLevel = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players')).LocalPlayer:WaitForChild('Data'):WaitForChild('Level').Value
  if (MyLevel >= 0 or MyLevel <= 9) then
    return {
      MonName = 'Bandit',
      CPos = CFrame.new(1072.92896, 15.864502, 1354.30603, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
  end
end

return Module
