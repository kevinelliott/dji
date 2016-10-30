require 'json'
require 'net/http'
require 'uri'

require 'nokogiri'         

#require 'dji/fedex/track_packages_response'

module DJI
  module DHL
  
    class << self

      # Get the tracking details for a waybill
      def track(waybill)
        uri = URI.parse(tracking_url_json)
        params = {
          'AWB' => waybill,
          'languageCode' => 'en'
        }
        uri.query = URI.encode_www_form(params)

        headers = {
          'Origin' => 'http://www.dhl.com/',
          'Referer' => tracking_url_json
        }

        http = Net::HTTP.new(uri.host, uri.port)
        res = http.get(uri.request_uri, headers)

        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          puts res.body

          # response = JSON.parse(res.body)['TrackPackagesResponse']
          # tpr = DJI::Fedex::TrackPackagesResponse.new_from_response(response)

          # data = { country_code: country_code, postal_code: postal_code }
          # if tpr.present?
          #   data[:track_packages_response] = tpr
          #   print_track_packages_response(data)
          # else
          #   puts response
          #   puts "Nothing parsed!"
          # end
          
          # print_tracking_details(data)
        else
          puts res.inspect
          res.error!
        end

      end

          # OK
          # puts res.body

      def tracking_url_json
        'http://www.dhl.com/shipmentTracking'
      end

      def print_tracking_response(data)
        now = Time.now.to_s

        puts
        puts "DHL Tracking for Airway Bill: #{data[:waybill]}"
        puts "-------------------------------------------------------------------------------------------------------"
        puts

        data[:track_packages_response].packages.each_with_index do |package, index|
          puts "PACKAGE #{index+1}"
          puts
          puts "Origin       : #{package.origin}"
          puts "Destination  : #{package.destination}"
          puts "Tendered     : #{package.tendered_date}"
          puts "Picked Up    : #{package.pickup_date}"
          puts "Shipped      : #{package.ship_date}"
          puts "Est. Deliver : #{package.estimated_delivery_date}" if package.estimated_delivery_date.present?
          puts "Delivered    : #{package.delivery_date}" if package.delivery_date.present?
          puts "Dimensions   : #{package.dimensions}"
          puts "Total Weight : #{package.total_weight[:pounds]} lbs (#{package.total_weight[:kilograms]} kgs)"
          puts "Status       : #{package.key_status}"
          puts
        end
      end

      def print_tracking_details(data)
          now = Time.now.to_s

          puts
          puts "ORDER TRACKING AS OF #{now}"
          puts "------------------------------------------------------"
          puts "Order Number     : #{data[:order_number]}"
          puts "Total            : #{data[:total]}"
          puts "Payment Status   : #{data[:payment_status]}"
          puts "Shipping Status  : #{data[:shipping_status]}"
          puts "Shipping Company : #{data[:shipping_company]}"
          puts "Tracking Number  : #{data[:tracking_number]}"
          puts
      end

    end
    
  end
end

# http://www.dhl.com/shipmentTracking?AWB=5902444026&languageCode=en

