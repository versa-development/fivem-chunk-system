local config = require 'data.config'
local log = require 'utils.logger'

local TARGET_DIRECTORY <const> = 'modules.bridge.target.'.. config.Target .. '.client'
local TARGET_ERROR_MESSAGE <const> = 'Config.Target = ' .. config.Target .. ' in your data/config.lua is not supported, please check the documentation or ask on the Versa Support Discord. https://docs.versadevelopment.net/'

if IsDuplicityVersion() then
  -- Check if all required bridges are available/exist
  local targetExists = pcall(require, TARGET_DIRECTORY)
  if not targetExists then
    error(TARGET_ERROR_MESSAGE)
  end

  -- Check if resource is outdated
  require 'utils.version'.checkVersion()
else
  -- Initialize the target bridge module
  local target = require (TARGET_DIRECTORY)
  target.init()

  -- Setup the box zones for the client
  local zones = require 'modules.zones.client'
  zones.init()
end