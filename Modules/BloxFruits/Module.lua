local Module = {}

function Module:GetToken()
  local plr = (cloneref and cloneref(game:GetService('Players')) or game:GetService('Players'))
  local lp = plr.LocalPlayer
  local UserId = lp.UserId

  local Token = 'ABC0xJbb0'

  return Token
end

return Module
