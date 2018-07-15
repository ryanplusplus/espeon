require = function(m)
  return dofile(m .. '.lc')
end

tmr.create():alarm(1250, tmr.ALARM_SINGLE, function()
  xpcall(function()
    require 'init'
  end, print)
end)
