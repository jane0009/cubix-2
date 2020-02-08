-- jane petrovna
-- v0.0
-- kernel print functions
local kernel = {}
if _G.kernel then
  kernel = _G.kernel
end

kernel.colors = colors

-- print utils
local function printl(line, text)
  term.setCursorPos(1, line)
  term.clearLine()
  prints(text)
  prints("\n")
end
kernel.printl = printl

local function prints(...)
  local nLinesPrinted = 0
    local nLimit = select("#", ... )
    for n = 1, nLimit do
        local s = tostring( select( n, ... ) )
        if n < nLimit then
            s = s .. "\t"
        end
        nLinesPrinted = nLinesPrinted + write( s )
    end
end
kernel.prints = prints

local function kprint(text, status, statuscol)
  local x,y = term.getSize()
  local cx, cy = term.getCursorPos()

  kernel.kprintl(cy, text, status, statuscol)

--  if cy == y then
--    term.scroll(1)
--  end
  -- return the line number to reference back
  return cy
end
kernel.kprint = kprint

local function kprintl(line, text, status, statuscol)
  -- kernel message status min
  local kmin = 5

  term.setCursorPos(1, line)
  term.clearLine()
  prints('[')
  term.setTextColor(statuscol)
  prints(kernel.textutils.pad_min(status, ' ', kmin))
  term.setTextColor(kernel.colors.white)
  prints(']')
  prints('\t')
  prints(text)
  prints("\n")
end
kernel.kprintl = kprintl

_G.kernel = kernel

kernel.kprint("loaded print functions", "OK", kernel.colors.green)