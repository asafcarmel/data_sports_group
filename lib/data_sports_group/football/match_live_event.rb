require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class MatchLiveEvent< Struct.new(:atc_event_id, :stat_type, :people_id, :team_id, :period, :game_minute, :game_minute_extra, :game_second, :phrase)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      
      def self.xml_path
        '//commentary'
      end

      def self.xml_name
        'commentary'
      end

      
      INTEGERS = [
        :game_minute, :game_minute_extra, :atc_event_id
      ]

      def enforce_attributes_type
        INTEGERS.each { |s| string_to_integer(s) }
      end
    end
  end
end