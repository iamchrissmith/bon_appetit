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
    shopping_list.merge!(recipe.ingredients)
  end
end
