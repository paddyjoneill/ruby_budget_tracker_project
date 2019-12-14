require_relative('./sqlrunner')
require_relative('../models/merchant')
require_relative('../models/category')
require_relative('../models/transaction')

Transaction.delete_all()
Merchant.delete_all()
Category.delete_all()

@category1 = Category.new({
  'name' => 'transport'
  })
@category1.save()

@category2 = Category.new({
  'name' => 'food'
  })
@category2.save()

@category3 = Category.new({
  'name' => 'rent'
  })
@category3.save()

@merchant1 = Merchant.new({
  'name' => 'ScotRail',
  'default_cat_id' => @category1.id
  })
@merchant1.save()

@merchant2 = Merchant.new({
  'name' => 'Nandos',
  'default_cat_id' => @category2.id
  })
@merchant2.save()

@merchant3 = Merchant.new({
  'name' => 'Landlord',
  'default_cat_id' => @category3.id
  })
@merchant3.save()

@trans1 = Transaction.new(
  { 'merchant_id' => @merchant1.id,
    'category_id' => @category1.id,
    'amount' => 10,
    'time' => '13:00',
    'date' => '11/12/19'
      }
    )
@trans1.save()

@trans2 = Transaction.new(
  { 'merchant_id' => @merchant2.id,
    'category_id' => @category2.id,
    'amount' => 20,
    'time' => '14:00',
    'date' => '12/12/19'
      }
    )
@trans2.save()

@trans3 = Transaction.new(
  { 'merchant_id' => @merchant3.id,
    'category_id' => @category3.id,
    'amount' => 30,
    'time' => '15:00',
    'date' => '13/12/19'
      }
    )
@trans3.save()
