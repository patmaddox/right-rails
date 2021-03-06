require 'rspec'

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'action_view'
require 'action_controller'

require 'right_rails'

module Rails
  class << self
    def env
      'production'
    end

    def root
      'rails-root'
    end

    def public_path
      "#{root}/public"
    end
  end

  module VERSION
    MAJOR = 2 unless defined?(MAJOR)
  end
end