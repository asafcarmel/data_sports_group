require 'data_sports_group/xml_translator'
require 'data_sports_group/string_converter'

module DataSportsGroup
  module Baseball
    class Score < Struct.new(:player_id, :firstname, :lastname, :matchname, :nationality, :position, :team_id, :team,
      :earnedruns, :earnedrunsaverage, :doubles, :triples, :baseonballs, :stolenbases, :hitbypitch, :totalruns, :runsbattedin,
      :homeruns, :totalhits, :atbat, :totalbases, :strikeout, :inningspitched, :winningpitcher,
      :bataverage, :onbasepercentage, :strikeoutspitched, :whip)
      extend  DataSportsGroup::XmlTranslator
      include DataSportsGroup::StringConverter
      def self.xml_path
        '//player_stats/player'
      end

      def self.xml_name
        'player'
      end
      INTEGERS = []

      def enforce_attributes_type
        INTEGERS.each { |s| string_to_integer(s) }
      end
    end
  end
end
