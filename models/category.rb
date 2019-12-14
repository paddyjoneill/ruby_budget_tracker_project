require_relative('../db/sqlrunner')

class Category

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO categories
    (
      name
    )
    VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM categories"
    results = SqlRunner.run( sql )
    return results.map { |hash| Merchant.new( hash ) }
  end

  def self.find( id )
    sql = "SELECT * FROM categories
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Category.new( results.first )
  end

  def update()
    sql = " UPDATE merchants SET
      name = $1
     WHERE id = $2;"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM categories"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM categories WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end



end
