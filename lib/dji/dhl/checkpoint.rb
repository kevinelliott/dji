require 'time'

module DJI
  module DHL

    class Checkpoint
      attr_accessor :counter
      attr_accessor :description
      attr_accessor :time_value, :date_value
      attr_accessor :datetime

      class << self

        def new_from_item(item)
          c = Checkpoint.new
          c.counter = item['counter']
          c.description = item['description']
          c.time_value = item['time']
          c.date_value = item['date']
          c.datetime = Time.parse("#{c.date_value}#{c.time_value}")
          c
        end

      end

    end

  end
end
