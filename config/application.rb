require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FindDataBeta
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.assets.initialize_on_precompile = false
    config.exceptions_app = self.routes

    config.analytics_tracking_id = ENV['GA_TRACKING_ID']
    config.analytics_test_tracking_id = ENV['GA_TEST_TRACKING_ID']
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**','**','*.{rb,yml}')]
    config.filter_parameters << :password
    config.filter_parameters << :password_confirmation

    Raven.configure do |config|
      if ENV['SENTRY_DSN']
        config.dsn = ENV['SENTRY_DSN']
      end

      config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
    end
  end
end
