class Invoice
  attr_reader :id, :customer_id, :merchant_id,
              :status, :created_at, :updated_at,
              :invoice_repository

  def initialize(input_data, invoice_repository)
    @id = input_data[0].to_i
    @customer_id = input_data[1].to_i
    @merchant_id = input_data[2].to_i
    @status = input_data[3]
    @created_at = input_data[4]
    @updated_at = input_data[5]
    @invoice_repository = invoice_repository
  end

  def transactions
    # invoice_repository.se.transaction_repo.find_all_by(:invoice_id, id)
    invoice_repository.repo_table(:transaction_repo).select do |transaction|
      transaction.invoice_id == id
    end
  end

  def invoice_items
    invoice_repository.se.invoice_item_repository.find_all_by_invoice_id(id)
    # invoice_repository.repo_table(:invoice_item_repo).select do |invoice_item|
    #   invoice_item.invoice_id == id
    # end
  end

  def items
    invoice_items.map do |invoice_item|
        invoice_repository.se.item_repo.find_by(:id, invoice_item.item_id)
    end.uniq
    # invoice_items.each do |invoice_item|
    #   repo_table(:item_repo).select do |item|
    #     invoice_item.item_id == item.id
    #   end
    # end
  end

  def customer
    invoice_repository.se.customer_repo.find_by(:id, customer_id)
    # repo_table(:customer_repo).find do |customer|
    #   find_by(:id, invoice_id).customer_id == customer.id
    # end
  end

  def merchant
    invoice_repository.se.merchant_repo.find_by(:id, merchant_id)
    # repo_table(:merchant_repo).find do |merchant|
    #   find_by(:id, invoice_id).merchant_id == merchant.id
    # end
  end
  def revenue
    invoice_items = invoice_repository.se.invoice_item_repo.find_all_by(:invoice_id, id)

    invoice_items.reduce(0) do |sum, invoice_item|
      sum + invoice_item.revenue
    end
  end

  def successful?
    transaction_repo = invoice_repository.se.transaction_repo
    transaction = transaction_repo.find_by(:invoice_id, id)

    !transaction.nil? && transaction.successful?
  end


end
