local Module = {}

function Module:Check()
  local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
  local MyLevel = plr.LocalPlayer:WaitForChild('Data'):WaitForChild('Level').Value

  if (MyLevel >= 0 or MyLevel <= 9) then
    return {
      MonName = 'Bandit',
      QName = 'BanditQuest1',
      QLevel = 1,
      QTitle = 'Defeat 5 Bandits',
      QPos = CFrame.new(1065, 17, 1546, 1, 0, 0, 0, 1, 0, 0, 0, 1),
      CPos = CFrame.new(1072.92896, 15.864502, 1354.30603, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
  elseif (MyLevel >= 10) then
    return {
      MonName = 'Monkey',
      QName = 'JungleQuest',
      QLevel = 1,
      QTitle = 'Defeat 6 Monkeys',
      QPos = CFrame.new(-1603, 37, 154, 1, 0, 0, 0, 1, 0, 0, 0, 1),
      CPos = CFrame.new(-1609, 37, 127, 1, 0, 0, 0, 1, 0, 0, 0, 1)
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

--[[
  elseif (MyLevel >= Number) then
    return {
      MonName = 'Mon name',
      QName = 'Quest Name',
      QLevel = Quest level,
      QTitle = 'Defeat Number Mon',
      QPos = CFrame.new(Quest cframe),
      CPos = CFrame.new(No mon cframe)
    }
]]

return Module
