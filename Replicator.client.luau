if not (game:IsLoaded()) then
	game.Loaded:Wait()
end

local playerAbilityThreads = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MoveFinder = require(ReplicatedStorage.Shared.Logic.Client.ClientMoveFinder)

ReplicatedStorage.Shared.Events.Client.Replicator.OnClientEvent:Connect(function(module, ...)
	local Parameters = { ... }
	local Player = Parameters[1]
	playerAbilityThreads[Player] = playerAbilityThreads[Player] or {}

	local abilityFunction = MoveFinder(module)
	local thread = coroutine.create(abilityFunction)
	table.insert(playerAbilityThreads[Player], thread)
	table.insert(Parameters, thread)
	coroutine.resume(thread, table.unpack(Parameters)) 
end)

ReplicatedStorage.Shared.Events.Handlers.Cancel.OnClientEvent:Connect(function(player, animations)
	if not playerAbilityThreads[player] then
		return
	end

	local character = game.Players.LocalPlayer.Character
	local humanoid = character:WaitForChild("Humanoid")
	local Animator = humanoid:WaitForChild("Animator")

	local playingAnimations = Animator:GetPlayingAnimationTracks()

	for _, track in pairs(playingAnimations) do
		for _, v in pairs(animations) do
			if track.Animation.AnimationId == v then
				track:Stop()
			end
		end
	end

	for i = #playerAbilityThreads[player], 1, -1 do
		print("Cancelling Client")
		local thread = table.remove(playerAbilityThreads[player], i)
		coroutine.close(thread)
	end
end)
