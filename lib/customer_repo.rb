require_relative 'repo'
require_relative 'customer'

class CustomerRepository < Repo
  attr_reader :se, :table, :hash

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    customer = @table
    map_data(Customer,'../sales_engine/data/customers.csv')
    @hash = populate_hash(@table)
  end




end
