# Privat24Api

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/privat24_api`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'privat24_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install privat24_api

## Usage

### CONFIGURE
```ruby
Privat24Api.configure do |config|
  config.cards << Privat24Api::Card.new(
    card_num:          '1111222233334444', 
    merchant_id:       '123456',
    merchant_password: 'OdFgjdOskdnsKJHD7GSHdgv8dd'
  )

  config.cards << Privat24Api::Card.new(
    card_num:          '5555666677778888', 
    merchant_id:       '78910',
    merchant_password: 'FdhshgdshdgsKJHD7GSHdgv8dd'
  )
end
```
### INFO METHODS
```ruby
Privat24Api.cards.first.info.balance()

Privat24Api.cards.first.info.transaction_details('01.09.2018', '25.09.2018')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/privat24_api.
