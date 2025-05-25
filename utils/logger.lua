local logger = {}

function logger.info(msg)
  print('[Versa Chunk System] ' .. msg)
end

function logger.error(msg)
  print('[Versa Chunk System] [ERROR] ' .. msg)
end

return logger