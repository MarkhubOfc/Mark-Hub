local success, GameList = pcall(function()
  return loadstring(game:HttpGet("https://raw.githubusercontent.com/MarkhubOfc/Mark-Hub/refs/heads/main/List.lua"))()
end)

if success and GameList then
  local currentId = tostring(game.PlaceId)
  if GameList[currentId] then
    loadstring(game:HttpGet(GameList[currentId]))()
    return
  end
end
