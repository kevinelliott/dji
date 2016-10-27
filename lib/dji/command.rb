require 'active_support'
require 'active_support/dependencies/autoload'
require 'active_support/core_ext/enumerable'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/transform_values'

require 'thor'

module DJI
  module Command
    extend ActiveSupport::Autoload

    autoload :Behavior
    autoload :Base

    include Behavior

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

      def find_by_namespace(name) # :nodoc:
        lookups = [ name, "dji:#{name}" ]

        lookup(lookups)

        namespaces = subclasses.index_by(&:namespace)
        namespaces[(lookups & namespaces.keys).first]
      end

      protected

      def command_type
        @command_type ||= "command"
      end

      def lookup_paths
        @lookup_paths ||= %w( dji/commands commands )
      end

    end

  end
end
