
module DJI
  module DHL

    class TrackingResults
      attr_accessor :shipments

      def initialize
        @shipments = []
      end

      class << self

        def new_from_results(results)
          return nil if results.blank?

          tr = TrackingResults.new

          results.each do |item|
            shipment = Shipment.new_from_item(item)
            tr.shipments << shipment
          end

          tr
        end

      end

    end

  end
end