require "privat24_api/request/request"

module Privat24Api
  class InfoRequest

    MOD = 'info'

    attr_reader :card_args

    def initialize(**card_args)
      @card_args = card_args
    end

    def balance
      Request.new(card_args).send_data_for(MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.payment(id: '')
        data.prop(name: 'cardnum', value: card_args[:card_num])
        data.prop(name: 'country', value: 'UA')
      end
    end

    def transaction_details(date_from, date_to)
      Request.new(card_args).send_data_for(MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        data.payment(id: '') do
          data.prop(name: 'sd',   value: date_from)
          data.prop(name: 'ed',   value: date_to)
          data.prop(name: 'card', value: card_args[:card_num])
        end
      end
    end
  end
end
