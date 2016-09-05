require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Football
    class FeedState < Struct.new(:state)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      
      def self.xml_path
        '/match'
      end

      def enforce_attributes_type
      end
    end
  end
end