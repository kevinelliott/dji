# DJI



## Installation

If you already have Ruby installed on your computer, you can install this. Otherwise, go install Ruby and come back to these instructions.

Open a command line (Terminal on macOS):

    $ gem install dji

When updates are released, you can get them with:

    $ gem update dji

If you do not manage your Ruby installations with RVM and are just using the system ruby, you might need to prefix the above commands with sudo, such as:

    $ sudo gem install dji

If you are on Ubuntu Linux, you can do:

    $ sudo apt install ruby ruby-dev
    $ sudo gem install dji

## Usage

### Order Tracking

```
    $ dji track [options]
    
    OPTIONS:
    
    -o, --order ORDER_NUMBER  # Your order number
    -p, --phone PHONE_TAIL    # Last 4 digits of your phone number
    -r, --repeat INTERVAL     # Optional: Repat every INTERVAL seconds
    --publish                 # Optional: Publish your order details to http://dji-track.herokuapp.com/orders
```

#### Example: Track an order

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

#### Example: Track an order, every 60 seconds

If you want this to repeat automatically at an interval, specify the option for repeat (either -r or --repeat) with the number of seconds. Do not use this nefariously, I suggest a reasonable interval such as 60 seconds, but more useful is probably around 300 seconds (5 minutes) to 600 seconds (10 minutes).

    $ dji track -o 123456789012 -p 1234 -r 60

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

#### Example: Track an order, and publish it for others to see

    $ dji track -o 123456789012 -p 1234 --publish

    ORDER TRACKING AS OF 2016-10-27 01:12:27 -0700
    ------------------------------------------------------
    Order Number     : 123456789012
    Total            : USD $1,398.00
    Payment Status   : Pay Confirmed
    Shipping Status  : Pending
    Shipping Company : Tba
    Tracking Number  : 

    You have successfully published your latest order status.
    See order statuses reported by others at http://dji-track.herokuapp.com/orders

### Search FedEx and track by reference

If you think your shipper is FedEx but you don't have a tracking code yet, you might be able to find your shipment by
searching Fedex by reference. This allows you to search and track by reference.

    $ dji track -c COUNTRY_CODE -p POSTAL_CODE

An example of searching in the USA (country code is us) with a postal code:

    $ dji fedex -c us -p 94123

    FedEx Packages for Country us, Postal Code 94123 as of 2016-10-27 03:44:37 -0700
    -------------------------------------------------------------------------------------------------------

    PACKAGE 1

    Origin       : SHENZHEN, CN
    Destination  : San Francisco, CA, US
    Tendered     : 
    Picked Up    : 
    Shipped      : 2016-10-27 00:00:00 -0600
    Est. Deliver : 2016-10-31 10:30:00 -0700
    Dimensions   : 22x34x16 cms
    Total Weight : 9.7 lbs (4.4 kgs)
    Status       : Label created

If you want to search by a different reference, you can optionally pass it in:

    $ dji fedex -c us -p 94123 --reference DJIGOODS

    FedEx Packages for Country us, Postal Code 94123 as of 2016-10-27 03:50:57 -0700
    -------------------------------------------------------------------------------------------------------

    PACKAGE 1

    Origin       : SHENZHEN, CN
    Destination  : San Francisco, CA, US
    Tendered     : 
    Picked Up    : 
    Shipped      : 2016-10-27 00:00:00 -0600
    Est. Deliver : 2016-10-31 10:30:00 -0700
    Dimensions   : 22x34x16 cms
    Total Weight : 9.7 lbs (4.4 kgs)
    Status       : Label created

You may also have it repeat the search on a regular interval (in seconds):

    $ dji fedex -c us -p 94123 -r 120

    Requesting FedEx tracking by reference DJIGOODS every 120 seconds. Press CONTROL-C to stop...

    FedEx Packages for Country us, Postal Code 94123 as of 2016-10-27 03:53:41 -0700
    -------------------------------------------------------------------------------------------------------

    PACKAGE 1

    Origin       : SHENZHEN, CN
    Destination  : San Francisco, CA, US
    Tendered     : 
    Picked Up    : 
    Shipped      : 2016-10-27 00:00:00 -0600
    Est. Deliver : 2016-10-31 10:30:00 -0700
    Dimensions   : 22x34x16 cms
    Total Weight : 9.7 lbs (4.4 kgs)
    Status       : Label created


    FedEx Packages for Country us, Postal Code 94123 as of 2016-10-27 03:55:42 -0700
    -------------------------------------------------------------------------------------------------------

    PACKAGE 1

    Origin       : SHENZHEN, CN
    Destination  : San Francisco, CA, US
    Tendered     : 
    Picked Up    : 
    Shipped      : 2016-10-27 00:00:00 -0600
    Est. Deliver : 2016-10-31 10:30:00 -0700
    Dimensions   : 22x34x16 cms
    Total Weight : 9.7 lbs (4.4 kgs)
    Status       : Label created

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dji. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

