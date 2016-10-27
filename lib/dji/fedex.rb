require 'json'
require 'net/http'
require 'uri'

require 'nokogiri'         

require 'dji/fedex/track_packages_response'

module DJI
  module Fedex
  
    class << self

      # Get the tracking details for an order
      def tracking_details(country, postal_code)
        uri = URI.parse(tracking_url)
        params = {
          'action' => 'altref',
          'trackingnumber' => 'DJI GOODS',
          'cntry_code' => country,
          'shipdate' => Time.now.strftime('%Y-%m-%d'),
          'dest_postal' => postal_code
        }
        uri.query = URI.encode_www_form(params)

        headers = {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Origin' => 'https://www.fedex.com/',
          'Referer' => tracking_url
        }

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        res = http.get(uri.request_uri, headers)

        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          puts res.body
          # OK
          # page = Nokogiri::HTML(res.body)
          # content = page.at_xpath('//div[@id="main"]/div[@class="container"]/div[@class="row"]/div[@class="col-xs-9"]/div[@class="col-xs-10 well"][2]')
          # # puts content
          # data = {}
          # data[:order_number] = content.at_xpath('div[1]').text.split(' ')[-1]
          # data[:total]        = content.at_xpath('div[2]').text.split(' ')[1..-1].join(' ')
          # data[:payment_status] = content.at_xpath('div[3]').text.split(': ')[1]
          # data[:shipping_status] = content.at_xpath('div[4]').text.split(': ')[1]
          # data[:shipping_company] = content.at_xpath('div[5]/span').text
          # data[:tracking_number] = content.at_xpath('div[6]/a').text
          
          # print_tracking_details(data)
        else
          puts res.inspect
          res.error!
        end

      end

      # The URL for order tracking
      def tracking_url
        'https://www.fedex.com/apps/fedextrack/'
      end

      def track_by_reference(country_code, postal_code, reference="DJIGOODS")
        uri = URI.parse(tracking_url_json)

        params = {
          'action' => 'altReferenceList',
          'locale' => 'en_US',
          'version' => 1,
          'format' => 'json'
        }
        params['data'] = {
          'TrackPackagesRequest' => {
            'appType' => 'WTRK',
            'appDeviceType' => 'DESKTOP',
            'uniqueKey' => '',
            'processingParameters' => {},
            'trackingInfoList' => [
              {
                'referenceInfo' => {
                  'referenceValueList' => [reference],
                  'shipDate' => Time.now.strftime('%Y-%m-%d'),
                  'postalCode' => postal_code,
                  'countryCode' => country_code,
                  'accountNbr' => ''
                }
              }
            ]
          }
        }.to_json

        headers = {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Origin' => 'https://www.fedex.com/',
          'Referer' => tracking_url,
          'Accept' => '*/*',
          'X-Requested-With' => 'XMLHttpRequest'
        }

        http = Net::HTTP.new uri.host, uri.port
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Post.new uri.path, headers
        request.set_form_data params
        res = http.request(request)

        case res
        when Net::HTTPSuccess, Net::HTTPRedirection
          # OK
          # puts res.body
          response = JSON.parse(res.body)['TrackPackagesResponse']
          tpr = DJI::Fedex::TrackPackagesResponse.new_from_response(response)

          data = { country_code: country_code, postal_code: postal_code }
          if tpr.present?
            data[:track_packages_response] = tpr
            print_track_packages_response(data)
          else
            puts response
            puts "Nothing parsed!"
          end
          # page = Nokogiri::HTML(res.body)
          # content = page.at_xpath('//div[@id="main"]/div[@class="container"]/div[@class="row"]/div[@class="col-xs-9"]/div[@class="col-xs-10 well"][2]')
          # # puts content
          # data = {}
          # data[:order_number] = content.at_xpath('div[1]').text.split(' ')[-1]
          # data[:total]        = content.at_xpath('div[2]').text.split(' ')[1..-1].join(' ')
          # data[:payment_status] = content.at_xpath('div[3]').text.split(': ')[1]
          # data[:shipping_status] = content.at_xpath('div[4]').text.split(': ')[1]
          # data[:shipping_company] = content.at_xpath('div[5]/span').text
          # data[:tracking_number] = content.at_xpath('div[6]/a').text
          
          # print_tracking_details(data)
        else
          puts res.inspect
          res.error!
        end

      end

      def tracking_url_json
        'https://www.fedex.com/trackingCal/track'
      end

      def print_track_packages_response(data)
        now = Time.now.to_s

        puts
        puts "FedEx Packages for Country #{data[:country_code]}, Postal Code #{data[:postal_code]} as of #{now}"
        puts "-------------------------------------------------------------------------------------------------------"
        puts

        data[:track_packages_response].packages.each_with_index do |package, index|
          puts "PACKAGE #{index+1}"
          puts
          puts "Origin       : #{package.origin}"
          puts "Destination  : #{package.destination}"
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