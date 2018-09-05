require "privat24_api/request/request"

module Privat24Api
  class PublicRequest

    MOD = 'public'

    attr_reader :card_args

    def initialize(**card_args)
      @card_args = card_args
    end

    # payment_id - order id of your shop
    def pay_on_privat_card(payment_id, card, amount, details, currency='UAH')
      Request.new(card_args).send_data_for(:get, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        data.payment(id: payment_id) do
          data.prop(name: 'b_card_or_acc', value: card)
          data.prop(name: 'amt',           value: amount)
          data.prop(name: 'ccy',           value: currency)
          data.prop(name: 'details',       value: details)
        end
      end
    end

    # payment_id - order id of your shop
    def pay_on_ua_card(payment_id, card, amount, b_name, b_crf, details, currency='UAH')
      Request.new(card_args).send_data_for(:post, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        data.payment(id: payment_id) do
          data.prop(name: 'b_card_or_acc', value: card)
          data.prop(name: 'amt',           value: amount)
          data.prop(name: 'ccy',           value: currency)
          data.prop(name: 'b_name',        value: b_name)
          data.prop(name: 'b_crf',         value: b_crf)
          data.prop(name: 'b_bic',         value: b_bic)
          data.prop(name: 'details',       value: details)
        end
      end
    end

    # payment_id - order id of your shop
    def pay_on_visa_card(payment_id, card, amount, b_name, b_crf, details, currency='UAH')
      Request.new(card_args).send_data_for(:post, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('30')
        data.test('0')
        data.payment(id: payment_id) do
          data.prop(name: 'b_card_or_acc', value: card)
          data.prop(name: 'amt',           value: amount)
          data.prop(name: 'ccy',           value: currency)
          data.prop(name: 'b_name',        value: b_name)
          data.prop(name: 'details',       value: details)
        end
      end
    end

    def check_status_pay(payment_id, card, amount, b_name, b_crf, details, currency='UAH')
      Request.new(card_args).send_data_for(:post, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        data.payment do
          data.prop(name: 'id',  value: card)
          data.prop(name: 'ref', value: amount)
        end
      end
    end

    def pay_on_mobile(phone, amount)
      Request.new(card_args).send_data_for(:post, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        data.payment(id: '') do
          data.prop(name: 'phone', value: phone)
          data.prop(name: 'amt',   value: amount)
        end
      end
    end

    def pay_on_mobile(*phones)
      Request.new(card_args).send_data_for(:post, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        phones.each_with_index do |phone, index|
          data.payment(id: index) do
            data.prop(name: 'phone', value: phone[:number])
            data.prop(name: 'amt',   value: phone[:amount])
          end
        end
      end
    end

    def check_status_mobile(id)
      Request.new(card_args).send_data_for(:post, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        data.payment do
          data.prop(name: 'id', value: id)
        end
      end
    end

    def send_sms(phone_from, phone_to, message)
      Request.new(card_args).send_data_for(:post, MOD, __method__.to_s) do |data|
        data.oper('cmt')
        data.wait('0')
        data.test('0')
        data.payment(id: '') do
          data.prop(name: 'phone',   value: phone_from)
          data.prop(name: 'phoneto', value: phone_to)
          data.prop(name: 'text',    value: message)
        end
      end
    end
  end
end
