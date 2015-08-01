class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
              :unit_price, :created_at, :updated_at,
              :invoice_item_repository

  def initialize(input_data, invoice_item_repository)
    @id = input_data[0]
    @item_id = input_data[1]
    @invoice_id = input_data[2]
    @quantity = input_data[3]
    @unit_price = input_data[4]
    @created_at = input_data[5]
    @updated_at = input_data[6]
    @invoice_item_repository = invoice_item_repository
  end

  def invoice
    # invoice_item_repository.repo_table(:invoice_repo).find do |invoice|
    #   find_by(:id, id).invoice_id == id
    # end
    invoice_item_repository.se.invoice_repo.find_by(:id, invoice_id)
  end

  def item
    # invoice_item_repository.repo_table(:item_repo).find do |item|
    #   find_by(:id, id).item_id == id
    # end
    invoice_item_repository.se.item_repo.find_by(:id, item_id)
  end

end
