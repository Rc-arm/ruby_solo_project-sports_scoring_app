require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/game.rb')
require_relative('../models/team.rb')
also_reload('../models/*')

get '/games' do #index
  @games = Game.all
  erb ( :"games/index" )
end

get '/games/new' do #new
  erb(:"games/new")
end

post '/games' do #create
  @game = Game.new(params)
  @game.save()
  redirect to("/games/result")
end

post '/games/:id/delete' do #delete
  Game.delete(params[:id])
  redirect to("/games")
end
