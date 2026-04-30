local List = {}

function List:CheckLevel()
  local MyLevel = game:GetService("Players").LocalPlayer:WaitForChild("Data"):WaitForChild("Level").Value
  
  if MyLevel >= 1 and MyLevel <= 9 then
    return {
      NameQuest = "BanditQuest1",
      NameMon = "Bandit",
      LevelQuest = 1,
      CFrameMon = CFrame.new(1045.962646484375, 27.00250816345215, 1560.8203125),
      CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231)
    }
  elseif MyLevel >= 10 and MyLevel <= 14 then
    return {
      NameQuest = "JungleQuest",
      NameMon = "Monkey",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-1448.51806640625, 67.85301208496094, 11.46579647064209),
      CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
    }
  elseif MyLevel >= 15 and MyLevel <= 29 then
    return {
      NameQuest = "JungleQuest",
      NameMon = "Gorilla",
      LevelQuest = 2,
      CFrameMon = CFrame.new(-1129.8836669921875, 40.46354675292969, -525.4237060546875),
      CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838)
    }
  elseif MyLevel >= 30 and MyLevel <= 39 then
    return {
      NameQuest = "BuggyQuest1",
      NameMon = "Pirate",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-1103.513427734375, 13.752052307128906, 3896.091064453125),
      CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
    }
  elseif MyLevel >= 40 and MyLevel <= 59 then
    return {
      NameQuest = "BuggyQuest1",
      NameMon = "Brute",
      LevelQuest = 2,
      CFrameMon = CFrame.new(-1140.083740234375, 14.809885025024414, 4322.92138671875),
      CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498)
    }
  elseif MyLevel >= 60 and MyLevel <= 74 then
    return {
      NameQuest = "DesertQuest",
      NameMon = "Desert Bandit",
      LevelQuest = 1,
      CFrameMon = CFrame.new(924.7998046875, 6.44867467880249, 4481.5859375),
      CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
    }
  elseif MyLevel >= 75 and MyLevel <= 89 then
    return {
      NameQuest = "DesertQuest",
      NameMon = "Desert Officer",
      LevelQuest = 2,
      CFrameMon = CFrame.new(1608.2822265625, 8.614224433898926, 4371.00732421875),
      CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359)
    }
  elseif MyLevel >= 90 and MyLevel <= 99 then
    return {
      NameQuest = "SnowQuest",
      NameMon = "Snow Bandit",
      LevelQuest = 1,
      CFrameMon = CFrame.new(1354.347900390625, 87.27277374267578, -1393.946533203125),
      CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
    }
  elseif MyLevel >= 100 and MyLevel <= 119 then
    return {
      NameQuest = "SnowQuest",
      NameMon = "Snowman",
      LevelQuest = 2,
      CFrameMon = CFrame.new(1201.6412353515625, 144.57958984375, -1550.0670166015625),
      CFrameQuest = CFrame.new(1389.74451, 88.1519318, -1298.90796)
    }
  elseif MyLevel >= 120 and MyLevel <= 149 then
    return {
      NameQuest = "MarineQuest2",
      NameMon = "Chief Petty Officer",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-4881.23095703125, 22.65204429626465, 4273.75244140625),
      CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018)
    }
  elseif MyLevel >= 150 and MyLevel <= 174 then
    return {
      NameQuest = "SkyQuest",
      NameMon = "Sky Bandit",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-4953.20703125, 295.74420166015625, -2899.22900390625),
      CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
    }
  elseif MyLevel >= 175 and MyLevel <= 189 then
    return {
      NameQuest = "SkyQuest",
      NameMon = "Dark Master",
      LevelQuest = 2,
      CFrameMon = CFrame.new(-5259.8447265625, 391.3976745605469, -2229.035400390625),
      CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165)
    }
  elseif MyLevel >= 190 and MyLevel <= 209 then
    return {
      NameQuest = "PrisonerQuest",
      NameMon = "Prisoner",
      LevelQuest = 1,
      CFrameMon = CFrame.new(5098.9736328125, -0.3204058110713959, 474.2373352050781),
      CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
    }
  elseif MyLevel >= 210 and MyLevel <= 249 then
    return {
      NameQuest = "PrisonerQuest",
      NameMon = "Dangerous Prisoner",
      LevelQuest = 2,
      CFrameMon = CFrame.new(5654.5634765625, 15.633401870727539, 866.2991943359375),
      CFrameQuest = CFrame.new(5308.93115, 1.65517521, 475.120514)
    }
  elseif MyLevel >= 250 and MyLevel <= 274 then
    return {
      NameQuest = "ColosseumQuest",
      NameMon = "Toga Warrior",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-1820.21484375, 51.68385696411133, -2740.6650390625),
      CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
    }
  elseif MyLevel >= 275 and MyLevel <= 299 then
    return {
      NameQuest = "ColosseumQuest",
      NameMon = "Gladiator",
      LevelQuest = 2,
      CFrameMon = CFrame.new(-1292.838134765625, 56.380882263183594, -3339.031494140625),
      CFrameQuest = CFrame.new(-1580.04663, 6.35000277, -2986.47534)
    }
  elseif MyLevel >= 300 and MyLevel <= 324 then
    return {
      NameQuest = "MagmaQuest",
      NameMon = "Military Soldier",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-5411.16455078125, 11.081554412841797, 8454.29296875),
      CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
    }
  elseif MyLevel >= 325 and MyLevel <= 374 then
    return {
      NameQuest = "MagmaQuest",
      NameMon = "Military Spy",
      LevelQuest = 2,
      CFrameMon = CFrame.new(-5802.8681640625, 86.26241302490234, 8828.859375),
      CFrameQuest = CFrame.new(-5313.37012, 10.9500084, 8515.29395)
    }
  elseif MyLevel >= 375 and MyLevel <= 399 then
    return {
      NameQuest = "FishmanQuest",
      NameMon = "Fishman Warrior",
      LevelQuest = 1,
      CFrameMon = CFrame.new(60878.30078125, 18.482830047607422, 1543.7574462890625),
      CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
    }
  elseif MyLevel >= 400 and MyLevel <= 449 then
    return {
      NameQuest = "FishmanQuest",
      NameMon = "Fishman Commando",
      LevelQuest = 2,
      CFrameMon = CFrame.new(61922.6328125, 18.482830047607422, 1493.934326171875),
      CFrameQuest = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
    }
  elseif MyLevel >= 450 and MyLevel <= 474 then
    return {
      NameQuest = "SkyExp1Quest",
      NameMon = "God's Guard",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-4710.04296875, 845.2769775390625, -1927.3079833984375),
      CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643)
    }
  elseif MyLevel >= 475 and MyLevel <= 524 then
    return {
      NameQuest = "SkyExp1Quest",
      NameMon = "Shanda",
      LevelQuest = 2,
      CFrameMon = CFrame.new(-7678.48974609375, 5566.40380859375, -497.2156066894531),
      CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196)
    }
  elseif MyLevel >= 525 and MyLevel <= 549 then
    return {
      NameQuest = "SkyExp2Quest",
      NameMon = "Royal Squad",
      LevelQuest = 1,
      CFrameMon = CFrame.new(-7624.25244140625, 5658.13330078125, -1467.354248046875),
      CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
    }
  elseif MyLevel >= 550 and MyLevel <= 624 then
    return {
      NameQuest = "SkyExp2Quest",
      NameMon = "Royal Soldier",
      LevelQuest = 2,
      CFrameMon = CFrame.new(-7836.75341796875, 5645.6640625, -1790.6236572265625),
      CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194)
    }
  elseif MyLevel >= 625 and MyLevel <= 649 then
    return {
      NameQuest = "FountainQuest",
      NameMon = "Galley Pirate",
      LevelQuest = 1,
      CFrameMon = CFrame.new(5551.02197265625, 78.90135192871094, 3930.412841796875),
      CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
    }
  elseif MyLevel >= 650 then
    return {
      NameQuest = "FountainQuest",
      NameMon = "Galley Captain",
      LevelQuest = 2,
      CFrameMon = CFrame.new(5441.95166015625, 42.50205993652344, 4950.09375),
      CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293)
    }
  end
end

return List
