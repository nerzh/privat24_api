require 'digest/md5'
require 'digest/sha1'

module Privat24Api
  class Request
    
    attr_reader :data_value, :card_num, :merchant_id, :merchant_password
    
    def initialize(**card_args)
      @card_num          = card_args[:card_num]
      @merchant_id       = card_args[:merchant_id]
      @merchant_password = card_args[:merchant_password]
    end
    
    def send_data_for(mod, met)
      builder = Nokogiri::XML::DocumentFragment.parse ""
      Nokogiri::XML::Builder.with(builder) do |xml|
        yield xml
      end

      @data_value = builder.to_xml

      send(mod, met)
    end

    private

    def send(mod, met)
      RestClient.post(make_url(mod, met), unescape_xml(make_xml), :content_type => "text/xml").body
    end

    def make_url(mod, met)
      "#{Privat24Api.base_url}#{Privat24Api.end_points[mod][met]}"
    end

    def unescape_xml(xml)
      CGI::unescapeHTML(xml)
    end

    def make_xml
      builder = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.request(version: '1.0') do
          xml.merchant(xml_merchant(signature))
          xml.data(data_value)
        end
      end 

      builder.to_xml
    end

    def xml_merchant(signatur)
      builder = Nokogiri::XML::DocumentFragment.parse ""

      Nokogiri::XML::Builder.with(builder) do |xml|
        xml.id(merchant_id)
        xml.signature(signatur)
      end

      builder.to_xml
    end

    def signature
      generate_signature(data_value, merchant_password)
    end

    def generate_signature(data, password)
      Digest::SHA1.hexdigest( Digest::MD5.hexdigest(data.strip << password) )
    end
  end
end


