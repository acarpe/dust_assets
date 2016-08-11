module DustAssets
  class DustProcessor

    def self.instance
      @instance ||= new
    end

    def self.call(input)
      instance.call(input)
    end

    def self.cache_key
      instance.cache_key
    end

    attr_reader :cache_key

    def initialize(options = {})
      @cache_key = [self.class.name, ::DustAssets::VERSION, options].freeze
    end

    def call(input)
      template_name = input[:name]
      compiled = Dust.precompile(input[:data], template_name)
      <<-TEMPLATE
        (function(ctx, callback) {
          dust.loadSource(#{compiled.inspect});
          dust.render('#{template_name}', ctx, callback);
        })
      TEMPLATE
    end
  end

end
