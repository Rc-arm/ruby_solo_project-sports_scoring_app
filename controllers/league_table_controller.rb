require('sinatra')
require('sinatra/contrib/all')
also_reload('../models/*')

get '/league-table' do
  erb ( :"league_table/index" )
end
