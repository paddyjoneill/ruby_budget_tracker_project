require 'sinatra'
# require 'sinatra/contrib/all'
require 'pg'
# require 'pry'


require_relative ('../models/category')
require_relative ('../models/merchant')
require_relative ('../models/transaction')
require_relative ('../models/budget')
also_reload('../models/*')

# index
get '/transactions/?' do
  @transactions = Transaction.all()
  @merchants = Merchant.all()
  @categories = Category.all()


  if params['month'] == nil
    redirect to "/transactions?month=#{Date.today.month}&year=#{Date.today.year}"
  else
    @transactions = Transaction.month(params['month'],params['year'])
    @date = Date.new(params['year'].to_i,params['month'].to_i,1)
    @prevmonth = @date << 1
    @nextmonth = @date >> 1

    @total = Transaction.transactions_total(@transactions)
  end

  erb(:"transactions/index")
end

# new
get '/transactions/new' do
  @merchants = Merchant.all_active()
  @categories = Category.all_active()
  erb(:"transactions/new")
end

# show
get '/transactions/:id' do
  @transaction = Transaction.find(params[:id].to_i)
  @merchants = Merchant.all()
  @categories = Category.all()
  @bill = Bill.find(@transaction.bill_id.to_i) if @transaction.bill_id
  erb(:"transactions/show")
end

# edit
get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id].to_i)
  @merchants = Merchant.all_active()
  @categories = Category.all_active()
  @bill = Bill.find(@transaction.bill_id.to_i) if @transaction.bill_id
  erb(:"transactions/edit")
end

# destroy
get '/transactions/:id/delete' do
  @transaction = Transaction.find(params['id'].to_i)
  @transaction.delete
  redirect to "/budgets?month=#{Date.today.month}&year=#{Date.today.year}"
end

# create
post '/transactions' do
  if params['is_bill'] != nil
    Transaction.recurring_bill(params)
  else
    Transaction.new(params).save
  end
  redirect to "/budgets?month=#{Date.today.month}&year=#{Date.today.year}"
end

# update
post '/transactions/:id' do
  if params['is_bill'] != nil
    Transaction.update_bill(params)
  else
    Transaction.new(params).update
  end
  redirect to "/budgets?month=#{Date.today.month}&year=#{Date.today.year}"
end
