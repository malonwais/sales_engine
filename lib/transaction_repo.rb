require_relative 'repo'
require_relative 'transaction'

class TransactionRepo < Repo
  def invoice(transaction_id)
    repo_table(:invoice_repo).find do |invoice|
      find_by(:id, transaction_id).invoice_id == invoice.id
    end
  end
end
