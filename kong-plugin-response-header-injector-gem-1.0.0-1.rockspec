package = "kong-plugin-response-header-injector-gem"
version = "1.0.0-1"
supported_platforms = {"linux", "macosx"}
source = {
  url = "https://github.com/mohitjain-kong/kong-plugin-response-header-injector-gem/archive/refs/tags/v1.0.0.tar.gz",
  dir = "kong-plugin-response-header-injector-gem-1.0.0",
}
description = {
  summary = "Kong plugin to inject a custom response header",
  homepage = "https://github.com/mohitjain-kong/kong-plugin-response-header-injector-gem",
  license = "MIT"
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["kong.plugins.response-header-injector-gem.handler"] = "kong/plugins/response-header-injector-gem/handler.lua",
    ["kong.plugins.response-header-injector-gem.schema"] = "kong/plugins/response-header-injector-gem/schema.lua",
  }
}