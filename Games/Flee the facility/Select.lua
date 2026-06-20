function serv(S)
  return game:GetService(S) or {}
end
local CoreGui = gethui and gethui() or serv('CoreGui')

function new(c, p)
  local k = Instance.new(c)
  for pp, v in pairs(p or {}) do
    k[pp] = v
  end
  return k
end

if CoreGui:FindFirstChild('Select language') then
  CoreGui['Select language']:Destroy()
end

local s = new('ScreenGui', {
  Name = 'Select language',
  Parent = CoreGui
})

local Win = new('Frame', {
  Name = 'Window',
  Size = UDim2.new(0, 475, 0, 325),
  Position = UDim2.new(0.5, -249, 0.5, -180),
  BackgroundColor3 = Color3.fromHex('#2d2c2b'),
  ClipsDescendants = true,
  Active = true,
  Draggable = true,
  Parent = s
})
new('UICorner', {
  CornerRadius = UDim.new(0, 4),
  Parent = Win
})
new('UIStroke', {
  Color = Color3.fromHex('#313131'),
  Parent = Win
})

local TBar = new('Frame', {
  Name = 'Title bar',
  Size = UDim2.new(1, -2.5, 0, 31),
  Position = UDim2.new(0, 1.25, 0, 0),
  BackgroundColor3 = Color3.fromHex('#2e2e2e'),
  Parent = Win
})
new('UICorner', {
  CornerRadius = UDim.new(0, 2),
  Parent = TBar
})
new('UIStroke', {
  Color = Color3.fromHex('#313131'),
  Parent = TBar
})

local LangLi = new('ScrollingFrame', {
  Name = 'Language List',
  Size = UDim2.new(1, -5, 0, 288),
  Position = UDim2.new(0, 2.5, 0, 34),
  BackgroundColor3 = Color3.fromHex('#282828'),
  ScrollBarThickness = 0.2,
  ScrollingEnabled = false,
  ScrollingDirection = Enum.ScrollingDirection.Y,
  ClipsDescendants = true,
  Parent = Win
})
new('UICorner', {
  CornerRadius = UDim.new(0, 2),
  Parent = LangLi
})
new('UIStroke', {
  Color = Color3.fromHex('#313131'),
  Parent = LangLi
})
new('UIListLayout', {
  FillDirection = Enum.FillDirection.Horizontal,
  Wraps = true,
  Parent = LangLi
})
new('UIPadding', {
  PaddingLeft = UDim.new(0, 6),
  PaddingRight = UDim.new(0, 6),
  PaddingTop = UDim.new(0, 6),
  PaddingBottom = UDim.new(0, 6),
  Parent = LangLi
})

local EN = new('TextButton', {
  Name = 'English lang',
  Size = UDim2.new(0, 75, 0, 45),
  BackgroundColor3 = Color3.fromHex('#2e2e2e'),
  Text = 'English',
  TextColor3 = Color3.fromHex('#cfcfcf'),
  TextScaled = true,
  Parent = LangLi
})
new('UICorner', {
  CornerRadius = UDim.new(0, 2),
  Parent = EN
})
new('UIStroke', {
  ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  Color = Color3.fromHex('#313131'),
  Parent = EN
})
EN.MouseButton1Click:Connect(function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Games/Flee%20the%20facility/EN.luau'))()
  s:Destroy()
end)

local PT_BR = new('TextButton', {
  Name = 'Portugues lang',
  Size = UDim2.new(0, 75, 0, 45),
  BackgroundColor3 = Color3.fromHex('#2e2e2e'),
  Text = 'Português',
  TextColor3 = Color3.fromHex('#cfcfcf'),
  TextScaled = true,
  Parent = LangLi
})
new('UICorner', {
  CornerRadius = UDim.new(0, 2),
  Parent = PT_BR
})
new('UIStroke', {
  ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  Color = Color3.fromHex('#313131'),
  Parent = PT_BR
})
PT_BR.MouseButton1Click:Connect(function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Games/Flee%20the%20facility/PT-BR.luau'))()
  s:Destroy()
end)
