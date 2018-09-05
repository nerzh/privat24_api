require "privat24_api/request/request"

module Privat24Api
  class PublicRequest

    MOD = 'public'

    def exchange_cash(url_attr='?exchange&coursid=5')
      request(__method__.to_s, url_attr)
    end

    def exchange_non_cash(url_attr='?exchange&coursid=11')
      request(__method__.to_s, url_attr)
    end

    def exchange(url_attr='?exchange&coursid=3')
      request(__method__.to_s, url_attr)
    end

    def exchange_archive(url_attr)
      request(__method__.to_s, url_attr)
    end

    def list_privat_offices(url_attr=nil)
      request(__method__.to_s, url_attr)
    end

    def atm(url_attr='?atm')
      request(__method__.to_s, url_attr)
    end

    def tso(url_attr='?tso')
      request(__method__.to_s, url_attr)
    end

    private

    def request(met, url_attr)
      Request.new.get_public_data_for(MOD, met, url_attr)
    end
  end
end
