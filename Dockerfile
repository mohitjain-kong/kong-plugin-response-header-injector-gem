FROM kong:latest

# Install dependencies for building the plugin.  These should match your
# development environment.  Adjust as necessary.
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libtool \
    pkg-config \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Switch back to the kong user
USER kong

# Create the directory where your plugin's source code will live. This
# needs to be accessible to the kong user.
WORKDIR /app

# Copy your plugin's source code into the container.
COPY . /app

# Install LuaRocks dependencies defined in rockspec
RUN luarocks make

# Add your plugin to Kong's configuration.  This tells Kong where to find
# your plugin's code.  Update `KONG_PLUGINS` to include your plugin's name.
#
# Note that the plugin name should match the name in your rockspec file.
ENV KONG_PLUGINS=bundled,response-header-injector-gem
ENV KONG_LUA_PACKAGE_PATH=/app/?.lua;\
                     /usr/local/openresty/lualib/?.lua;\
                     /usr/local/share/lua/5.1/?.lua;\
                     /usr/local/share/lua/?.lua;\
                     /usr/share/lua/5.1/?.lua;\
                     /usr/share/lua/?.lua
ENV KONG_LUA_PACKAGE_CPATH=/usr/local/openresty/lualib/?.so;\
                      /usr/local/lib/lua/5.1/?.so;\
                      /usr/local/lib/lua/?.so;\
                      /usr/lib/lua/5.1/?.so;\
                      /usr/lib/lua/?.so

# Optionally, specify custom Kong configuration options.
# ENV KONG_DECLARATIVE_CONFIG=/path/to/kong.yml
# ENV KONG_DATABASE=off

# Expose Kong's ports
EXPOSE 8000
EXPOSE 8001
EXPOSE 8443
EXPOSE 8444

# Start Kong
CMD ["kong", "start"]