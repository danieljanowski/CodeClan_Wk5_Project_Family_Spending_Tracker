require('pry-byebug')
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('models/category')
require_relative('models/merchant')
require_relative('models/transaction')
require_relative('models/user')
also_reload('./models/*')
# also_reload('./images/*')
# also_reload('./public/*')

# require_relative('controllers/categories_controller')


get '/' do
  @users = User.all
  erb( :index )
end

post '/transaction/:id/new' do
 # catch user_id
 @user = User.find(params['id'])
 @transactions = Transaction.by_user(params['id'])
 @merchants = Merchant.all
 @categories = Category.all
 erb( :"transactions/new")
end

get '/transactions/:id' do
   @user = User.find(params['id'])
   @transactions = Transaction.by_user(params['id'])
   erb( :"transactions/show")
end

post '/transactions/:user_id' do
  @transaction = Transaction.new( params )
  @transaction.save()
  @user = User.find(params['user_id'])
  @transactions = Transaction.by_user(params['user_id'])
  erb( :"transactions/show")
end
