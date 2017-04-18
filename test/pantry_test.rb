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

  def test_pantry_can_have_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(r)

    expected = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected, pantry.shopping_list
  end

  def test_pantry_can_merge_shopping_lists
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(r)

    r2 = Recipe.new("Spaghetti")
    r2.add_ingredient("Noodles", 10)
    r2.add_ingredient("Sauce", 10)
    r2.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r2)

    expected = {"Cheese" => 25, "Flour" => 20, "Noodles" => 10, "Sauce" => 10}
    assert_equal expected, pantry.shopping_list
  end
end

# # Adding another recipe
#
# # Printing the shopping list
# pantry.print_shopping_list
# # * Cheese: 25
# # * Flour: 20
# # * Noodles: 10
# # * Sauce: 10
# # => "* Cheese: 20\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
# ```
