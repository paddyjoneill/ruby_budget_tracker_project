require 'sinatra'
require 'sinatra/contrib/all'
require 'pg'
require 'pry'


require_relative ('../models/category')
require_relative ('../models/merchant')
require_relative ('../models/transaction')
require_relative ('../models/budget')
also_reload('../models/*')


get '/transactions/?' do
@transactions = Transaction.all()
@merchants = Merchant.all()
@categories = Category.all()
erb(:"transactions/index")
end

get '/transactions/:id/edit' do
  @transaction = Transaction.find(params[:id].to_i)
  @merchants = Merchant.all()
  @categories = Category.all()
  erb(:"transactions/edit")
end

get '/transactions/:id/delete' do
  @transaction = Transaction.find(params[:id].to_i)
  @transaction.delete
  redirect to '/transactions'
end

get '/transactions/new' do
  @merchants = Merchant.all()
  @categories = Category.all()
  erb(:"transactions/new")
end

post '/transactions' do
  Transaction.new(params).save
  redirect to '/transactions'
end

post '/transactions/:id' do
  Transaction.new(params).update
  redirect to '/transactions'
end
