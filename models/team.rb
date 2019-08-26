require_relative( '../db/sql_runner' )

class Team

  attr_reader( :name, :id )
  attr_accessor( :played, :won, :lost, :points )

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @played = options['played'].to_i
    @won = options['won'].to_i
    @lost = options['lost'].to_i
    @points = options['points'].to_i
  end

  def save()
    sql = "INSERT INTO teams
    (
      name,
      played,
      won,
      lost,
      points
    )
    VALUES
    (
      $1, $2, $3, $4, $5
    )
    RETURNING id"
    values = [@name, @played, @won, @lost, @points]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM teams"
    results = SqlRunner.run( sql )
    return results.map { |team| Team.new( team ) }
  end

  def self.find( id )
    sql = "SELECT * FROM teams
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Team.new( results.first )
  end

  def self.delete_all
    sql = "DELETE FROM teams"
    SqlRunner.run( sql )
  end

end
