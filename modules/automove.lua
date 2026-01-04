-- modules/auto_move.lua

local AutoMove = {}

local Players = game:GetService("Players")

function AutoMove.MoveTo(target)
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoid = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")

    humanoid:MoveTo(target)
    humanoid.MoveToFinished:Wait()
end

return AutoMove
