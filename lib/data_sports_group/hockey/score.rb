require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Hockey
    class Score < Struct.new(:player_id, :firstname, :lastname, :matchname, :nationality, :position, :team_id, :team, :time_on_ice_min,
      :ice_goals, :ice_assists, :ice_plus_minus, :penalty_minutes, :ice_pp_goals, :pp_assists, :shots_on_goal,
      :ice_gk_win, :ice_gk_goals_against, :ice_gk_saves, :ice_shutouts)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      def self.xml_path
        '//player_stats/player'
      end

      def self.xml_name
        'player'
      end
      INTEGERS = [
        :ice_goals, :ice_assists, :ice_plus_minus, :penalty_minutes, :ice_pp_goals, :pp_assists, :shots_on_goal,
        :ice_gk_win, :ice_gk_goals_against, :ice_gk_saves, :ice_shutouts, :time_on_ice_min
      ]

      def enforce_attributes_type
        INTEGERS.each { |s| string_to_integer(s) }
      end
    end
  end
end
