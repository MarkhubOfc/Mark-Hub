local Module = {}

function Module:Check()
  local MyLevel = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players')).LocalPlayer:WaitForChild('Data'):WaitForChild('Level').Value
  if (MyLevel >= 0) then
    return {
      MonName = 'Bandit',
      QName = 'BanditQuest1',
      QLevel = 1,
      QTitle = 'Defeat 5 Bandits',
      QPos = CFrame.new(1065, 17, 1546, 1, 0, 0, 0, 1, 0, 0, 0, 1),
      CPos = CFrame.new(1072.92896, 15.864502, 1354.30603, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
  else
    return {
      MonName = 'Bandit',
      QName = 'BanditQuest1',
      QLevel = 1,
      QTitle = 'Defeat 5 Bandits',
      QPos = CFrame.new(1065, 17, 1546, 1, 0, 0, 0, 1, 0, 0, 0, 1),
      CPos = CFrame.new(1072.92896, 15.864502, 1354.30603, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
  end
end

return Module
