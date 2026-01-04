--// Steal a Brainrot Kaitun - Main Loader

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- ⚠️ ĐỔI USERNAME / REPO CỦA BẠN
local BASE_URL = "https://raw.githubusercontent.com/USERNAME/REPO/main/"

local Config = loadstring(game:HttpGet(BASE_URL .. "modules/config.lua"))()
local Performance = loadstring(game:HttpGet(BASE_URL .. "modules/performance.lua"))()
local AutoBuy = loadstring(game:HttpGet(BASE_URL .. "modules/autobuy.lua"))()

-- Init
Performance.Init(Config.Performance)
AutoBuy.Start(Config.Misc)

print("[Steal a Brainrot Kaitun] Loaded successfully.")
