require 'data_sports_group/api'
require 'data_sports_group/football/team'
require 'data_sports_group/football/player'
require 'data_sports_group/football/match'
require 'data_sports_group/football/score'

module DataSportsGroup
  module Football
    class FootballApi < DataSportsGroup::Api
      def get_season_team(season_id)
        xml = response_xml('/get_season_team', season_id: season_id)
        return Team.to_list(xml)
      end

      def get_squad(team_id)
        xml = response_xml('/get_squad', team: team_id)
        return Player.to_list(xml)
      end

      def get_season_matches(season_id)
        xml = response_xml('/get_matches', type: 'season', id: season_id)
        return Match.to_list(xml)
      end

      def get_detailed_match(match_id)
        xml = response_xml('/get_matches', type: 'match', id: match_id, detailed: 'yes')
        match = Match.to_list(xml).first
        match.player_stats = Score.to_list(xml)
        return match
      end

      private

      def response_xml(url, properties)
        response = self.generic_request(url, properties)
        Nokogiri::XML(response.to_s)
      end
    end
  end
end