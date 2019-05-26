module Qg
  class << self
    def configure
      yield(configuration)
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end

  class Configuration
    attr_accessor :default

    def initialize
      @default = {}
    end
  end
end
