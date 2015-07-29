require_relative 'repo'
require_relative 'transaction'

class TransactionRepo < Repo
  def invoice(transaction_id)
    @se.invoice_repo.table.find do |invoice|
      find_by(:id, transaction_id).invoice_id == invoice.id
    end
  end
end
