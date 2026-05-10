local List = {}

function List:CheckLevel()
  local MyLevel = game:GetService("Players").LocalPlayer:WaitForChild("Data"):WaitForChild("Level").Value
  
  if MyLevel >= 1500 then
  end
end

return List
