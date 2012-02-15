require 'nokogiri'

module Engine
  module Interaction
    class NaverApi
      GEOCODE_URL = "http://openapi.map.naver.com/api/geocode.php"

      def self.location_data_by_address(address)
        xml_doc = Nokogiri::XML(self.send_location_request(address))

        result = { :latitude => xml_doc.at_css("geocode item point y").try(:text), :longitude => xml_doc.at_css("geocode item point x").try(:text) }
      end

      def self.send_location_request(address)
        proxy = ENV['HTTP_PROXY']
        clnt = HTTPClient.new(proxy)

        clnt.get(GEOCODE_URL, { "key" => Rails.application.config.interaction_api_naver_key, "encoding" => 'utf-8', "coord" => "LatLng", "query" => address}).content
      end
    end
  end
end
