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
      team_b_id,
      winner_team_id
    ) =
    (
      $1, $2, $3
    )
    WHERE id = $4"
    values = [@team_a_id, @team_b_id, @winner_team_id, @id]
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

  def team_a
# What does this need to do? In the game there's a team_a and a team_b (where team_a currently is always the winner). This method is for
  end

  def team_b

  end

  def play()
    # Input team_a_id and team_b_id [DONE above - adding get team.id from team.find_id]
    # team_a.find_id
    # team_b.find_id
    # Select team_a_id as winner, team_b_id as loser {this will become select random winner, then select winner based on attributes} [DONE]
    @winner_team_id = @team_a_id
    update()
    # Updates winner_team_id column on games table
    # puts "And the winner is... #{winner}"
    # Display result on webpage - 10:04 Tue 27th: I don't know how to do this yet  end
  end

end
