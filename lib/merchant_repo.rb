require_relative 'repo'
require_relative 'merchant'
class MerchantRepo < Repo

  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Merchant,'./data/merchants.csv')
  end

end
