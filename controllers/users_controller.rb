require('pry-byebug')
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/category')
require_relative('../models/merchant')
require_relative('../models/transaction')
require_relative('../models/user')
also_reload('../models/*')

get '/users/:user_id/edit' do
   @user = User.find(params['user_id'])
   erb ( :"users/edit")
end

get '/users/:user_id/delete' do
  Transaction.delete_by_user(params['user_id'])
  user = User.find(params['user_id'])
  user.delete
  redirect to '/'
end

post '/users/:id' do
  user = User.new(params)
  user.update
  redirect to '/'
end

get '/user/new' do
  erb ( :"users/new" )
end

post '/users' do
  user = User.new(params)
  user.save
  redirect to '/'
end

get '/user/:user_id/top_up' do
  @user = User.find(params['user_id'])
  erb ( :"users/top_up" )
end

post '/user/:user_id/top_up' do
  user = User.find(params['user_id'])
  user.top_up(params['balance'])
  redirect to '/'
end
