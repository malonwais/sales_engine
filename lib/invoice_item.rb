class InvoiceItem
  attr_reader :id, :item_id, :invoice_id, :quantity,
  :unit_price, :created_at, :updated_at,
  :invoice_item_repository

  def initialize(input_data, invoice_item_repository)
    @id = input_data[0].to_i
    @item_id = input_data[1].to_i
    @invoice_id = input_data[2].to_i
    @quantity = input_data[3].to_i
    @unit_price = BigDecimal.new(input_data[4]) * 0.01
    @created_at = input_data[5]
    @updated_at = input_data[6]
    @invoice_item_repository = invoice_item_repository
  end

  def invoice
    # invoice_item_repository.repo_table(:invoice_repo).find do |invoice|
    #   find_by(:id, id).invoice_id == id
    # end
    invoice_item_repository.se.invoice_repository.find_by(:id, invoice_id)
  end

  def item
    # invoice_item_repository.repo_table(:item_repo).find do |item|
    #   find_by(:id, id).item_id == id
    # end
    invoice_item_repository.se.item_repository.find_by(:id, item_id)
  end

  def revenue
    total = if successful? then quantity.to_i * unit_price.to_i else 0 end
    BigDecimal.new(total)
  end
  def simple_revenue
    quantity * unit_price
  end

  def merchant
    item_repo = invoice_item_repository.se.item_repo
    merchant = item_repo.find_by(:id, item_id).merchant

    merchant
  end

  def successful?
    transaction_repo = invoice_item_repository.se.transaction_repo
    transaction = transaction_repo.find_by(:invoice_id, invoice_id)

    !transaction.nil? && transaction.successful?
  end

  # def big_d(number)
  #   dollars = number / 100
  #   cents = number % 100
  #
  #   BigDecimal.new(dollars +.#{cents}")
  # end

end
