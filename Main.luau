local GameList = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/List.luau"))()
if GameList ~= nil then
  for placeId, url in pairs(GameList) do
    if placeId and url then
      if game.PlaceId == placeId then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Games/" .. url))()
      end
    end
  end
end
