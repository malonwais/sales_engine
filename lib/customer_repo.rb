require_relative 'repo'
require_relative 'customer'

class CustomerRepo < Repo

  def invoices(customer_id)
    repo_table(:invoice_repo).select do |invoice|
      invoice.customer_id == customer_id
    end
  end

end
