local PlayerHydrationService = game:GetService("PlayerHydrationService")
local ServerScriptService = game:GetService("ServerScriptService")
local PlayerData = require(ServerScriptService.Server.PlayerData.PlayerDataTable)
local MoveManager = require(game:GetService("ServerStorage").Logic.Managers.MoveManager)

return function(...)
    local Parameters = {...}
    local MoveName = Parameters[1]
    local Player = Parameters[2]
    local duration = Parameters[4]
    local canBeCancelled = Parameters[5]
    local animationID = Parameters[6]

    for _, v in ipairs(game:GetService("ServerStorage").Abilities:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name == MoveName then
            local thread = coroutine.create(require(v))
            MoveManager:AddActiveMove(Player, thread, MoveName, duration, canBeCancelled, animationID)
            table.insert(Parameters, thread)
            coroutine.resume(thread, table.unpack(Parameters))
            return
        end
    end
end