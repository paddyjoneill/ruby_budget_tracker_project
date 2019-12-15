require_relative('../db/sqlrunner')

class Category

  attr_reader :id
  attr_accessor :name, :active

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @active = options['active']
  end

  def save()
    sql = "INSERT INTO categories
    (
      name, active
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @active]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM categories"
    results = SqlRunner.run( sql )
    category_array = results.map { |hash| Category.new( hash ) }
    for category in category_array
      if category.active == "t"
        category.active = true
      else
        category.active = false
      end
    end
    return category_array
  end

  def self.all_active()
    sql = "SELECT * FROM categories WHERE active = true"
    results = SqlRunner.run( sql )
    category_array = results.map { |hash| Category.new( hash ) }
    for category in category_array
      if category.active == "t"
        category.active = true
      else
        category.active = false
      end
    end
    return category_array
  end

  def self.find( id )
    sql = "SELECT * FROM categories
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    category = Category.new( results.first )
    if category.active == "t"
      category.active = true
    else
      category.active = false
    end
    return category
  end

  def update()
    sql = " UPDATE categories SET
      (name, active) = ( $1, $2)
     WHERE id = $3;"
    values = [@name, @active, @id]
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
