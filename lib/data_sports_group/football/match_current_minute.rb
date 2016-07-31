require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class MatchCurrentMinute < Struct.new(:match_id, :game_minute, :period, :score_a, :score_b)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      
      def self.xml_path
        '/datasportsgroup/competition/match'
      end

      def self.xml_name
        'match'
      end

      def enforce_attributes_type
      end
    end
  end
end