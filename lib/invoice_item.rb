class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price, :created_at,
              :updated_at
  def initialize(input_data)
    @id = input_data[0]
    @item_id = input_data[1]
    @invoice_id = input_data[2]
    @quantity = input_data[3]
    @unit_price = input_data[4]
    @created_at = input_data[5]
    @updated_at = input_data[6]
  end
end
