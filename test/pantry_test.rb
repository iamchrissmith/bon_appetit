require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def pantry_exists
    @pantry = Pantry.new
  end

  def test_pantry_has_empty_stock
    @pantry = Pantry.new
    assert @pantry.stock.empty?
    assert_instance_of Hash, @pantry.stock
  end

  def test_pantry_can_check_for_an_item_and_returns_0_when_not_found
    @pantry = Pantry.new
    assert_equal 0, @pantry.stock_check("Cheese")
  end
end



# pantry.stock_check("Cheese")
# # => 0
#
# pantry.restock("Cheese", 10)
# pantry.stock_check("Cheese")
# # => 10
#
# pantry.restock("Cheese", 20)
# pantry.stock_check("Cheese")
# # => 30
# ```
