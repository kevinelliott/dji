module DJI
  module Command
    class VersionCommand < Base
      desc 'version', 'get the version'

      def perform
        puts "dji #{DJI::VERSION}"
      end
    end
  end
end
