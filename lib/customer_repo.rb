require_relative 'repo'
require_relative 'customer'

class CustomerRepo < Repo

  def invoices(customer_id)
    @se.invoice_repo.table.select do |invoice|
      invoice.customer_id == customer_id
    end
  end

end
