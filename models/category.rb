require_relative('../db/sql_runner')

class Category

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save
    sql = "INSERT INTO categories
          (name)
          VALUES
          ($1)
          RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result.first["id"].to_i
  end

  def update
    sql = "UPDATE categories
          SET name = $1
          WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM categories
          WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM categories
          WHERE id = $1"
    values = [id]
    category = SqlRunner.run(sql, values).first
    return Category.new(category)
  end

  def self.delete_all
    sql = "DELETE FROM categories"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM categories"
    SqlRunner.run(sql).map {|category| Category.new(category)}
  end

end
