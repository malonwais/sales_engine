class Merchant
  attr_reader :id, :name, :merchant_id, :merchant_repository

  def initialize(input_data, merchant_repository)
    @id = input_data[0]
    @name = input_data[1]
    @created_at = input_data[2]
    @updated_at = input_data[3]
    @merchant_repository = merchant_repository
  end

  def items
    # merchant_repository.se.item_repo.find_all_by(:merchant_id, id)
    merchant_repository.repo_table(:item_repo).select do |item|
      item.merchant_id == id
    end
  end

  def invoices
    # merchant_repository.se.invoice_repo.find_all_by(:merchant_id, id)

    merchant_repository.repo_table(:invoice_repo).select do |invoice|
      invoice.merchant_id == id
    end
  end

end
