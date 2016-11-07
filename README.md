# Finicity::Ruby
[![Build Status](https://travis-ci.org/Fundthrough/finicity-ruby.svg?branch=master)](https://travis-ci.org/Fundthrough/finicity-ruby)
[![Code Climate](https://codeclimate.com/github/Fundthrough/finicity-ruby/badges/gpa.svg)](https://codeclimate.com/github/Fundthrough/finicity-ruby)
[![License](http://img.shields.io/:license-MIT-blue.svg?style=flat)](LICENSE)


Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/finicity/ruby`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'finicity-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install finicity-ruby

## Usage

In your `config/initializers/` add `finicity.rb` file with corresponding values:

    Finicity.configure do |config|
      config.base_url       = "https://api.finicity.com/aggregation"
      config.app_key        = "xxxxxxxxxxxxxxxx"
      config.partner_id     = "xxxxxxxxxxxxxxxx"
      config.partner_secret = "xxxxxxxxxxxxxxxx"
      config.app_type       = "testing" # or "active"
      config.verbose        = false # or "true"
      config.max_retries    = 1 # How many times do you want to retry the request in case timeout failures.
    end

### Institutions
#### List

To get all institutions

    Finicity::Client.institution.list

To search for specific institution

    Finicity::Client.institution.list(search: "Royal Bank of Canada")

#### Get specific Institution (with login Credentials)
Using the `id` you just got from the list above, you can find any specific institution

    Finicity::Client.institution.get("107132")


### Customers
#### Add new customer
Finicity requires `username` to add a new customer. The response will contain the customer ID to be used for subsequent calls.

    response = Finicity::Client.customer.add("YetAnotherBatman")
    customer_id = response.body.customer.id

#### Delete customer
Using the `customer_id` you just got after you add the customer.

    Finicity::Client.scope(customer_id).delete

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/finicity-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

