require('minitest/autorun')
require('minitest/reporters')
require_relative('../models/category')
require_relative('../models/merchant')
require_relative('../models/transaction')
require('pry')


Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestCategory < MiniTest::Test

  def setup

    Transaction.delete_all()
    Merchant.delete_all()
    Category.delete_all()

    @category1 = Category.new({
      'name' => 'transport'
      })
    end

    def test_category_has_name
      assert_equal("transport", @category1.name)
    end

    def test_can_update_name
      @category1.name = "food"
      @category1.update()
      assert_equal("food", @category1.name)
    end

  end
