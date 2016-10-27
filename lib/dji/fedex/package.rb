
module DJI
  module Fedex
    class Package
      attr :tracking_number, :pretty_tracking_number
      attr :tracking_qualifier, :tracking_carrier_code, :tracking_carrier_description
      attr :shipper_company_name, :shipper_name, :shipper_address, :shipper_address_line_2,
           :shipper_city, :shipper_region_code, :shipper_country_code, :shipper_phone_number,
           :shipped_by
      attr :recipient_company_name, :recipient_name, :recipient_address, :recipient_address_line_2,
           :recipient_city, :recipient_region_code, :recipient_country_code, :recipient_phone_number,
           :shipped_to
      attr :key_status, :key_status_code, :last_scan_status, :last_scan_date_time
      attr :received_by, :sub_status, :main_status
      attr :scan_events

      def initialize
        self.scan_events = []
      end

      class << self

        def new_from_response_package_item(item)
          package = Package.new
          package.tracking_number = item['trackingNbr']
          package.pretty_tracking_number = item['displayTrackingNbr']
          package.tracking_qualifier = item['trackingQualifier']
          package.tracking_carrier_code = item['trackingCarrierCd']
          package.tracking_carrrier_description = item['trackingCarrierDesc']

          package.shipper_company_name = item['shipperCmpnyName']
          package.shipper_name = item['shipperName']
          package.shipper_address = item['shipperAddr1']
          package.shipper_address_line_2 = item['shipperAddr2']
          package.shipper_city = item['shipperCity']
          package.shipper_region_code = item['shipperStateCD']
          package.shipper_postal_code = item['shipperZip']
          package.shipper_country_code = item['shipperCntryCD']
          package.shipper_phone_number = item['shipperPhoneNbr']
          package.shipped_by = item['shippedBy']

          package.recipient_company_name = item['recipientCmpnyName']
          package.recipient_name = item['recipientName']
          package.recipient_address = item['recipientAddr1']
          package.recipient_address_line_2 = item['recipientAddr2']
          package.recipient_city = item['recipientCity']
          package.recipient_region_code = item['recipientStateCD']
          package.recipient_postal_code = item['recipientZip']
          package.recipient_country_code = item['recipientCntryCD']
          package.recipient_phone_number = item['recipientPhoneNbr']
          package.shipped_to = item['shippedTo']

          package.key_status = item['keyStatus']
          package.key_status_code = item['keyStatusCD']
          package.last_scan_status = item['lastScanStatus']
          package.last_scan_date_time = item['lastScanDateTime']

          package.received_by = item['receivedByNm']
          package.sub_status = item['subStatus']
          package.main_status = item['mainStatus']

        end

      end

    end
  end
end
