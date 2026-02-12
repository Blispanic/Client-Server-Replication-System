local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Ability = ReplicatedStorage.Shared.Events.Handlers.Ability

return function(input, gameProcessed, enabled, tool, Skillsets)
    if not enabled then
		return
	end
	if not tool then
		return
	end
	if gameProcessed then
		return
	end -- Note, make sure to do Humanoid Health check on server.

	local inputUsed
	if input.UserInputType == Enum.UserInputType.Keyboard then
		inputUsed = input.KeyCode.Name
	elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
		inputUsed = "MouseButton1" -- Can also change to M1 to shorten but this is better for readability.
	else -- Not a valid input.
		return
	end

	local MovesetModule = require(Skillsets:FindFirstChild(tool, true))
	if not MovesetModule then
		return
	end

	for k, v in pairs(MovesetModule) do
		if typeof(v) == "number" then
			continue
		end

		if v["Keybind"] == inputUsed then
			Ability:FireServer(tool, inputUsed, k)
            -- print("Fired to server!")
		end
	end
end
