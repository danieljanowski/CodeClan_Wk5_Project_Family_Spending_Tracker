require('pry-byebug')
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/category')
require_relative('../models/merchant')
require_relative('../models/transaction')
require_relative('../models/user')
also_reload('../models/*')

get '/categories' do
  @categories = Category.all
  erb (:"categories/show")
end

post '/categories' do
  category = Category.new(params)
  category.save
  redirect to '/categories'
end

get '/category/new' do
  erb( :"categories/new" )
end

get '/categories/:category_id/delete' do
  Transaction.delete_by_category(params['category_id'])
  category = Category.find(params['category_id'])
  category.delete
  redirect to '/categories'
end

get '/categories/:category_id/edit' do
  @category = Category.find(params['category_id'])
  # @categories = Category.all
  erb ( :"categories/edit")
end

post '/categories/:id' do
  category = Category.new(params)
  category.update
  redirect to '/categories'
end
