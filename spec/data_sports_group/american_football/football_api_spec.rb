require 'spec_helper'
require 'data_sports_group/american_football/football_api'
require 'data_sports_group/base/team'
require 'data_sports_group/base/player'

describe DataSportsGroup::AmericanFootball::AmericanFootballApi, vcr: {
  cassette_name: 'data_sports_group_americamn_football',
  record: :new_episodes,
  match_requests_on: [:uri]
  } do

    let(:football) { DataSportsGroup::AmericanFootball::AmericanFootballApi.new(get_key, get_client, get_user, get_password) }
    context 'API integration' do
      describe '.get_season_team' do
        let(:dnv_team) { DataSportsGroup::DsgBase::Team.new('15', 'Denver Broncos', 'Denver Broncos', 'club', 'male', 'active', DateTime.new(2015,6,5,11,00,19)) }
        it 'fetches teams' do
          teams = football.get_season_team(12153)
          expect(teams.size).to eq(3)
          expect(teams.select{ |s| s.team_id == '15'}.first).to eql(dnv_team)
        end
      end

      describe '.get_squad' do
        let(:norman) { DataSportsGroup::DsgBase::Player.new('356087', 'Dwayne', 'Norman', 'D. Norman', Date.new(1993,9,23), '', 'United States', 'United States', 'Linebacker') }
        it 'fetches players' do
          players = football.get_squad(15)
          expect(players.size).to eq(90)
          expect(players.select{ |s| s.people_id == '356087'}.first).to eql(norman)
        end
      end

      describe '.get_season_matches' do
        let(:sample_match) {
          DataSportsGroup::AmericanFootball::Match.new(668809, DateTime.new(2016,9,9,2,30), '02:30:00', DateTime.new(2016,9,9,0,30),
          '00:30:00', '15', 'Denver Broncos', '', '', 'Denver Broncos', 'USA', '28', 'Carolina Panthers', '', '', 'Carolina Panthers', 'USA', 'Fixture', '1', 'yet unknown',
          '', '', '', '', '', '','', '', '', '', '', '', 'home_away', nil, 'soc_p2s' ,0, '',
          '', '', DateTime.new(2016,8,23,12,39,29),nil)
        }
        it 'fetches matches' do
          matches = football.get_season_matches(12190)
          expect(matches.size).to eq(2048)
          expect(matches.select{ |s| s.match_id=668809 }.first).to eql(sample_match)
          expect(matches.last.attendance).to eq(0)
        end
      end

      describe '.get_detailed_match' do
        let(:sample_score) {
          DataSportsGroup::AmericanFootball::Score.new('356143', 'Foswhitt ', 'Whittaker', 'F. Whittaker', 'United States', 'Running Back',nil, '28',
          'Carolina Panthers', 26, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)
        }
        let(:sample_match) {
          DataSportsGroup::AmericanFootball::Match.new('663020', DateTime.new(2016,2,8,01,30), '01:30:00',
          DateTime.new(2016,2,8,00,30), '00:30:00', '15', 'Denver Broncos', '', '', 'Denver Broncos', 'USA',
          '28', 'Carolina Panthers', '', '', 'Carolina Panthers', 'USA', 'Played', '', 'team_A',  '24', '10', '10', '0', '3', '7', '3', '0', '8', '3','','',
          'home_away', nil, 'amf_p4s', 0, '9', 'Levi\'s Stadium', 'Santa Clara, CA', DateTime.new(2016,8,22,16,58,46), 'no')
        }

        it 'fetches detailed match' do
          match = football.get_detailed_match(663020)
          expect(match).to eql(sample_match)
          expect(match.player_stats.size).to eq(60)
          expect(match.player_stats.select{ |s| s.player_id == '356143'}.first).to eql(sample_score)
        end
      end
    end
  end
