local Module = {}

function Module:CheckLevel()
  local MyLevel = game:GetService("Players").LocalPlayer:WaitForChild('Data'):WaitForChild('Level').Value

  if MyLevel >= 0 then
    return {
      MonName = 'Thief',
      MonValue = 5,
      QuestName = 'QuestNPC1',
      QuestTitle = 'Thief Hunter',
      QuestCFrame = CFrame.new(166, 16, -215)
    }
  end
end

return Module
