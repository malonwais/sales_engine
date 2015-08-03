require_relative 'repo'
require_relative 'transaction'

class TransactionRepo < Repo

  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Transaction,'../sales_engine/data/transactions.csv')
  end

end
