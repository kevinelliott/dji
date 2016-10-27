require 'active_support'
require 'active_support/dependencies'
require 'active_support/dependencies/autoload'
require 'active_support/descendants_tracker'
require 'active_support/core_ext/class/subclasses'
require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/array/extract_options'

require 'dji/version'

module DJI
  extend ActiveSupport::Autoload

  autoload :OrderTracking
end
