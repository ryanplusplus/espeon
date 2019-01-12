return function(command, hide_error)
  local error_out = os.tmpname()
  local wrapped_command = command .. ' 2> ' .. error_out

  local f = assert(io.popen(wrapped_command))
  local result = f:read('*all')
  f:close()

  local error_f = assert(io.open(error_out))
  local error_result = error_f:read('*all')
  error_f:close()

  if error_result == '' then
    return result
  else
    error(error_result)
  end
end
