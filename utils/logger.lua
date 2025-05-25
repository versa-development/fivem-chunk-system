local config = require 'data.config'

local Logger = {}

--- Concatenates arguments into a single string, converting each argument to a string.
local function formatLogMessage(...)
  local args = {...}
  for i = 1, #args do
    args[i] = tostring(args[i])
  end
  return table.concat(args, ' ')
end

function Logger.info(...)
  print('^5[Versa Chunks] ^7' .. formatLogMessage(...))
end

function Logger.warn(...)
  print('^5[Versa Chunks] ^3[WARNING] ' .. formatLogMessage(...) .. '^7')
end

function Logger.error(...)
  print('^5[Versa Chunks] ^1[ERROR] ' .. formatLogMessage(...) .. '^7')
end

function Logger.debug(...)
  if config.Debug then
    print('^5[Versa Chunks] ^2[DEBUG] ' .. formatLogMessage(...) .. '^7')
  end
end

return Logger