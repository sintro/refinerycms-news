require 'refinerycms-core'
require 'refinerycms-settings'

module Refinery
  autoload :NewsGenerator, 'generators/refinery/news_generator'

  module News
    require 'refinery/news/engine'

    autoload :Tab, 'refinery/news/tabs'

    class << self
      attr_writer :root
      attr_writer :tabs

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def tabs
        @tabs ||= []
      end

      def factory_paths
        @factory_paths ||= [ root.join("spec/factories").to_s ]
      end
    end
  end
end
