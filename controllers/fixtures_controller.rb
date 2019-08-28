require('sinatra')
require('sinatra/contrib/all')
also_reload('../models/*')

get '/fixtures' do
  erb ( :"fixtures/index" )
end
