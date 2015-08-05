
class Customer
  attr_reader :id, :first_name, :last_name,
              :created_at, :updated_at, :customer_repository, :args

  def initialize(input_data, customer_repository)
    @id = input_data[0].to_i
    @first_name = input_data[1]
    @last_name = input_data[2]
    @created_at = input_data[3]
    @updated_at = input_data[4]
    @customer_repository = customer_repository
    @args = [:id, :first_name, :last_name,
                :created_at, :updated_at]
  end

  def invoices
    @customer_repository.se.invoice_repository.find_all_by_customer_id(id)
  end
  def transactions
    customer_transactions =  []
    invoices.each do |invoice|
      customer_transactions << @customer_repository.se.transaction_repository.find_all_by_invoice_id(invoice.id)
    end
    customer_transactions
  end
  
  def favorite_merchant
    merchants = Hash.new(0)
    invoices.each do |invoice|
      if invoice.successful?
        merchant = customer_repository.se.merchant_repository.find_by(:id, invoice.merchant_id)
        merchants[merchant] += 1
      end
    end
    merchants.sort_by{|merchant, count| count}.reverse[0][0]
  end

end
