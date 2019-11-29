require_relative( '../db/sql_runner' )

class Team

  attr_accessor :played, :won, :lost, :points
  attr_reader :name, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @played = options['played'] ? options['played'].to_i : 0
    @won = options['won'] ? options['won'].to_i : 0
    @lost = options['lost'] ? options['lost'].to_i : 0
    @points = options['points'] ? options['points'].to_i : 0
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

  def update()
    sql = "UPDATE teams
    SET
    (
      name,
      played,
      won,
      lost,
      points
    ) =
    (
      $1, $2, $3, $4, $5
    )
    WHERE id = $6"
    values = [@name, @played, @won, @lost, @points, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM teams
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM teams"
    team_data = SqlRunner.run(sql)
    teams = map_items(team_data)
    return teams
  end

  def self.find(id)
    sql = "SELECT * FROM teams
    WHERE id = $1"
    values = [id]
    team = SqlRunner.run(sql, values)
    result = Team.new(team.first)
    return result
  end

  def self.delete_all
    sql = "DELETE FROM teams"
    # SqlRunner.run( sql )
  end

  def self.map_items(team_data)
    return team_data.map { |team| Team.new(team) }
  end

  # def won
  #   @played += 1
  #   @won += 1
  #   @points += 3
  #   update()
  # end
  #
  # def lost
  #   @played += 1
  #   @lost += 1
  #   update()
  # end

end
