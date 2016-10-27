require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/descendants_tracker'
require 'active_support/core_ext/module/delegation'

require 'dji/version'

module DJI
  extend ActiveSupport::Autoload

  puts ActiveSupport::Dependencies.autoload_paths
  autoload :Command
  autoload :OrderTracking
end
