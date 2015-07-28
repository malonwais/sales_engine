class Merchant
  attr_reader :id, :name, :merchant_id
  def initialize(input_data)
    @id = input_data[0]
    @name = input_data[1]
    @created_at = input_data[2]
    @updated_at = input_data[3]
  end
end
