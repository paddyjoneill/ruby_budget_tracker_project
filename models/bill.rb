require_relative('../db/sqlrunner')

class Bill

  attr_reader :bill_id
  attr_accessor :end_date

  def initialize(options)
    @bill_id = options['bill_id'].to_i if options['bill_id']
    @end_date = options['end_date']
  end

  def save()
    sql = "INSERT INTO bills
    (
      end_date
    )
    VALUES
    (
      $1
    )
    RETURNING bill_id"
    values = [@end_date]
    results = SqlRunner.run(sql, values)
    @bill_id = results.first()['bill_id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM bills"
    results = SqlRunner.run( sql )
    bill_array = results.map { |hash| Bill.new( hash ) }
    return bill_array
  end

  def self.find( id )
    sql = "SELECT * FROM bills
    WHERE id = $1"
    values = [bill_id]
    results = SqlRunner.run( sql, values )
    bill = Bill.new( results.first )
  end

  def update()
    sql = " UPDATE bill SET
    end_date = $1
     WHERE id = $2;"
    values = [@end_date, @bill_id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM bills"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM bills WHERE id = $1"
    values = [@bill_id]
    SqlRunner.run( sql, values )
  end
end
