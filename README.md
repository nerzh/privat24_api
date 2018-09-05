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
### RUBY HASH, JSON AND XML RESPONSE
```ruby
response = Privat24Api.cards.first.info.balance()

# ruby hash response
response.to_hash

# json response
response.to_json

# xml response
response.to_xml
```

### INFO METHODS
```ruby
card = Privat24Api.cards.first

card.info.balance

#sd    required    Начало периода. Формат дд.мм.гггг
#ed    required    Конец периода. Формат дд.мм.гггг
card.info.transaction_details('01.09.2018', '25.09.2018')
```

### PAYMENT METHODS
```ruby
card = Privat24Api.cards.first

#payment id    required    Уникальный идентификатор платежа, присвоенный партнером платежей. Повторяется в ответе на запрос, сохраняется в базе Приват24, служит для однозначного сопоставления операций на стороне партнера платежей с операциями в приват24.
#card    required    Карта или счёт получателя
#amount    required    Сумма Напр.: 23.05
#currency    required    Валюта (UAH, EUR, USD)
#details    required    Назначение платежа
card.payment.pay_on_privat_card(payment_id, card, amount, details, currency='UAH')

#card    required    Счёт получателя
#amount    required    Сумма Напр.: 23.05
#currency    required    Валюта (UAH, EUR, USD)
#b_name    required    Наименование получателя
#b_crf    required    ОКПО банка получателя
#b_bic    required    МФО банка получателя
#details    required    Назначение платежа
card.payment.pay_on_ua_card(payment_id, card, amount, b_name, b_crf, b_bic, details, currency='UAH')

#card    required    Карта или счёт получателя
#amount    required    Сумма Напр.: 23.05
#currency    required    Валюта (UAH, EUR, USD)
#b_name    required    ФИО получателя
#details    required    Назначение платежа
card.payment.pay_on_visa_card(payment_id, card, amount, b_name, details, currency='UAH')

#id    required/optional    Уникальный идентификатор платежа, присвоенный партнером платежей. (payment_id из предыдущего запроса). Обязательный, если не передается параметр ref
#ref    required/optional    Уникальный идентификатор платежа, присвоенный приват24. Возвращается в ответе на запрос создания платежа. Обязательный, если не передается параметр id
card.payment.check_status_pay(id, ref)

#phone    required    Номер телефона
#amount    required    Сумма (грн.)
card.payment.pay_on_mobile(phone, amount)

#phones [{number: '0631234567', amount: '100'}, {number: '0637654321', amount: '200'}]
card.payment.pay_on_mobile_multiple(*phones)

#id="SIVN1392995003.855" - приходит в ответ на запрос пополнения
card.payment.check_status_mobile(id)

#phone_from    required    Номер телефона отправителя
#phone_to    required    Номер телефона получателя
#message    required    Текст сообщения
card.payment.send_sms(phone_from, phone_to, message)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/privat24_api.
