require = function(m)
  return dofile(m .. '.lc')
end

tmr.create():alarm(1500, tmr.ALARM_SINGLE, function()
  xpcall(function()
    require 'app'
  end, print)
end)
