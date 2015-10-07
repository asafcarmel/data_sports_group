require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class Score < Struct.new(:player_id, :firstname, :lastname, :matchname, :nationality, :position, :shirtnumber, :team_id, :team, :yellow_cards, :red_cards, :yellow_red_cards, :goals, :assists, :penalty_save, :own_goals, :penalty_miss, :penalty_goals, :clean_sheet, :single_goal_against, :goals_against, :minutes_played, :win, :saves, :shots_total, :shots_on_target, :crosses, :fouled)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      def self.xml_path
        '/datasportsgroup/competition/season/rounds/match/player_stats/player'
      end

      def self.xml_name
        'player'
      end

      INTEGERS = [:yellow_cards, :red_cards, :yellow_red_cards, :goals, :assists, :penalty_save, :own_goals, :penalty_miss, :penalty_goals, :clean_sheet, :single_goal_against, :goals_against, :minutes_played, :win, :saves, :shots_total, :shots_on_target, :crosses, :fouled]

      def enforce_attributes_type
        INTEGERS.each { |s| string_to_integer(s) }
      end
    end
  end
end