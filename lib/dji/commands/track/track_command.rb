module DJI
  module Command
    class TrackCommand < Base
      desc 'track ORDER_NUMBER PHONE_TAIL', 'track an order'
      option :order_number, required: true, aliases: :o
      option :phone_tail, required: true, aliases: :p
      option :repeat, aliases: :r
      option :publish, required: false, default: false
      
      option :country, required: false, aliases: :c
      option :debug, required: false, default: false, aliases: :d
      option :dji_username, required: false, aliases: [:username, :u]
      option :email_address, required: false, aliases: [:email, :e]

      def track
        provided_options = {
          order_number: options[:order_number],
          phone_tail:   options[:phone_tail],
          country:      options[:country],
          debug:        options[:debug],
          dji_username: options[:dji_username],
          email:        options[:email_address],
        }

        if options[:repeat].present?
          interval = options[:repeat].to_i.presence || 300
          puts
          puts "Requesting order tracking details every #{interval} seconds. Press CONTROL-C to stop..."

          while true
            data = DJI::OrderTracking.tracking_details(provided_options)
            DJI::OrderTracking.publish(data) if data.present? && options[:publish].present?
            sleep(interval)
          end
        else
          data = DJI::OrderTracking.tracking_details(provided_options)
          DJI::OrderTracking.publish(data) if data.present? && options[:publish].present?
        end
      end
    end
  end
end
