require "spree_delayed_job/version"
require "spree_delayed_job/delayed_rake"

module SpreeDelayedJob
  class Engine < Rails::Engine
    railtie_name "spree_delayed_job"
    engine_name 'spree_delayed_job'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
