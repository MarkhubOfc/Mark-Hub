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

return Module
