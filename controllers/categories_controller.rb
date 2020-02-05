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
get '/categories/?' do
  @categories = Category.all()
  erb(:"categories/index")
end

# new
get '/categories/new' do
  @categories = Category.all()
  erb(:"categories/new")
end

# show
get '/categories/:id' do
  @category = Category.find(params[:id].to_i)
  erb(:"categories/show")
end

# edit
get '/categories/:id/edit' do
  @category = Category.find(params[:id].to_i)
  erb(:"categories/edit")
end

# destroy
get '/categories/:id/delete' do
  @category = Category.find(params[:id].to_i)
  @category.delete
  redirect to '/categories'
end

# create
post '/categories' do
  Category.new(params).save
  redirect to '/categories'
end

# update
post '/categories/:id' do
  Category.new(params).update
  redirect to '/categories'
end
