require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CozyPlanet
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths += %W(#{config.root}/lib)
  	config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.sass.load_paths << File.expand_path('../../vendor/assets/stylesheets/')
    config.assets.paths << File.expand_path('../../vendor/assets/javascripts/')
    config.filter_parameters << :password

    config.time_zone = 'Asia/Kuala_Lumpur'
  end
end
