require 'spec_helper'
require 'data_sports_group/football/football_api'
require 'data_sports_group/base/team'
require 'data_sports_group/base/player'

describe DataSportsGroup::Football::FootballApi, vcr: {
  cassette_name: 'data_sports_group_football',
  record: :new_episodes,
  match_requests_on: [:uri]
  } do

    let(:football) { DataSportsGroup::Football::FootballApi.new(get_key, get_client, get_user, get_password) }
    context 'API integration' do
      describe '.get_season_team' do
        let(:fsv_team) { DataSportsGroup::DsgBase::Team.new('567', '1. FSV Mainz 05', '1. FSV Mainz 05', 'club', 'male', 'active', DateTime.new(2015,8,3,2,23,48)) }
        it 'fetches teams' do
          teams = football.get_season_team(9165)
          expect(teams.size).to eq(18)
          expect(teams.first).to eql(fsv_team)
        end
      end

      describe '.get_squad' do
        let(:weidenfeller) { DataSportsGroup::DsgBase::Player.new('5218', 'Roman', 'Weidenfeller', 'R. Weidenfeller', Date.new(1980,8,6), 'Diez', 'Germany', 'Germany', 'Goalkeeper') }
        it 'fetches players' do
          players = football.get_squad(522)
          expect(players.size).to eq(31)
          expect(players.first).to eql(weidenfeller)
        end
      end

      describe '.get_season_matches' do
        let(:sample_match) { DataSportsGroup::Football::Match.new('521502', DateTime.new(2015,8,14,20,30), '20:30:00', DateTime.new(2015,8,14,18,30),
           '18:30:00', '539', 'FC Bayern München', 'Bayern M', 'BAY', '', 'DEU', '524', 'Hamburger SV', 'HSV', 'HSV', '', 'DEU', 'Played', '1', 'team_A',
             '5', '0', '1', '0', '4', '0', '', '', '', '', 'home_away', '', 'soc_p2s', 75000, '290',
             'Allianz-Arena', 'München', DateTime.new(2015,10,15,13,30,43))}
        it 'fetches matches' do
          matches = football.get_season_matches(9165)
          expect(matches.size).to eq(308)
          expect(matches.first).to eql(sample_match)
          expect(matches.last.attendance).to eq(50000)
        end
      end

      describe '.get_detailed_match' do
        let(:sample_score) { DataSportsGroup::Football::Score.new('11538', 'Serge', 'Aurier', 'S. Aurier', 'Côte d’Ivoire', 'Defender', '19', '574', 'Paris Saint-Germain FC', 0, 0, 0, 1, 1, 3, 0, 2, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 90, 1, 0, 7, 2)}
        let(:sample_match) { DataSportsGroup::Football::Match.new('542466', DateTime.new(2015,9,30,20,45), '20:45:00',
           DateTime.new(2015,9,30,18,45), '18:45:00', '865', 'FK Shakhtar Donetsk', 'Shak Donetsk', 'SHD', '', 'UKR',
            '574', 'Paris Saint-Germain FC', 'PSG', 'PSG', '', 'FRA', 'Played', '2', 'team_B',  '0', '3', '0', '2', '0', '1', '', '', '', '',
            'home_away', '', 'soc_p2s', 32730, '836', 'L\'viv Arena', 'L’viv', DateTime.new(2015,10,14,22,6,25), 'no')}

        it 'fetches detailed match' do
          match = football.get_detailed_match(542466)
          expect(match).to eql(sample_match)
          expect(match.player_stats.size).to eq(28)
          expect(match.player_stats.select{ |s| s.player_id == '11538'}.first).to eql(sample_score)
        end
      end

      describe '.get_live_events' do
        it 'right number of events and is_final' do
          events_response = football.get_live_events(622572)
          expect(events_response[:events].length).to eql(235)
          expect(events_response[:is_final]).to eql('yes')
        end

        it 'events is as expected' do
          expected = DataSportsGroup::Football::MatchLiveEvent.new(45489742, "tackles_won", "71071", "18914", "H2", 49, 0, "9", "Vladimir Poluyakhtov won a tackle")
          events_response = football.get_live_events(622572)
          event = events_response[:events][1]
          expect(event).to eql(expected)
        end

        it 'is_final' do
          events_response = football.get_live_events(622582)
          expect(events_response[:is_final]).to eql('no')
        end
      end

      describe '.get_matches_current_minute' do
        #TODO NEED TO BE ADDED
      end

      describe '.get_match_lineups' do
        it 'has two keys' do
          lineups_bench_players = football.get_match_lineups(622572)
          expect(lineups_bench_players[:lineup].length).to eql(22)
          expect(lineups_bench_players[:bench].length).to eql(21)
        end

        it 'each element has right keys' do
          lineups_bench_players = football.get_match_lineups(622572)
          lineup_player = lineups_bench_players[:lineup][0]
          expect(lineup_player[:player_id]).to eql("21024")
          expect(lineup_player[:team_id]).to eql("943")
        end
      end

    end
  end
