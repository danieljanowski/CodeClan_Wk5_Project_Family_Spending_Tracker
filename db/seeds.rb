require('pry-byebug')
require_relative('../models/merchant.rb')
require_relative('../models/category.rb')
require_relative('../models/transaction.rb')
require_relative('../models/user.rb')
require_relative('../db/sql_runner')

Transaction.delete_all
Merchant.delete_all
Category.delete_all
User.delete_all

user1 = User.new('first_name' => 'Daniel', 'last_name' => 'Janowski', 'username' => 'Daniel', 'balance' => 200.00)
user1.save
user2 = User.new('first_name' => 'Oliver', 'last_name' => 'Janowski', 'username' => 'Oliver', 'balance' => 78.00)
user2.save
user3 = User.new('first_name' => 'Kaja', 'last_name' => 'Janowska', 'username' => 'Kaja', 'balance' => 65.50)
user3.save
user4 = User.new('first_name' => 'Milena', 'last_name' => 'Janowska', 'username' => 'Millie', 'balance' => 230.40)
user4.save
user5 = User.new('first_name' => 'Samuel', 'last_name' => 'Janowski', 'username' => 'Samuel', 'balance' => 54.10)
user5.save
user6 = User.new('first_name' => 'Agata', 'last_name' => 'Janowska', 'username' => 'Mum', 'balance' => 124.00)
user6.save
user7 = User.new('first_name' => 'Naomi', 'last_name' => 'Janowska', 'username' => 'Naomi', 'balance' => 66.00)
user7.save



merchant1 = Merchant.new('name' => 'Tesco')
merchant2 = Merchant.new('name' => 'Smyths')
merchant3 = Merchant.new('name' => 'Pizza Hut')
merchant4 = Merchant.new('name' => 'PCWorld')
merchant7 = Merchant.new('name' => 'McDonalds')
merchant8 = Merchant.new('name' => 'Odeon')
merchant1.save
merchant2.save
merchant3.save
merchant4.save
merchant7.save
merchant8.save

category1 = Category.new('name' => 'groceries')
category2 = Category.new('name' => 'toys')
category3 = Category.new('name' => 'restaurant')
category5 = Category.new('name' => 'gadgets')
category8 = Category.new('name' => 'entertainment')
category9 = Category.new('name' => 'sweets')
category1.save
category2.save
category3.save
category5.save
category8.save
category9.save

transaction1 = Transaction.new('user_id' => user1.id, 'category_id' => category1.id, 'merchant_id' => merchant1.id, 'value' => 23.00)
transaction2 = Transaction.new('user_id' => user1.id, 'category_id' => category2.id, 'merchant_id' => merchant2.id, 'value' => 34.00)
transaction3 = Transaction.new('user_id' => user1.id, 'category_id' => category3.id, 'merchant_id' => merchant3.id, 'value' => 52.00)
transaction4 = Transaction.new('user_id' => user1.id, 'category_id' => category5.id, 'merchant_id' => merchant4.id, 'value' => 37.00)
transaction5 = Transaction.new('user_id' => user2.id, 'category_id' => category2.id, 'merchant_id' => merchant2.id, 'value' => 17.50)
transaction6 = Transaction.new('user_id' => user2.id, 'category_id' => category3.id, 'merchant_id' => merchant1.id, 'value' => 52.00)
transaction7 = Transaction.new('user_id' => user3.id, 'category_id' => category3.id, 'merchant_id' => merchant7.id, 'value' => 4.50)
transaction8 = Transaction.new('user_id' => user4.id, 'category_id' => category8.id, 'merchant_id' => merchant8.id, 'value' => 8.40)
transaction9 = Transaction.new('user_id' => user4.id, 'category_id' => category9.id, 'merchant_id' => merchant1.id, 'value' => 1.50)
transaction10 = Transaction.new('user_id' => user4.id, 'category_id' => category3.id, 'merchant_id' => merchant7.id, 'value' => 12.50)

transaction1.save
transaction2.save
transaction3.save
transaction4.save
transaction5.save
transaction6.save
transaction7.save
transaction8.save
transaction9.save
transaction10.save

# binding.pry
nil
