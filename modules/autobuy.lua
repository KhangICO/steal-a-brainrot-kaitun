local AutoBuy = {}
local CHECK_DELAY = 0.15
local CheckBrainrotRarity = true ----check CheckBrainrotRarity "secret", "OG", "Admin" if right auto buy brainrot 
local Players = game:GetService("Players")

-- ===== Utils =====
local function IsSecret(model)
    if model:GetAttribute("Rarity") then
        return tostring(model:GetAttribute("Rarity")) == "Secret"
    end
    return string.lower(model.Name):find("secret") ~= nil
end

local function IsIgnoredSecret(model, IgnoreList)
    local name = string.lower(model.Name)
    for _,v in pairs(IgnoreList or {}) do
        if name:find(string.lower(v)) then
            return true
        end
    end
    return false
end

local function GetIncomePerSecond(model)
    for _,attr in pairs({"IncomePerSecond", "Income", "CPS"}) do
        if model:GetAttribute(attr) then
            return tonumber(model:GetAttribute(attr))
        end
    end

    for _,v in pairs(model:GetDescendants()) do
        if v:IsA("TextLabel") then
            local text = v.Text:gsub(",", ""):lower()
            local num, suf = text:match("([%d%.]+)%s*([kmibt])")
            if num then
                num = tonumber(num)
                if suf == "k" then num = num * 1e3 end
                if suf == "m" then num = num * 1e6 end
                if suf == "b" then num = num * 1e9 end
                if suf == "t" then num = num * 1e12 end
                return num
            end
        end
    end
    return nil
end

local function TryBuy(model)
    for _,v in pairs(model:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v)
            return true
        end
    end
    return false
end

-- ===== Main =====
function AutoBuy.Start(MiscConfig)
    local AutoCfg = MiscConfig["Auto Buy"]
    if not AutoCfg or not AutoCfg["Enable"] then return end

    local MinIPS = AutoCfg["Min Income Per Second"] or 0
    local IgnoreList = MiscConfig["Ignore Secret"] or {}
    local BuyOnBrainrot = AutoCfg["Buy When Brainrot Near"] or false
    local BrainrotRadius = AutoCfg["Brainrot Radius"] or 50

    task.spawn(function()
        while task.wait(CHECK_DELAY) do
            for _,obj in pairs(workspace:GetChildren()) do
                if not obj:IsA("Model") then goto continue end
    
                local pos = GetModelPosition(obj)
                local brainrotNearby = false
                if BuyOnBrainrot and pos then
                    brainrotNearby = IsBrainrotNear(pos, BrainrotRadius)
                end

                local ips = GetIncomePerSecond(obj)
                local name = string.lower(obj.Name)
                if brainrotNearby then
                    if IsSecret(obj) then
                        if not name:find("secret") and not name:find("admin") and not name:find("OG") then goto continue end
                        if MoveToBrainrot then
                            local bmod, bpos = GetNearestBrainrot(pos or GetModelPosition(obj), BrainrotRadius)
                            if bpos then
                                pcall(function()
                                    MovePlayerNear(bpos, MoveOffset)
                                end)
                                task.wait(0.1)
                            end
                        end
                    else
                        if not ips or ips < MinIPS then goto continue end
                    end
                else
                    if not ips or ips < MinIPS then goto continue end
                end
    
                -- Secret nhưng nằm trong ignore list → bỏ qua
                if IsSecret(obj) and IsIgnoredSecret(obj, IgnoreList) then
                    goto continue
                end
    
                pcall(function()
                    TryBuy(obj)
                end)
    
                ::continue::
            end
        end
    end)
end

return AutoBuy
