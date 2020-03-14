require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('models/category')
require_relative('models/merchant')
require_relative('models/transaction')
require_relative('models/user')
also_reload('./models/*')
# require_relative('controllers/categories_controller')


get '/' do
  @users = User.all
  erb( :index )
end

post '/transaction/new' do
  @transactions = Transaction.all
  erb( :"transactions/new" )
end

# get '/transactions/:id/new' do
#  catch user_id
# end

get '/transactions/:id' do
  @transactions = Transaction.all
  #return user object by :id

  erb( :"transactions/show")
end
