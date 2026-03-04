# response-header-injector-gem

A Kong Gateway plugin that injects a custom response header `X-Powered-By-Gem` into every response.  The header value is configurable.

## Purpose

This plugin is useful for adding a custom header to all responses from your Kong Gateway instance.  This can be used for various purposes, such as:

*   Identifying the origin of the response (e.g., for internal tracking or debugging).
*   Advertising your application or organization.
*   Adding a custom identifier for security purposes.

## Configuration

You can configure the plugin by adding it to a service, route, or globally. The following configuration options are available:

| Field       | Type   | Required | Default | Description                                                                           |
| ----------- | ------ | -------- | ------- | ------------------------------------------------------------------------------------- |
| `header_value` | string | Yes      |         | The value to be injected into the `X-Powered-By-Gem` response header.                   |
| `enabled`  | boolean | No       | `true`  | Whether the plugin is enabled or not.                                               |

### Example Configuration

To configure the plugin on a specific route:

curl -X POST http://localhost:8001/routes/{route_id}/plugins \
  --data "name=response-header-injector-gem" \
  --data "config.header_value=My Awesome Application"

To configure the plugin globally:

curl -X POST http://localhost:8001/plugins \
  --data "name=response-header-injector-gem" \
  --data "config.header_value=My Global Configuration"

## Installation

1.  Clone this repository into your Kong plugin directory.  The default Kong plugin directory is `/usr/local/share/kong/plugins`.

    ```bash
    git clone https://github.com/your-username/response-header-injector-gem /usr/local/share/kong/plugins/response-header-injector-gem
    

2.  Add the plugin to the `plugins` section of your Kong configuration file (`kong.conf`).

    
    plugins = bundled,response-header-injector-gem
    

3.  Restart Kong.

    ```bash
    kong restart
    

## Usage

Once the plugin is installed and configured, it will automatically inject the `X-Powered-By-Gem` header into every response that passes through Kong.

For example, if you configure the plugin with `header_value=My Application`, the response header will be:

X-Powered-By-Gem: My Application

## Development

### Prerequisites

*   Kong Gateway development environment.
*   LuaRocks.

### Testing

Run the unit tests:

busted spec

### Contributing

Contributions are welcome! Please submit a pull request with your changes.