require 'dust_assets/version'
require 'sprockets/jst_processor'

module DustAssets
  autoload(:Dust, 'dust_assets/dust')
  autoload(:DustProcessor, 'dust_assets/dust_processor')

  PATH = File.expand_path('../../vendor/assets/javascripts', __FILE__)

  def self.path
    PATH
  end

  def self.register_extensions(sprockets_environment)
    sprockets_environment.register_mime_type 'text/dust', extensions: ['.dust', '.jst.dust']
    # SEE https://github.com/rails/sprockets/blob/e2952781d383f286b55c532d2347f42fa6679cfd/lib/sprockets.rb#L168
    sprockets_environment.register_transformer 'text/dust', 'application/javascript+function', DustProcessor
    sprockets_environment.register_transformer 'application/javascript+function', 'application/javascript', Sprockets:: JstProcessor
  end

  def self.add_to_asset_versioning(sprockets_environment)
    sprockets_environment.version += "-#{DustAssets::VERSION}"
  end
end

if defined?(Rails)
  require 'dust_assets/engine'
else
  require 'sprockets'
  ::DustAssets.register_extensions(Sprockets)
end
