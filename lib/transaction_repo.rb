require_relative 'repo'
require_relative 'transaction'

class TransactionRepository < Repo

  attr_reader :se, :table, :hash

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Transaction,'../sales_engine/data/transactions.csv')
    @hash = populate_hash(@table)
  end

end
