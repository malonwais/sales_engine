require_relative 'repo'
require_relative 'invoice_item'
class InvoiceItemRepo < Repo

  def invoice(id)
    @se.invoice_repo.table.select do |invoice|
      find_by_id(id).invoice_id == invoice.id
    end.first
  end

  def item(id)
    @se.item_repo.table.select do |item|
      find_by_id(id).item_id == item.id
    end.first
  end

end
