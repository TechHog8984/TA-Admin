if shared.__TALIB__ then shared.__TALIB__:Stop() end
if not game:IsLoaded() then
	repeat game.Loaded:Wait() until game:IsLoaded()
end
local TALib = {
	IgnoreRecipiants = true,

	Commands = {},

	Prefix = '!'
}
function TALib:CreateCommand(info)
	local Command = {}

	local I = 1
	for x, V in next, {'Name', 'Callback'--[[, 'Args']], 'Description'} do
		if info[V] then
			Command[V] = info[V]
			I -= 1
		elseif info[I] then
			Command[V] = info[I]
		end
		I += 1
	end


	assert(type(Command.Name) == 'string', 'Expected \'string\' for Name, got ' .. tostring(Name) .. '.')
	assert(type(Command.Callback) == 'function', 'Expected \'function\' for Callback, got ' .. tostring(Callback) .. '.')
	--assert(type(Command.Args) == 'table', 'Expected \'table\' for Args, got ' .. tostring(Args) .. '.')
	if not Command.Description then Command.Description = Command.Name end
	assert(type(Command.Description) == 'string', 'Expected \'string\' for Description, got ' .. tostring(Description) .. '.')

	TALib.Commands[Command.Name] = Command

	return Command
end

function TALib:GetCommand(str)
	if TALib then
		if str:sub(1,#TALib.Prefix) == TALib.Prefix then
			local Command = nil
			local Split = str:split(' ')
			local First = Split[1]

			local Command = TALib.Commands[First:sub(#TALib.Prefix + 1, -1)]
			if Command then
				return Command, ({select(2, unpack(Split))})
			end
		end
	end
	return nil
end

function TALib:HandleCommand(Message, Recipiant)
	if TALib then
		if TALib.IgnoreRecipiants and (type(Recipiant) == 'string' and Recipiant ~= 'All') then return end
		local Command, Args = TALib:GetCommand(Message)
		if Command then
			Command.Callback(unpack(Args))
		end
	end
end

local getservice = game.GetService

local Players = getservice(game, 'Players')
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
	repeat Players:GetAttributeChangedSignal('LocalPlayer'):Wait();LocalPlayer = Players.LocalPlayer until LocalPlayer
end
local ChattedConnection = nil
ChattedConnection = LocalPlayer.Chatted:Connect(function(Message, Recipiant)
	if TALib then
		TALib:HandleCommand(Message, Recipiant)
	end
end)

function TALib:Stop()
	if ChattedConnection then
		ChattedConnection:Disconnect()
		ChattedConnection = nil
	end
	if TALib then
		if shared.__TALIB__ and shared.__TALIB__ == TALib then
			shared.__TALIB__ = nil
		end
		TALib = nil
	end
end

shared.__TALIB__ = TALib
return TALib