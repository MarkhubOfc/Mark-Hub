local Module = {}

function Module:Check()
  local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
  local WS = (cloneref and cloneref(game:GetService('Workspace')) or game:GetService('Workspace'))
  
  -- Local player Data
  local MyLevel = plr.LocalPlayer:WaitForChild('Data'):WaitForChild('Level').Value
  if MyLevel >= 0 and MyLevel <= 9 then
    return {
      SpecialId = 0,
      MonName = 'Bandit',
      QName = 'BanditQuest1',
      QLevel = 1,
      QTitle = 'Defeat 5 Bandits',
      QPos = CFrame.new(1065, 17, 1546, 1, 0, 0, 0, 1, 0, 0, 0, 1),
      CPos = CFrame.new(1072.92896, 15.864502, 1354.30603, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    }
  elseif MyLevel >= 10 and MyLevel <= 14 then
    return {
      SpecialId = 0,
      MonName = 'Monkey',
      QName = 'JungleQuest',
      QLevel = 1,
      QTitle = 'Defeat 6 Monkeys',
      QPos = CFrame.new(-1603, 37, 154),
      CPos = CFrame.new(-1609, 37, 127)
    }
  elseif MyLevel >= 15 and MyLevel <= 29 then
    return {
      SpecialId = 0,
      MonName = 'Gorilla',
      QName = 'JungleQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Gorillas',
      QPos = CFrame.new(-1603, 37, 154),
      CPos = CFrame.new(-1325, 19, -551)
    }
  elseif MyLevel >= 30 and MyLevel <= 39 then
    return {
      SpecialId = 0,
      MonName = 'Pirate',
      QName = 'BuggyQuest1',
      QLevel = 1,
      QTitle = 'Defeat 8 Pirates',
      QPos = CFrame.new(-1140, 5, 3827),
      CPos = CFrame.new(-1208, 5, 3921)
    }
  elseif MyLevel >= 40 and MyLevel <= 59 then
    return {
      SpecialId = 0,
      MonName = 'Brute',
      QName = 'BuggyQuest1',
      QLevel = 2,
      QTitle = 'Defeat 8 Brutes',
      QPos = CFrame.new(-1140, 5, 3827),
      CPos = CFrame.new(-1124, 15, 4295)
    }
  elseif MyLevel >= 60 and MyLevel <= 74 then
    return {
      SpecialId = 0,
      MonName = 'Desert Bandit',
      QName = 'DesertQuest',
      QLevel = 1,
      QTitle = 'Defeat 8 Desert Bandits',
      QPos = CFrame.new(897, 6, 4388),
      CPos = CFrame.new(958, 15, 4401)
    }
  elseif MyLevel >= 75 and MyLevel <= 89 then
    return {
      SpecialId = 0,
      MonName = 'Desert Officer',
      QName = 'DesertQuest',
      QLevel = 2,
      QTitle = 'Defeat 6 Desert Officers',
      QPos = CFrame.new(897, 6, 4388),
      CPos = CFrame.new(1567, 10, 4369)
    }
  elseif MyLevel >= 90 and MyLevel <= 99 then
    return {
      SpecialId = 0,
      MonName = 'Snow Bandit',
      QName = 'SnowQuest',
      QLevel = 1,
      QTitle = 'Defeat 7 Snow Bandits',
      QPos = CFrame.new(1384, 87, -1294),
      CPos = CFrame.new(1372, 103, -1405)
    }
  elseif MyLevel >= 100 and MyLevel <= 119 then
    return {
      SpecialId = 0,
      MonName = 'Snowman',
      QName = 'SnowQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Snowmans',
      QPos = CFrame.new(1384, 87, -1294),
      CPos = CFrame.new(1158, 107, -1503)
    }
  elseif MyLevel >= 120 and MyLevel <= 149 then
    return {
      SpecialId = 0,
      MonName = 'Chief Petty Officer',
      QName = 'MarineQuest2',
      QLevel = 1,
      QTitle = 'Defeat 8 Chief Petty Officers',
      QPos = CFrame.new(-5036, 29, 4325),
      CPos = CFrame.new(-4922, 21, 3997)
    }
  elseif MyLevel >= 150 and MyLevel <= 174 then
    return {
      SpecialId = 0,
      MonName = 'Sky Bandit',
      QName = 'SkyQuest',
      QLevel = 1,
      QTitle = 'Defeat 7 Sky Bandits',
      QPos = CFrame.new(-4841, 718, -2622),
      CPos = CFrame.new(-4956, 296, -2901)
    }
  elseif MyLevel >= 175 and MyLevel <= 189 then
    return {
      SpecialId = 0,
      MonName = 'Dark Master',
      QName = 'SkyQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Dark Masters',
      QPos = CFrame.new(-4841, 718, -2622),
      CPos = CFrame.new(-5224, 430, -2279)
    }
  elseif MyLevel >= 190 and MyLevel <= 209 then
    return {
      SpecialId = 0,
      MonName = 'Prisoner',
      QName = 'PrisonerQuest',
      QLevel = 1,
      QTitle = 'Defeat 8 Prisoners',
      QPos = CFrame.new(5306, 2, 474),
      CPos = CFrame.new(5044, 2, 514)
    }
  elseif MyLevel >= 210 and MyLevel <= 249 then
    return {
      SpecialId = 0,
      MonName = 'Dangerous Prisoner',
      QName = 'PrisonerQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Dangerous Prisoners',
      QPos = CFrame.new(5306, 2, 474),
      CPos = CFrame.new(5596, 2, 610)
    }
  elseif MyLevel >= 250 and MyLevel <= 274 then
    return {
      SpecialId = 0,
      MonName = 'Toga Warrior',
      QName = 'ColosseumQuest',
      QLevel = 1,
      QTitle = 'Defeat 7 Toga Warriors',
      QPos = CFrame.new(-1577.35046, 7.43121386, -2984.27515, 0.681490481, 2.8824866e-08, 0.731826961, 3.14892254e-08, 1, -6.87108823e-08, -0.731826961, 6.98704739e-08, 0.681490481),
      CPos = CFrame.new(-1786.38354, 41.178318, -2740.29297, 0.999907076, 8.20518622e-08, -0.0136341415, -8.12765464e-08, 1, 5.74200421e-08, 0.0136341415, -5.63065683e-08, 0.999907076)
    }
  elseif MyLevel >= 275 and MyLevel <= 299 then
    return {
      SpecialId = 0,
      MonName = 'Gladiator',
      QName = 'ColosseumQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Gladiators',
      QPos = CFrame.new(-1577.35046, 7.43121386, -2984.27515, 0.681490481, 2.8824866e-08, 0.731826961, 3.14892254e-08, 1, -6.87108823e-08, -0.731826961, 6.98704739e-08, 0.681490481),
      CPos = CFrame.new(-1385.80981, 7.48420763, -3279.99927, 0.24238883, 3.88813177e-08, 0.9701792, 4.34417693e-08, 1, -5.09298843e-08, -0.9701792, 5.44911352e-08, 0.24238883)
    }
  elseif MyLevel >= 300 and MyLevel <= 324 then
    return {
      SpecialId = 0,
      MonName = 'Military Soldier',
      QName = 'MagmaQuest',
      QLevel = 1,
      QTitle = 'Defeat 7 Military Soldiers',
      QPos = CFrame.new(-5316.13721, 12.2790842, 8516.93457, 0.561972737, -1.36195561e-08, -0.827155769, 5.75840744e-08, 1, 2.26573089e-08, 0.827155769, -6.03637886e-08, 0.561972737),
      CPos = CFrame.new(-5402.39111, 23.8708324, 8511.2666, 0.559043229, -2.01662527e-08, -0.829138517, -5.96194738e-08, 1, -6.45201155e-08, 0.829138517, 8.55023359e-08, 0.559043229)
    }
  elseif MyLevel >= 325 and MyLevel <= 374 then
    return {
      SpecialId = 0,
      MonName = 'Military Spy',
      QName = 'MagmaQuest',
      QLevel = 2,
      QTitle = 'Defeat 8 Military Spys',
      QPos = CFrame.new(-5316.13721, 12.2790842, 8516.93457, 0.561972737, -1.36195561e-08, -0.827155769, 5.75840744e-08, 1, 2.26573089e-08, 0.827155769, -6.03637886e-08, 0.561972737),
      CPos = CFrame.new(-5798.00635, 97.9792938, 8805.15137, -0.162153482, -1.86368414e-08, 0.986765563, 6.42401021e-09, 1, 1.99424441e-08, -0.986765563, 9.57272928e-09, -0.162153482)
    }
  elseif MyLevel >= 375 and MyLevel <= 399 then
    return {
      SpecialId = 1,
      MonName = 'Fishman Warrior',
      QName = 'FishmanQuest',
      QLevel = 1,
      QTitle = 'Defeat 8 Fishman Warriors',
      QPos = CFrame.new(61122.4844, 18.5134315, 1569.41138, 0.965646863, -5.98844423e-08, 0.259857982, 3.17008322e-08, 1, 1.12648593e-07, -0.259857982, -1.00541044e-07, 0.965646863),
      CPos = CFrame.new(60943.7188, 48.7146912, 1552.30688, -0.995199919, 9.07342752e-08, 0.0978628993, 9.07112465e-08, 1, -4.68461536e-09, -0.0978628993, 4.21513668e-09, -0.995199919)
    }
  elseif MyLevel >= 400 and MyLevel <= 449 then
    return {
      SpecialId = 1,
      MonName = 'Fishman Commando',
      QName = 'FishmanQuest',
      QLevel = 2,
      QTitle = 'Defeat 7 Fishman Commandos',
      QPos = CFrame.new(61122.4844, 18.5134315, 1569.41138, 0.965646863, -5.98844423e-08, 0.259857982, 3.17008322e-08, 1, 1.12648593e-07, -0.259857982, -1.00541044e-07, 0.965646863),
      CPos = CFrame.new(61868.8906, 75.5137024, 1406.24072, -0.992563665, 2.19734844e-08, 0.121726699, 2.63579469e-08, 1, 3.44086857e-08, -0.121726699, 3.7361275e-08, -0.992563665)
    }
  elseif MyLevel >= 450 then
    return {
      SpecialId = 0,
      MonName = "God's Guard",
      QName = 'SkyExp1Quest',
      QLevel = 1,
      QTitle = "Defeat 7 God's Guards",
      QPos = CFrame.new(-4721.9917, 845.318542, -1954.87976, -0.999318779, 1.9976083e-08, -0.0369044468, 1.56465472e-08, 1, 1.17606234e-07, 0.0369044468, 1.16948691e-07, -0.999318779),
      CPos = CFrame.new(-4718.56201, 852.011902, -1930.24744, -0.938789725, 1.51794044e-08, -0.344490677, 1.44443719e-08, 1, 4.70020378e-09, 0.344490677, -5.63448399e-10, -0.938789725)
    }
  end
end

local Model = {
    {
      SpecialId = 0, -- Id, 0 = not special
      MonName = '', -- Target name
      QName = '', -- Quest name
      QLevel = 1, -- Quest level
      QTitle = 'Defeat ', -- Quest title
      QPos = CFrame.new(0, 0, 0), -- Quest cframe
      CPos = CFrame.new(0, 0, 0) -- No mon cframe
    }
}

return Module
