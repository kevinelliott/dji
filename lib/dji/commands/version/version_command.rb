module DJI
  module Command
    class VersionCommand < Base
      desc 'version', 'get the version'

      def version
        puts "dji #{DJI::VERSION}"
      end
    end
  end
end
