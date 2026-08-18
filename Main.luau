local GameList

local PlaceId = game.PlaceId
if GameList then
  for placeId, url in pairs(GameList) do
    if placeId and url then
      if PlaceId == placeId then
        loadstring(game:HttpGet(url))()
      end
    end
  end
end
