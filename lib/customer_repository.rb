require_relative 'repository'
require_relative 'customer'

class CustomerRepository < Repository

  def load_data(csv_path)
    map_data(Customer, File.join(csv_path, "customers.csv"))
  end

end
