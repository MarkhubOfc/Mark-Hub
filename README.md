# Zynkore Hub
* Open source and keyless

## Loader (Main)
```luau
loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Main.luau"))()
```

## Dead rails (Auto bond)
```luau
getgenv().Auto_load = true
getgenv().Game_config = {
  Auto_reset = true,
  Auto_teleport = true,
  Only_drop_bond = false
}

getgenv().Lobby_config = {
  Players_number = 1,
  Auto_create_party = true,
  Auto_recreate_party = true
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/Zynkore/Hub/refs/heads/main/Games/Dead%20Rails/Auto%20bond.luau"))()
```

### Lib: Redz V5 `Remake` & Obsidian
