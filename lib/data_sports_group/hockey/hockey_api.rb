require 'data_sports_group/base/base_api'
require 'data_sports_group/hockey/score'
require 'data_sports_group/hockey/match'

module DataSportsGroup
  module Hockey
    class HockeyApi < DataSportsGroup::DsgBase::BaseApi

      def path_prefix
        '/icehockey'
      end

      def build_match_list(xml)
        Match.to_list(xml)
      end

      def build_score_list(xml)
        Score.to_list(xml)
      end

    end
  end
end
