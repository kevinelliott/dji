require 'active_support'

module DJI
  module Command
    module Behavior
      extend ActiveSupport::Concern

      class_methods do

        def subclasses
          @subclasses ||= []
        end

      end

      protected

      # Receives namespaces in an array and tries to find matching generators
      # in the load path.
      def lookup(namespaces) #:nodoc:
        paths = namespaces_to_paths(namespaces)

        paths.each do |raw_path|
          lookup_paths.each do |base|
            path = "#{base}/#{raw_path}_#{command_type}"

            begin
              require path
              return
            rescue LoadError => e
              raise unless e.message =~ /#{Regexp.escape(path)}$/
            rescue Exception => e
              warn "[WARNING] Could not load #{command_type} #{path.inspect}. Error: #{e.message}.\n#{e.backtrace.join("\n")}"
            end
          end
        end
      end

      # Convert namespaces to paths by replacing ":" for "/" and adding
      # an extra lookup. For example, "dji:track" should be searched
      # in both: "dji/track/track_command" and "dji/track_command".
      def namespaces_to_paths(namespaces) #:nodoc:
        paths = []
        namespaces.each do |namespace|
          pieces = namespace.split(":")
          paths << pieces.dup.push(pieces.last).join("/")
          paths << pieces.join("/")
        end
        paths.uniq!
        paths
      end

    end
  end
end