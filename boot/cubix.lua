-- jane petrovna
-- v0.0
-- bootloader
local run = nil
if shell then
  term.clear()
  run = shell.run
  run("/sbin/drivers/cc/init.lua")
else
  function loadfile(filename, ...)
    if filename:sub(1,1) ~= "/" then
      filename = (os.getenv("PWD") or "/") .. "/" .. filename
    end
    local handle, open_reason = require("filesystem").open(filename)
    if not handle then
      return nil, open_reason
    end
    local buffer = {}
    while true do
      local data, reason = handle:read(1024)
      if not data then
        handle:close()
        if reason then
          return nil, reason
        end
        break
      end
      buffer[#buffer + 1] = data
    end
    return load(table.concat(buffer), "=" .. filename, ...)
  end

  run = function(filename)
    local program, reason = loadfile(filename)
    if not program then
      return error(reason .. ':' .. filename, 0)
    end
    return program()
  end

  -- load drivers
  run("/sbin/drivers/oc/init.lua")
end

-- load shared drivers
run("/sbin/drivers/shared/init.lua")

-- error if no kernel table is present. something went wrong
if not _G.kernel then
  error("kernel table not found")
end

--for k,v in pairs(_G.kernel) do
--  print('found syscall or syscall table ' .. k)
--end

run("/sbin/init.lua")