class Customer
  attr_reader :id, :first_name, :last_name, :created_at, :updated_at
  def initialize(input_data)
    @id = input_data[0]
    @first_name = input_data[1]
    @last_name = input_data[2]
    @created_at = input_data[3]
    @updated_at = input_data[4]
  end

end
