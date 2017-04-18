class Pantry
  attr_reader :stock
  def initialize
    @stock = {}
  end

  def stock_check(item_name)
    @stock[item_name] || 0
  end
end
