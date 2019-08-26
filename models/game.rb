require_relative( '../db/sql_runner' )

class Game

  attr_reader( :team_a_id, :team_b_id, :id )

  def initialize( options )
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

  def self.all()
    sql = "SELECT * FROM games"
    results = SqlRunner.run( sql )
    return results.map { |game| Game.new( game ) }
  end

  def self.delete_all()
    sql = "DELETE FROM games"
    SqlRunner.run( sql )
  end

  def self.destroy(id)
    sql = "DELETE FROM games
    WHERE id = $1"
    values = [id]
    SqlRunner.run( sql, values )
  end

end
