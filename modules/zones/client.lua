local config = require 'data.config'
local log = require 'utils.logger'
local chunks = require 'modules.chunks.client'

local Zones = {}
local CHUNK_SIZE <const> = 250
local MIN_X, MAX_X <const> = -3000, 3000
local MIN_Y, MAX_Y <const> = -3000, 3000

local INSIDE_ZONE_COLOUR <const> = { r = 0, g = 255, b = 0, a = 50 }
local OUTSIDE_ZONE_COLOUR <const> = { r = 255, g = 0, b = 0, a = 15 }

local function debugZone(type, zone)
  if type == 'onEnter' then
    log.debug('Entered zone at', zone.coords.x, zone.coords.y)
    Wait(1000)
    zone.debugColour = INSIDE_ZONE_COLOUR
  elseif type == 'onExit' then
    Wait(1000)
    zone.debugColour = OUTSIDE_ZONE_COLOUR
  end
end

local function getChunkId(x, y)
  return ('chunk_%d_%d'):format(x, y)
end

local function createZones()
  for x = MIN_X, MAX_X, CHUNK_SIZE do
    for y = MIN_Y, MAX_Y, CHUNK_SIZE do
      local zone = lib.zones.box({
        coords = vector3(x, y, 0),
        size = vector3(CHUNK_SIZE, CHUNK_SIZE, 500),
        rotation = 0,
        onEnter = function(self)
          if config.Debug then debugZone('onEnter', self) end
        end,
        onExit = function(self)
          if config.Debug then debugZone('onExit', self) end
        end,
        debug = config.Debug,
        debugColour = OUTSIDE_ZONE_COLOUR
      })

      -- Store the zone in the chunks cache
      local chunkId = getChunkId(x, y)
      chunks.create(chunkId, zone)
    end
  end
end

function Zones.init()
  createZones()
end

return Zones