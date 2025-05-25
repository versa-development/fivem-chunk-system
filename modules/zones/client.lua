local log = require 'utils.logger'
local M = {}

function M.init()
  log.log('Initializing client zones...')

  lib.zones.box({
    coords = vec3(0.0, 0.0, 0.0),
    size = vec3(100.0, 100.0, 10.0),
    rotation = 0,
    debug = true,
    onEnter = function()
      print('Entered a chunk!')
    end,
    onExit = function()
      print('Exited a chunk!')
    end,
  })
end

return M