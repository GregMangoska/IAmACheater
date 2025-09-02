-- LocalScript in StarterPlayerScripts
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

-- Create Tool
local tool = Instance.new("Tool")
tool.Name = "LayTool"
tool.RequiresHandle = true
tool.Parent = player:WaitForChild("Backpack")

-- Create handle
local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1,1,1)
handle.Anchored = false
handle.CanCollide = true
handle.Parent = tool

-- Rainbow effect on handle
local hue = 0
RunService.RenderStepped:Connect(function()
	if handle.Parent then
		hue = (hue + 0.01) % 1
		handle.Color = Color3.fromHSV(hue,1,1)
	end
end)

-- Lay down function (from your addcmd snippet)
local function layDown()
	local char = player.Character
	if not char then return end
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if not humanoid then return end
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	-- Sit first
	humanoid.Sit = true
	task.wait(0.1)

	-- Rotate HumanoidRootPart to lay down
	root.CFrame = root.CFrame * CFrame.Angles(math.pi * 0.5, 0, 0)

	-- Stop animations
	for _, v in ipairs(humanoid:GetPlayingAnimationTracks()) do
		v:Stop()
	end
end

-- Trigger lay down on left click
tool.Activated:Connect(layDown)
