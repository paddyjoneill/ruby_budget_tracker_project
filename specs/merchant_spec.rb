require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/merchant')
require_relative('../models/category')
require('pry')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestMerchant < MiniTest::Test

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

  end

  def test_merchant_has_name
    assert_equal("ScotRail", @merchant1.name)
  end

  def test_merchant_has_default_category
    result = Category.find(@merchant1.default_cat_id)
    assert_equal("transport", result.name)
  end

  def test_can_update_merchant_name
    @merchant1.name = "Lothian Buses"
    @merchant1.update()
    assert_equal("Lothian Buses", @merchant1.name)
  end


end
