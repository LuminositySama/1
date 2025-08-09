local starterModule = require(game:GetService("StarterPlayer").StarterPlayerScripts["TSFL Client"].Modules.BallNetworking)
local playerModule = require(game:GetService("Players").LocalPlayer.PlayerScripts["TSFL Client"].Modules.BallNetworking)

hookfunction(playerModule.IsDistanceTooBig, function() return false end)
hookfunction(starterModule.IsDistanceTooBig, function() return false end)
hookfunction(playerModule.VerifyHit, function() return false end)
hookfunction(starterModule.VerifyHit, function() return false end)
hookfunction(playerModule.IsBallBoundingHitbox, function() return true end)
hookfunction(starterModule.IsBallBoundingHitbox, function() return true end)

local function isUUID(str)
	return string.match(str, "^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") ~= nil
end

local function getBallParts()
	local ballFolder = workspace:FindFirstChild("Balls")
	if not ballFolder then return {} end

	local ballParts = {}
	for _, part in ipairs(ballFolder:GetDescendants()) do
		if part:IsA("BasePart") and isUUID(part.Name) then
			table.insert(ballParts, part)
		end
	end

	return ballParts
end

local localPlayer = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local reachDistance = 5
local maxReach = 100000
local reachEnabled = true

local uiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local uiWindow = uiLibrary:Load("Akram Reach Controller", "Default")
local reachTab = uiLibrary.newTab("Reach Settings", "Default")

reachTab.newToggle("Enable Reach", "", reachEnabled, function(state)
	reachEnabled = state
end)

reachTab.newSlider("Reach Distance", "", maxReach, false, function(distance)
	reachDistance = math.floor(distance)
end)

reachTab.newKeybind("Toggle UI", "", Enum.KeyCode.RightControl, function()
	uiWindow:Toggle()
end)

runService.RenderStepped:Connect(function()
	if not reachEnabled then return end

	local character = localPlayer.Character
	if not character then return end

	local bodyParts = { "Right Leg", "Left Leg", "Torso", "Head" }
	local nearbyBalls = getBallParts()

	for _, bodyPartName in ipairs(bodyParts) do
		local bodyPart = character:FindFirstChild(bodyPartName)
		if bodyPart then
			for _, desc in ipairs(bodyPart:GetDescendants()) do
				if desc:IsA("TouchTransmitter") or desc.Name == "TouchInterest" then
					for _, ball in ipairs(nearbyBalls) do
						if (ball.Position - bodyPart.Position).Magnitude <= reachDistance then
							pcall(function()
								firetouchinterest(ball, desc.Parent, 0)
								firetouchinterest(ball, desc.Parent, 1)
							end)
						end
					end
				end
			end
		end
	end
end)
