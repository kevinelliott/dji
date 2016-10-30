require 'time'

module DJI
  module DHL

    class Shipment
      attr_accessor :waybill
      attr_accessor :delivery_code, :delivery_status
      attr_accessor :origin, destination
      attr_accessor :origin_country, :origin_region, :origin_city
      attr_accessor :destination_country, :destination_region, :destination_city
      attr_accessor :checkpoints
      attr_accessor :estimated_delivery_date, :estimated_delivery_product

      def initialize
        @checkpoints = []
      end

      def origin=(value)
        self.origin = value
        self.origin_city, self.origin_region, self.origin_country = value.split(' - ')
      end

      class << self

        def new_from_item(item)
          shipment                 = Shipment.new
          shipment.waybill         = item['id']
          shipment.delivery_code   = item['delivery']['code']
          shipment.delivery_status = item['delivery']['status']
          shipment.origin          = item['origin']['value']
          shipment
        end

      end

    end

  end
end
