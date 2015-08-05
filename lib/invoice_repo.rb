require_relative 'repo'
require_relative 'invoice'
class InvoiceRepository < Repo

  attr_reader :se, :table, :hash

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Invoice,'../sales_engine/data/invoices.csv')
    @hash = populate_hash(@table)
  end


end
