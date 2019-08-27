require_relative('../db/sql_runner')
require_relative('./team')

class Game

  attr_reader :team_a_id, :team_b_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @team_a_id = options['team_a_id'].to_i
    @team_b_id = options['team_b_id'].to_i
    @winner_team_id = options['winner_team_id'].to_i if options['winner_team_id']
  end

  def save()
    sql = "INSERT INTO games
    (
      team_a_id,
      team_b_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@team_a_id, @team_b_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE games
    SET
    (
      team_a_id,
      team_b_id
    ) =
    (
      $1, $2
    )
    WHERE id = $3"
    values = [@team_a_id, @team_b_id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM games
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM games"
    game_data = SqlRunner.run(sql)
    games = map_items(game_data)
    return games
  end

  def self.delete_all()
    sql = "DELETE FROM games"
    SqlRunner.run(sql)
  end

  def self.map_items(game_data)
    return game_data.map { |game| Game.new(game) }
  end

  def play(team_a, team_b)
    # Input team_a_id and team_b_id [DONE above - adding get team.id from team.find_id]
    # team_a.find_id
    # team_b.find_id
    # Select team_a_id as winner, team_b_id as loser {this will become select random winner, then select winner based on attributes} [DONE]
    winner = team_a
    puts "And the winner is... #{winner}"
    # Display result on webpage - 10:04 Tue 27th: I don't know how to do this yet
    # Update team_a_id on teams table: increase played by 1, increas won by 1, increase points by 1
    # sql = "UPDATE teams
    # SET
    # (
    #   played +=,
    #   won +=,
    #   points +=
    # )
    # =
    # (
    #   $1, $2, $4
    # )
    # WHERE id = winner
    # "
    # # Update team_b_id on teams table: increase played by 1, increas lost by 1
    # sql = "UPDATE teams
    # SET
    # (
    #   played +=,
    #   lost +=,
    # )
    # =
    # (
    #   $1, $3
    # )
    # WHERE id = loser
    # "
    # values = [@played, @won, @lost, @points]
    # SqlRunner.run(sql, values)
  end

end
