require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository

  attr_reader :se, :table, :quick_lookup_table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Transaction,'../sales_engine/data/transactions.csv')
    @quick_lookup_table = populate_quick_lookup_table(@table)
  end

end
