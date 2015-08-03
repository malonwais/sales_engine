require_relative 'repo'
require_relative 'invoice_item'

class InvoiceItemRepository < Repo
  attr_reader :se, :table, :invoice_items

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    @invoice_items =  @table
    map_data(InvoiceItem,'../sales_engine/data/invoice_items.csv')
  end



end
