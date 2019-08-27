require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/team.rb' )
also_reload( '../models/*' )

get '/teams' do
  @teams = Team.all()
  erb ( :"teams/index" )
end

get '/teams/:id' do
  @team = Team.find(params['id'].to_i)
  erb( :"teams/show" )
end
