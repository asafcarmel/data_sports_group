require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class Team < Struct.new(:team_id, :current_team_name, :original_team_name, :type, :gender, :status, :last_updated)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      
      def self.xml_path
        '/datasportsgroup/competition/season/team'
      end

      def self.xml_name
        'team'
      end

      def enforce_attributes_type
        string_to_datetime(:last_updated)
      end
    end
  end
end