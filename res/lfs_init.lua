package.loaders[1] = function(module)
  local fn, ba = node.flashindex(module)
  return ba and 'Module not in LFS' or fn
end

tmr.create():alarm(500, tmr.ALARM_SINGLE, function()
  xpcall(function()
    require 'init'
  end, print)
end)
