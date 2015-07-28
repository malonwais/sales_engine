class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at,
              :updated_at
  def initialize(input_data)
    @id = input_data[0]
    @name = input_data[1]
    @description = input_data[2]
    @unit_price = input_data[3]
    @merchant_id = input_data[4]
    @created_at = input_data[5]
    @updated_at = input_data[6]
  end
end
