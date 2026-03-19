local plugin = {}; plugin.VERSION = "1.0.0"; plugin.PRIORITY = 1000

function plugin:header_filter(conf)
  if conf.header_value and conf.header_value ~= ngx.null then
    kong.response.set_header("X-Powered-By-Gem", conf.header_value)
  end
end

return plugin