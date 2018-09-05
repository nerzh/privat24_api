require "privat24_api/request/request"

module Privat24Api
  class PaymentRequest

    MOD = 'payment'

    attr_reader :card_args

    def initialize(**card_args)
      @card_args = card_args
    end
  end
end
