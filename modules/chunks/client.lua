local log = require 'utils.logger'

local Chunks = {}
Chunks.cache = {} -- Cache to store chunk data

function Chunks.create(id, data)
  Chunks.cache[id] = data
end

function Chunks.get(id)
  return Chunks.cache[id]
end

function Chunks.getAll()
  return Chunks.cache
end

function Chunks.enterChunk(chunkId)
  -- TODO: Implement logic for entering a chunk
end

return Chunks