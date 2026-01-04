local Performance = {}

function Performance.Init(PerfConfig)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local VirtualUser = game:GetService("VirtualUser")
    local LP = Players.LocalPlayer

    -- Anti AFK
    LP.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)

    -- FPS Cap
    if PerfConfig["FPS Cap"] then
        pcall(function()
            setfpscap(PerfConfig["FPS Cap"])
        end)
    end

    -- Black Screen
    if PerfConfig["Black Screen"] then
        pcall(function()
            RunService:Set3dRenderingEnabled(false)
        end)
    end
end

return Performance
