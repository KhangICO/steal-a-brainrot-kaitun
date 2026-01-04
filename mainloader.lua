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
local UI = loadstring(game:HttpGet(BASE_URL .. "modules/UI.lua"))()

-- Init
if Performance and Performance.Init then
    Performance.Init(Config.Performance)
end

if AutoBuy and AutoBuy.Start then
    AutoBuy.Start(Config.Misc)
end

if UI and UI.Create then
    local ui = UI.Create()
    ui.SetVisible(true)
end

print("[Steal a Brainrot Kaitun] Loaded successfully.")

getgenv().scriptLoaded = true
getgenv().Joebiden = true