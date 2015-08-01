require_relative 'repo'
require_relative 'invoice_item'

class InvoiceItemRepo < Repo
  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(InvoiceItem,'./data/invoice_items.csv')
  end



end
