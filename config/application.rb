require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Erp
  class Application < Rails::Application
    config.web_console.whitelisted_ips = '192.168.1.7'
  end
end
