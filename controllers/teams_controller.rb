require('sinatra')
require('sinatra/contrib/all')
# require('pry')
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

# The following code deletes an entry from the teams table in the sport_scoring_app database
post '/teams/:id/delete' do # delete
  # The above line displays the action to be taken and the assigned path for the browser
  team = Team.find(params[:id])
  # The above line uses the id which is passed in to locate the entry in the table
  team.delete()
  # The above line removes the entry from the table
  redirect to '/teams'
  # The above line takes the user from the team's id page to the Teams list page
end

get '/about' do # about index
  erb(:"/about")
end
