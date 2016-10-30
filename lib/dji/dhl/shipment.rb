require 'time'

module DJI
  module Fedex

    class Shipment
      attr_accessor :waybill
      attr_accessor :delivery_status
      attr_accessor :origin, :origin_country, :origin_region, :origin_city
      attr_accessor :destination, :destination_country, :destination_region, :destination_city
      attr_accessor :checkpoints
      attr_accessor :estimated_delivery_date, :estimated_delivery_product

      def initialize
        @checkpoints = []
      end

      class << self

        def new_from_item(item)
          shipment = Shipment.new
          shipment.waybill = item['id']
        end

      end

    end

  end
end
