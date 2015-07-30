require_relative 'repo'
require_relative 'invoice_item'
class InvoiceItemRepo < Repo

  def invoice(id)
    repo_table(:invoice_repo).find do |invoice|
      find_by(:id, id).invoice_id == invoice.id
    end
  end

  def item(id)
    repo_table(:item_repo).find do |item|
      find_by(:id, id).item_id == item.id
    end
  end

end
