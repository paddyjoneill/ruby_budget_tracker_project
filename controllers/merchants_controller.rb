require 'sinatra'
# require 'sinatra/contrib/all'
require 'pg'
require 'pry'


require_relative ('../models/category')
require_relative ('../models/merchant')
require_relative ('../models/transaction')
require_relative ('../models/budget')
also_reload('../models/*')

# index
get '/merchants/?' do
  @merchants = Merchant.all()
  @categories = Category.all()
  erb(:"merchants/index")
end

# new
get '/merchants/new' do
  @categories = Category.all()
  erb(:"merchants/new")
end

# show
get '/merchants/:id' do
  @merchant = Merchant.find(params[:id].to_i)
  @categories = Category.all()
  erb(:"merchants/show")
end

# edit
get '/merchants/:id/edit' do
  @merchant = Merchant.find(params[:id].to_i)
  @categories = Category.all()
  erb(:"merchants/edit")
end

# destroy
get '/merchants/:id/delete' do
  @merchant = Merchant.find(params[:id].to_i)
  @merchant.delete
  redirect to '/merchants'
end



# create
post '/merchants' do
  Merchant.new(params).save
  redirect to '/merchants'
end

# update
post '/merchants/:id' do
  Merchant.new(params).update
  redirect to '/merchants'
end
