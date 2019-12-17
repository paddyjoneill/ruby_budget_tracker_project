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

  @date = Date.new(params['year'].to_i,params['month'].to_i,1)
  @prevmonth = @date << 1
  @nextmonth = @date >> 1
  
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
