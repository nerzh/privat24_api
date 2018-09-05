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
    }
  }
end
