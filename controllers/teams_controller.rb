require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/team.rb')
also_reload('../models/*')

get '/teams' do # index
  @teams = Team.all()
  erb(:"teams/index")
end

get '/teams/new' do # new
  erb(:"teams/new")
end

get '/teams/:id' do # show
  @team = Team.find(params[:id])
  erb(:"teams/show")
end

post '/teams' do # create
  @team = Team.new(params)
  @team.save()
  redirect to '/teams'
end

get '/teams/:id/edit' do # edit
  @team = Team.find(params[:id])
  erb(:"teams/edit")
end

post '/teams/:id' do # update
  # binding.pry
  Team.new(params).update
  redirect to '/teams'
end

post '/teams/:id/delete' do # delete
  team = Team.find(params[:id])
  team.delete()
  redirect to '/teams'
end

get '/about' do # about index
  erb(:"/about")
end
