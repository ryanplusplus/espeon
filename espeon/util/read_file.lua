return function(filename)
  local f = assert(io.open(filename, 'r'))
  local contents = f:read('*all')
  f:close()
  return contents
end
