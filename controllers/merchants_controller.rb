require('pry-byebug')
require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('../models/category')
require_relative('../models/merchant')
require_relative('../models/transaction')
require_relative('../models/user')
also_reload('../models/*')

get '/merchants' do
  @merchants = Merchant.all
  erb (:"merchants/show")
end

get '/merchant/new' do
  erb( :"merchants/new" )
end

post '/merchants' do
  merchant = Merchant.new(params)
  merchant.save
  redirect to '/merchants'
end

get '/merchants/:merchant_id/edit' do
  @merchant = Merchant.find(params['merchant_id'])
  erb ( :"merchants/edit")
end

get '/merchants/:merchant_id/delete' do
  Transaction.delete_by_merchant(params['merchant_id'])
  merchant = Merchant.find(params['merchant_id'])
  merchant.delete
  redirect to '/merchants'
end

post '/merchants/:id' do
  merchant = Merchant.new(params)
  merchant.update
  redirect to '/merchants'
end
