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

  @total = Transaction.tranactions_total(@transactions)

  @month = params['month'].to_i
  @previousmonth = params['month'].to_i == 1 ? 12 : params['month'].to_i - 1
  @nextmonth = params['month'].to_i == 12 ? 1 : params['month'].to_i + 1
  @year = params['year'].to_i
  @previousmonthyear = params['month'].to_i == 1 ? params['year'].to_i - 1 : params['year']
  @nextmonthyear = params['month'].to_i == 12 ? params['year'].to_i + 1 : params['year']

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
  redirect to '/transactions'
end

# update
post '/transactions/:id' do
  Transaction.new(params).update
  redirect to '/transactions'
end
