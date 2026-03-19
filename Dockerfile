FROM kong:latest

# Install necessary packages
USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    zlib1g-dev \
    ruby \
    ruby-dev \
    rubygems && \
    rm -rf /var/lib/apt/lists/*

# Install bundler
RUN gem install bundler

# Create plugin directory
RUN mkdir -p /opt/kong/plugins/response-header-injector-gem

# Copy plugin files
COPY . /opt/kong/plugins/response-header-injector-gem/

# Install plugin dependencies (if any) using bundler
WORKDIR /opt/kong/plugins/response-header-injector-gem/
RUN if [ -f Gemfile ]; then bundle install ; fi

# Change ownership of plugin directory
RUN chown -R kong:kong /opt/kong/plugins/response-header-injector-gem

# Switch back to kong user
USER kong

# Add plugin to Kong configuration
ENV KONG_PLUGINS=bundled,response-header-injector-gem

# Optionally set plugin cpath if needed (usually not required if following Kong plugin structure)
# ENV KONG_PLUGIN_PATH=/opt/kong/plugins

# Example configuration for Kong (optional, can be overridden in kong.conf)
# ENV KONG_ADMIN_LISTEN=0.0.0.0:8001
# ENV KONG_PROXY_LISTEN=0.0.0.0:8000

# Expose Kong admin and proxy ports
EXPOSE 8000
EXPOSE 8001

# Start Kong (command might be defined in the base image)
# CMD kong start