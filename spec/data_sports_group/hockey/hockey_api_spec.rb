require 'spec_helper'
require 'data_sports_group/hockey/hockey_api'
require 'data_sports_group/base/team'
require 'data_sports_group/base/player'
describe DataSportsGroup::Hockey::HockeyApi, vcr: {
  cassette_name: 'data_sports_group_hockey',
  record: :new_episodes,
  match_requests_on: [:uri]
  } do

    let(:hockey) { DataSportsGroup::Hockey::HockeyApi.new(get_key, get_client, get_user, get_password) }
    context 'API integration' do
      describe '.get_season_team' do
        let(:admrial) { DataSportsGroup::DsgBase::Team.new('25592', 'Admiral Vladivostok', 'Admiral Vladivostok', 'club', 'male', 'active', DateTime.new(2016,1,21,23,39,21)) }
        it 'fetches teams' do
          teams = hockey.get_season_team(12118)
          expect(teams.size).to eq(29)
          expect(teams.first).to eql(admrial)
        end
      end

      describe '.get_squad' do
        let(:andronov) { DataSportsGroup::DsgBase::Player.new('355650', 'Sergei', 'Mozyakin', 'S. Mozyakin', Date.new(1981,3,30), '', 'Russia', 'Russia', 'Forward') }
        it 'fetches players' do
          players = hockey.get_squad(25588)
          expect(players.size).to eq(25)
          expect(players.first).to eql(andronov)
        end
      end

      describe '.get_season_matches' do
        let(:sample_match) { DataSportsGroup::Hockey::Match.new('661974', DateTime.new(2016,8,22), '', DateTime.new(2016,8,21,22,00), '22:00:00', '25588',
           'Metallurg Magnitogorsk', '', '', '', 'RUS', '25578', 'HC CSKA Moskva', '', '', '', 'RUS', 'Fixture', '', 'yet unknown',  '', '', '', '', '', '',
            '', '', '', '','','','home_away', nil, 'ice_p3s', 0,'', '', '',DateTime.new(2016,8,2,12,4,50),'no') }
        it 'fetches matches' do
          matches = hockey.get_season_matches(12118)
          expect(matches.size).to eq(870)
          expect(matches.first).to eql(sample_match)
          expect(matches.last.attendance).to eq(0)
        end
      end

      describe '.get_detailed_match' do
        let(:sample_score) { DataSportsGroup::Hockey::Score.new('355018', 'Igor', 'Makarov', 'I. Makarov', 'Russia', 'Forward', '25578', 'HC CSKA Moskva', 9, 0, 0, -1, 0, 0, 0, 1, 0, 0, 0, 0)}
        let(:sample_match) { DataSportsGroup::Hockey::Match.new('663184', DateTime.new(2016,4,07,18,30), '18:30:00', DateTime.new(2016,4,07,16,30), '16:30:00', '25578', 'HC CSKA Moskva',
           '', '', '', 'RUS', '25588', 'Metallurg Magnitogorsk', '', '', '', 'RUS', 'Played', '', 'team_A',  '5', '1', '0', '1', '3', '0', '2', '0',
            '', '','','', 'home_away', nil, 'ice_p3s', 5600, '5473', 'Ledovyj Dvorets Sporta CSKA', 'Moskva', DateTime.new(2016,8,9,20,42,29), 'no') }
        it 'fetches detailed match' do
          match = hockey.get_detailed_match(663184)
          expect(match).to eql(sample_match)
          expect(match.player_stats.size).to eq(44)
          expect(match.player_stats.select{ |s| s.player_id == '355018'}.first).to eql(sample_score)
        end
      end
    end
  end
