require 'pry'
class Pantry
  attr_reader :stock, :shopping_list
  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = {}
  end

  def stock_check(item_name)
    stock[item_name] || 0
  end

  def restock(item, quantity)
    current = stock[item] || 0
    stock[item] = current + quantity
  end

  def add_to_shopping_list(recipe)
    shopping_list.merge!(recipe.ingredients) {|key, oldval, newval| newval + oldval}
  end

  def print_shopping_list
    list = shopping_list.map do |item, quantity|
      "* #{item}: #{quantity}"
    end
    puts list
    list.join("\n")
  end

  def add_to_cookbook(recipe)
    @cookbook[recipe.name] = recipe.ingredients
  end

  def what_can_i_make
    available_food = find_available_recipes
    available_food.map {|recipes| recipes.first}
  end

  def how_many_can_i_make
    possible_recipes = find_available_recipes.to_h
    possible_recipes.group_by do |recipe|
      recipe.reduce(0) do |max, (ingredient, quantity)|
        max_can_make = stock[ingredient] / quantity
        max >  max_can_make ? max : max_can_make
      end
    end
  end

  def find_available_recipes
    @cookbook.find_all do |recipe, ingredients|
      ingredients.all? do |name, amount_needed|
        amount_needed <= stock[name]
      end
    end
  end
end
