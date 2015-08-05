require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository
  attr_reader :se, :table, :quick_lookup_table

  def initialize(sales_engine, csv_path)
    @se = sales_engine
    @table = []
    customer = @table
    map_data(Customer,'../sales_engine/data/customers.csv')
    @quick_lookup_table = populate_quick_lookup_table(@table)
  end

end
