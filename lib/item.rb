class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at,
              :updated_at, :item_repository

  def initialize(input_data, item_repository)
    @id = input_data[0]
    @name = input_data[1]
    @description = input_data[2]
    @unit_price = input_data[3]
    @merchant_id = input_data[4]
    @created_at = input_data[5]
    @updated_at = input_data[6]
    @item_repository = item_repository
  end

  def invoice_items
    # item_repository.se.invoice_item_repo.find_all_by(:item_id, id)
    item_repository.repo_table(:invoice_item_repo).select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def merchant
    # item_repository.se.merchant_repo.find_by(:id, merchant_id)
    item_repository.repo_table(:merchant_repo).find do |merchant|
      merchant_id == merchant.id
    end
  end
  def best_day(invoice_date)
    
    #from the item we have to get to invoice items i think
    
    #I still have to detect only successful transactions
  end
  def get_invoice_item_quantity
    0
  end
end
