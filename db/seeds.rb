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


user1 = User.new('first_name' => 'Daniel', 'last_name' => 'Janowski', 'username' => 'Daniel', 'balance' => 100)
user1.save

merchant1 = Merchant.new('name' => 'Tesco')
merchant2 = Merchant.new('name' => 'Smyths')
merchant3 = Merchant.new('name' => 'Pizza Hut')
merchant1.save
merchant2.save
merchant3.save

category1 = Category.new('name' => 'groceries')
category2 = Category.new('name' => 'toys')
category3 = Category.new('name' => 'eating out')
category1.save
category2.save
category3.save

transaction1 = Transaction.new('user_id' => user1.id, 'category_id' => category1.id, 'merchant_id' => merchant1.id, 'value' => 23)
transaction2 = Transaction.new('user_id' => user1.id, 'category_id' => category2.id, 'merchant_id' => merchant2.id, 'value' => 34)
transaction3 = Transaction.new('user_id' => user1.id, 'category_id' => category3.id, 'merchant_id' => merchant3.id, 'value' => 52)

transaction1.save
transaction2.save
transaction3.save

binding.pry
nil
