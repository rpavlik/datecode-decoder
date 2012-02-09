#!/usr/bin/env lua

if #arg < 2 then
	io.stderr:write("Please pass the kind of date code, then date code as command line arguments.\n")
	os.exit(1)
end

success, result = pcall(require, arg[1])
if success then
	decodeDatecode = result
else
	io.stderr:write("Couldn't find a datecode decoder called '")
	io.stderr:write(arg[1])
	io.stderr:write("' - messsage:\n")
	io.stderr:write(result)
	io.stderr:write("\n")
	os.exit(1)
end

local datestring, tableOrErr = decodeDatecode(arg[2])
if datestring then
	print(datestring)
else
	io.stderr:write("Error from date decoder: ")
	io.stderr:write(tableOrErr)
	io.stderr:write("\n")
	os.exit(1)
end
