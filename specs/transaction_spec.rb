require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/transaction')
require_relative('../models/category')
require_relative('../models/merchant')
require('pry')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestTransaction < MiniTest::Test


  def setup

    Transaction.delete_all()
    Merchant.delete_all()
    Category.delete_all()

    @category1 = Category.new({
      'name' => 'transport'
      })
    @category1.save()

    @merchant1 = Merchant.new({
      'name' => 'ScotRail',
      'default_cat_id' => @category1.id
      })
    @merchant1.save()

    @trans1 = Transaction.new(
      { 'merchant_id' => @merchant1.id,
        'category_id' => @category1.id,
        'amount' => 10,
        'time' => '13:00',
        'date' => '11/12/19'
          }
        )
    @trans1.save()

  end

  def test_transaction_has_merchant
    result = Merchant.find(@trans1.merchant_id)
    assert_equal("ScotRail", result.name)
  end

  def test_transaction_has_category
    result = Category.find(@trans1.category_id)
    assert_equal("transport", result.name)
  end

  def test_transaction_has_amount
    assert_equal(10, @trans1.amount)
  end

  def test_transaction_has_time
    assert_equal("13:00", @trans1.time)
  end

  def test_transaction_has_date
    assert_equal("11/12/19", @trans1.date)
  end

end
