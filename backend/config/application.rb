# frozen_string_literal: true
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.load_defaults 7.0

    config.session_store :cookie_store, key: '_lov3time_session_key_1'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options

    config.api_only = true

    # For this: https://github.com/lynndylanhurley/devise_token_auth/issues/1536
    config.action_controller.raise_on_open_redirects = false
  end
end
