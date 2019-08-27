require_relative('../db/sql_runner')

class Game

  attr_reader :team_a_id, :team_b_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @team_a_id = options['team_a_id'].to_i
    @team_b_id = options['team_b_id'].to_i
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

end
