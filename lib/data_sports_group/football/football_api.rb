require 'data_sports_group/base/base_api'
require 'data_sports_group/football/score'
require 'data_sports_group/football/match_current_minute'
require 'data_sports_group/football/match_live_event'
require 'data_sports_group/football/player_in_lineup'
require 'data_sports_group/football/player_on_bench'
require 'data_sports_group/football/feed_state'
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

      def get_matches_current_minute
        xml = response_xml('/get_matches_day', playing: 'yes')
        MatchCurrentMinute.to_list(xml)
      end

      def get_live_events(match_id)
        xml = response_xml('/get_commentary', type: 'match', id: match_id)
        events = MatchLiveEvent.to_list(xml)
        feed_state = FeedState.to_list(xml)
        {events: events, is_final: feed_state[0].final}
      end

      def get_match_lineups(match_id)
         xml = response_xml('/get_matches', type: 'match', id: match_id, detailed: 'yes')
         lineup = PlayerInLinup.to_list(xml).map(&:to_h)
         bench = PlayerOnBench.to_list(xml).map(&:to_h)
         {
            lineup: lineup,
            bench: bench
         }
      end

      private

      def response_xml(url, properties)
        response = self.generic_request(url, properties)
        Nokogiri::XML(response.to_s)
      end
    end
  end
end
