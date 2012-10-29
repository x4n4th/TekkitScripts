fs.delete("NuclearControl")
fs.copy("disk/NuclearControl", "NuclearControl")
shell.run("monitor", "top", "NuclearControl")