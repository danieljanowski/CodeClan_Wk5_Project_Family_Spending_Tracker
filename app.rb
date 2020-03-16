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

get '/transaction/:id/new' do
 # catch user_id
 @user = User.find(params['id'])
 @transactions = Transaction.by_user(params['id'])
 @merchants = Merchant.all
 @categories = Category.all
 erb( :"transactions/new")
end

get '/transaction/:user_id/:transaction_id/delete' do
  transaction = Transaction.find(params['transaction_id'])
  transaction.delete
  @user = User.find(params['user_id'])
  @transactions = Transaction.by_user(params['user_id'])
  erb( :"transactions/show")
end

get '/transaction/:user_id/:transaction_id/edit' do
 # catch user_id
 @user = User.find(params['user_id'])
 # binding.pry
 @transaction = Transaction.find(params['transaction_id'])
 @transactions = Transaction.by_user(params['user_id'])
 @merchants = Merchant.all
 @categories = Category.all
 erb( :"transactions/edit")
end

post '/transactions/:user_id/:id' do
  transaction = Transaction.new( params )
  transaction.update
  @user = User.find(params['user_id'])
  @transactions = Transaction.by_user(params['user_id'])
  erb( :"transactions/show")
end

get '/transactions/:user_id' do
   @user = User.find(params['user_id'])
   @transactions = Transaction.by_user(params['user_id'])
   erb( :"transactions/show")
end

post '/transactions/:user_id' do
  transaction = Transaction.new( params )
  transaction.save()
  @user = User.find(params['user_id'])
  @transactions = Transaction.by_user(params['user_id'])
  erb( :"transactions/show" )
end

get '/user/new' do
  erb ( :"users/new" )
end

post '/users' do
  user = User.new(params)
  user.save
  redirect to '/'
end

get '/users/:user_id/edit' do
   @user = User.find(params['user_id'])
   erb ( :"users/edit")
end

post '/users/:id' do
  user = User.new(params)
  user.update
  redirect to '/'
end
