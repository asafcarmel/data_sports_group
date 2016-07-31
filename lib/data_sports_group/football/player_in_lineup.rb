require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class PlayerInLinup < Struct.new(:player_id, :team_id)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      
      def self.xml_path
        '//events/lineups/event'
      end

      def self.xml_name
        'event'
      end

      INTEGERS = [
        :player_id, :team_id
      ]

      def enforce_attributes_type
        INTEGERS.each { |s| string_to_integer(s) }
      end
    end
  end
end