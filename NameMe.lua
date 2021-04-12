print("Enter a name for me:")
local name = read()
local formattedName = "aaa_"..name
shell.run("label", "set", name)
shell.run("mkdir", formattedName)