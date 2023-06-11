local fzf = require("fzf-lua")
local signs = require("gitsigns")

local function dump(o, tbs, tb)
	tb = tb or 0
	tbs = tbs or "  "
	if type(o) == "table" then
		local s = "{"
		if next(o) then
			s = s .. "\n"
		else
			return s .. "}"
		end
		tb = tb + 1
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. tbs:rep(tb) .. "[" .. k .. "] = " .. dump(v, tbs, tb)
			s = s .. ",\n"
		end
		tb = tb - 1
		return s .. tbs:rep(tb) .. "}"
	else
		return tostring(o)
	end
end

local function doThing()
	local hunks = signs.get_hunks()
	local data = {}

	for key, value in pairs(hunks) do
		data[key] = value.lines
	end

	fzf.fzf_exec(function(fzf_cb)
		for i, x in pairs(hunks) do
			--[[ print("HUNK" .. i) ]]
			--[[ print(dump(x)) ]]
			fzf_cb(x.lines[1])
		end
		fzf_cb() -- EOF
	end, {
		previewer = "git_diff",
		actions = {
			["default"] = fzf.actions.file_edit,
		},
	})
end
doThing()

return doThing
