if game.PlaceId == 114234929420007 or game.PlaceId == 135434213652028 or game.PlaceId == 108194354348181 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/bloxstrike.lua"))() --bloxstrike
  print("Loaded Blox Strike")
elseif game.PlaceId == 301549746 or game.PlaceId == 1480424328 then
  loadstring(game:HttpGet("https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/counterblox.lua"))() -- counterblox
  print("Loaded Counter Blox")
else
  loadstring(game:HttpGet("https://raw.githubusercontent.com/d0inks/moon.lua/refs/heads/main/ext/universal.lua"))() --universal
  print("Moon.lua Universal")
  print("pls be aware some functions might not work depending on what game ur using.")
end
