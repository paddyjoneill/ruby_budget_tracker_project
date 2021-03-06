require_relative('../db/sqlrunner')
require_relative('./merchant')
require_relative('./category')
require_relative('./bill')

class Transaction

  attr_reader :id, :merchant_id, :category_id, :amount, :time, :bill_id
  attr_accessor :date, :is_bill

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @merchant_id = options['merchant_id'].to_i
    @category_id = Merchant.find(@merchant_id).default_cat_id.to_i
    @amount = options['amount'].to_i
    @time = options['time']
    @date = options['date']
    #these two only used if recurring bill
    @is_bill = options['is_bill'] if options['is_bill']
    @bill_id = options['bill_id'] if options['bill_id']
  end

  def save()
    sql = "INSERT INTO transactions
    (
      merchant_id, category_id, amount, time, date, is_bill, bill_id
    )
    VALUES
    (
      $1, $2, $3, $4, $5, $6, $7
    )
    RETURNING id"
    values = [@merchant_id, @category_id, @amount, @time, @date, @is_bill, @bill_id]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

# returns all transactions
  def self.all()
    sql = "SELECT * FROM transactions
            ORDER BY date;"
    results = SqlRunner.run( sql )
    results_array = results.map { |hash| Transaction.new( hash ) }
    for result in results_array
      result.date = Date.parse result.date
      if result.is_bill == "t"
        result.is_bill = true
      else
        result.is_bill = nil
      end
    end
    return results_array
  end

# returns all transactions for a month
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
      if result.is_bill == "t"
        result.is_bill = true
      else
        result.is_bill = nil
      end
    end
    return results_array
  end

# returns all transactions for a category in a month
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
      if result.is_bill == "t"
        result.is_bill = true
      else
        result.is_bill = nil
      end
    end
    return results_array
  end

# returns all transactions for a merchant in a month
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
      if result.is_bill == "t"
        result.is_bill = true
      else
        result.is_bill = nil
      end
    end
    return results_array
  end

# finds transaction by id
  def self.find( id )
    sql = "SELECT * FROM transactions
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run( sql, values )
    result = Transaction.new( results.first )
    result.date = Date.parse result.date
    if result.is_bill == "t"
      result.is_bill = true
    else
      result.is_bill = nil
    end
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
    @date = Date.parse(options['date'])
    @end_date = Date.parse(options['end_date'])
    bill = Bill.new(options)
    bill.save()
    options['bill_id'] = bill.bill_id.to_i
    options['is_bill'] = true
    while @date < @end_date
      options['date'] = @date
      trans = Transaction.new(options)
      trans.save()
      @date = @date >> 1
    end
  end

  def self.delete_bill(bill_id, date)
    sql = "DELETE FROM transactions WHERE bill_id = $1 AND date >= $2"
    values = [bill_id, date]
    SqlRunner.run( sql, values )
  end

  def self.update_bill(options)
    self.delete_bill(options['bill_id'], options['date'])
    self.recurring_bill(options)
  end


end
