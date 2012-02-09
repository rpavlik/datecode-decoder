#!/usr/bin/env lua

function getMonthName(num)
	return os.date("%B", os.time{ year = 2000, month = num, day = 1})
end


function letterToMonth(letter)
	local monthcode = ("ABCDEFGHJKLM"):find(letter:upper())
	return monthcode
end

-- Returns a fully-detailed string, then a table containing an approximation for use by os.time
function decodeDatecode(datecode)
	local date = {
		day = 1 -- dummy - unknown
	}

	-- codes in the form #X??? - found on OEM Saturn AC/Delco batteries from 2002.
	-- source: http://www.cadillacforums.com/forums/electrical-technical-information/69788-ac-delco-battery-age.html
	if datecode:len() == 5 then
		local yeardigit = tonumber(datecode:sub(1, 1))
		local month = letterToMonth(datecode:sub(2, 2))
		if yeardigit ~= nil and month ~= nil then
			-- OK, we've decoded successfully.

			-- Somewhere between 2 and 8 there's a switch from 2000 to 1990 as the
			-- year base. TODO
			date.year = 2000 + yeardigit
			date.month = month
			return ("%s %d"):format(date.year, getMonthName(month)), date
		end
	end

	print "Sorry, can't decode that date code!"

	os.exit(1)
end


if #arg ~= 1 then
	io.stderr:write("Please pass the date code as the first command line argument.")
	os.exit(1)
end

local datestring = decodeDatecode(arg[1])
print(datestring)
