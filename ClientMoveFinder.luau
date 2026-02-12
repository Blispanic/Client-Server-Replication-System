

return function(...)
    local Parameters = {...}
    local MoveName = Parameters[1]

    for _, v in ipairs(game:GetService("ReplicatedStorage").Shared.Abilities:GetDescendants()) do
        if v:IsA("ModuleScript") and v.Name == MoveName then
            return require(v)
        end
    end
end