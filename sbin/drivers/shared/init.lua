-- jane petrovna
-- v0.0
-- functions that can be shared between both OC and CC
local kernel = {}
if _G.kernel then
  kernel = _G.kernel
end

-- text utils
kernel.textutils = {}
local textutils = {}

function pad(text, padding, number)
  local padded = ""
  for i=1,number+1 do
    padded = padded .. padding
  end
  padded = padded .. text
  for i=1,number+1 do
    padded = padded .. padding
  end
  return padded
end
textutils.pad = pad

function pad_min(text, padding, size)
  local ts = string.len(text)
  local dif = size - ts
  local padded
  if dif > 0 then
    padded = kernel.textutils.pad(text, padding, dif/2)
  else
    padded = text
  end
  return padded
end
textutils.pad_min = pad_min

kernel.textutils = textutils


_G.kernel = kernel