require( 'sinatra' )
require( 'sinatra/contrib/all' )

require_relative('models/category')
require_relative('models/merchant')
require_relative('models/transaction')
require_relative('models/user')
also_reload('./models/*')

require_relative('controllers/transactions_controller')
require_relative('controllers/merchants_controller')
require_relative('controllers/categories_controller')
require_relative('controllers/users_controller')

get '/' do
  @users = User.all
  erb( :index )
end
