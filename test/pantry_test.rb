require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test
  def pantry_exists
    panty = Pantry.new
  end

  def test_pantry_has_empty_stock
    panty = Pantry.new
    assert panty.stock.empty?
    assert_instance_of Hash, panty.stock
  end

  def test_pantry_can_check_for_an_item_and_returns_0_when_not_found
    panty = Pantry.new
    assert_equal 0, panty.stock_check("Cheese")
  end

  def test_pantry_can_add_stock_and_return_quantity
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_pantry_can_add_stock_to_existing_item
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
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
