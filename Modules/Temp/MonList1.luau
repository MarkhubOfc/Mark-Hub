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
  elseif MyLevel >= 30 and MyLevel <= 39 then
    return {
      MonName = 'Pirate',
      QName = 'BuggyQuest1',
      QLevel = 1,
      QTitle = 'Defeat 8 Pirates',
      QPos = CFrame.new(-1140, 5, 3827),
      CPos = CFrame.new(-1208, 5, 3921)
    }
  elseif MyLevel >= 40 and MyLevel <= 59 then
    return {
      MonName = 'Brute',
      QName = 'BuggyQuest1',
      QLevel = 2,
      QTitle = 'Defeat 8 Brutes',
      QPos = CFrame.new(-1140, 5, 3827),
      CPos = CFrame.new(-1124, 15, 4295)
    }
  elseif MyLevel >= 60 and MyLevel <= 74 then
    return {
      MonName = 'Desert Bandit',
      QName = 'DesertQuest',
      QLevel = 1,
      QTitle = 'Defeat 8 Desert Bandits',
      QPos = CFrame.new(897, 6, 4388),
      CPos = CFrame.new(958, 15, 4401)
    }
  elseif MyLevel >= 75 and MyLevel <= 89 then
    return {
      MonName = 'Desert Officer',
      QName = 'DesertQuest',
      QLevel = 2,
      QTitle = 'Defeat 6 Desert Officers',
      QPos = CFrame.new(897, 6, 4388),
      CPos = CFrame.new(1567, 10, 4369)
    }
  elseif MyLevel >= 90 and MyLevel <= 99 then
    return {
      MonName = 'Snow Bandit',
      QName = 'SnowQuest',
      QLevel = 1,
      QTitle = 'Defeat 7 Snow Bandits',
      QPos = CFrame.new(1384, 87, -1294),
      CPos = CFrame.new(1372, 103, -1405)
    }
  elseif MyLevel >= 100 and MyLevel <= 119 then
    return {
      MonName = 'Snowman',
      QName = 'SnowQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Snowmans',
      QPos = CFrame.new(1384, 87, -1294),
      CPos = CFrame.new(1158, 107, -1503)
    }
  elseif MyLevel >= 120 and MyLevel <= 149 then
    return {
      MonName = 'Chief Petty Officer',
      QName = 'MarineQuest2',
      QLevel = 1,
      QTitle = 'Defeat 8 Chief Petty Officers',
      QPos = CFrame.new(-5036, 29, 4325),
      CPos = CFrame.new(-4922, 21, 3997)
    }
  elseif MyLevel >= 150 and MyLevel <= 174 then
    return {
      MonName = 'Sky Bandit',
      QName = 'SkyQuest',
      QLevel = 1,
      QTitle = 'Defeat 7 Sky Bandits',
      QPos = CFrame.new(-4841, 718, -2622),
      CPos = CFrame.new(-4956, 296, -2901)
    }
  elseif MyLevel >= 175 then
    return {
      MonName = 'Dark Master',
      QName = 'SkyQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Dark Masters',
      QPos = CFrame.new(-4841, 718, -2622),
      CPos = CFrame.new(-5224, 430, -2279)
    }
  end
end

return Module
