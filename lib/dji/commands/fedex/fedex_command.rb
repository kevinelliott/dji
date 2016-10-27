module DJI
  module Command
    class FedexCommand < Base
      desc 'fedex COUNTRY_CODE POSTAL_CODE', 'track FedEx by reference'
      option :country_code, required: true, aliases: :c
      option :postal_code, required: true, aliases: :p
      option :reference, required: false, aliases: :ref, default: 'DJIGOODS'
      option :repeat, required: false, aliases: :r

      def fedex
        if options[:repeat].present?
          interval = options[:repeat].to_i.presence || 300
          puts
          puts "Requesting FedEx tracking by reference #{options[:reference]} every #{interval} seconds. Press CONTROL-C to stop..."

          while true
            DJI::Fedex.track_by_reference(options[:country_code], options[:postal_code], options[:reference])
            sleep(interval)
          end
        else
          DJI::Fedex.track_by_reference(options[:country_code], options[:postal_code], options[:reference])
        end
      end
    end
  end
end
