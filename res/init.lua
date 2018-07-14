require = function(m)
  return dofile(m .. '.lc')
end

tmr.create():alarm(2000, tmr.ALARM_SINGLE, function()
  local ok, err = pcall(function()
    require 'init'
  end)

  if not ok then print(err) end
end)
