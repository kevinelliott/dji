require 'thor'
require 'active_support/inflector'

module DJI
  module Command
    
    class Base < ::Thor
      
      class << self

        # Convenience method to get the namespace from the class name. It's the
        # same as Thor default except that the Command at the end of the class
        # is removed.
        def namespace
          ActiveSupport::Inflector.underscore(
            ActiveSupport::Inflector.demodulize(
              name
            )
          ).chomp("_command").sub(/:command:/, ":")
        end

        def inherited(base) #:nodoc:
          super

          if base.name && base.name !~ /Base$/
            DJI::Command.subclasses << base
          end
        end

        def perform(command, args, config) # :nodoc:
          command = nil if Thor::HELP_MAPPINGS.include?(args.first)

          dispatch(command, args.dup, nil, config)
        end

        # Return command name without namespaces.
        #
        #   DJI::Command::TestCommand.command_name # => 'test'
        def command_name
          @command_name ||= begin
            if command = name.to_s.split("::").last
              command.chomp!("Command")
              command.underscore
            end
          end
        end

      end

    end

  end
end
