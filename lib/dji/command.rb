require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/transform_values'

require 'thor'

module DJI
  module Command

    class << self
      def invoke(namespace, args = [], **config)
        namespace = namespace.to_s
        namespace = 'help' if namespace.blank? || Thor::HELP_MAPPINGS.include?(namespace)
        namespace = 'version' if %w( -v --version ).include? namespace

        if command = find_by_namespace(namespace)
          command.perform(namespace, args, config)
        else
          puts "There is no such command: #{namespace}"
          exit
        end
      end
    end

  end
end
