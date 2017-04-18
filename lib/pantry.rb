class Pantry
  attr_reader :stock, :shopping_list
  def initialize
    @stock = {}
    @shopping_list = {}
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
end
