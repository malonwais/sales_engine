require_relative 'repo'
require_relative 'customer'

class CustomerRepo < Repo
  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Customer,'./data/customers.csv')
  end




end
