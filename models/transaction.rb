require_relative('../db/sqlrunner')
require_relative('./merchant')
require_relative('./category')

class Transaction

  attr_reader :id, :merchant_id, :category_id, :amount, :time
  attr_accessor :date

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @merchant_id = options['merchant_id'].to_i
    @category_id = Merchant.find(@merchant_id).default_cat_id.to_i
    @amount = options['amount'].to_i
    @time = options['time']
    @date = options['date']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      merchant_id, category_id, amount, time, date
    )
    VALUES
    (
      $1, $2, $3, $4, $5
    )
    RETURNING id"
    values = [@merchant_id, @category_id, @amount, @time, @date]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM transactions
            ORDER BY date;"
    results = SqlRunner.run( sql )
    results_array = results.map { |hash| Transaction.new( hash ) }
    for result in results_array
      result.date = Date.parse result.date
    end
    return results_array
  end

  def self.month(month, year)
    sql = "SELECT * FROM transactions
            WHERE EXTRACT(MONTH from date) = $1
            AND EXTRACT(YEAR from date) = $2
            ORDER BY date;"
    values = [month, year]
    results = SqlRunner.run( sql ,values)
    results_array = results.map { |hash| Transaction.new( hash ) }
    for result in results_array
      result.date = Date.parse result.date
    end
    return results_array
  end

  def self.month_category(month, year, category_id)
    sql = "SELECT * FROM transactions
            WHERE EXTRACT(MONTH from date) = $1
            AND EXTRACT(YEAR from date) = $2
            AND category_id = $3
            ORDER BY date;"
    values = [month, year, category_id]
    results = SqlRunner.run( sql ,values)
    results_array = results.map { |hash| Transaction.new( hash ) }
    for result in results_array
      result.date = Date.parse result.date
    end
    return results_array
  end

  def self.month_merchant(month, year, merchant_id)
    sql = "SELECT * FROM transactions
            WHERE EXTRACT(MONTH from date) = $1
            AND EXTRACT(YEAR from date) = $2
            AND merchant_id = $3
            ORDER BY date;"
    values = [month, year, merchant_id]
    results = SqlRunner.run( sql ,values)
    results_array = results.map { |hash| Transaction.new( hash ) }
    for result in results_array
      result.date = Date.parse result.date
    end
    return results_array
  end

  def self.find( id )
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    result = Transaction.new( results.first )
    result.date = Date.parse result.date
    return result
  end

  def update()
    sql = " UPDATE transactions SET (
      merchant_id, category_id, amount, time, date
    ) = (
      $1, $2, $3, $4, $5
    ) WHERE id = $6;"
    values = [@merchant_id, @category_id, @amount, @time, @date, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM transactions"
    SqlRunner.run( sql )
  end

  def delete
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run( sql, values )
  end

  def self.transactions_total(transactions)
    total = 0
    for transaction in transactions
      total += transaction.amount
    end
    return total
  end

  def self.recurring_bill(options)
    # binding.pry
    @date = Date.parse(options['date'])
    @end_date = Date.parse(options['end_date'])
    while @date < @end_date
      options['date'] = @date
      bill = Transaction.new(options)
      bill.save()
      @date = @date >> 1
    end
  end



end
