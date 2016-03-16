require 'spec_helper'
require 'data_sports_group/football/football_api'

describe DataSportsGroup::Football::FootballApi, vcr: {
  cassette_name: 'data_sports_group_football',
  record: :new_episodes,
  match_requests_on: [:uri]
  } do

    let(:football) { DataSportsGroup::Football::FootballApi.new(get_key, get_client, get_user, get_password) }
    context 'API integration' do
      describe '.get_season_team' do
        let(:fsv_team) { DataSportsGroup::Football::Team.new('567', '1. FSV Mainz 05', '1. FSV Mainz 05', 'club', 'male', 'active', DateTime.new(2015,8,3,2,23,48)) }
        it 'fetches teams' do
          teams = football.get_season_team(9165)
          expect(teams.size).to eq(18)
          expect(teams.first).to eql(fsv_team)
        end
      end

      describe '.get_squad' do
        let(:weidenfeller) { DataSportsGroup::Football::Player.new('5218', 'Roman', 'Weidenfeller', 'R. Weidenfeller', Date.new(1980,8,6), 'Diez', 'Germany', 'Germany', 'Goalkeeper') }
        it 'fetches players' do
          players = football.get_squad(522)
          expect(players.size).to eq(26)
          expect(players.first).to eql(weidenfeller)
        end
      end

      describe '.get_season_matches' do
        let(:sample_match) { DataSportsGroup::Football::Match.new('521502', DateTime.new(2015,8,14,20,30), '20:30:00', DateTime.new(2015,8,14,18,30), '18:30:00', '539', 'FC Bayern München', 'Bayern M', 'BAY', '', 'DEU', '524', 'Hamburger SV', 'HSV', 'HSV', '', 'DEU', 'Played', '1', 'team_A',  '5', '0', '1', '0', '4', '0', '', '', '', '', 'home_away', '', 'soc_p2s', 75000, '', 'Allianz-Arena', 'München', DateTime.new(2015,10,15,13,30,43)) }
        it 'fetches matches' do
          matches = football.get_season_matches(9165)
          expect(matches.size).to eq(306)
          expect(matches.first).to eql(sample_match)
          expect(matches.last.attendance).to eq(0)
        end
      end

      describe '.get_detailed_match' do
        let(:sample_score) { DataSportsGroup::Football::Score.new('11538', 'Serge', 'Aurier', 'S. Aurier', 'Côte d’Ivoire', 'Defender', '19', '574', 'Paris Saint-Germain FC', 0, 0, 0, 1, 1, 3, 0, 2, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 90, 1, 0, 7, 2)}
        let(:sample_match) { DataSportsGroup::Football::Match.new('542466', DateTime.new(2015,9,30,20,45), '20:45:00', DateTime.new(2015,9,30,18,45), '18:45:00', '865', 'FK Shakhtar Donetsk', 'Shak Donetsk', '', '', 'UKR', '574', 'Paris Saint-Germain FC', 'PSG', '', '', 'FRA', 'Played', '2', 'team_B',  '0', '3', '0', '2', '0', '1', '', '', '', '', 'home_away', '', 'soc_p2s', 32730, '', 'L\'viv Arena', 'Lviv', DateTime.new(2015,10,14,22,6,25)) }

        it 'fetches detailed match' do
          match = football.get_detailed_match(542466)
          expect(match).to eql(sample_match)
          expect(match.player_stats.size).to eq(28)
          expect(match.player_stats.select{ |s| s.player_id == '11538'}.first).to eql(sample_score)
        end
      end
    end
  end
