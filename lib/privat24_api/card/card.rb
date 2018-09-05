require "privat24_api/request/info/info_request"
require "privat24_api/request/payment/payment_request"
require "privat24_api/request/public/public_request"

module Privat24Api
  class Card
    attr_reader :args

    def initialize(**args)
      @args = args
    end

    def info
      Privat24Api::InfoRequest.new(args)
    end

    def payment
      Privat24Api::PaymentRequest.new(args)
    end
  end
end
