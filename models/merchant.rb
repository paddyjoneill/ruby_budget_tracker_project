require_relative('../db/sqlrunner')
require_relative('./category')

class Merchant

  attr_reader :id
  attr_accessor :name, :default_cat_id, :active

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @default_cat_id = options['default_cat_id'].to_i
    @active = options['active']
  end

  def save()
    sql = "INSERT INTO merchants
    (
      name, default_cat_id, active
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@name, @default_cat_id, @active]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run( sql )
    merchants_array = results.map { |hash| Merchant.new( hash ) }
    for merchant in merchants_array
      if merchant.active == "t"
        merchant.active = true
      else
        merchant.active = false
      end
    end
    return merchants_array
  end

  def self.all_active()
    sql = "SELECT * FROM merchants WHERE active = true"
    results = SqlRunner.run( sql )
    merchants_array = results.map { |hash| Merchant.new( hash ) }
    for merchant in merchants_array
      if merchant.active == "t"
        merchant.active = true
      else
        merchant.active = false
      end
    end
    return merchants_array
  end

  def self.find( id )
    sql = "SELECT * FROM merchants
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    merchant = Merchant.new( results.first )
    if merchant.active == "t"
      merchant.active = true
    else
      merchant.active = false
    end
    return merchant
  end

  def update()
    sql = " UPDATE merchants SET (
      name, default_cat_id, active
    ) = (
      $1, $2, $3
    ) WHERE id = $4;"
    values = [@name, @default_cat_id, @active, @id]
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
