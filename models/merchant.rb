require_relative('../db/sqlrunner')
require_relative('./category')

class Merchant

  attr_reader :id
  attr_accessor :name, :default_cat_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @default_cat_id = options['default_cat_id'].to_i
  end

  def save()
    sql = "INSERT INTO merchants
    (
      name, default_cat_id
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @default_cat_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run( sql )
    return results.map { |hash| Merchant.new( hash ) }
  end

  def self.find( id )
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    return Merchant.new( results.first )
  end

  def update()
    sql = " UPDATE merchants SET (
      name, default_cat_id
    ) = (
      $1, $2
    ) WHERE id = $3;"
    values = [@name, @default_cat_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM merchants"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM merchants WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end





end
