require_relative('../db/sql_runner')

class User

  attr_reader :id
  attr_accessor :first_name, :last_name, :username, :balance

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @first_name = options['first_name']
    @last_name = options['last_name']
    @username = options['username']
    @balance = options['balance']
  end

  def save
    sql = "INSERT INTO users
          (first_name,
          last_name,
          username,
          balance)
          VALUES
          ($1, $2, $3, $4)
          RETURNING id"
    values = [@first_name, @last_name, @username, @balance]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def update
    sql = "UPDATE users
          SET
          (first_name,
          last_name,
          username,
          balance)
          =
          ($1, $2, $3, $4)
          WHERE id = $5"
          values = [@first_name, @last_name, @username, @balance, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM users
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM users
          WHERE id = $1"
    values = [id]
    user = SqlRunner.run(sql, values).first
    return User.new(user)
  end

  def self.delete_all
    sql = "DELETE FROM users"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM users"
    SqlRunner.run(sql).map {|user| User.new(user)}
  end

end
