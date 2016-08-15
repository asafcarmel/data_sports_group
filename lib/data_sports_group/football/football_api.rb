require 'data_sports_group/base/base_api'
require 'data_sports_group/football/score'
require 'data_sports_group/football/match'

module DataSportsGroup
  module Football
    class FootballApi < DataSportsGroup::DsgBase::BaseApi

      def build_score_list(xml)
        Score.to_list(xml)
      end
      def build_match_list(xml)
        Match.to_list(xml)
      end

      private

      def response_xml(url, properties)
        response = self.generic_request(url, properties)
        Nokogiri::XML(response.to_s)
      end
    end
  end
end
