module DJI
  module Command
    class TrackCommand < Base
      desc 'track ORDER_NUMBER PHONE_TAIL', 'track an order'
      option :order_number, required: true, aliases: :o
      option :phone_tail, required: true, aliases: :p
      option :repeat, aliases: :r

      def track
        if options[:repeat].present?
          interval = options[:repeat].to_i.presence || 300
          puts
          puts "Requesting order tracking details every #{interval} seconds. Press CONTROL-C to stop..."

          while true
            DJI::OrderTracking.tracking_details(options[:order_number], options[:phone_tail])
            sleep(interval)
          end
        else
          DJI::OrderTracking.tracking_details(options[:order_number], options[:phone_tail])
        end
      end
    end
  end
end
