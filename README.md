# DJI



## Installation

If you already have Ruby installed on your computer, you can install this. Otherwise, go install Ruby and come back to these instructions.

Open a command line (Terminal on macOS):

    $ gem install dji

## Usage

### Track an order

    $ dji track -o ORDER_NUMBER -p PHONE_TAIL

Use your order number in place of ORDER_NUMBER and the last 4 digits of your phone number for PHONE_TAIL. A full example might look like this:

    $ dji track -o 123456789012 -p 1234

    ORDER TRACKING AS OF 2016-10-27 01:12:27 -0700
    ------------------------------------------------------
    Order Number     : 123456789012
    Total            : USD $1,398.00
    Payment Status   : Pay Confirmed
    Shipping Status  : Pending
    Shipping Company : Tba
    Tracking Number  : 

If you want this to repeat automatically at an interval, specify the option for repeat (either -r or --repeat) with the number of seconds. Do not use this nefariously, I suggest a reasonable interval such as 60 seconds, but more useful is probably around 300 seconds (5 minutes) to 600 seconds (10 minutes).

    SpaceX-Falcon-9:dji kevin$ dji track -o 123456789012 -p 1234 -r 60

    Requesting order tracking details every 60 seconds. Press CONTROL-C to stop...

    ORDER TRACKING AS OF 2016-10-27 01:29:36 -0700
    ------------------------------------------------------
    Order Number     : 123456789012
    Total            : USD $1,398.00
    Payment Status   : Pay Confirmed
    Shipping Status  : Pending
    Shipping Company : Tba
    Tracking Number  : 


    ORDER TRACKING AS OF 2016-10-27 01:30:37 -0700
    ------------------------------------------------------
    Order Number     : 123456789012
    Total            : USD $1,398.00
    Payment Status   : Pay Confirmed
    Shipping Status  : Pending
    Shipping Company : Tba
    Tracking Number  : 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dji. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

