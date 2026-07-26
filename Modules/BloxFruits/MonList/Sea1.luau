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
  elseif MyLevel >= 175 and MyLevel <= 189 then
    return {
      MonName = 'Dark Master',
      QName = 'SkyQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Dark Masters',
      QPos = CFrame.new(-4841, 718, -2622),
      CPos = CFrame.new(-5224, 430, -2279)
    }
  elseif MyLevel >= 190 and MyLevel <= 209 then
    return {
      MonName = 'Prisoner',
      QName = 'PrisonerQuest',
      QLevel = 1,
      QTitle = 'Defeat 8 Prisoners',
      QPos = CFrame.new(5306, 2, 474),
      CPos = CFrame.new(5044, 2, 514)
    }
  elseif MyLevel >= 210 and MyLevel <= 249 then
    return {
      MonName = 'Dangerous Prisoner',
      QName = 'PrisonerQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Dangerous Prisoners',
      QPos = CFrame.new(5306, 2, 474),
      CPos = CFrame.new(5596, 2, 610)
    }
  elseif MyLevel >= 250 and MyLevel <= 274 then
    return {
      MonName = 'Toga Warrior',
      QName = 'ColosseumQuest',
      QLevel = 1,
      QTitle = 'Defeat 7 Toga Warriors',
      QPos = CFrame.new(-1577.35046, 7.43121386, -2984.27515, 0.681490481, 2.8824866e-08, 0.731826961, 3.14892254e-08, 1, -6.87108823e-08, -0.731826961, 6.98704739e-08, 0.681490481),
      CPos = CFrame.new(-1786.38354, 41.178318, -2740.29297, 0.999907076, 8.20518622e-08, -0.0136341415, -8.12765464e-08, 1, 5.74200421e-08, 0.0136341415, -5.63065683e-08, 0.999907076)
    }
  elseif MyLevel >= 275 then
    return {
      MonName = 'Gladiator',
      QName = 'ColosseumQuest',
      QLevel = 2,
      QTitle = 'Defeat 7 Gladiators',
      QPos = CFrame.new(-1577.35046, 7.43121386, -2984.27515, 0.681490481, 2.8824866e-08, 0.731826961, 3.14892254e-08, 1, -6.87108823e-08, -0.731826961, 6.98704739e-08, 0.681490481),
      CPos = CFrame.new(-1385.80981, 7.48420763, -3279.99927, 0.24238883, 3.88813177e-08, 0.9701792, 4.34417693e-08, 1, -5.09298843e-08, -0.9701792, 5.44911352e-08, 0.24238883)
    }
  end
end

local Model = {
    {
      MonName = '', -- Target name <String>
      QName = '', -- Quest name <String>
      QLevel = , -- Quest level <Number>
      QTitle = 'Defeat ', -- Quest title <String>
      QPos = CFrame.new(), -- Quest cframe <CFrame>
      CPos = CFrame.new() -- No mon cframe <CFrame>
    }
}

return Module
