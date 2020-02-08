-- jane petrovna
-- v 0.0
-- handle computercraft system calls
print('load computercraft functions')
local kernel = {}
if _G.kernel then
  kernel = _G.kernel
end

kernel.run = shell.run

_G.kernel = kernel

-- load extra drivers
-- TODO: iterate through all files in dir and execute, avoiding hardcoded filenames
kernel.run('/sbin/drivers/cc/print.lua')