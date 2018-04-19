return function(command)
  local f = assert(io.popen(command))
  local result = f:read('*all')
  f:close()
  return result
end
