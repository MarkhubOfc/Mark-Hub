local Module = {}

function Module:Check()
  local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
  local MyLevel = plr.LocalPlayer:WaitForChild('Data'):WaitForChild('Level').Value

  if MyLevel >= 0 and MyLevel <= 9 then
    return {
      MonName = 'Bandit',
      QName = 'BanditQuest1',
      QLevel = 1,
      QTitle = 'Defeat 5 Bandits',
      QPos = CFrame.new(1065, 17, 1546, 1, 0, 0, 0, 1, 0, 0, 0, 1),
      CPos = CFrame.new(1072.92896, 15.864502, 1354.30603, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
  elseif MyLevel >= 10 and MyLevel <= 14 then
    return {
      MonName = 'Monkey',
      QName = 'JungleQuest',
      QLevel = 1,
      QTitle = 'Defeat 6 Monkeys',
      QPos = CFrame.new(-1603, 37, 154),
      CPos = CFrame.new(-1609, 37, 127)
    }
  elseif MyLevel >= 15 and MyLevel <= 29 then
    return {
      MonName = 'Gorilla',
      QName = 'JungleQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Gorillas',
      QPos = CFrame.new(-1603, 37, 154),
      CPos = CFrame.new(-1325, 19, -551)
    }
  elseif MyLevel >= 30 then
    return {
      MonName = 'Pirate',
      QName = 'BuggyQuest1',
      QLevel = 1,
      QTitle = 'Defeat 8 Pirates',
      QPos = CFrame.new(-1140, 5, 3827),
      CPos = CFrame.new(-1208, 5, 3921)
    }
  end
end

--[[
  elseif MyLevel >= Number then
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
