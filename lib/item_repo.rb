require_relative 'repo'
require_relative 'item'
class ItemRepository < Repo

  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Item,'../sales_engine/data/items.csv')
  end

end
