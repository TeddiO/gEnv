-- gEnv can fetch any environment variable that existed when srcds launched.
-- Any new variables require a total srcds restart, not just a reload of the map.
require("genv")

-- An example of getting our PATH variable. 
local pathEnv = genv.GetVariable("PATH")
print(pathEnv)
