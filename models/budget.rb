require_relative('../db/sqlrunner')

class Budget

  attr_reader :id
  attr_accessor :monthly_budget, :target, :income

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @income = options['income'].to_i
    @target = options['target'].to_i
    @monthly_budget = @income - @target

  end

  def save()
    sql = "INSERT INTO budgets
    (
      monthly_budget, target, income
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@monthly_budget, @target, @income]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM budgets"
    results = SqlRunner.run( sql )
    category_array = results.map { |hash| Budget.new( hash ) }
    return category_array.first
  end

  def update()
    sql = " UPDATE budgets SET
      (monthly_budget, target, income) = ( $1, $2, $3)
     WHERE id = $4;"
    values = [@monthly_budget, @target, @income, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM budgets"
    SqlRunner.run(sql)
  end


end
