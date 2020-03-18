require_relative('../db/sql_runner')
require('pry-byebug')

class Transaction

  attr_reader :id
  attr_accessor :user_id, :category_id, :merchant_id, :value

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @user_id = options['user_id'].to_i
    @category_id = options['category_id'].to_i
    @merchant_id = options['merchant_id'].to_i
    @value = options['value']
  end

  def save
    sql = "INSERT INTO transactions
          (user_id,
          category_id,
          merchant_id,
          value)
          VALUES
          ($1, $2, $3, $4)
          RETURNING id"
    values = [@user_id, @category_id, @merchant_id, @value]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def update
    sql = "UPDATE transactions
          SET
          (user_id,
          category_id,
          merchant_id,
          value)
          =
          ($1, $2, $3, $4)
          WHERE id = $5"
          values = [@user_id, @category_id, @merchant_id, @value, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM transactions
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def user
    sql = "SELECT users.* FROM users
          INNER JOIN transactions
          ON users.id = transactions.user_id
          WHERE transactions.id = $1
          ORDER BY transactions.id"
    values = [@id]
    return User.new(SqlRunner.run(sql, values).first)
  end

  def category
    sql = "SELECT categories.* FROM categories
          INNER JOIN transactions
          ON categories.id = transactions.category_id
          WHERE transactions.id = $1
          ORDER BY categories.name"
    values = [@id]
    return Category.new(SqlRunner.run(sql, values).first)
  end

  def merchant
    sql = "SELECT merchants.* FROM merchants
          INNER JOIN transactions
          ON merchants.id = transactions.merchant_id
          WHERE transactions.id = $1
          ORDER BY merchants.name"
    values = [@id]
    return Merchant.new(SqlRunner.run(sql, values).first)
  end

  def self.find(id)
    sql = "SELECT * FROM transactions
          WHERE id = $1"
    values = [id]
    transaction = SqlRunner.run(sql, values).first
    return Transaction.new(transaction)
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run(sql)
  end

  def self.delete_by_user(user_id)
    sql = "DELETE FROM transactions
          WHERE user_id = $1"
    values = [user_id]
    SqlRunner.run(sql, values)
  end

  def self.delete_by_category(category_id)
    sql = "DELETE FROM transactions
          WHERE category_id = $1"
    values = [category_id]
    SqlRunner.run(sql, values)
  end

  def self.delete_by_merchant(merchant_id)
    sql = "DELETE FROM transactions
          WHERE merchant_id = $1"
    values = [merchant_id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_merchant(user_id, merchant_id)
    sql = "SELECT transactions.*, merchants.name FROM transactions
          INNER JOIN merchants
          ON merchants.id = transactions.merchant_id
          WHERE user_id = $1 AND merchant_id = $2
          ORDER BY merchants.name"
    values = [user_id, merchant_id]
    result = SqlRunner.run(sql, values)
    search = result.map{|transaction| Transaction.new(transaction)}
  end

  def self.find_by_category(user_id, category_id)
    sql = "SELECT transactions.*, categories.name FROM transactions
          INNER JOIN categories
          ON categories.id = transactions.merchant_id
          WHERE user_id = $1 AND category_id = $2
          ORDER BY categories.name"
    values = [user_id, category_id]
    result = SqlRunner.run(sql, values)
    result.map{|transaction| Transaction.new(transaction)}
  end

  def self.by_user(id)
    sql = "SELECT * FROM transactions
          WHERE user_id = $1"
    values = [id]
    SqlRunner.run(sql, values).map {|transaction| Transaction.new(transaction)}
  end

  def self.total_by_user(id)
    sql = "SELECT SUM(value) FROM transactions
        WHERE user_id = $1"
    values = [id]
    SqlRunner.run(sql, values).first['sum']
  end

  def self.all
    sql = "SELECT * FROM transactions
          ORDER BY transactions.id"
    SqlRunner.run(sql).map {|transaction| Transaction.new(transaction)}
  end

end
