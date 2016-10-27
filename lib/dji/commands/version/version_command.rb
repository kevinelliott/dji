module DJI
  module Command
    class VersionCommand < Base
      def perform
        puts "dji #{DJI::VERSION}"
      end
    end
  end
end
