require('minitest/autorun')
require('minitest/rg')
require('pry')
require_relative('../game.rb')
require_relative('../team.rb')

class GameTest < MiniTest::Test

  def setup()
    @test_team_a = Team.new({
      'name' => "Test Team A",
      'played' => 1,
      'won' => 1,
      'lost' => 0,
      'points' => 1
    })

    @test_team_b = Team.new({
      'name' => "Test Team B"
    })
    
    @test_game_01 = Game.new({
      'team_a_id' => @test_team_a.id,
      'team_b_id' => @test_team_b.id
      })

    binding.pry
    nil
  end

  def test_play_game()
    @test_game_01.play()
    assert_equal("Test Team A", game.winner)
  end

end
