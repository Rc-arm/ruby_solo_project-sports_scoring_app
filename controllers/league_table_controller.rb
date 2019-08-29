require('sinatra')
require('sinatra/contrib/all')
require('pry')
require_relative('../models/league_table.rb')
require_relative('../models/teams.rb')
also_reload('../../ruby_solo_project/*')

get '/league-table' do
  erb ( :"league_table" )
end
