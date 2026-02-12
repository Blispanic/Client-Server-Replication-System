local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Ability = ReplicatedStorage.Shared.Events.Handlers.Ability
local Managers = ServerStorage.Logic.Managers
local Checkers = ServerStorage.Logic.Checkers
local Handlers = ServerStorage.Logic.Handlers
local MoveStateManager = require(Managers.MoveStateManager)
local CooldownManager = require(Managers.CooldownManager)
local PlayerStateChecker = require(Checkers.PlayerStateChecker)
local MoveFinder = require(Handlers.MoveFinder)

return function(...)
	local Parameters = { ... }
	local Player = Parameters[1]
	local className = Parameters[2]
	local bind = Parameters[3]
	local abilityName = Parameters[4]

	if not PlayerStateChecker:CanPlayerUseAbility(Player, bind) then
		return
	end

	local classTemplate = require(ServerStorage.ClassTemplates:FindFirstChild(className, true))
	local canBeCancelled = classTemplate[abilityName].CanBeCancelled
	local duration = classTemplate[abilityName]["Attack Time"]
	local animationID = classTemplate[abilityName].Animation
	
	-- print("Input access granted.")

	MoveFinder(abilityName, Player, bind, duration, canBeCancelled, animationID) -- ability name first because it looks cleaner to me with the string first then the player.
end
