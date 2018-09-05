# Privat24Api

REGISTRATION MERCHANT: https://api.privatbank.ua/#p24/registration

Ruby Api for Privat Bank Privat24, Info, Payment and Public methods for Privat24 API Privat Bank

## Installation
```ruby
gem 'privat24_api'
```
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


#   API позволяет просмотреть информацию о существующих у мерчанта счетах, их статусе, а также балансе, доступных средствах и кредитном лимите
1 - card.info.balance


#   API позволяет просмотреть детальную информацию о движении денежных средств по счету (карте) мерчанта-физлица за выбранный период
#sd    required    Начало периода. Формат дд.мм.гггг
#ed    required    Конец периода. Формат дд.мм.гггг
2 - card.info.transaction_details('01.09.2018', '25.09.2018')
```

### PAYMENT METHODS
```ruby
card = Privat24Api.cards.first


#   API позволяет осуществить перевод средств между картами ПриватБанка.
#payment id    required    Уникальный идентификатор платежа, присвоенный партнером платежей. Повторяется в ответе на запрос, сохраняется в базе Приват24, служит для однозначного сопоставления операций на стороне партнера платежей с операциями в приват24.
#card    required    Карта или счёт получателя
#amount    required    Сумма Напр.: 23.05
#currency    required    Валюта (UAH, EUR, USD)
#details    required    Назначение платежа
1 - card.payment.pay_on_privat_card(payment_id, card, amount, details, currency='UAH')


#   API позволяет осуществить платеж с карты ПриватБанка на карту любого другого банка по Украине.
#card    required    Счёт получателя
#amount    required    Сумма Напр.: 23.05
#currency    required    Валюта (UAH, EUR, USD)
#b_name    required    Наименование получателя
#b_crf    required    ОКПО банка получателя
#b_bic    required    МФО банка получателя
#details    required    Назначение платежа
2 - card.payment.pay_on_ua_card(payment_id, card, amount, b_name, b_crf, b_bic, details, currency='UAH')


#   API позволяет осуществить платеж с карты ПриватБанк на карту VISA любого международного банка
#card    required    Карта или счёт получателя
#amount    required    Сумма Напр.: 23.05
#currency    required    Валюта (UAH, EUR, USD)
#b_name    required    ФИО получателя
#details    required    Назначение платежа
3 - card.payment.pay_on_visa_card(payment_id, card, amount, b_name, details, currency='UAH')

#   Проверка статуса платежа
#id    required/optional    Уникальный идентификатор платежа, присвоенный партнером платежей. (payment_id из предыдущего запроса). Обязательный, если не передается параметр ref
#ref    required/optional    Уникальный идентификатор платежа, присвоенный приват24. Возвращается в ответе на запрос создания платежа. Обязательный, если не передается параметр id
4 - card.payment.check_status_pay(id, ref)


#   API позволяет осуществить пополнение мобильной связи операторов Украины на указанную сумму.
#phone    required    Номер телефона
#amount    required    Сумма (грн.)
5 - card.payment.pay_on_mobile(phone, amount)

#   Массовое пополнение моб. связи
#phones [{number: '0631234567', amount: '100'}, {number: '0637654321', amount: '200'}]
6 - card.payment.pay_on_mobile_multiple(phones)


#   Проверка состояния платежа пополнения мобильной связи
#id="SIVN1392995003.855" - приходит в ответ на запрос пополнения
7 - card.payment.check_status_mobile(id)


#   Отправка sms
#phone_from    required    Номер телефона отправителя
#phone_to    required    Номер телефона получателя
#message    required    Текст сообщения
8 - card.payment.send_sms(phone_from, phone_to, message)
```

### PUBLIC METHODS
```ruby
public_api = Privat24Api::PublicRequest.new


#   API предоставляет информацию о наличных курсах валют ПриватБанка
#default url_attr = '?exchange&coursid=5'
1 - public_api.exchange_cash(url_attr='?exchange&coursid=5')


#   API предоставляет информацию о безналичных курсах валют ПриватБанка
#default url_attr = '?exchange&coursid=11'
2 - public_api.exchange_non_cash(url_attr='?exchange&coursid=11')


#   Наличный курс ПриватБанка (в отделениях)
#default url_attr = '?exchange&coursid=3'
3 - public_api.exchange(url_attr='?exchange&coursid=3') 


#   Архив курсов валют ПриватБанка, НБУ
#url_attr = '?date=01.12.2014'
4 - public_api.exchange_archive(url_attr)


#   Информация о размещении отделений ПриватБанка
#url_attr = '?city=Днепропетровск&address=Титова'
#default url_attr = nil
5 - public_api.list_privat_offices(url_attr=nil)


#   Информация о размещении банкоматов ПриватБанка
#url_attr = '?atm&address=&city=Днепропетровск'
#default url_attr = '?atm'
6 - public_api.atm(url_attr='?atm')


#   Информация о размещении терминалов самообслуживания ПриватБанка
#url_attr = '?tso&address=&city=Днепропетровск'
#default url_attr = '?tso'
7 - public_api.tso(url_attr='?tso')
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/privat24_api.
