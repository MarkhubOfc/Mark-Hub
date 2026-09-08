local Module = {}

function Module:CheckQuest()
  local LP = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Modules/Universal/General.luau"))():Service("Players").LocalPlayer
  local MyLevel = LP:WaitForChild("Data"):WaitForChild("Level").Value
  local Data = {
    MonName = "Bandit",
    QuestName = "BanditQuest1",
    QuestLevel = 1,
    QuestTitle = "Defeat 5 Bandits",
    QuestCFrame = CFrame.new(1052.93628, 15.1164293, 1551.85596, -0.961428165, -2.23723067e-08, 0.275056243, -2.2906379e-08, 1, 1.27053668e-09, -0.275056243, -5.07901277e-09, -0.961428165),
    MonCFrame = CFrame.new(1237.02576, 61.2648048, 1502.44153, -0.989115715, 9.5733796e-08, 0.147139624, 9.06752859e-08, 1, -4.10864445e-08, -0.147139624, -2.729732e-08, -0.989115715)
  }
  if MyLevel >= 0 and MyLevel <= 9 then
    Data = {
      MonName = "Bandit",
      QuestName = "BanditQuest1",
      QuestLevel = 1,
      QuestTitle = "Defeat 5 Bandits",
      QuestCFrame = CFrame.new(1052.93628, 15.1164293, 1551.85596, -0.961428165, -2.23723067e-08, 0.275056243, -2.2906379e-08, 1, 1.27053668e-09, -0.275056243, -5.07901277e-09, -0.961428165),
      MonCFrame = CFrame.new(1237.02576, 61.2648048, 1502.44153, -0.989115715, 9.5733796e-08, 0.147139624, 9.06752859e-08, 1, -4.10864445e-08, -0.147139624, -2.729732e-08, -0.989115715)
    }
  elseif MyLevel >= 10 then
    Data = {
      MonName = "Monkey",
      QuestName = "JungleQuest",
      QuestLevel = 1,
      QuestTitle = "Defeat 6 Monkeys",
      QuestCFrame = CFrame.new(1052.93628, 15.1164293, 1551.85596, -0.961428165, -2.23723067e-08, 0.275056243, -2.2906379e-08, 1, 1.27053668e-09, -0.275056243, -5.07901277e-09, -0.961428165),
      MonCFrame = CFrame.new(-1685.91577, 50.382988, 175.898087, 0.0419148728, -8.79960922e-08, -0.999121189, 2.60587041e-09, 1, -8.79641675e-08, 0.999121189, 1.08342679e-09, 0.0419148728)
    }
  end
  return Data
end

return Module
