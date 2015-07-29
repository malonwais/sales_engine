require_relative 'repo'
require_relative 'transaction'
class TransactionRepo < Repo

  def invoice(transaction_id)
    @se.invoice_repo.table.select do |invoice|
      find_by(:id, transaction_id).invoice_id == invoice.id
    end.first
  end

end
