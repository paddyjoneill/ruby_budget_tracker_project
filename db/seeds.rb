require_relative('./sqlrunner')
require_relative('../models/merchant')
require_relative('../models/category')
require_relative('../models/transaction')
require_relative('../models/budget')

require 'pry'


Transaction.delete_all()
Merchant.delete_all()
Category.delete_all()

@category1 = Category.new({
  'name' => 'transport',
  'active' => true
  })
@category1.save()

@category2 = Category.new({
  'name' => 'food',
  'active' => true
  })
@category2.save()

@category3 = Category.new({
  'name' => 'rent',
  'active' => true
  })
@category3.save()

@merchant1 = Merchant.new({
  'name' => 'ScotRail',
  'default_cat_id' => @category1.id,
  'active' => true
  })
@merchant1.save()

@merchant2 = Merchant.new({
  'name' => 'Nandos',
  'default_cat_id' => @category2.id,
  'active' => true
  })
@merchant2.save()

@merchant3 = Merchant.new({
  'name' => 'Landlord',
  'default_cat_id' => @category3.id,
  'active' => true
  })
@merchant3.save()

@trans1 = Transaction.new(
  { 'merchant_id' => @merchant1.id,
    'category_id' => @category1.id,
    'amount' => 10,
    'time' => '13:00',
    'date' => Date.parse("2019-11-11")
      }
    )
@trans1.save()

@trans2 = Transaction.new(
  { 'merchant_id' => @merchant2.id,
    'category_id' => @category2.id,
    'amount' => 20,
    'time' => '14:00',
    'date' => Date.parse("2019-12-12")
      }
    )
@trans2.save()

@trans3 = Transaction.new(
  { 'merchant_id' => @merchant3.id,
    'category_id' => @category3.id,
    'amount' => 30,
    'time' => '15:00',
    'date' => Date.parse("2019-12-13")
      }
    )
@trans3.save()

@budget1 = Budget.new(
  { 'monthly_budget' => 400,
    'target' => 250,
    'income' => 1500
  }
)
@budget1.save()

binding.pry
nil
