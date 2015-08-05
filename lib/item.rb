class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at,
              :updated_at, :item_repository, :args

  def initialize(input_data, item_repository)
    @id = input_data[0].to_i
    @name = input_data[1]
    @description = input_data[2]
    @unit_price = BigDecimal.new(input_data[3]) 
    @merchant_id = input_data[4].to_i
    @created_at = input_data[5]
    @updated_at = input_data[6]
    @item_repository = item_repository
    @args = [:id, :name, :description, :unit_price, :merchant_id, :created_at,
                :updated_at]
  end

  def invoice_items
    item_repository.se.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    item_repository.se.merchant_repository.find_by(:id, merchant_id)
    
  end
  def best_day(invoice_date)
    
    #from the item we have to get to invoice items i think
    
    #I still have to detect only successful transactions
  end
  def get_invoice_item_quantity
    # item_repository.se.invoice_items.each do |invoice_item|
    # 
    # end
    0
  end
  
end
