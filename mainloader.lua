--// Steal a Brainrot Kaitun - Main Loader

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Base URL
local BASE_URL = "https://raw.githubusercontent.com/KhangICO/steal-a-brainrot-kaitun/main/"

-- Load modules
local Config = loadstring(game:HttpGet(BASE_URL .. "modules/config.lua"))()
local Performance = loadstring(game:HttpGet(BASE_URL .. "modules/performance.lua"))()
local AutoBuy = loadstring(game:HttpGet(BASE_URL .. "modules/autobuy.lua"))()

-- Init
if Performance and Performance.Init then
    Performance.Init(Config.Performance)
end

if AutoBuy and AutoBuy.Start then
    AutoBuy.Start(Config.Misc)
end

print("[Steal a Brainrot Kaitun] Loaded successfully.")
