local Module = {}

function Module:Service(Service)
  if Service ~= nil or Service ~= "" then
    return (cloneref and cloneref(game:GetService(Service)) or game:GetService(Service))
  end
  return game:GetService(Service)
end

function Module:GetHttp(Link)
  return loadstring(game:HttpGet(Link))()
end

function Module:new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end

return Module
