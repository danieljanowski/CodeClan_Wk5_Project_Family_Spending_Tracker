require( 'sinatra' )
require( 'sinatra/contrib/all' )
# require_relative('controllers/zombies_controller')


get '/' do
  erb( :index )
end
