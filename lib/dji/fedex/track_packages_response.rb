
module DJI
  module Fedex
    class TrackPackagesResponse
      attr :packages

      def initialize
        self.packages = []
      end

      class << self
        def new_from_response(response)
          return nil if !response.has_key?('successful') || response['successful'].blank?

          tpr = TrackPackagesResponse.new

          response['packageList'].each do |item|
            package = Package.new_from_response_package_item(item)
            tpr.packages << package if package.present?
          end

          return tpr
        end
      end

    end
  end
end