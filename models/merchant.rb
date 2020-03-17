require_relative('../db/sql_runner')

class Merchant

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO merchants
          (name)
          VALUES
          ($1)
          RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def update
    sql = "UPDATE merchants
          SET name = $1
          WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM merchants
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM merchants
          WHERE id = $1"
    values = [id]
    merchant = SqlRunner.run(sql, values).first
    return Merchant.new(merchant)
  end

  def self.delete_all
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM merchants
          ORDER BY merchants.name"
    SqlRunner.run(sql).map {|merchant| Merchant.new(merchant)}
  end

end
