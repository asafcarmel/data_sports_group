require 'data_sports_group/base/base_api'
require 'data_sports_group/baseball/score'
require 'data_sports_group/baseball/match'

module DataSportsGroup
  module Baseball
    class BaseballApi < DataSportsGroup::DsgBase::BaseApi

      def path_prefix
        '/baseball'
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
