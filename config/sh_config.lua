Config = Config or {}

--[[ 
    -- Main Map Bounds & Cayo Bounds --
    
    We recommend not changing these values unless you know what you're doing.
    The map bounds setup now are best performance wise and should be left alone. 
]]--
Config.MapBounds = {
    { x = 1000.0, y = 1000.0 },
    { x = 1000.0, y = 3000.0 },
    { x = 3000.0, y = 3000.0 },
    { x = 3000.0, y = 1000.0 },
}

Config.CayoBounds = {
    { x = 1000.0, y = 1000.0 },
    { x = 1000.0, y = 3000.0 },
    { x = 3000.0, y = 3000.0 },
    { x = 3000.0, y = 1000.0 },
}

Config.ChunkSize = 100

--[[ 
    -- Other Config Options --
]]