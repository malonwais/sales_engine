class Merchant
  attr_reader :id, :name, :merchant_id, :merchant_repository,
              :created_at, :updated_at, :fields

  def initialize(input_data, merchant_repository)
    @id = input_data[0].to_i
    @name = input_data[1]
    @created_at = input_data[2]
    @updated_at = input_data[3]
    @merchant_repository = merchant_repository
    @fields = [:id, :name, :merchant_id,
                :created_at, :updated_at]
  end

  def items
    merchant_repository.se.item_repository.find_all_by(:merchant_id, id)
  end

  def invoices
    merchant_repository.se.invoice_repository.find_all_by(:merchant_id, id)
  end

  def revenue(date = false)
    set_of_invoices = if date
      if date.class == Date
        date = date.strftime("%Y-%m-%d")
      else
        date = Date.parse(date).strftime("%Y-%m-%d")
      end
      invoices.select do |invoice|
        invoice.created_at[0..9] == date
      end
    else
      invoices
    end
    output = set_of_invoices.reduce(0) do |sum, invoice|
      sum + invoice.revenue
    end
    output * 0.01
  end

  def favorite_customer
    customers = Hash.new(0)
    invoices.each do |invoice|
      if invoice.successful?
        customer_repository = merchant_repository.se.customer_repository
        customer = customer_repository.find_by(:id, invoice.customer_id)
        customers[customer] += 1
      end
    end
    customers.sort_by{|customer, count| count}.reverse[0][0]
  end

  def customers_with_pending_invoices
    customers = []
    invoices.each do |invoice|
      if !invoice.successful?
        customer_repository = merchant_repository.se.customer_repository
        customers << customer_repository.find_by(:id, invoice.customer_id)
      end
    end
    customers
  end
  
  def inspect
    self.class.to_s
  end

end
