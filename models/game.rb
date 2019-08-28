require_relative('../db/sql_runner')
require_relative('./team.rb')

class Game

  attr_reader :team_a_id, :team_b_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @team_a_id = options['team_a_id'].to_i
    @team_b_id = options['team_b_id'].to_i
    @winner_team_id = options['winner_team_id'].to_i if options['winner_team_id']
    @loser_team_id = options['loser_team_id'].to_i if options['loser_team_id']
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
      winner_team_id,
      loser_team_id
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@team_a_id, @team_b_id, @winner_team_id, @loser_team_id, @id]
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
# What does this need to do? In the game there's a team_a and a team_b (where team_a currently is always the winner). This method is for taking the team from the database so it can be used in .play.
  @team_a_id = team_a(id)
  end

  def team_b
    @team_b_id = team_b(id)
  end

  # def play()
  #   # team_a.find_id
  #   # team_b.find_id
  #   # Select team_a_id as winner, team_b_id as loser {this will become select random winner, then select winner based on attributes}
  #   @winner_team_id = @team_a_id
  #   @loser_team_id = @team_b_id
  #   update()
  #   puts @winner_team_id
  #   # Updates winner_team_id column on games table
  #   # Display result on webpage - 10:04 Tue 27th: I don't know how to do this yet
  # end

  def play(teams)
    teams = [@team_a_id, @team_b_id]
    winning_team = teams.sample()
    puts winning_team
  end

end
