local config = require 'data.config'
local log = require 'utils.logger'
local chunks = require 'modules.chunks.client'

local Zones = {}
local CHUNK_SIZE <const> = 250
local CHUNK_HEIGHT <const> = 500
local MIN_X, MAX_X <const> = -3000, 3000
local MIN_Y, MAX_Y <const> = -3000, 3000

local INSIDE_ZONE_COLOUR <const> = { r = 0, g = 255, b = 0, a = 50 }
local SURROUNDING_ZONE_COLOUR <const> = { r = 255, g = 255, b = 0, a = 25 }
local OUTSIDE_ZONE_COLOUR <const> = { r = 255, g = 0, b = 0, a = 15 }

local function debugZone(type, zone, chunkId)
  local chunk = chunks.get(chunkId)

  if type == 'onEnter' then
    log.debug('Entered zone at', zone.id, json.encode(chunk.surroundingChunks))
    zone.debugColour = INSIDE_ZONE_COLOUR
    -- Set the surrounding zones to a different colour
    for i = 1, #chunk.surroundingChunks do
      local surroundingChunkId = chunk.surroundingChunks[i]
      local surroundingZone = chunks.get(surroundingChunkId).zone
      surroundingZone.debugColour = SURROUNDING_ZONE_COLOUR
    end
  elseif type == 'onExit' then
    Wait(5000)
    zone.debugColour = OUTSIDE_ZONE_COLOUR
    -- Reset the surrounding zones to the outside colour
    for i = 1, #chunk.surroundingChunks do
      local surroundingChunkId = chunk.surroundingChunks[i]
      local surroundingZone = chunks.get(surroundingChunkId).zone
      surroundingZone.debugColour = OUTSIDE_ZONE_COLOUR
    end
  end
end

--- Get the surrounding chunks (N, NE, E, SE, S, SW, W, NW) for a given chunk based on its coordinates.
local function getSurroundingChunks(x, y)
    local response = {}

    for dx = -1, 1 do
        for dy = -1, 1 do
            if not (dx == 0 and dy == 0) then
                local gridX = x + (dx * CHUNK_SIZE)
                local gridY = y + (dy * CHUNK_SIZE)

                for chunkId,chunk in pairs(chunks.getAll()) do
                    if chunk.zone.coords.x == gridX and chunk.zone.coords.y == gridY then
                        response[#response + 1] = chunkId
                        break
                    end
                end
            end
        end
    end

    return response
end

local function createZones()
  -- Creates zones in a grid pattern based on the defined chunk size
  for x = MIN_X, MAX_X, CHUNK_SIZE do
    for y = MIN_Y, MAX_Y, CHUNK_SIZE do

      -- Create the ox lib box zone for the chunk 
      local zone = lib.zones.box({
        coords = vector3(x, y, 0),
        size = vector3(CHUNK_SIZE, CHUNK_SIZE, CHUNK_HEIGHT),
        rotation = 0,
        onEnter = function(self)
          if config.Debug then debugZone('onEnter', self, self.id) end
        end,
        onExit = function(self)
          if config.Debug then debugZone('onExit', self, self.id) end
        end,
        debug = config.Debug,
        debugColour = OUTSIDE_ZONE_COLOUR
      })

      -- Store the zone in the chunks cache
      chunks.create(zone.id, { 
        surroundingChunks = {},
        entities = {},
        zone = zone 
      })
    end
  end

  -- Once all zones are created, we can set the surrounding zones (we render entities in current zone and surrounding zones)
  -- cache them so then the client doesn't need to loop every time they enter a new zone
  local allChunks = chunks.getAll()
  for chunkId, chunk in pairs(allChunks) do
    chunks.cache[chunkId].surroundingChunks = getSurroundingChunks(chunk.zone.coords.x, chunk.zone.coords.y)
  end
end

--- Called by init.lua to initialize the zones on load
function Zones.init()
  createZones()
end

return Zones