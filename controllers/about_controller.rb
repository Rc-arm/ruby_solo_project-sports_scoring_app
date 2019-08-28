require('sinatra')
require('sinatra/contrib/all')
also_reload('../models/*')

get '/about' do
  erb ( :"about/index" )
end
