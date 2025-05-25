local Version = {}

local log = require 'utils.logger'

local API_URL <const> = 'https://api.versadevelopment.net/resources/chunks/version'
local API_METHOD <const> = 'GET'
local RESOURCE_VERSION <const> = tonumber(GetResourceMetadata(GetCurrentResourceName(), 'version', 0) or nil)

Version.currentVersion = RESOURCE_VERSION

function Version.checkVersion()
  if not Version.currentVersion then
    log.error('Failed to retrieve current resource Version. Please ensure the resource is properly configured.')
    return
  end

  PerformHttpRequest(API_URL, function(err, response, headers)
    if err == 200 then
      local data = json.decode(response)
      if data.success then
        Version.latestVersion = tonumber(data.data.version)

        if Version.latestVersion > Version.currentVersion then
          log.warn('A new version of Versa Chunk System is available. Please update to the latest version @ https://github.com/versa-development/versa_chunk_system')
        end
      end
    else
      Version.latestVersion = nil
      log.error('Failed to fetch version data from Versa API. Error code: ' .. err)
    end
  end, API_METHOD)
end

return Version