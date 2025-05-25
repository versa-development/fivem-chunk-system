local log = require 'utils.logger'

local Chunks = {}

function Chunks.create(id, data)
  Chunks[id] = data
  log.debug('Chunk created:', id, data)
end

return Chunks