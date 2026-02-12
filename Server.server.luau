local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Server = require(ServerStorage.Logic.Handlers.Server)
local Ability = ReplicatedStorage.Shared.Events.Handlers.Ability
local Managers = ServerStorage.Logic.Managers
local MoveStateManager = require(Managers.MoveStateManager)
local CooldownManager = require(Managers.CooldownManager)

Ability.OnServerEvent:Connect(function(Player: Player, className: string, input: string, moveName: string) -- Do extra sanity checks later to see if the player owns the class (or secondary) and if they have it equipped.
    Server(Player, className, input, moveName)
end)
