
class Customer
  attr_reader :id, :first_name, :last_name,
              :created_at, :updated_at, :customer_repository

  def initialize(input_data, customer_repository)
    @id = input_data[0]
    @first_name = input_data[1]
    @last_name = input_data[2]
    @created_at = input_data[3]
    @updated_at = input_data[4]
    @customer_repository = customer_repository
  end

  def invoices
    # @customer_repository.se.invoice_repo.find_all_by(:customer_id, id)
    customer_repository.repo_table(:invoice_repo).select do |invoice|
      invoice.customer_id == id
    end
  end

end
