local typedefs = require "kong.db.schema.typedefs"

return {
  name = "response-header-injector-gem",
  fields = {
    { consumer = typedefs.no_consumer },
    { config = {
      type = "record",
      fields = {
        { header_value = { type = "string", required = true, default = "Kong Gateway" } },
      },
    }},
  }
}