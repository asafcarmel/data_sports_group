require 'data_sports_group/api'
require 'data_sports_group/base/team'
require 'data_sports_group/base/player'

module DataSportsGroup
  module DsgBase
    class BaseApi < DataSportsGroup::Api

      def path_prefix
        ""
      end

      def get_season_team(season_id)
        xml = response_xml(path_prefix + '/get_season_team', season_id: season_id)
        return Team.to_list(xml)
      end

      def get_squad(team_id)
        xml = response_xml('/get_squad', team: team_id)
        return DataSportsGroup::DsgBase::Player.to_list(xml)
      end

      def get_season_matches(season_id)
        xml = response_xml(path_prefix + '/get_matches', type: 'season', id: season_id)
        return build_match_list(xml)
      end

      def get_detailed_match(match_id)
        xml = response_xml(path_prefix + '/get_matches', type: 'match', id: match_id, detailed: 'yes')
        match = build_match_list(xml).first
        match.player_stats = build_score_list(xml)
        return match
      end

      def build_score_list(xml)
        nil
      end

      def build_match_list(xml)
        nil
      end

      private

      def response_xml(url, properties)
        response = self.generic_request(url, properties)
        Nokogiri::XML(response.to_s)
      end
    end
  end
end
