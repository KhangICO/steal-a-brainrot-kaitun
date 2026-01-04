local AutoBuy = {}
local CHECK_DELAY = 0.15

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
                if suf == "k" then num *= 1e3 end
                if suf == "m" then num *= 1e6 end
                if suf == "b" then num *= 1e9 end
                if suf == "t" then num *= 1e12 end
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

    task.spawn(function()
        while task.wait(CHECK_DELAY) do
            for _,obj in pairs(workspace:GetChildren()) do
                if not obj:IsA("Model") then continue end

                local ips = GetIncomePerSecond(obj)
                if not ips or ips < MinIPS then continue end

                -- Secret nhưng nằm trong ignore list → bỏ qua
                if IsSecret(obj) and IsIgnoredSecret(obj, IgnoreList) then
                    continue
                end

                pcall(function()
                    TryBuy(obj)
                end)
            end
        end
    end)
end

return AutoBuy
