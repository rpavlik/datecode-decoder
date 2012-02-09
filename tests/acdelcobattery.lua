module(..., package.seeall)

local known = {
	["2F606"] = "June 2002" --rpavlik's AC Delco in a 2002 Saturn SL-2
}

for input, expected_output in pairs(known) do
	_G["test_known_" .. input] = function()
		local decode = require "acdelcobattery"
		assert_equal((decode(input)), expected_output)
	end
end
