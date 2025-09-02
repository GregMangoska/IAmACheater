-- LocalScript inside StarterPlayerScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

local char = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
local humanoid = char:WaitForChild("Humanoid")

local speed = 16 -- movement speed
local rayDistance = 5 -- distance to check for walls/ceiling

-- Function to rotate character based on surface normal
local function rotateToNormal(normal)
    local lookVector = humanoidRootPart.CFrame.LookVector
    local upVector = normal
    humanoidRootPart.CFrame = CFrame.fromMatrix(
        humanoidRootPart.Position,
        lookVector,
        upVector
    )
end

-- Wall/walking logic
RunService.RenderStepped:Connect(function()
    local origin = humanoidRootPart.Position
    local direction = humanoidRootPart.CFrame.LookVector * 2

    -- Cast rays downward, forward, backward, left, right to detect surfaces
    local surfaces = {
        workspace:Raycast(origin, Vector3.new(0, -rayDistance, 0)), -- down
        workspace:Raycast(origin, Vector3.new(0, rayDistance, 0)),  -- up
        workspace:Raycast(origin, Vector3.new(direction.X*rayDistance, 0, direction.Z*rayDistance)) -- forward
        -- add more if you want left/right/back checks
    }

    -- Find first surface hit
    for _, hit in pairs(surfaces) do
        if hit then
            rotateToNormal(hit.Normal)
            break
        end
    end
end)
