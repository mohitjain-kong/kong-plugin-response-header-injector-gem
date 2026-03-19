# response-header-injector-gem

A Kong Gateway plugin that injects a custom response header `X-Powered-By-Gem` with a configurable string value on every response.

## Purpose

This plugin allows you to add a custom header to every response served by your Kong Gateway, which can be useful for identifying and tracking requests that have passed through specific Kong instances or deployments, aiding in debugging, or simply adding a custom attribution.

## Installation

1.  Clone this repository or download the plugin files.
2.  Place the plugin files in Kong's `plugins/` directory.  The location of this directory depends on your Kong installation method.  For example, it might be `/usr/local/share/lua/5.1/kong/plugins` or `/opt/kong/plugins`.  Consult the Kong documentation for your specific installation.
3.  Restart or reload Kong to load the new plugin.

## Configuration

You can configure this plugin through the Kong Admin API or declarative configuration. The following configuration options are available:

| Field         | Type    | Required | Default | Description                                                                                                      |
|---------------|---------|----------|---------|------------------------------------------------------------------------------------------------------------------|
| `header_value`| string  | Yes      |         | The value to be inserted into the `X-Powered-By-Gem` header.  This is the main configuration option.         |
| `enabled`     | boolean | No       | `true`  | Whether the plugin is enabled or not.                                                                          |

**Example (Admin API):**

curl -X POST http://kong:8001/services/{service}/plugins \
  --data "name=response-header-injector-gem" \
  --data "config.header_value=PoweredByMyAwesomeGem"

Replace `{service}` with the ID or name of your service.

**Example (Declarative Configuration):**

plugins:
  - name: response-header-injector-gem
    service: {service_id}
    config:
      header_value: PoweredByMyDeclarativeConfig

Replace `{service_id}` with the ID of your service.

## Usage

Once the plugin is configured and enabled, every response from the associated service/route will include the `X-Powered-By-Gem` header with the value specified in the `header_value` configuration option.

**Example Response Header:**

HTTP/1.1 200 OK
...
X-Powered-By-Gem: PoweredByMyAwesomeGem
...

## Implementation Details

This plugin uses Kong's `header_filter` phase to inject the custom header into the response before it is sent to the client. This ensures that the header is present in every response, regardless of the upstream service's behavior.

## Development

1.  Fork this repository.
2.  Make your changes.
3.  Submit a pull request.

## License

MIT