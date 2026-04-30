local List = {}

function List:CheckLevel()
  local MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
  
  if MyLevel >= 1 and MyLevel <= 9 then
    return {
      QuestName = "BanditQuest1",
      QuestLvl = 1,
      EnemyName = "Bandit",
      fPos = CFrame.new(1228, 63, 1515),
      QuestPos = CFrame.new(1063, 17, 1547)
    }
  elseif MyLevel >= 10 and MyLevel <= 14 then
    return {
      QuestName = "JungleQuest",
      QuestLvl = 1,
      EnemyName = "Monkey",
      fPos = CFrame.new(-1448, 48, 58),
      QuestPos = CFrame.new(-1603, 37, 153)
    }
  elseif MyLevel >= 15 and MyLevel <= 19 then
    return {
      QuestName = "JungleQuest",
      QuestLvl = 2,
      EnemyName = "Gorilla",
      fPos = CFrame.new(-1328, 19, -543),
      QuestPos = CFrame.new(-1603, 37, 153)
    }
  elseif MyLevel >= 20 then
    return {
      QuestName = "JungleQuest",
      QuestLvl = 3,
      EnemyName = "The Gorilla King",
      fPos = CFrame.new(-1328, 19, -543),
      QuestPos = CFrame.new(-1603, 37, 153)
    }
  end
end

return List
