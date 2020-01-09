require('pry')
require_relative('../models/team.rb')
require_relative('../models/fixture.rb')

Fixture.delete_all()
Team.delete_all()

team1 = Team.new({
  "name" => "The Gym Bunnies",
  "played" => 2,
  "won" => 1,
  "lost" => 1,
  "points" => 1
})

team1.save()

team2 = Team.new({
  "name" => "Shop Winventory",
  "played" => 2,
  "won" => 2,
  "lost" => 0,
  "points" => 2
})

team2.save()

team3 = Team.new({
  "name" => "Spending Tracker Big Spenders",
  "played" => 2,
  "won" => 0,
  "lost" => 2,
  "points" => 0
})

team3.save()

team4 = Team.new({
  "name" => "Sports Scorers",
  "played" => 2,
  "won" => 2,
  "lost" => 0,
  "points" => 2
})

team4.save()

team5 = Team.new({
  "name" => "Travel Bucket List Jetsetters",
  "played" => 2,
  "won" => 1,
  "lost" => 1,
  "points" => 1
})

team5.save()

team6 = Team.new({
  "name" => "Vet Squad Managers",
  "played" => 2,
  "won" => 0,
  "lost" => 2,
  "points" => 0
})

team6.save()

fixture1 = Fixture.new({
  "team_a_id" => team1.id,
  "team_b_id" => team2.id,
  "winning_team_id" => team2.id,
  "losing_team_id" => team1.id
})

fixture1.save()

fixture2 = Fixture.new({
  "team_a_id" => team3.id,
  "team_b_id" => team4.id,
  "winning_team_id" => team4.id,
  "losing_team_id" => team3.id
})

fixture2.save()

fixture3 = Fixture.new({
  "team_a_id" => team5.id,
  "team_b_id" => team6.id,
  "winning_team_id" => team5.id,
  "losing_team_id" => team6.id
})

fixture3.save()

fixture4 = Fixture.new({
  "team_a_id" => team1.id,
  "team_b_id" => team3.id,
  "winning_team_id" => team1.id,
  "losing_team_id" => team3.id
})

fixture4.save()

fixture5 = Fixture.new({
  "team_a_id" => team2.id,
  "team_b_id" => team5.id,
  "winning_team_id" => team2.id,
  "losing_team_id" => team5.id
})

fixture5.save()

fixture6 = Fixture.new({
  "team_a_id" => team4.id,
  "team_b_id" => team6.id,
  "winning_team_id" => team4.id,
  "losing_team_id" => team6.id
})

fixture6.save()

binding.pry
nil
