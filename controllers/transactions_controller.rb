require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'pry'


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

  if params['month'] != nil
    @transactions = Transaction.month(params['month'],params['year'])
  else
    @transactions = Transaction.all()
  end

  @total = Transaction.transactions_total(@transactions)

  @date = Date.new(params['year'].to_i,params['month'].to_i,1)
  @prevmonth = @date << 1
  @nextmonth = @date >> 1

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
  erb(:"transactions/show")
end

# edit
get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id].to_i)
  @merchants = Merchant.all_active()
  @categories = Category.all_active()
  erb(:"transactions/edit")
end

# destroy
get '/transactions/:id/delete' do
  @transaction = Transaction.find(params[:id].to_i)
  @transaction.delete
  redirect to '/transactions'
end

# create
post '/transactions' do
  Transaction.new(params).save
  redirect to "/transactions?month=#{Date.today.month}&year=#{Date.today.year}"
end

# update
post '/transactions/:id' do
  Transaction.new(params).update
  redirect to "/transactions?month=#{Date.today.month}&year=#{Date.today.year}"
end
