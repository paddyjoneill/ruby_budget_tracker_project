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
