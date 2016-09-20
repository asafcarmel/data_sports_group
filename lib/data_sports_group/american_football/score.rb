require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module AmericanFootball
    class Score < Struct.new(:player_id, :firstname, :lastname, :matchname, :nationality, :position, :shirtnumber, :team_id, :team,
        :totalrushingyards, :totalpassingyards, :totalreceivingyards, :rushingtd, :passingtd, :receivingtd, :kickreturntd, :puntreturntd,
        :fumblerecoverytd, :conversionmade, :converstionpass, :interceptionsthrown, :totalreceptions, :fumbleslost)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      def self.xml_path
        '//player_stats/player'
      end

      def self.xml_name
        'player'
      end

      INTEGERS = [
        :totalrushingyards,:totalpassingyards, :totalreceivingyards,
        :rushingtd, :passingtd, :receivingtd, :kickreturntd, :puntreturntd,
        :fumblerecoverytd, :conversionmade, :converstionpass, :interceptionsthrown, :totalreceptions, :fumbleslost
      ]

      def enforce_attributes_type
        INTEGERS.each { |s| self[s].nil? ? self[s]=0 : string_to_integer(s) }
      end
    end
  end
end
