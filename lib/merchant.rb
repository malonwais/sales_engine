class Merchant
  attr_reader :id, :name, :merchant_id, :merchant_repository

  def initialize(input_data, merchant_repository)
    @id = input_data[0].to_i
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

  def revenue(date = false)
    set_of_invoices = if date
      date = Date.parse(date).strftime("%Y-%m-%d")
      invoices.select do |invoice|
        invoice.created_at[0..9] == date
      end
    else
      invoices
    end

    set_of_invoices.reduce(0) do |sum, invoice|
      sum + invoice.revenue
    end
  end

  def favorite_customer
    customers = Hash.new(0)
    invoices.each do |invoice|
      if invoice.successful?
        customer = merchant_repository.se.customer_repo.find_by(:id, invoice.customer_id)
        customers[customer] += 1
      end
    end
    customers.sort_by{|customer, count| count}.reverse[0][0]
  end

  def customers_with_pending_invoices
    customers = []
    invoices.each do |invoice|
      if !invoice.successful?
        customers << merchant_repository.se.customer_repo.find_by(:id, invoice.customer_id)
      end
    end
    customers
  end


end
