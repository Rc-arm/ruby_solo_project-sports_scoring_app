require('sinatra')
require('sinatra/contrib/all')
# require('pry')
require_relative('../models/fixture.rb')
require_relative('../models/team.rb')
also_reload('../models/*')

get '/fixtures' do #index
  @fixtures = Fixture.all
  erb (:"fixtures/index")
end

get '/fixtures/new' do #new
  @fixtures = Fixture.all
  erb(:"fixtures/new")
end

get '/fixtures/:id' do # show
  @fixture = Fixture.find(params[:id])
  erb(:show)
end

post '/fixtures' do #create
  @fixture = Fixture.new(params)
  @fixture.save()
  erb(:create)
end

get '/fixtures/:id/edit' do # edit
  @fixture = Fixture.find(params[:id])
  erb(:"fixtures/edit")
end

post '/fixtures/:id' do # update
  Fixture.new(params).update
  redirect to '/fixtures'
end

post '/fixtures/:id/delete' do #delete
  fixture = Fixture.find(params[:id])
  fixture.delete()
  redirect to("/fixtures")
end
