module DustAssets
  class Engine < ::Rails::Engine
    initializer 'sprockets.dust', :after => 'sprockets.environment', :group => :all do |_|
      config.assets.configure do |sprockets_env|
        ::DustAssets::register_extensions(sprockets_env)
      end
    end
  end
end
