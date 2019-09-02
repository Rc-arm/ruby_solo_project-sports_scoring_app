require_relative('../db/sql_runner')
require_relative('./team.rb')

class Fixture

  attr_accessor :winning_team_id, :losing_team_id
  attr_reader :team_a_id, :team_b_id, :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @team_a_id = options['team_a_id'].to_i
    @team_b_id = options['team_b_id'].to_i
    @winning_team_id = options['winning_team_id'].to_i if options['winning_team_id']
    @losing_team_id = options['losing_team_id'].to_i if options['losing_team_id']
  end

  def save()
    sql = "INSERT INTO fixtures
    (
      team_a_id,
      team_b_id,
      winning_team_id,
      losing_team_id
    )
    VALUES
    (
      $1, $2, $3, $4
    )
    RETURNING id"
    values = [@team_a_id, @team_b_id, @winning_team_id, @losing_team_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.find(id)
    sql = "SELECT * FROM fixtures
    WHERE id = $1"
    values = [id]
    fixture = SqlRunner.run(sql, values)
    result = Fixture.new(fixture.first)
    return result
  end

  def update()
    sql = "UPDATE fixtures
    SET
    (
      team_a_id,
      team_b_id,
      winning_team_id,
      losing_team_id
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@team_a_id, @team_b_id, @winning_team_id, @losing_team_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM fixtures
    WHERE id = $1"
    values = [id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM fixtures"
    fixture_data = SqlRunner.run(sql)
    fixtures = map_items(fixture_data)
    return fixtures
  end

  def self.delete_all()
    sql = "DELETE FROM fixtures"
    SqlRunner.run(sql)
  end

  def self.map_items(fixture_data)
    return fixture_data.map { |fixture| Fixture.new(fixture) }
  end

  def team_a()
    sql = "SELECT * FROM teams
    WHERE id = $1"
    values = [@team_a_id]
    teams = SqlRunner.run(sql, values)
    result = Team.new(teams.first)
    return result
  end

  def team_b()
    sql = "SELECT * FROM teams
    WHERE id = $1"
    values = [@team_b_id]
    teams = SqlRunner.run(sql, values)
    result = Team.new(teams.first)
    return result
  end

  def winning_team()
    sql = "SELECT * FROM teams
    WHERE id = $1"
    values = [@winning_team_id]
    teams = SqlRunner.run(sql, values)
    result = Team.new(teams.first)
    return result
  end

  # def play(teams)
  #   teams = [@team_a_id, @team_b_id]
  #   @winning_team_id = teams.sample()
  #   @losing_team_id = if team in teams is not @winning_team_id
  # end

end
