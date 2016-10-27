module DJI
  module Command
    class TrackCommand < Base
      desc 'track ORDER_NUMBER PHONE_TAIL', 'track an order'
      option :order_number, required: true, aliases: :o
      option :phone_tail, required: true, aliases: :p

      def track
        DJI::OrderTracking.tracking_details(order_number, phone_tail)
      end
    end
  end
end
