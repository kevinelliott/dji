require 'date'
require 'time'

require 'dji/dhl/checkpoint'

module DJI
  module DHL

    class Shipment
      attr_accessor :waybill
      attr_accessor :delivery_code, :delivery_status
      attr_accessor :origin, :destination
      attr_accessor :origin_country, :origin_region, :origin_city
      attr_accessor :destination_country, :destination_region, :destination_city
      attr_accessor :checkpoints
      attr_accessor :estimated_delivery_date, :estimated_delivery_product

      def initialize
        @checkpoints = []
      end

      def destination=(value)
        @destination = value
        self.destination_city, self.destination_region, self.destination_country = value.split(' - ')
      end

      def origin=(value)
        @origin = value
        self.origin_city, self.origin_region, self.origin_country = value.split(' - ')
      end

      class << self

        def new_from_item(item)
          puts item.inspect
          shipment                 = Shipment.new
          shipment.waybill         = item['id']
          shipment.delivery_code   = item['delivery']['code']
          shipment.delivery_status = item['delivery']['status']
          shipment.destination     = item['destination']['value']
          shipment.origin          = item['origin']['value']
          shipment.estimated_delivery_date = Date.parse(item['edd']['date'])
          shipment.estimated_delivery_product = item['edd']['product']

          item['checkpoints'].each do |item|
            checkpoint = Checkpoint.new_from_item(item)
            shipment.checkpoints << checkpoint
          end

          shipment
        end

      end

    end

  end
end
