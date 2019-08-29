require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/team.rb')
also_reload('../../ruby_solo_project/*')

get '/teams' do
  @teams = Team.all()
  erb ( :"teams/index" )
end

# get '/teams/:id' do
#   @team = Team.find(params['id'].to_i)
#   erb( :"teams/show" )
# end

get '/teams/league-table' do
  erb( :"teams/league_table" )
end

get '/teams/fixtures' do
  erb( :"teams/fixtures" )
end

get '/about' do
  erb( :"about" )
end
