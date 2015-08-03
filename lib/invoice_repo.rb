require_relative 'repo'
require_relative 'invoice'
class InvoiceRepo < Repo

  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Invoice,'../sales_engine/data/invoices.csv')
  end


end
