require_relative('./sqlrunner')
require_relative('../models/merchant')
require_relative('../models/category')
require_relative('../models/transaction')
require_relative('../models/budget')

require 'pry'


Transaction.delete_all()
Merchant.delete_all()
Category.delete_all()
Budget.delete_all()

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

@category4 = Category.new({
  'name' => 'utilities',
  'active' => true
  })
@category4.save()

@category5 = Category.new({
  'name' => 'council tax',
  'active' => true
  })
@category5.save()

@category6 = Category.new({
  'name' => 'groceries',
  'active' => true
  })
@category6.save()

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

@merchant4 = Merchant.new({
  'name' => 'Scottish Gas',
  'default_cat_id' => @category4.id,
  'active' => true
  })
@merchant4.save()

@merchant5 = Merchant.new({
  'name' => 'Edinburgh Council',
  'default_cat_id' => @category5.id,
  'active' => true
  })
@merchant5.save()

@merchant6 = Merchant.new({
  'name' => 'Chanter',
  'default_cat_id' => @category2.id,
  'active' => true
  })
@merchant6.save()

@merchant7 = Merchant.new({
  'name' => 'Peppers',
  'default_cat_id' => @category2.id,
  'active' => true
  })
@merchant7.save()

@merchant8 = Merchant.new({
  'name' => 'Lothian Buses',
  'default_cat_id' => @category1.id,
  'active' => true
  })
@merchant8.save()

@merchant9 = Merchant.new({
  'name' => 'Easyjet',
  'default_cat_id' => @category1.id,
  'active' => true
  })
@merchant9.save()

@merchant9 = Merchant.new({
  'name' => 'Scotmid',
  'default_cat_id' => @category6.id,
  'active' => true
  })
@merchant9.save()



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
    'amount' => 500,
    'time' => '15:00',
    'date' => Date.parse("2019-12-13")
      }
    )
@trans3.save()

@trans4 = Transaction.new(
  { 'merchant_id' => @merchant4.id,
    'category_id' => @category4.id,
    'amount' => 120,
    'time' => '15:00',
    'date' => Date.parse("2019-12-5")
      }
    )
@trans4.save()

@trans5 = Transaction.new(
  { 'merchant_id' => @merchant5.id,
    'category_id' => @category5.id,
    'amount' => 140,
    'time' => '15:00',
    'date' => Date.parse("2019-12-1")
      }
    )
@trans5.save()

@trans6 = Transaction.new(
  { 'merchant_id' => @merchant9.id,
    'category_id' => @category6.id,
    'amount' => 57,
    'time' => '13:00',
    'date' => Date.parse("2019-12-08")
      }
    )
@trans6.save()

@trans7 = Transaction.new(
  { 'merchant_id' => @merchant8.id,
    'category_id' => @category1.id,
    'amount' => 157,
    'time' => '13:00',
    'date' => Date.parse("2019-12-05")
      }
    )
@trans7.save()

@trans8 = Transaction.new(
  { 'merchant_id' => @merchant7.id,
    'category_id' => @category2.id,
    'amount' => 9,
    'time' => '13:00',
    'date' => Date.parse("2019-12-07")
      }
    )
@trans8.save()

@budget1 = Budget.new(
  {
    'target' => 250,
    'income' => 2000
  }
)
@budget1.save()
