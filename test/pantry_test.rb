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

  def test_pantry_can_provide_a_printed_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Pasta")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    r.add_ingredient("Noodles", 10)
    r.add_ingredient("Sauce", 10)

    pantry.add_to_shopping_list(r)
    expected = "* Cheese: 20\n* Flour: 20\n* Noodles: 10\n* Sauce: 10"
    assert_output( stdout = "#{expected}\n" ) { pantry.print_shopping_list }
    assert_equal expected, pantry.print_shopping_list
  end

  def test_what_can_i_make_returns_available_recipes_based_on_stock
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    expected = ["Pickles", "Peanuts"]
    assert_equal expected, pantry.what_can_i_make
  end
end
# How many can I make?
# pantry.how_many_can_i_make # => {"Brine Shot" => 4, "Peanuts" => 2}
