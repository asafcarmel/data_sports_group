require 'data_sports_group/base/base_api'
require 'data_sports_group/american_football/score'
require 'data_sports_group/american_football/match'

module DataSportsGroup
  module AmericanFootball
    class AmericanFootballApi < DataSportsGroup::DsgBase::BaseApi

      def build_score_list(xml)
        Score.to_list(xml)
      end
      def build_match_list(xml)
        Match.to_list(xml)
      end

      def path_prefix
        '/american_football'
      end
      
      private

      def response_xml(url, properties)
        response = self.generic_request(url, properties)
        Nokogiri::XML(response.to_s)
      end
    end
  end
end
