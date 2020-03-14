require_relative('../db/sql_runner')

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

  def self.all
    sql = "SELECT * FROM transactions"
    SqlRunner.run(sql).map {|transaction| Transaction.new(transaction)}
  end

end
