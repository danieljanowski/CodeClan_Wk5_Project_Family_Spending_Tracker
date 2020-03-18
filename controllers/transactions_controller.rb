require('pry-byebug')
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/category')
require_relative('../models/merchant')
require_relative('../models/transaction')
require_relative('../models/user')
also_reload('../models/*')

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
  @merchants = Merchant.all
  @categories = Category.all
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

post '/transactions/:user_id/search' do
   @user = User.find(params['user_id'])
  if params['merchant_id']
    @transactions = Transaction.find_by_merchant(params['user_id'], params['merchant_id'])
  elsif params['category_id']
    @transactions = Transaction.find_by_category(params['user_id'], params['category_id'])
  else
    @transactions = "No transactions"
  end
  erb(:'transactions/search_results')
end

post '/transactions/:user_id/:id' do
  transaction = Transaction.new( params )
  transaction.update
  @user = User.find(params['user_id'])
  @transactions = Transaction.by_user(params['user_id'])
  @merchants = Merchant.all
  @categories = Category.all
  erb( :"transactions/show")
end

get '/transactions/:user_id' do
   @user = User.find(params['user_id'])
   @transactions = Transaction.by_user(params['user_id'])
   @merchants = Merchant.all
   @categories = Category.all
   erb( :"transactions/show")
end

post '/transactions/:user_id' do
  transaction = Transaction.new( params )
  transaction.save()
  @user = User.find(params['user_id'])
  @transactions = Transaction.by_user(params['user_id'])
  @merchants = Merchant.all
  @categories = Category.all
  erb( :"transactions/show" )
end
