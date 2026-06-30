local Module = {}

function Module:CheckLevel()
  local MyLevel = game:GetService("Players").LocalPlayer:WaitForChild('Data'):WaitForChild('Level').Value

  if MyLevel >= 0 then
    return {
      MonName = 'Thief',
      MonValue = 5,
      QuestName = 'QuestNPC1',
      QuestTitle = 'Thief Hunter',
      QuestCFrame = CFrame.new(168.69014, 16.3297405, -214.601608, -0.0913135335, 0, -0.995822191, 0, 1, 0, 0.995822191, 0, -0.0913135335)
    }
  end
end

return Module
