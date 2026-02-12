local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Skillsets = ReplicatedStorage.Shared.Skillsets
local ToolHandler = require(ReplicatedStorage.Shared.Handlers.Client.ToolHandler)
local InputHandler = require(ReplicatedStorage.Shared.Handlers.Client.InputHandler)
local Ability = ReplicatedStorage.Shared.Events.Handlers.Ability

local enabled = false
local tool
Character.ChildAdded:Connect(function(c: Tool)
	for _, v in pairs(Skillsets:GetDescendants()) do
		if v.Name == c.Name then
			enabled = true
			tool = c.Name
			c.Unequipped:Once(function()
				enabled = false
				tool = nil
			end)
		end
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	InputHandler(input, gameProcessed, enabled, tool, Skillsets)
end)
