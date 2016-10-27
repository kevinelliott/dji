require 'thor'

module DJI
  module Command

    class Base < Thor

      class << self

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
