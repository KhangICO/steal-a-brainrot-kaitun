--// Steal a Brainrot Kaitun - Main Loader

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local BASE_URL = "https://raw.githubusercontent.com/KhangICO/steal-a-brainrot-kaitun/main/"

local function LoadModule(path)
    local ok, result = pcall(function()
        return loadstring(game:HttpGet(BASE_URL .. path))()
    end)

    if not ok then
        warn("[Loader] Failed to load:", path, result)
        return nil
    end

    print("[Loader] Loaded:", path)
    return result
end

-- Load modules
local Config = LoadModule("modules/config.lua")
local Performance = LoadModule("modules/performance.lua")
local AutoBuy = LoadModule("modules/autobuy.lua")
local UI = LoadModule("modules/UI.lua")

if not Config then
    warn("Config failed to load → STOP")
    return
end

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
