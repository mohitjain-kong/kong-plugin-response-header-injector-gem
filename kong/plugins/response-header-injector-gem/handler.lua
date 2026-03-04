local plugin = {}; plugin.VERSION = "1.0.0"; plugin.PRIORITY = 1000

function plugin:header_filter(conf)
  if conf.value and conf.value ~= ngx.null then
    kong.response.set_header("X-Powered-By-Gem", conf.value)
  end
end

return plugin