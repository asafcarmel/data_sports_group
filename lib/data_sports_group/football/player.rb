require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class Player < Struct.new(:people_id, :first_name, :last_name, :match_name, :date_of_birth, :place_of_birth, :country_of_birth, :nationality, :position)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      
      def self.xml_path
        '/datasportsgroup/team/people'
      end

      def self.xml_name
        'people'
      end

      def enforce_attributes_type
        string_to_datetime(:date_of_birth)
      end
    end
  end
end