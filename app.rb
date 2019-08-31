require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/fixtures_controller')
require_relative('controllers/teams_controller')

get '/' do
  erb( :index )
end
