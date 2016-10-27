require 'net/http'
require 'uri'

require 'nokogiri'         

module DJI
  class Fedex

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

        http = Net::HTTP.new uri.host, uri.port
        request = Net::HTTP.get(uri, headers)
        res = http.request(request)

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