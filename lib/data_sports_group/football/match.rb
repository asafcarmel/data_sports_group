require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class Match < Struct.new(:match_id, :date, :time, :date_utc, :time_utc, :team_a_id, :team_a_current_name, :team_a_short_name, :team_a_tla_name, :team_a_original_name, :team_a_country, :team_b_id, :team_b_current_name, :team_b_short_name, :team_b_tla_name, :team_b_original_name, :team_b_country, :status, :gameweek, :winner, :score_a, :score_b, :score_p1s_a, :score_p1s_b, :score_p2s_a, :score_p2s_b, :score_ets_a, :score_ets_b, :score_pen_a, :score_pen_b, :score_venue_type, :game_minute, :final_period, :attendance, :venue_id, :venue_name, :venue_city, :last_updated)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter

      attr_accessor :player_stats
      
      def self.xml_path
        '/datasportsgroup/competition/season/rounds//match'
      end

      def self.xml_name
        'match'
      end

      def enforce_attributes_type
        string_to_datetime(:date, "#{self.date} #{self.time}")
        string_to_datetime(:date_utc, "#{self.date_utc} #{self.time_utc}")
        string_to_integer(:attendance)
        string_to_datetime(:last_updated)
      end
    end
  end
end