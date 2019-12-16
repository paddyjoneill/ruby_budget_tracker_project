require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'pry'


require_relative ('../models/category')
require_relative ('../models/merchant')
require_relative ('../models/transaction')
require_relative ('../models/budget')
also_reload('../models/*')

get '/budgets/?' do
  @budget = Budget.all()
  @merchants = Merchant.all()
  @categories = Category.all()

  if params['month'] != nil
    @transactions = Transaction.month(params['month'],params['year'])
  else
    @transactions = Transaction.all()
  end
  @total = Transaction.transactions_total(@transactions)

  @month = params['month'].to_i
  @previousmonth = params['month'].to_i == 1 ? 12 : params['month'].to_i - 1
  @nextmonth = params['month'].to_i == 12 ? 1 : params['month'].to_i + 1
  @year = params['year'].to_i
  @previousmonthyear = params['month'].to_i == 1 ? params['year'].to_i - 1 : params['year']
  @nextmonthyear = params['month'].to_i == 12 ? params['year'].to_i + 1 : params['year']

  @budgetremaining = @budget.monthly_budget - @total

  erb(:"budgets/index")
end

get '/budgets/edit' do
  @budget = Budget.all()
  erb(:"budgets/edit")
end

post '/budgets/:id' do
  budget = Budget.new(params)
  budget.update
  redirect to "/budgets?month=#{Date.today.month}&year=#{Date.today.year}"
end
