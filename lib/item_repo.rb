require_relative 'repo'
require_relative 'item'
class ItemRepository < Repo
  
  attr_reader :se, :table
  
  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Item,'../sales_engine/data/items.csv')
  end
  
  def most_revenue(item_count)
    invoices = Hash.new(0)
    start = Time.now()
    @se.invoice_item_repository.table.each  do |invoice_item|
      invoices[invoice_item.invoice_id] = invoice_item.simple_revenue
    end
    puts "took: "

    puts Time.now() - start
    invoices
  end
end
