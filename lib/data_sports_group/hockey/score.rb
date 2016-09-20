require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Hockey
    # class Score < Struct.new(:player_id, :firstname, :lastname, :matchname, :nationality, :position, :team_id, :team, :time_on_ice_min,
    #   :ice_goals, :ice_assists, :ice_plus_minus, :penalty_minutes, :ice_pp_goals, :pp_assists, :shots_on_goal,
    #   :ice_gk_win, :ice_gk_goals_against, :ice_gk_saves, :ice_shutouts)



      class Score < Struct.new(:player_id, :firstname, :lastname, :matchname, :common_name, :nationality, :position, :shirtnumber, :team_id, :team,
      :goals, :assists, :points, :shots_on_goal, :penalty_minutes, :faceoffs, :faceoffs_won, :blocks, :hits, :fouls_against, :time_on_ice_min,
      :time_on_ice_seconds, :shifts, :plus_minus, :game_winning_goals, :shootout_dec_shots, :gk_win, :gk_loss, :shootouts_played, :gk_shots_on_goal,
      :gk_goals_against, :gk_saves, :shutouts, :s_goals, :pp_goals, :sh_goals, :ot_goals, :pp_assists)

      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      def self.xml_path
        '//player_stats/player'
      end

      def self.xml_name
        'player'
      end
      INTEGERS = [
        :goals, :assists, :plus_minus, :points, :shots_on_goal, :penalty_minutes, :faceoffs, :faceoffs_won, :blocks, :hits, :fouls_against, :time_on_ice_min,
        :time_on_ice_seconds, :shifts, :game_winning_goals, :shootout_dec_shots, :gk_win, :gk_loss, :shootouts_played, :gk_shots_on_goal,
        :gk_goals_against, :gk_saves, :shutouts, :s_goals, :pp_goals, :sh_goals, :ot_goals, :pp_assists
      ]

      def enforce_attributes_type
        INTEGERS.each { |s| string_to_integer(s) }
      end
    end
  end
end
