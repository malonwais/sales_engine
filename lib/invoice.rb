class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(input_data)
    @id = input_data[0]
    @customer_id = input_data[1]
    @merchant_id = input_data[2]
    @status = input_data[3]
    @created_at = input_data[4]
    @updated_at = input_data[5]
  end

end
