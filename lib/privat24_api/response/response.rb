
module Privat24Api
  class Response
    
    attr_reader :body
    
    def initialize(body)
      @body = body
    end
    
    def to_hash
      Hash.from_xml(body)
    end

    def to_json
      Hash.from_xml(body).to_json
    end

    def to_xml
      body
    end
  end
end



