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
  erb(:new)
end

get '/teams/:id' do # show
  @team = Team.find(params[:id])
  erb(:show)
end

post '/teams' do # create
  @team = Team.new(params)
  @team.save()
  erb(:create)
end

get '/teams/:id/edit' do # edit
  @team = Team.find(params[:id])
  erb(:edit)
end

post '/teams/:id' do # update
  Team.new(params).update
  redirect to '/teams'
end

post '/teams/:id/delete' do # delete
  team = Team.find(params[:id])
  Team.delete()
  redirect to '/teams'
end
