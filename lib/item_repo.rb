require_relative 'repo'
require_relative 'item'
class ItemRepo < Repo

  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Item,'./data/items.csv')
  end

end
