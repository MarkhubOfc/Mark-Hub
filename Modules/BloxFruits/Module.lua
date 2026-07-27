local Module = {}

function Module:GetToken()
  local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
  local lp = plr.LocalPlayer
  local UserId = lp.UserId
  local Token = tostring(UserId):sub(2, 4) .. tostring(math.random(10000, 99999))
  
  return Token
end

return Module
