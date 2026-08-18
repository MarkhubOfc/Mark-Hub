local GameList = loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/List.luau"))()

local PlaceId = game.PlaceId
if GameList then
  for placeId, url in pairs(GameList) do
    if placeId and url then
      if PlaceId == placeId then
        loadstring(game:HttpGet("" .. url))()
      end
    end
  end
end
