module Privat24Api
  def self.class_attr_accessor(*names)
    names.each do |name|
      define_singleton_method("#{name.to_s}=".to_sym) do |attr|
        class_variable_set("@@#{name.to_s}", attr)
      end
      
      define_singleton_method(name.to_sym) do
        class_variable_get("@@#{name.to_s}")
      end
    end
  end

  class_attr_accessor :cards, :base_url, :end_points

  def self.configure
    yield self
  end

  self.cards      = []
  self.base_url   = 'https://api.privatbank.ua/p24api/'
  self.end_points = {
    'info' => {
      'balance'             => 'balance',
      'transaction_details' => 'rest_fiz'
    },
    'payment' => {
      'pay_on_privat_card'     => 'pay_pb',
      'pay_on_ua_card'         => 'pay_ua',
      'pay_on_visa_card'       => 'pay_visa',
      'check_status_pay'       => 'check_pay',
      'pay_on_mobile'          => 'directfill',
      'pay_on_mobile_multiple' => 'directfill',
      'check_status_mobile'    => 'check_directfill',
      'send_sms'               => 'sendsms'
    },
    'public' => {
      'exchange_cash'       => 'pubinfo',
      'exchange_non_cash'   => 'pubinfo',
      'exchange'            => 'pubinfo',
      'exchange_archive'    => 'exchange_rates',
      'list_privat_offices' => 'pboffice',
      'atm'                 => 'infrastructure',
      'tso'                 => 'infrastructure'
    }
  }
end
